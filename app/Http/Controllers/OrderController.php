<?php

namespace App\Http\Controllers;

use App\Models\DeliveryOrder;
use App\Models\Order;
use App\Models\OrderProduct;
use App\Models\Product;
use App\Models\ShippingAgent;
use Illuminate\Http\Request;
use Auth;

class OrderController extends Controller
{
    public function getCart() {
        $user = Auth::user();

        $cart = Order::where('user_id', $user->id)->where('status', 0)->with(['products', 'delivery'])->first();

        return response()->json([
            "success" => true,
            "data" => $cart
        ]);
    }

    public function AddProduct() {

        $order_id = 0;

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
            $order_id = $hasOrder->id;
            $productOrder = OrderProduct::where('order_id', $hasOrder->id)->where('product_id', $product_id)->first();
            if ($productOrder) {
                $productOrder->quantity = $productOrder->quantity + $quantity;
                $productOrder->save();
               // $hasOrder->total_cost = $hasOrder->total_cost + ($product->price * $productOrder->quantity);
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

              //  $hasOrder->total_cost = $hasOrder->total_cost + ($product->price * $quantity);
                $hasOrder->save();
                $product->available_quantity = $product->available_quantity - $quantity;
                $product->save();
            }
        } else {
            $new_order = new Order();
            $new_order->user_id = $user->id;
            $new_order->total_cost = 0;
            $new_order->save();

            $order_id = $new_order->id;
            //$hasOrder = $new_order;

            $order = new OrderProduct();
            $order->order_id = $new_order->id;
            $order->product_id = $product->id;
            $order->quantity = $quantity;
            //$order->user_id = $user->id;
            $order->save();

            $product->available_quantity = $product->available_quantity - $quantity;
            $product->save();

            $agent = ShippingAgent::all()->random(1)->first();
            $estimate_date = now()->addDays(rand(3,7));

            $delivery = new DeliveryOrder();
            $delivery->order_id = $new_order->id;
            $delivery->shipping_agent_id = $agent->id;
            $delivery->delivery_date = $estimate_date;
            $delivery->save();
        }

        //$hasOrder->total_cost = $hasOrder->total_cost + ($product->price * $quantity) ;

        $update_order = Order::where('id', $order_id)->first();
        $update_order->total_cost = $update_order->total_cost + ($product->price * $quantity);
        $update_order->save();

        $cart = Order::where('user_id', $user->id)->where('status', 0)->with(['products', 'delivery'])->first();

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

    public function removeProduct() {
        $product_id = request('product_id');

        $user = Auth::user();

        $order = Order::where('user_id', $user->id)->where('status', 0)->first();

        if (!$order) {
            return response()->json(["success" => false, "error" => "La orden no existe."]);
        }

        $productInOrder = OrderProduct::where('order_id', $order->id)->where('product_id', $product_id)->first();

        if (!$productInOrder) {
            return response()->json(["success" => false, "error" => "El producto no existe en la orden."]);
        }

        $quantity = $productInOrder->quantity;

        $productInOrder->delete();
        $countable = OrderProduct::where('order_id', $order->id)->count();
        $product = Product::where('id', $product_id)->first();
        $product->available_quantity = $product->available_quantity + $quantity;
        $product->save();

        $order->total_cost = $order->total_cost - ($product->price * $quantity);
        $order->save();

        if ($countable==0) {
            $order->status = 1;
            $order->save();
        }

        $cart = Order::where('user_id', $user->id)->where('status', 0)->with('products')->first();

        return response()->json(["success" => true, "data" => $cart]);

    }
}
