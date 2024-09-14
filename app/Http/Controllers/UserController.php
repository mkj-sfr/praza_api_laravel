<?php

namespace App\Http\Controllers;

use App\Models\Role;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use App\Traits\ApiResponseController;
use App\Http\Requests\RegisterUserRequest;
use App\Http\Requests\UpdateUserRequest;

class UserController extends Controller
{
    use ApiResponseController;

    public function show()
    {
        $users = User::whereNot('is_trashed', true)->with('role', 'files', 'courses', 'clientSessions', 'studentClasses')->get();
        if ($users) {
            return $this->successResponse($users);
        }
        return $this->notFoundResponse([
            'message' => 'No users were found.'
        ]);
    }

//    public function show()
//    {
//        $all_users = User::with('role')->get();
//        if ($all_users->toArray()) {
//            foreach ($all_users as $user) {
//                if ($user->role && $user->role->toArray()) {
//                    $user['role'] = $user->role->toArray();
//                    $role_with_pages = Role::with('pages')->find($user['role']['id'])->toArray();
//                    if ($role_with_pages) {
//                        $user['pages'] = $role_with_pages['pages'];
//                    }
//                }
//                $users[] = $user;
//            }
//            return $this->successResponse($users);
//        }
//        return $this->notFoundResponse([
//            'message' => 'No users were found.'
//        ]);
//    }

    public function show_single()
    {
        $user_id = request('user_id');
        $user = User::find($user_id);
        return $this->successResponse($user->toArray());
    }

    public function create(RegisterUserRequest $request)
    {
        $validated = $request->validated();

        $validated['password'] = Hash::make($validated['password']);
        $user = User::create($validated);
        return $this->successResponse($user->toArray());
    }

    public function update(UpdateUserRequest $request)
    {
        $user_id = $request->user_id;
        $request->request->remove('user_id');
        $validated = $request->validated();
        $user = User::find($user_id);
        if ($user) {
            $user->update($validated);
            $user = User::find($user_id);
            return $this->successResponse($user->toArray());
        }
        return $this->notFoundResponse([
            'message' => 'User was not found.'
        ]);
    }

    public function status_switch()
    {
        $user_id = request('user_id');
        $user = User::find($user_id);
        if ($user) {
            $user->status = !$user->status;
            $user->save();
            return $this->successResponse($user->toArray());
        } else {
            return $this->notFoundResponse([
                'message' => 'User was not found.'
            ]);
        }
    }

    public function send_sms()
    {
        $user_id = request('user_id');
        $message = request('message');
        $user_phone_number = User::find($user_id)->phone_number;
        // TODO: add sms service code snippet
        return $this->successResponse([
            'message' => $message,
            'phone_number' => $user_phone_number
        ]);
    }

    public function show_payments()
    {
        $user_id = request('user_id');
        $user = User::where('id', $user_id)->with('payments')->first()->toArray();
        if ($user['payments']) {
            return $this->successResponse($user);
        }
        return $this->notFoundResponse([
            'message' => 'No payments were found for this user.'
        ]);
    }

    public function send_sms_collection()
    {
        $message = request('message');
        $users_phone_number = User::whereNot('phone_number', null)->pluck('phone_number')->toArray();

        // sms collection code snippet

        return $this->successResponse([
            'message' => $message,
            'phone_numbers' => $users_phone_number
        ]);
    }

    public function set_role()
    {
        $user_id = request('user_id');
        $role_id = request('role_id');
        $user = User::find($user_id);
        if ($user) {
            $result = $user->update(['role_id' => $role_id]);
            if($result) {
                return $this->successResponse(['data' => $user->toArray()]);
            }
            return $this->errorResponse([
                'message' => 'Role was not found.'
            ]);
        }
        return $this->notFoundResponse([
            'message' => 'User was not found.'
        ]);
    }

    public function delete()
    {
        $user_id = request('user_id');
        $user = User::find($user_id);
        if ($user) {
            $user->is_trashed = true;
            $user->save();
            return $this->successResponse($user->toArray());
        }
        return $this->notFoundResponse([
            'message' => 'User was not found.'
        ]);
    }
}
