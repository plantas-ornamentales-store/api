<?php

use App\Http\Controllers\AuthController;
use App\Http\Controllers\CategoryController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

use App\Http\Controllers\ProductController;

Route::get('/products/landing', [ProductController::class, 'index']);

Route::post('/users/create', [\App\Http\Controllers\AuthController::class, 'register']);

Route::get('/products/{id}', [ProductController::class,'show']);
Route::post('/products/search', [ProductController::class, 'search']);

Route::get('/categories', [CategoryController::class, 'index']);
Route::get('/category/{id}', [CategoryController::class, 'products']);

Route::group([
    'middleware' => 'api',
    'prefix' => 'auth'
], function ($router) {
    Route::post('register', [AuthController::class, 'register']);
    Route::post('login', [AuthController::class, 'login']);
    Route::post('logout', [AuthController::class, 'logout']);
    Route::post('refresh', [AuthController::class, 'refresh']);
    Route::post('check', [AuthController::class, 'check'])->middleware('jwt');
    Route::post('me', [AuthController::class, 'me']);

});
