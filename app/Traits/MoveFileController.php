<?php

namespace App\Traits;
use Illuminate\Support\Facades\File;

trait MoveFileController
{
    public function move_file($sourcePath, $destinationPath)
    {
        if (File::exists($sourcePath)) {
            // Move the file
            File::move($sourcePath, $destinationPath);
            return $destinationPath;
        } else {
            return false;
        }
    }
}