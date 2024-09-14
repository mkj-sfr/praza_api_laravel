<?php

namespace App\Http\Controllers;

use App\Models\Upload;
use App\Traits\ApiResponseController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;

class UploadController extends Controller
{
    use ApiResponseController;

    public function show()
    {
        $files = Upload::all();
        if ($files) {
            return $this->successResponse($files);
        }
        return $this->notFoundResponse([
            'message' => 'No uploads found'
        ]);
    }

    public function create()
    {
        if (request()->hasFile('file')) {
            $file = request()->file('file');
            $path = $file->storePublicly('files', 'public');
            $file = Upload::create([
                'name' => $file->hashName(),
                'size' => $file->getSize(),
                'path' => $path,
                'extension' => $file->extension(),
                'type' => request()->file_type,
                'upload_by' => request()->user_id,
            ]);
            return $this->successResponse($file);
        }
        return $this->errorResponse([
            'message' => 'No file to upload',
        ]);
    }

    public function update()
    {
        if (request()->hasFile('file')) {
            $file_id = request()->file_id;
            $file = request()->file('file');
            $path = $file->storePublicly('files', 'public');
            $file = Upload::find($file_id)->update([
                'name' => $file->hashName(),
                'size' => $file->getSize(),
                'path' => $path,
                'type' => request()->file_type,
                'upload_by' => request()->user_id,
            ]);
            return $this->successResponse($file);
        }
        return $this->errorResponse([
            'message' => 'No file to upload',
        ]);

    }

    public function delete()
    {
        $file_id = request()->file_id;
        $file = Upload::find($file_id);
        $file->status = false;
        $file->save();
        Storage::disk('public')->delete($file->path);
        return $this->successResponse($file);
    }
}
