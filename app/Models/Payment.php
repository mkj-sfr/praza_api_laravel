<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Payment extends Model
{
    use HasFactory;

    protected $guarded = [];


    protected $hidden = [
        'updated_at',
    ];

    public function user()
    {
        return $this->belongsTo(User::class);
    }

    public function course()
    {
        return $this->belongsTo(Course::class);
    }

    public function counsel()
    {
        return $this->belongsTo(Counsel::class);
    }

    public function classCourse()
    {
        return $this->belongsTo(ClassCourse::class);
    }

    public function invoice()
    {
        return $this->belongsTo(Invoice::class);
    }
}
