<?php

use App\Http\Controllers\CategoryController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

use App\Http\Controllers\ProductController;

Route::get('/products/landing', [ProductController::class, 'index']);

Route::post('/users/create', [\App\Http\Controllers\AuthController::class, 'register']);

Route::get('/products/{id}', [ProductController::class,'show']);

Route::get('/categories', [CategoryController::class, 'index']);
