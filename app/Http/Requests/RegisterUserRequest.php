<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Http\Exceptions\HttpResponseException;
use Illuminate\Contracts\Validation\Validator;
use App\Traits\ApiResponseController;

class RegisterUserRequest extends FormRequest
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
            'first_name' => ['required', 'max:255'],
            'last_name' => ['required', 'max:255'],
            'phone_number' => ['required_without:email', 'digits:11', 'unique:users,phone_number', 'nullable'],
            'email' => ['required_without:phone_number', 'email', 'unique:users,email', 'nullable'],
            'password' => ['required', 'confirmed', 'min:8', 'regex:/^(?=.*[a-zA-Z])(?=.*\d).+$/'],
            'national_id' => ['numeric', 'max_digits:11'],
            'status' => 'boolean',
        ];
    }

    protected function failedValidation(Validator $validator)
    {
        $errors = $validator->errors()->toArray();

        throw new HttpResponseException($this->errorResponse(['errors' => $errors]));
    }
}
