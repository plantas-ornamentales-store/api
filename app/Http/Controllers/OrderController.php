<?php

namespace App\Http\Controllers;

use App\Models\Order;
use App\Models\OrderProduct;
use App\Models\Product;
use Illuminate\Http\Request;
use Auth;

class OrderController extends Controller
{
    public function getCart() {
        $user = Auth::user();

        $cart = Order::where('user_id', $user->id)->where('status', 0)->with('products')->first();

        return response()->json([
            "success" => true,
            "data" => $cart
        ]);
    }

    public function AddProduct() {

        $product_id = request('product_id');
        $quantity = request('quantity');

        $user = Auth::user();

        $product = Product::where('id', $product_id)->first();

        if (!$product) {
            return response()->json(["success" => false, "error" => "El producto no existe."]);
        }

        if ($product->available_quantity<$quantity) {
            return response()->json(["success" => false, "error" => "No hay suficiente stock de este producto, no se ha podido agregar al carrito."]);
        }

        $hasOrder = Order::where('user_id', $user->id)->where('status', 0)->first();

        if ($hasOrder) {
            $productOrder = OrderProduct::where('order_id', $hasOrder->id)->where('product_id', $product_id)->first();
            if ($productOrder) {
                $productOrder->quantity = $productOrder->quantity + $quantity;
                $productOrder->save();
                $hasOrder->total_cost = $hasOrder->total_cost + ($product->price * $productOrder->quantity);
                $hasOrder->save();
                $product->available_quantity = $product->available_quantity - $quantity;
                $product->save();
            } else {
                $order = new OrderProduct();
                $order->order_id = $hasOrder->id;
               // $order->user_id = $user->id;
                $order->product_id = $product->id;
                $order->quantity = $quantity;
                $order->save();

                $hasOrder->total_cost = $hasOrder->total_cost + ($product->price * $quantity);
                $hasOrder->save();
                $product->available_quantity = $product->available_quantity - $quantity;
                $product->save();
            }
        } else {
            $new_order = new Order();
            $new_order->user_id = $user->id;
            $new_order->total_cost = ($product->price * $quantity);
            $new_order->save();

            $order = new OrderProduct();
            $order->order_id = $new_order->id;
            $order->product_id = $product->id;
            $order->quantity = $quantity;
            //$order->user_id = $user->id;
            $order->save();

            $product->available_quantity = $product->available_quantity - $quantity;
            $product->save();
        }

        $cart = Order::where('user_id', $user->id)->where('status', 0)->with('products')->first();

        return response()->json([
            "success" => true,
            "data" => $cart
        ]);
    }

    public function payOrder() {
        $order = request('order_id');

        $orderCheck = Order::where('id', $order)->first();

        if (!$orderCheck) {
            return response()->json(["success" => false, "error" => "La orden a pagar no existe."]);
        }

        if ($orderCheck->status==1) {
            return response()->json(["success" => false, "error" => "La orden a pagar ya ha sido pagada previamente."]);
        }

        $orderCheck->status = 1;
        $orderCheck->save();

        return response()->json(["success" => true, "data" => $order]);

    }
}
