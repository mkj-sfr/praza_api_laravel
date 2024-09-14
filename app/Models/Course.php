<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Course extends Model
{
    use HasFactory;

    protected $guarded = [];

    protected $hidden = [
        'created_at',
        'updated_at',
    ];

    public function payments()
    {
        return $this->hasMany(Payment::class);
    }

    public function users()
    {
        return $this->belongsToMany(User::class);
    }

    public function course_category()
    {
        return $this->belongsTo(CourseCategory::class);
    }

    public function carts()
    {
        return $this->hasMany(Cart::class);
    }

    public function platform()
    {
        return $this->belongsTo(Platform::class);
    }
}
