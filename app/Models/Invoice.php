<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Invoice extends Model
{
    use HasFactory;

    protected $fillable = [
        'description',
        'price',
        'payment_id',
    ];

    protected $hidden = [
        'updated_at',
    ];

    public function payments()
    {
        return $this->hasMany(Payment::class);
    }

    public function receipt()
    {
        $this->belongsTo(Upload::class, 'upload_id');
    }
}
