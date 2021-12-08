<?php

namespace App\Http\Controllers;

use App\Models\Category;
use App\Models\Product;
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

    public function products($id) {
        $products = Product::where('category_id', $id)->get();
        $category = Category::where('id', $id)->first();

        $data = [
            "products" => $products,
            "category" => $category
        ];

        return response()->json([
            "success" => true,
            "data" => $data
        ]);
    }
}
