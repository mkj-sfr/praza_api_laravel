<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Contracts\Validation\Validator;
use Illuminate\Http\Exceptions\HttpResponseException;
use App\Traits\ApiResponseController;

class RegisterClassCourseRequest extends FormRequest
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
            'slug' => 'required|string',
            'level' => 'required|string',
            'has_next_step' => 'required|boolean',
            'session_id' => 'required|integer',
            'status' => 'boolean',
            'platform_id' => 'required|integer',
            'student_id' => 'nullable|integer',
            'teacher_id' => 'nullable|integer',
        ];
    }

    protected function failedValidation(Validator $validator)
    {
        $errors = $validator->errors()->toArray();

        throw new HttpResponseException($this->errorResponse(['errors' => $errors]));
    }
}
