<?php

namespace App\Http\Controllers;

use App\Models\Category;
use Illuminate\Http\Request;

class CategoryController extends Controller
{
    public function index() {
        $categories = Category::orderBy('name')->get();

        return response()->json([
            "success" => true,
            "data" => $categories
        ]);
    }
}
