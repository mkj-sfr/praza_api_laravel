<?php

namespace App\Http\Controllers;

use App\Models\DiscountCode;
use Illuminate\Http\Request;
use App\Traits\ApiResponseController;
use App\Http\Requests\RegisterDiscountCodeRequest;
use App\Http\Requests\UpdateDiscountCodeRequest;

class DiscountCodeController extends Controller
{
    use ApiResponseController;

    public function show()
    {
        $discount_codes = DiscountCode::all();
        if ($discount_codes->isEmpty()) {
            return $this->notFoundResponse([
                'message' => 'No discount codes found'
            ]);
        }
        return $this->successResponse(['data' => $discount_codes->toArray()]);
    }

    public function show_single()
    {
        $discount_code_id = request('discount_code_id');
        $discount_code = DiscountCode::find($discount_code_id);
        return $this->successResponse(['data' => $discount_code->toArray()]);
    }

    public function create(RegisterDiscountCodeRequest $request)
    {
        $validated = $request->validated();
        $discount_code = DiscountCode::create($validated);
        return $this->successResponse(['data' => $discount_code->toArray()]);
    }

    public function update(UpdateDiscountCodeRequest $request)
    {
        $discount_code_id = request('discount_code_id');
        $validated = $request->validated();
        DiscountCode::find($discount_code_id)->update($validated);
        $discount_code = DiscountCode::find($discount_code_id);
        return $this->successResponse(['data' => $discount_code->toArray()]);
    }

    public function delete()
    {
        $discount_code_id = request('discount_code_id');
        DiscountCode::destroy($discount_code_id);
        return $this->successResponse([
            'message' => 'Discount code deleted'
        ]);
    }
}
