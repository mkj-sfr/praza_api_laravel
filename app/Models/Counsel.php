<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Counsel extends Model
{
    use HasFactory;

    protected $guarded = [];

    protected $hidden = [
        'created_at',
        'updated_at',
    ];

    public function session()
    {
        return $this->belongsTo(UserAvailableSession::class, 'session_id');
    }

    public function platform()
    {
        return $this->belongsTo(Platform::class);
    }

    public function client()
    {
        return $this->belongsTo(User::class, 'client_id');
    }

    public function counselor()
    {
        return $this->belongsTo(User::class, 'counselor_id');
    }

    public function payments()
    {
        return $this->hasMany(Payment::class);
    }

    public function counselingType()
    {
        return $this->belongsTo(CounselingType::class);
    }


//    public function counselors()
//    {
//        return $this->belongsToMany(User::class, 'counsel_user', 'counsel_id', 'counselor_id');
//            ->whereHas('role', function ($query) {
//                $query->where('name', 'counselor');
//            });
//    }

//    public function clients()
//    {
//        return $this->belongsToMany(User::class, 'counsel_user', 'counsel_id', 'client_id');
//            ->whereHas('role', function ($query) {
//                $query->where('name', 'student');
//            });
//    }
}
