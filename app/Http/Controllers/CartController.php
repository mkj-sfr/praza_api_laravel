<?php

namespace App\Http\Controllers;

use App\Models\Cart;
use App\Models\Course;
use App\Models\User;
use Illuminate\Http\Request;
use App\Traits\ApiResponseController;
use App\Http\Requests\RegisterCartRequest;
use Illuminate\Support\Facades\Auth;


class CartController extends Controller
{
    use ApiResponseController;
    public function show()
    {
        $user_id = Auth::user()->id;
        $carts = Cart::where('user_id', $user_id)->get();
        if($carts->toArray())
        {
             return $this->successResponse(['data' => $carts]);
        }
        return $this->notFoundResponse([
            'message' => 'No carts were found'
        ]);
    }

    public function create(RegisterCartRequest $request)
    {
        $validated = $request->validated();
        $validated['user_id'] = Auth::user()->id;
        $cart = Cart::where([
            ['user_id', $validated['user_id']],
            ['course_id', $validated['course_id']],
        ])->first();
        $pivot = Course::find($validated['course_id'])->users()->wherePivot('user_id', $validated['user_id'])->exists();
        if(!$cart) {
            if(!$pivot) {
                $cart = Cart::create($validated);
                Course::find($validated['course_id'])->users()->attach($validated['user_id']);
                return $this->successResponse(['data' => $cart]);
            }
            return $this->errorResponse([
                'message' => 'You\'ve already bought this course'
            ]);
        }
        return $this->errorResponse([
            'message' => 'This course is already in your cart.'
        ]);
    }

    public function delete()
    {
        $user_id = Auth::user()->id;
        $course_id = request('course_id');
        $cart = Cart::where([
            ['user_id', $user_id],
            ['course_id', $course_id],
        ])->first();
        $pivot = Course::find($course_id)->users()->wherePivot('user_id', $user_id)->exists();
        if($cart) {
            if ($pivot) {
                if(!$pivot->status) {
                    Cart::where([
                        ['user_id', $user_id],
                        ['course_id', $course_id],
                    ])->delete();
                    Course::find($course_id)->users()->detach($user_id);
                    return $this->successResponse([
                        'message' => 'Cart item deleted successfully.'
                    ]);
                }
                return $this->errorResponse([
                    'message' => 'This course is already bought.'
                ]);
            }
            return $this->notFoundResponse([
                'message' => 'This course is in your cart but not registered for buy.'
            ]);
        }
        return $this->notFoundResponse([
            'message' => 'This course is not in your cart.'
        ]);
    }

    public function delete_all()
    {
        $user_id = Auth::user()->id;
        Cart::where('user_id', $user_id)->delete();
        User::find($user_id)->courses()->detach();
        return $this->successResponse([
            'message' => 'User cart deleted successfully'
        ]);
    }
}
