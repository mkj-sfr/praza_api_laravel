<?php

namespace App\Http\Controllers;

use App\Models\File;
use Illuminate\Http\Request;
use App\Traits\ApiResponseController;
use App\Http\Requests\RegisterFileRequest;
use App\Http\Requests\UpdateFileRequest;

class FileController extends Controller
{
    use ApiResponseController;

    public function show()
    {
        $files = File::all();
        if($files->isEmpty()){
            return $this->notFoundResponse([
                'message' => 'No files found'
            ]);
        }
        return $this->successResponse($files->toArray());
    }

    public function show_single()
    {
        $file_id = request('file_id');
        $file = File::find($file_id);
        return $this->successResponse($file->toArray());
    }

    public function create(RegisterFileRequest $request)
    {
        $validated = $request->validated();
        $file = File::create($validated);
        return $this->successResponse($file->toArray());
    }

    public function update(UpdateFileRequest $request)
    {
        $file_id = request('file_id');
        $validated = $request->validated();
        File::find($file_id)->update($validated);
        $file = File::find($file_id);
        return $this->successResponse($file->toArray());
    }

    public function status_switch()
    {
        $file_id = request('file_id');
        $file = File::find($file_id);
        $file->status = !$file->status;
        $file->save();
        return $this->successResponse($file->toArray());
    }

    public function delete()
    {
        $file_id = request('file_id');
        File::destroy($file_id);
        return $this->successResponse([
            'message' => 'File deleted'
        ]);
    }
}
