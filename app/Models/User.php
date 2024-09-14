<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Laravel\Sanctum\HasApiTokens;

class User extends Authenticatable
{
    use HasApiTokens, HasFactory, Notifiable;

    /**
     * The attributes that are mass assignable.
     *
     * @var array<int, string>
     */
    protected $guarded = [];

    /**
     * The attributes that should be hidden for serialization.
     *
     * @var array<int, string>
     */
    protected $hidden = [
        'password',
        'remember_token',
        'updated_at',
        'email_verified_at',
        'role_assigned_date',
    ];

    /**
     * The attributes that should be cast.
     *
     * @var array<string, string>
     */
    protected $casts = [
        'email_verified_at' => 'datetime',
    ];

    public function role() {
        return $this->belongsTo(Role::class);
    }

    public function payments() {
        return $this->hasMany(Payment::class);
    }

    public function courses()
    {
        return $this->belongsToMany(Course::class)->wherePivot('status', 0)->with('course_category');
    }

    public function files()
    {
        return $this->hasMany(File::class);
    }

    public function carts()
    {
        return $this->hasMany(Cart::class);
    }

    public function clientSessions()
    {
        return $this->hasMany(Counsel::class, 'client_id');
    }

    public function counselorSessions()
    {
        return $this->hasMany(Counsel::class, 'counselor_id');
    }

    public function studentClasses()
    {
        return $this->hasMany(ClassCourse::class, 'student_id');
    }

    public function teacherClasses()
    {
        return $this->hasMany(ClassCourse::class, 'teacher_id');
    }

//    public function teacherClasses()
//    {
//        return $this->belongsToMany(ClassCourse::class, 'class_course_user', 'user_id', 'class_course_id')
//            ->whereHas('role', function ($query) {
//                $query->where('name', 'teacher');
//            });
//    }
//
//    public function studentClasses()
//    {
//        return $this->belongsToMany(ClassCourse::class, 'class_course_user', 'user_id', 'class_course_id')
//            ->whereHas('role', function ($query) {
//                $query->where('name', 'student');
//            });
//    }
//
//    public function counselorSessions()
//    {
//        return $this->belongsToMany(Counsel::class, 'counsel_user', 'user_id', 'counsel_id')
//            ->whereHas('role', function ($query) {
//                $query->where('name', 'counselor');
//            });
//    }
//
//    public function clientSessions()
//    {
//        return $this->belongsToMany(Counsel::class, 'counsel_user', 'user_id', 'counsel_id')
//            ->whereHas('role', function ($query) {
//                $query->where('name', 'student');
//            });
//    }
}
