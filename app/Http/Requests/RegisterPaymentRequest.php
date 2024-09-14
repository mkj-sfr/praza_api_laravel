<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Http\Exceptions\HttpResponseException;
use Illuminate\Contracts\Validation\Validator;
use App\Traits\ApiResponseController;

class RegisterPaymentRequest extends FormRequest
{
    use ApiResponseController;

    /**
     * Determine if the user is authorized to make this request.
     */
    public function authorize(): bool
    {
        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array<string, \Illuminate\Contracts\Validation\ValidationRule|array<mixed>|string>
     */
    public function rules(): array
    {
        return [
            'user_id' => 'required',
            'price' => 'required|min:1|numeric',
            'description' => 'required|string',
            'billing_id' => 'required|numeric',
            'payment_id' => 'required|numeric',
            'payment_method' => 'required|string',
            'status' => 'integer|nullable|min:0|max:2',
            'course_id' => 'integer|nullable',
            'class_course_id' => 'integer|nullable',
            'counsel_id' => 'integer|nullable',
            'upload_id' => 'integer|nullable',
        ];
    }

    protected function failedValidation(Validator $validator)
    {
        $errors = $validator->errors()->toArray();

        throw new HttpResponseException($this->errorResponse(['errors' => $errors]));
    }
}

