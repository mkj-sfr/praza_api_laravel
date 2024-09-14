<?php

namespace App\Http\Controllers;

use App\Models\Cart;
use App\Models\ClassCourse;
use App\Models\Counsel;
use App\Models\Course;
use App\Models\DiscountCode;
use App\Models\Invoice;
use App\Models\Payment;
use Illuminate\Http\Request;
use App\Traits\ApiResponseController;
use App\Http\Requests\RegisterInvoiceRequest;
use App\Http\Requests\ValidatePortalRequest;
use App\Http\Requests\ValidateInvoiceRequest;
use Illuminate\Support\Facades\Auth;

class InvoiceController extends Controller
{
    use ApiResponseController;

//    public function show()
//    {
//        $payment_id = request('payment_id');
//        $user_id = request('user_id');
//        $payment_with_invoices = Payment::where('id', $payment_id)->with('invoice')->get();
//        if ($payment_with_invoices->invoice) {
//            $all_invoices = $payment_with_invoices->invoice;
//            foreach ($all_invoices as $invoice) {
//                if ($invoice->user_id == $user_id) {
//                    $invoices[] = $invoice;
//                }
//            }
//            return $this->successResponse($invoices);
//        }
//        return $this->notFoundResponse([
//            'message' => 'No invoices were found'
//        ]);
//    }


    public function show()
    {
        $invoice = Invoice::with('payments')->get();
        if ($invoice->isEmpty()) {
            return $this->errorResponse([
                'message' => 'No Invoices were found',
            ]);
        }
        return $this->successResponse(['data' => $invoice->toArray()]);
    }

    public function show_invoice_payments()
    {
        $invoice_id = request('invoice_id');
        $invoice_with_payments = Invoice::with('payments')->find($invoice_id);
        if ($invoice_with_payments->isEmpty()) {
            return $this->errorResponse([
                'message' => 'No Invoice was found',
            ]);
        }
        return $this->successResponse(['data' => $invoice_with_payments->toArray()]);
    }

    public function validate_price(ValidatePortalRequest $request)
    {
        $validated = $request->validated();
        if ($validated['counsel_id']) {
            $counsel = Counsel::where('id', $validated['counsel_id'])->with('counselor')->first()->toArray();
            $price = $counsel['counselor']['price'];
            $discount = DiscountCode::where([
                ['code', $validated['discount_code']],
                ['discount_for', 1],
                ['status', 1],
            ])->first();
            if ($discount->type) {
                $price = $price * (100 - $discount->amount);
            } else {
                $price = $price - $discount->amount;
            }
            return $this->successResponse(['price' => $price]);
        } elseif ($validated['cart']) {
            $user_id = Auth::user()->id;
            $discount = DiscountCode::where([
                ['code', $validated['discount_code']],
                ['discount_for', 0],
                ['status', 1],
            ])->first();
            $courses_in_carts = Cart::where('user_id', $user_id)->pluck('course_id')->toArray();
            $courses = Course::whereIn('id', $courses_in_carts)->get()->toArray();
            foreach ($courses as $course) {
                $price += $course['price'];
            }
            if ($discount->type) {
                $price = $price * (100 - $discount->amount);
            } else {
                $price = $price - $discount->amount;
            }
            return $this->successResponse(['price' => $price]);
        } elseif ($validated['class_id']) {
            $class = ClassCourse::where('id', $validated['class_id'])->with('teacher')->first()->toArray();
            $price = $class['teacher']['price'];
            $discount = DiscountCode::where([
                ['code', $validated['discount_code']],
                ['discount_for', 2],
                ['status', 1],
            ])->first();
            if ($discount->type) {
                $price = $price * (100 - $discount->amount);
            } else {
                $price = $price - $discount->amount;
            }
            return $this->successResponse(['price' => $price]);
        }
        return $this->errorResponse([
            'message' => 'Price did not validated'
        ]);
    }

    public function register_invoice_from_cart(RegisterInvoiceRequest $request)
    {
        $validated = $request->validated();
        $user_id = Auth::user()->id;
        $validated['user_id'] = $user_id;
        $validated['status'] = false;
        $validated['payment_method'] = 'portal';
        $invoice = Invoice::create($validated);
        $courses_in_carts = Cart::where('user_id', $user_id)->pluck('course_id');
        $courses_in_carts = ($courses_in_carts) ? $courses_in_carts->toArray() : null;
        if (count($courses_in_carts) > 1) {
            $courses = Course::whereIn('id', $courses_in_carts)->get()->toArray();
            foreach ($courses as $course) {
                Payment::create([
                    'price' => $course['price'],
                    'description' => 'خرید دوره',
                    'payment_method' => $validated['payment_method'],
                    'status' => 0,
                    'user_id' => $user_id,
                    'course_id' => $course['id'],
                    'invoice_id' => $invoice->id,
                ]);
            }
            Cart::where('user_id', $user_id)->delete();
            return $this->successResponse(['data' => $invoice]);
        } elseif (count($courses_in_carts) == 1) {
            $course = Course::where('id', $courses_in_carts[0])->first()->toArray();
            Payment::create([
                'price' => $course['price'],
                'description' => 'خرید دوره',
                'billing_id' => $validated['billing_id'],
                'payment_id' => $validated['payment_id'],
                'payment_method' => $validated['payment_method'],
                'status' => 0,
                'user_id' => $user_id,
                'course_id' => $course['id'],
                'invoice_id' => $invoice->id,
            ]);
            Cart::where('user_id', $user_id)->delete();
            return $this->successResponse(['data' => $invoice]);
        }
        return $this->errorResponse([
            'message' => 'User cart is empty.'
        ]);
    }

    public function register_invoice(RegisterInvoiceRequest $request)
    {
        if (request('counsel_id')) {
            $counsel = Counsel::where('id', request('counsel_id')->with('client', 'counselor')->first()->toArray());
            $invoice = Invoice::create([
                'price' => $counsel['counselor']['price'],
                'payment_method' => 'portal',
                'status' => 0,
                'user_id' => $counsel['client']['id'],
            ]);
            Payment::create([
                'price' => $counsel['counselor']['price'],
                'description' => 'رزرو وقت مشاوره',
                'payment_method' => 'portal',
                'status' => 0,
                'user_id' => $counsel['client']['id'],
                'counsel_id' => $counsel['id'],
                'invoice_id' => $invoice->id,
            ]);
        } elseif (request('class_id')) {
            $class = ClassCourse::where('id', request('class_id')->with('student', 'teacher')->first()->toArray());
            $invoice = Invoice::create([
                'price' => $class['teacher']['price'],
                'payment_method' => 'portal',
                'status' => 0,
                'user_id' => $class['student']['id'],
            ]);
            Payment::create([
                'price' => $class['teacher']['price'],
                'description' => 'رزرو کلاس',
                'payment_method' => 'portal',
                'status' => 0,
                'user_id' => $class['student']['id'],
                'class_course_id' => $class['id'],
                'invoice_id' => $invoice->id,
            ]);
        }
        return $this->errorResponse([
            'message' => 'class_id or counsel_id is needed.'
        ]);
    }

    public function validate_invoice(ValidateInvoiceRequest $request)
    {
        $validated = $request->validated();
        $invoice = Invoice::where('id', $validated['invoice_id'])->with('payments')->first();
        if ($validated['status']) {
            foreach ($invoice->payments as $payment) {
                $payment->update([
                    'status' => 1,
                    'billing_id' => $validated['billing_id'],
                    'payment_id' => $validated['payment_id']
                ]);
                if($payment->course_id) {
                    Course::find($payment->course_id)->users()->updateExistingPivot($payment->user_id, ['status' => 1]);
                } elseif ($payment->class_course_id) {
                    ClassCourse::find($payment->class_course_id)->update(['status' => 1]);
                } elseif ($payment->counsel_id) {
                    Counsel::find($payment->counsel_id)->update(['status' => 1]);
                }
            }
            $invoice->update([
                'status' => true,
                'billing_id' => $validated['billing_id'],
                'payment_id' => $validated['payment_id']
            ]);
            return $this->successResponse([
                'message' => 'Payment validated successfully'
            ]);
        } else {
            $invoice->update(['is_trashed', true]);
            foreach ($invoice->payments as $payment) {
                $payment->update(['is_trashed' => true]);
                if($payment->course_id) {
                    Course::find($payment->course_id)->users()->detach($payment->user_id);
                } elseif ($payment->class_course_id) {
                    ClassCourse::find($payment->class_course_id)->delete();
                } elseif ($payment->counsel_id) {
                    Counsel::find($payment->counsel_id)->delete();
                }
            }
            return $this->errorResponse([
                'message' => 'Payment did not verified.'
            ]);
        }
    }
}
