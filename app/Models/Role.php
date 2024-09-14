<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Role extends Model
{
    use HasFactory;

    protected $guarded = [];


    protected $hidden = [
        'updated_at',
        'created_at',
    ];

    public function pages() {
        return $this->belongsToMany(Page::class);
    }

    public function users() {
        return $this->hasMany(User::class);
    }
}
