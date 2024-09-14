<?php

namespace App\Http\Controllers;

use App\Models\CourseCategory;
use Illuminate\Http\Request;
use App\Traits\ApiResponseController;
use App\Http\Requests\RegisterCourseCategoryRequest;
use App\Http\Requests\UpdateCourseCategoryRequest;



class CourseCategoryController extends Controller
{
    use ApiResponseController;

    public function show()
    {
        $categoriesWithChildren = CourseCategory::with('children')->get()->toArray();
        if($categoriesWithChildren){
            return $this->successResponse($categoriesWithChildren);
        }
        return $this->notFoundResponse([
            'message' => 'No categories found',
        ]);
    }

    public function show_single()
    {
        $course_category_id = request('course_category_id');
        $course_category = CourseCategory::find($course_category_id);
        return $this->successResponse($course_category->toArray());
    }

    public function create(RegisterCourseCategoryRequest $request)
    {
        $validated = $request->validated();
        $created = CourseCategory::create($validated);
        return $this->successResponse($created->toArray());
    }

    public function update(UpdateCourseCategoryRequest $request)
    {
        $course_category_id = $request->course_category_id;
        $request->request->remove('course_category_id');
        $validated = $request->validated();
        CourseCategory::find($course_category_id)->update($validated);
        $updated = CourseCategory::find($course_category_id);
        return $this->successResponse($updated->toArray());
    }

    public function status_switch()
    {
        $course_category_id = request('course_category_id');
        $category = CourseCategory::find($course_category_id);
        if($category){
            $category->status = !$category->status;
            $category->save();
            return $this->successResponse($category->toArray());
        }
        return $this->notFoundResponse([
            'message' => 'No category found',
        ]);
    }

    public function delete()
    {
        $course_category_id = request('course_category_id');
        $result = CourseCategory::destroy($course_category_id);
        if($result){
            return $this->successResponse([
                'message' => 'Category deleted'
            ]);
        }
        else{
            return $this->notFoundResponse([
                'message' => 'No category found'
            ]);
        }
    }
}
