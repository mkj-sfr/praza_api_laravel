<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class SubTask extends Model
{
    use HasFactory;

    protected $guarded = [];


    protected $hidden = [
        'created_at',
        'updated_at',
    ];

    public function document() {
        return $this->belongsTo(Upload::class, 'upload_id');
    }

    public function task()
    {
        return $this->belongsTo(Task::class);
    }
}
