<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

use App\Http\Controllers\ProductController;



Route::post('/users/create', [\App\Http\Controllers\AuthController::class, 'register']);

Route::get('/products/{id}', [ProductController::class,'show']);

Route::get('/products', [ProductController::class, 'index']);