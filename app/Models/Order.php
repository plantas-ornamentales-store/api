<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Order extends Model
{
    use HasFactory;

    public function products() {
        return $this->hasMany(OrderProduct::class)->with('product');
    }

    public function delivery() {
        return $this->hasOne(DeliveryOrder::class)->with('agent');
    }
}
