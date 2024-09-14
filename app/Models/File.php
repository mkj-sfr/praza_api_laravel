<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class File extends Model
{
    use HasFactory;

    protected $fillable = [
        'name',
        'type',
        'status',
        'user_id',
    ];

    protected $hidden = [

    ];

    public function tasks()
    {
        return $this->hasMany(Task::class);
    }
}
