<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Http\Exceptions\HttpResponseException;
use Illuminate\Contracts\Validation\Validator;
use App\Traits\ApiResponseController;

class UpdateUserRequest extends FormRequest
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
            'first_name' => ['max:255', 'nullable'],
            'last_name' => ['max:255', 'nullable'],
            'phone_number' => ['digits:11', 'unique:users,phone_number', 'nullable'],
            'email' => ['email', 'unique:users,email', 'nullable'],
            'national_id' => 'max_digits:11|numeric|nullable',
            'status' => 'boolean|nullable',
        ];
    }

    protected function failedValidation(Validator $validator)
    {
        $errors = $validator->errors()->toArray();

        throw new HttpResponseException($this->errorResponse(['errors' => $errors]));
    }
}
