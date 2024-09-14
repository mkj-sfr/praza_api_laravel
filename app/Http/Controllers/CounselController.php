<?php

namespace App\Http\Controllers;

use App\Models\Counsel;
use App\Models\User;
use Illuminate\Http\Request;
use App\Traits\ApiResponseController;
use App\Http\Requests\RegisterCounselRequest;
use App\Http\Requests\UpdateCounselRequest;
use Illuminate\Support\Facades\Auth;

class CounselController extends Controller
{
    use ApiResponseController;
    public function show()
    {
        $counsels = Counsel::with('session', 'counselor', 'client', 'platform', 'counselingType')->get();
        if($counsels->count() > 0)
        {
            return $this->successResponse(['data' => $counsels->toArray()]);
        }
        return $this->notFoundResponse([
            'message' => "No counsels were found",
        ]);
    }

    public function show_by_user_role()
    {
        $user_id = Auth::user()->id;
        if(request()->has('user_id') && !empty(request('user_id'))) {
            $user_id = request('user_id');
        }
        $user = User::with('role', 'counselorSessions', 'clientSessions')->find($user_id);
        $sessions = ($user->role->name == 'counselor') ? $user->counselorSessions : $user->clientSessions;

        if($sessions->count() > 0)
        {
            return $this->successResponse(['data' => $sessions->toArray()]);
        }
        return $this->notFoundResponse([
            'message' => "No counsel sessions were found",
        ]);
    }

    public function show_single()
    {
        $counsel_id = request('counsel_id');
        $counsel = Counsel::with('session', 'counselor', 'client', 'platform', 'counselingType')->find($counsel_id);
        if($counsel){
            return $this->successResponse(['data' => $counsel->toArray()]);
        }
        return $this->notFoundResponse([
            'message' => "Counsel does not exist",
        ]);
    }

    public function create(RegisterCounselRequest $request)
    {
        $validated = $request->validated();
        if(!(request()->has('client_id')) or empty(request('client_id'))) {
            $validated['client_id'] = Auth::user()->id;
        }
        if(!(request()->has('counselor_id')) or empty(request('counselor_id'))) {
            $validated['counselor_id'] = Auth::user()->id;
        }
        $counsel = Counsel::create($validated);
        return $this->successResponse(['data' => $counsel->toArray()]);
    }

    public function update(UpdateCounselRequest $request)
    {
        $counsel_id = request('counsel_id');
        $validated = $request->validated();
        if(!(request()->has('client_id')) or empty(request('client_id'))) {
            $validated['client_id'] = Auth::user()->id;
        }
        if(!(request()->has('counselor_id')) or empty(request('counselor_id'))) {
            $validated['counselor_id'] = Auth::user()->id;
        }
        Counsel::find($counsel_id)->update($validated);
        $counsel = Counsel::with('counselor', 'client', 'platform', 'session', 'counselingType')->find($counsel_id);
        return $this->successResponse(['data' => $counsel->toArray()]);
    }

    public function delete()
    {
        $counsel_id = request('counsel_id');
        Counsel::destroy($counsel_id);
        return $this->successResponse([
            'message' => "Counsel has been deleted"
        ]);
    }
}
