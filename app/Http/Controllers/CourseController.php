<?php

namespace App\Http\Controllers;

use App\Models\Course;
use App\Models\Payment;
use App\Models\User;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Http\Request;
use App\Traits\ApiResponseController;
use App\Http\Requests\RegisterCourseRequest;
use App\Http\Requests\UpdateCourseRequest;
use Illuminate\Support\Facades\Auth;

class CourseController extends Controller
{
    use ApiResponseController;
    public function show()
    {
        $courses = Course::with('course_category')->get();
        if ($courses->isEmpty()) {
            return $this->notFoundResponse([
                'message' => 'No courses found'
            ]);
        }
        return $this->successResponse($courses->toArray());
    }

    public function show_single()
    {
        $course_id = request('course_id');
        $course = Course::where('id', $course_id)->with('course_category')->first();
        if($course){
            return $this->successResponse($course->toArray());
        }
        return $this->notFoundResponse([
            'message' => 'Course not found'
        ]);
    }

    public function course_buyers()
    {
        $course_id = request('course_id');
        $course_with_users = Course::where('id', $course_id)->with('users')->first()->toArray();
        if($course_with_users['users']){
            foreach ($course_with_users['users'] as $user) {
                $ids[] = $user['id'];
            }
            $payments = Payment::where('course_id', $course_id)->whereIn('user_id', $ids)->with('user')->get()->toArray();
            if($payments){
                return $this->successResponse(['data' => $payments]);
            }
            return $this->notFoundResponse([
                'message' => 'No payments were found.'
            ]);
        }
        return $this->notFoundResponse([
            'message' => 'No course buyers were found.'
        ]);
    }

    public function course_buyer_info()
    {
        $user_id = request('user_id');
        $user = User::with('files', 'courses', 'clientSessions', 'studentClasses')->find($user_id);
        if($user){
            return $this->successResponse(['data' => $user]);
        }
        return $this->notFoundResponse([
            'message' => 'User was not found.'
        ]);
    }

    public function course_payment_confirm()
    {
        $payment_id = request('payment_id');
        $new_payment_status = request('payment_status');
        $payment = Payment::find($payment_id);
        $user = User::find($payment->user_id);
        $course = Course::find($payment->course_id);
        if($payment){
            $payment->status = $new_payment_status;
            $payment->save();

            switch ($new_payment_status) {
                case 0: // set status to pending
                    $user->courses()->updateExistingPivot($course->id, ['status' => 0]);
                    break;
                case 1: // set status to confirmed
                    $user->courses()->updateExistingPivot($course->id, ['status' => 1]);
                    break;
                case 2: // set status to declined
                    $user->courses()->detach($course->id);
                    break;
                default:
                    return $this->errorResponse([
                        'message' => 'Status code is incorrect'
                    ]);
            }
            return $this->successResponse($payment->toArray());
        }
        return $this->notFoundResponse([
            'message' => 'Payment not found'
        ]);
    }

    public function not_confirmed_course_payments()
    {
        $payments = Payment::whereNot('course_id', null)->where('status', false)->get()->toArray();
        if($payments)
        {
            return $this->successResponse($payments);
        }
        return $this->notFoundResponse([
            'message' => 'No payments found'
        ]);
    }

    public function course_payments()
    {
        $payments = Payment::whereNot('course_id', null)->get()->toArray();
        if($payments)
        {
            return $this->successResponse($payments);
        }
        return $this->notFoundResponse([
            'message' => 'No payments found'
        ]);
    }

    public function create(RegisterCourseRequest $request)
    {
        $validated = $request->validated();
        $course = Course::create($validated);
        return $this->successResponse($course->toArray());
    }

    public function update(UpdateCourseRequest $request)
    {
        $course_id = request()->course_id;
        $validated = $request->validated();
        $request->request->remove('id');
        Course::where('id', $course_id)->update($validated);
        $course = Course::find($course_id);
        return $this->successResponse($course->toArray());

    }

    public function status_switch()
    {
        $course_id = request()->course_id;
        $course = Course::find($course_id);
        $course->status = ($course->status) ? 0 : 1;
        $course->save();
        return $this->successResponse($course->toArray());
    }

    public function course_buyer_send_sms()
    {
        $user_id = request('user_id');
        $message = request('message');
        $buyer = User::find($user_id);
        if($buyer->phone_number)
        {
            // todo
        }
        return $this->errorResponse([
            'message' => 'Buyer\'s phone number not registered'
        ]);

    }

    public function my_courses()
    {
        $user_id = Auth::user()->id;
        $courses = User::find($user_id)->courses()->wherePivot('status', true)->get();
        if($courses->count() > 0){
            return $this->successResponse($courses->toArray());
        }
        return $this->notFoundResponse([
            'message' => 'No courses found'
        ]);
    }

    public function delete()
    {
        $course_id = request('course_id');
        $course = Course::find($course_id);
        if($course){
            $course->delete();
            return $this->successResponse([
                'message' => 'Course deleted'
            ]);
        }
        return $this->notFoundResponse([
            'message' => 'Course not found'
        ]);
    }
}
