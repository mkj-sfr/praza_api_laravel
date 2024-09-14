<?php

namespace App\Http\Controllers;

use App\Models\UserAvailableSession;
use Illuminate\Http\Request;
use App\Traits\ApiResponseController;
use App\Http\Requests\RegisterSessionRequest;
use App\Http\Requests\UpdateSessionRequest;
use Illuminate\Support\Facades\Auth;


class SessionController extends Controller
{
    use ApiResponseController;

    public function show_user_sessions()
    {
        $user_id = request('user_id');
        $is_available = request('is_available');
        if($is_available) {
            $sessions = UserAvailableSession::where([
                ['user_id', $user_id],
                ['status', false]
            ])->get();
        } else {
            $sessions = UserAvailableSession::where('user_id', $user_id)->get();
        }
        if($sessions->isEmpty()) {
            return $this->notFoundResponse([
                'message' => 'No sessions were found'
            ]);
        }
        return $this->successResponse(['data' => $sessions->toArray()]);
    }

    public function create(RegisterSessionRequest $request)
    {
        $validated = $request->validated();
        $user_id = Auth::user()->id;
        $validated['user_id'] = $user_id;
        $session = UserAvailableSession::create($validated);
        return $this->successResponse(['data' => $session->toArray()]);
    }

    public function update(UpdateSessionRequest $request)
    {
        $validated = $request->validated();
        $user_id = Auth::user()->id;
        $validated['user_id'] = $user_id;
        $session = UserAvailableSession::find($validated['session_id']);
        if($session) {
            $session->date = $validated['date'];
            $session->save();
            return $this->successResponse(['data' => $session->toArray()]);
        }
        return $this->notFoundResponse([
            'message' => 'Session not found'
        ]);
    }

    public function delete()
    {
        $session_id = request('session_id');
        $session = UserAvailableSession::find($session_id);
        if($session) {
            $session->delete();
            return $this->successResponse([
                'message' => 'Session deleted successfully'
            ]);
        }
        return $this->notFoundResponse([
            'message' => 'Session not found'
        ]);
    }
}
