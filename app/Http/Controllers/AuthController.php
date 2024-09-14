<?php

namespace App\Http\Controllers;

use App\Models\Role;
use App\Models\User;
use App\Models\VerificationCode;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use App\Http\Requests\LoginUserRequest;
use App\Http\Requests\LoginWithCodeRequest;
use App\Http\Requests\RegisterUserRequest;
use App\Http\Requests\RegisterVerificationCodeRequest;
use App\Http\Requests\VerifyCodeRequest;
use App\Http\Requests\ResetPasswordRequest;
use App\Traits\ApiResponseController;


class AuthController extends Controller
{
    use ApiResponseController;

    public function register(RegisterUserRequest $request)
    {
        $validated = $request->validated();

        $validated['password'] = Hash::make($validated['password']);

        $user = User::create($validated);
        $user['token'] = $user->createToken('API token of ' . $user->first_name . ' ' . $user->last_name)->plainTextToken;

        return $this->successResponse($user->toArray());
    }

    public function login(LoginUserRequest $request)
    {
        $validated = $request->validated();
        if ($validated['email']) {
            $user = User::where('email', $validated['email'])->first();
            if ($user && (Hash::check($validated['password'], $user->password))) {
                $user = User::where('email', $validated['email'])->with('role')->first();
            } else {
                return $this->notFoundResponse([
                    'message' => 'User not found.'
                ]);
            }
        } else {
            $user = User::where('phone_number', $validated['phone_number'])->first();
            if ($user && (Hash::check($validated['password'], $user->password))) {
                $user = User::where('phone_number', $validated['phone_number'])->with('role')->first();
            } else {
                return $this->notFoundResponse([
                    'message' => 'User not found.'
                ]);
            }
        }
        $user_array = $user->toArray();
        if ($user_array['role']) {
            $role_with_pages = Role::with('pages')->find($user->role_id)->toArray();
            $user_array['pages'] = $role_with_pages['pages'];
        }
        return $this->successResponse([
            'user' => $user_array,
            'token' => $user->createToken('API token of ' . $user->first_name . ' ' . $user->last_name)->plainTextToken
        ]);
    }

    public function login_with_code(LoginWithCodeRequest $request)
    {
        $validated = $request->validated();
        if ($validated['phone_number']) {
            $user = User::where('phone_number', $validated['phone_number'])->with('role')->first();
        } else {
            $user = User::where('email', $validated['email'])->with('role')->first();
        }
        $user_array = $user->toArray();
        $is_verified = VerificationCode::where([
            ['user_id', $user->id],
            ['code', $validated['code']],
            ['is_expired', false],
        ])->first();
        if ($is_verified) {
            if ($user->role_id) {
                $role_with_pages = Role::with('pages')->find($user->role_id)->toArray();
                $user_array['pages'] = $role_with_pages['pages'];
            }
            $is_verified->is_expired = true;
            $is_verified->save();
            return $this->successResponse([
                'user' => $user_array,
                'token' => $user->createToken('API token of ' . $user->first_name . ' ' . $user->last_name)->plainTextToken
            ]);
        }
        return $this->errorResponse([
            'message' => 'User is not verified.'
        ]);
    }

    public function reset_password_code_confirm(VerifyCodeRequest $request)
    {
        $validated = $request->validated();
        if(isset($validated['email']) && $validated['email']) {
            $user = User::where('email', $validated['email'])->first();
            $verification = VerificationCode::where([
                ['user_id', $user->id],
                ['code', $validated['code']],
                ['is_expired', false],
            ])->first();
        } elseif (isset($validated['phone_number']) && $validated['phone_number']) {
            $user = User::where('phone_number', $validated['phone_number'])->first();
            $verification = VerificationCode::where([
                ['user_id', $user->id],
                ['code', $validated['code']],
                ['is_expired', false],
            ])->first();
        } else {
            return $this->errorResponse([
                'message' => 'Email or phone number is required.'
            ]);
        }
        if ($verification) {
            $verification->is_expired = true;
            $verification->save();
            return $this->successResponse([
                'message' => 'User Verified.',
            ]);
        }
        return $this->errorResponse([
            'message' => 'Verification code is invalid.'
        ]);
    }

    public function reset_password(ResetPasswordRequest $request)
    {
        $validated = $request->validated();
        if(isset($validated['email']) && $validated['email']) {
            $user = User::where('email', $validated['email'])->first();
        } elseif(isset($validated['phone_number']) && $validated['phone_number']) {
            $user = User::where('phone_number', $validated['phone_number'])->first();
        } else {
            return $this->errorResponse([
                'message' => 'Email or phone number is required.'
            ]);
        }
        $user->password = Hash::make($validated['password']);
        $user->save();
        return $this->successResponse([
            'message' => 'Password reset successfully.'
        ]);
    }

    public function send_verification_code(RegisterVerificationCodeRequest $request)
    {
        $validated = $request->validated();
        $verification_code = random_int(10000, 99999);
        if ($validated['phone_number']) {
            $user = User::where('phone_number', $validated['phone_number'])->first();
            // todo: send sms
        } else {
            $user = User::where('email', $validated['email'])->first();
            // todo: send email
        }
        if($user)
        {
            VerificationCode::create([
                'user_id' => $user->id,
                'code' => $verification_code
            ]);
            return $this->successResponse(['verification_code' => $verification_code]);
        }
        return $this->notFoundResponse([
            'message' => 'User not found.'
        ]);
    }

    public function logout()
    {
        if (Auth::user()->tokens()->delete()) {
            return $this->successResponse([
                'message' => 'You have successfully been logged out and your token has been revoked.'
            ]);
        }
    }
}
