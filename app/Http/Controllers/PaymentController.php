<?php

namespace App\Http\Controllers;

use App\Models\Invoice;
use App\Models\Payment;
use Illuminate\Http\Request;
use App\Traits\ApiResponseController;
use App\Http\Requests\RegisterPaymentRequest;



class PaymentController extends Controller
{
    use ApiResponseController;

    public function show()
    {
        $payments = Payment::with('invoice')->get();
        if ($payments->isEmpty()) {
            return $this->errorResponse([
                'message' => 'No payments found',
            ]);
        }
        return $this->successResponse($payments->toArray());
    }

    public function create(RegisterPaymentRequest $request)
    {
        $validated = $request->validated();
        $invoice = Invoice::create([
            'price' => $validated['price'],
            'payment_method' => $validated['payment_method'],
            'billing_id' => $validated['billing_id'],
            'payment_id' => $validated['payment_id'],
            'status' => 1,
            'user_id' => $validated['user_id'],
            'upload_id' => null,
        ]);
        $validated['invoice_id'] = $invoice->id;
        $payment = Payment::create($validated);
        return $this->successResponse($payment->toArray());
    }
}
