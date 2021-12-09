<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Str;
use Tymon\JWTAuth\Facades\JWTAuth;
use Illuminate\Foundation\Auth\ThrottlesLogins;

class AuthController extends Controller
{
    /**
     * Create a new AuthController instance.
     *
     * @return void
     */
    public function __construct()
    {
        $this->middleware('auth:api', ['except' => ['login', 'register']]);
    }

    /**
     * Get a JWT via given credentials.
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function login()
    {
        $credentials = request(['email', 'password']);
        $email = request('email');

        if (is_null($email)) {
            return response()->json(["success" => false, "error" => "Debes introducir un correo electrónico."], 200);
        }
        $check_email = User::where('email', $email)->first();
        if (!$check_email) {
            return response()->json(["success" => false, "error" => "No hemos localizado una cuenta asociada con la dirección de email ingresada."], 200);
        }
        if (!$token = auth()->attempt($credentials)) {
            return response()->json(["success" => false, 'error' => 'Los credenciales ingresados no son válidos.'], 401);
        }

        return response()->json(["success" => true, "data" => [
            'access_token' => $token,
            'token_type' => 'bearer',
            'expires_in' => auth()->factory()->getTTL() * 60,
            'user' => auth('api')->user()
        ]]);
    }

    /**
     * Get the authenticated User.
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function me()
    {

        return response()->json(auth()->user());
    }

    /**
     * Log the user out (Invalidate the token).
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function logout()
    {
        $u = auth('api')->user();
        auth()->invalidate();
        $u->save();

        return response()->json("success");
    }

    /**
     * Refresh a token.
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function refresh()
    {
        return $this->respondWithToken(auth()->refresh());
    }

    public function check (Request $request) {

        $token = str_replace('Bearer ', '', $request->header('Authorization'));

        $u = auth('api')->user();
        $u->save();

        return $this->respondWithToken($token);

    }

    public function register() {
        $nombre = request("name");
        $email = request("email");
        $password = request("password");
        $repeatpassword = request("repeat_password");

        if (Str::length($nombre)<=0) {
            return response()->json(["success" => false, "error" => "El nombre debe tener más de 1 carácter."]);
        }

        if (Str::length($email)<=0) {
            return response()->json(["success" => false, "error" => "El email es inválido."]);
        }

        if(!filter_var($email, FILTER_VALIDATE_EMAIL)) {
            return response()->json(["success" => false, "error" => "El formato del correo es inválido."]);
        }

        if ($password!==$repeatpassword) {
            return response()->json(["success" => false, "error" => "Las contraseñas no coinciden."]);
        }

        if (Str::length($password)<=0 || Str::length($password)<6) {
            return response()->json(["success" => false, "error" => "La longitud de la clave es inválida. Mínimo de 6 carácteres."]);
        }

        $checkEmail = User::where('email', $email)->first();
        if ($checkEmail) {
            return response()->json(["success" => false, "error" => "El correo electrónico ya está en uso."]);
        }

        $user = new User();
        $user->name = $nombre;
        $user->email = $email;
        $user->password = Hash::make($password);
        $user->save();

        $token = auth()->login($user);


        return response()->json(
            ["success" => true,
                "data" => [
                    'access_token' => $token,
                    'token_type' => 'bearer',
                    'expires_in' => auth('api')->factory()->getTTL() * 60,
                    'user' => auth('api')->user()
                ]
            ]
        );
    }

    /**
     * Get the token array structure.
     *
     * @param  string $token
     *
     * @return \Illuminate\Http\JsonResponse
     */
    protected function respondWithToken($token)
    {
        return response()->json([
            'access_token' => $token,
            'token_type' => 'bearer',
            'expires_in' => auth()->factory()->getTTL() * 60,
            'user' => auth('api')->user()
        ]);
    }

}
