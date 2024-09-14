<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ClassCourse extends Model
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

    public function student()
    {
        return $this->belongsTo(User::class, 'student_id');
    }

    public function teacher()
    {
        return $this->belongsTo(User::class, 'teacher_id');
    }

    public function payments()
    {
        return $this->hasMany(Payment::class);
    }

//    public function students()
//    {
//        return $this->belongsToMany(User::class, 'class_course_user', 'class_course_id', 'student_id')
//            ->whereHas('role', function ($query) {
//                $query->where('name', 'student');
//            });
//    }
//
//    public function teachers()
//    {
//        return $this->belongsToMany(User::class, 'class_course_user', 'class_course_id', 'teacher_id')
//            ->whereHas('role', function ($query) {
//                $query->where('name', 'teacher');
//            });
//    }
}
