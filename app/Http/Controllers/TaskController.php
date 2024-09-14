<?php

namespace App\Http\Controllers;

use App\Models\File;
use App\Models\Task;
use Illuminate\Http\Request;
use App\Http\Requests\RegisterTaskRequest;
use App\Http\Requests\UpdateTaskRequest;
use App\Traits\ApiResponseController;


class TaskController extends Controller
{
    use ApiResponseController;

    public function show()
    {
        $file_id = request('file_id');
        $file_with_tasks = File::where('id', $file_id)->with('tasks')->first()->toArray();
        return $this->successResponse($file_with_tasks['tasks']);
    }

    public function show_single()
    {
        $task_id = request('task_id');
        $task = Task::find($task_id);
        return $this->successResponse($task->toArray());
    }

    public function create(RegisterTaskRequest $request)
    {
        $validated = $request->validated();
        $task = Task::create($validated);
        return $this->successResponse($task->toArray());
    }

    public function update(UpdateTaskRequest $request)
    {
        $task_id = request('task_id');
        $validated = $request->validated();
        Task::find($task_id)->update($validated);
        $task = Task::find($task_id);
        return $this->successResponse($task->toArray());
    }

    public function delete()
    {
        $task_id = request('document_step_id');
        Task::destroy($task_id);
        return $this->successResponse([
            'message' => 'Task deleted'
        ]);
    }
}
