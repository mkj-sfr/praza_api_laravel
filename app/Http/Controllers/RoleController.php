<?php

namespace App\Http\Controllers;

use App\Models\Role;
use Illuminate\Http\Request;
use App\Http\Requests\RegisterRoleRequest;
use App\Http\Requests\UpdateRoleRequest;
use App\Traits\ApiResponseController;

class RoleController extends Controller
{
    use ApiResponseController;

    public function show()
    {
        $roles = Role::with('pages')->get();
        if ($roles) {
            return $this->successResponse($roles->toArray());
        }
        return $this->notFoundResponse([
            'message' => 'No roles were found.',
        ]);
    }

    public function show_single()
    {
        $role_id = request('role_id');
        $role = Role::where('id', $role_id)->with('pages')->first();
        return $this->successResponse($role->toArray());
    }

    public function create(RegisterRoleRequest $request)
    {
        $validated = $request->validated();
        $role = Role::create($validated);
        return $this->successResponse($role->toArray());
    }

    public function update(UpdateRoleRequest $request)
    {
        $role_id = $request->role_id;
        $request->request->remove('role_id');
        $validated = $request->validated();
        $role = Role::find($role_id);
        if ($role) {
            $role->update($validated);
            $role = Role::find($role_id);
            return $this->successResponse($role->toArray());
        }
        return $this->notFoundResponse([
            'message' => 'Role was not found.'
        ]);
    }

    public function delete()
    {
        $role_id = request('role_id');
        $role = Role::find($role_id);
        if ($role) {
            if (Role::destroy($role_id)) {
                return $this->successResponse([
                    'message' => "Role named $role->name was deleted."
                ]);
            }
            return $this->errorResponse([
                'message' => 'Role was not deleted.'
            ]);
        }
        return $this->notFoundResponse([
            'message' => 'Role was not found.'
        ]);
    }

    public function page_attach()
    {
        $role_id = request()->role_id;
        $role = Role::find($role_id);
        $pages = request()->page_ids; // TODO: check the way ids are passed through post form data
        // TODO: edit postman after this
        $role->pages()->attach($pages);
        $role = Role::with('pages')->find($role_id);
        return $this->successResponse($role->toArray());
    }

    public function page_detach()
    {
        $role_id = request()->role_id;
        $role = Role::find($role_id);
        $pages = request()->page_ids; // TODO: check the way ids are passed through post form data
        // TODO: edit postman after this
        $role->pages()->detach($pages);
        $role = Role::with('pages')->find($role_id);
        return $this->successResponse($role->toArray());
    }
}
