<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Task extends Model
{
    use HasFactory;

    protected $guarded = [];


    protected $hidden = [
        'created_at',
        'updated_at',
    ];

    public function file()
    {
        return $this->belongsTo(File::class);
    }

    public function subTasks()
    {
        return $this->hasMany(SubTask::class);
    }
}
