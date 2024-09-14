<?php

namespace App\Http\Controllers;

use App\Models\ClassCourse;
use Illuminate\Http\Request;
use App\Traits\ApiResponseController;
use App\Models\User;
use App\Http\Requests\RegisterClassCourseRequest;
use App\Http\Requests\UpdateClassCourseRequest;
use Illuminate\Support\Facades\Auth;


class ClassCourseController extends Controller
{
    use ApiResponseController;

    public function show()
    {
        $classes = ClassCourse::with('session', 'student', 'teacher', 'platform')->get();
        if($classes->count() > 0)
        {
            return $this->successResponse(['data' => $classes->toArray()]);
        }
        return $this->errorResponse([
            'message' => 'No classes were found',
        ]);
    }

    public function show_by_user_role()
    {
        $user_id = Auth::user()->id;
        if(request()->has('user_id') && !empty(request('user_id'))) {
            $user_id = request('user_id');
        }
        $user = User::with('role', 'teacherClasses', 'studentClasses')->find($user_id);
        $classes = ($user->role->name == 'teacher') ? $user->teacherClasses : $user->studentClasses;
        if($classes->count() > 0)
        {
            return $this->successResponse(['data' => $classes->toArray()]);
        }
        return $this->notFoundResponse([
            'message' => "No classes were found",
        ]);
    }

    public function show_single()
    {
        $class_id = request('class_id');
        $class = ClassCourse::with('session', 'student', 'teacher', 'platform')->find($class_id);
        if($class){
            return $this->successResponse(['data' => $class->toArray()]);
        }
        return $this->notFoundResponse([
            'message' => "Class does not exist",
        ]);
    }

    public function create(RegisterClassCourseRequest $request)
    {
        $validated = $request->validated();
        if(!(request()->has('student_id')) or empty(request('student_id'))) {
            $validated['student_id'] = Auth::user()->id;
        }
        if(!(request()->has('teacher_id')) or empty(request('teacher_id'))) {
            $validated['teacher_id'] = Auth::user()->id;
        }
        $class = ClassCourse::create($validated);
        return $this->successResponse(['data' => $class->toArray()]);
    }

    public function update(UpdateClassCourseRequest $request)
    {
        $class_id = request('class_id');
        $validated = $request->validated();
        if(!(request()->has('student_id')) or empty(request('student_id'))) {
            $validated['student_id'] = Auth::user()->id;
        }
        if(!(request()->has('teacher_id')) or empty(request('teacher_id'))) {
            $validated['teacher_id'] = Auth::user()->id;
        }
        ClassCourse::find($class_id)->update($validated);
        $class = ClassCourse::where('id', $class_id)->with('teacher', 'student', 'platform', 'session')->first();
        return $this->successResponse(['data' => $class->toArray()]);
    }

    public function delete()
    {
        $class_id = request('class_id');
        ClassCourse::destroy($class_id);
        return $this->successResponse([
            'message' => "Class has been deleted"
        ]);
    }
}
