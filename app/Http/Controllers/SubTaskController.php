<?php

namespace App\Http\Controllers;

use App\Models\Task;
use Illuminate\Http\Request;
use App\Traits\ApiResponseController;
use App\Http\Requests\RegisterSubTaskRequest;
use App\Http\Requests\UpdateSubTaskRequest;
use App\Models\SubTask;

class SubTaskController extends Controller
{
    use ApiResponseController;

    public function show()
    {
        $task_id = request('task_id');
        $task_with_sub_tasks = Task::where('id', $task_id)->with('subTasks')->first()->toArray();
        return $this->successResponse($task_with_sub_tasks['subTasks']);
    }

    public function show_single()
    {
        $sub_task_id = request('sub_task_id');
        $sub_task = SubTask::find($sub_task_id);
        return $this->successResponse($sub_task->toArray());
    }

    public function create(RegisterSubTaskRequest $request) {
        if(request()->hasFile('file')){
            // todo
        }
        $validated = $request->validated();
        $sub_task = SubTask::create($validated);
        return $this->successResponse($sub_task->toArray());
    }

    public function update(UpdateSubTaskRequest $request) {
        $sub_task_id = request('sub_task_id');
        if(request()->hasFile('file')){
            // todo
        }
        $validated = $request->validated();
        SubTask::find($sub_task_id)->update($validated);
        $sub_task = SubTask::find($sub_task_id);
        return $this->successResponse($sub_task->toArray());
    }

    public function status_switch()
    {
        $sub_task_id = request('sub_task_id');
        $sub_task = SubTask::find($sub_task_id);
        if($sub_task){
            $sub_task->status = !$sub_task->status;
            $sub_task->save();
            return $this->successResponse($sub_task->toArray());
        }
        return $this->errorResponse([
            'message' => 'Sub task not found',
        ]);
    }

    public function delete()
    {
        $sub_task_id = request('sub_task_id');
        if(request()->hasFile('file')){
            // todo
        }
        SubTask::destroy($sub_task_id);
        return $this->successResponse([
            'message' => 'Sub task deleted'
        ]);
    }
}
