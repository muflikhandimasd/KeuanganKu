<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Account extends Model
{
    use HasFactory;

    protected $guarded = [];

    function user(): BelongsTo
    {
        return $this->belongsTo(User::class, 'user_id');
    }

    function transactions()
    {
        return $this->hasMany(Transaction::class);
    }
}