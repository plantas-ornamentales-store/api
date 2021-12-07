<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Str;

class AuthController extends Controller
{

    public function register() {
        $nombre = request("name");
        $email = request("email");
        $password = request("password");

        if (Str::length($nombre)<=0) {
            return response()->json(["success" => false, "error" => "El nombre debe tener más de 1 carácter."]);
        }

        if (Str::length($email)<=0) {
            return response()->json(["success" => false, "error" => "El email es inválido."]);
        }

        if(!filter_var($email, FILTER_VALIDATE_EMAIL)) {
            return response()->json(["success" => false, "error" => "El formato del correo es inválido."]);
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

        return response()->json([
            "success" => true,
            "data" => $user
        ]);

    }

}
