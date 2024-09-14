<?php

namespace App\Http\Controllers;

use App\Models\Platform;
use Illuminate\Http\Request;
use App\Traits\ApiResponseController;

class PlatformController extends Controller
{
    use ApiResponseController;

    public function show_by_type()
    {
        $type = request('type');
        $type = ($type == 'counsel') ? 0 : 1;
        $platforms = Platform::where('type', $type)->get();
        if ($platforms->isEmpty()) {
            return $this->notFoundResponse([
                'message' => 'No platforms were found.'
            ]);
        }
        return $this->successResponse(['data' => $platforms->toArray()]);
    }

    public function show_single()
    {
        $platform_id = request('platform_id');
        $platform = Platform::find($platform_id);
        if ($platform) {
            return $this->successResponse(['data' => $platform->toArray()]);
        }
        return $this->notFoundResponse([
            'message' => 'Platform was not found.'
        ]);
    }

    public function create()
    {
        $platform = Platform::create([
            'name' => request('name'),
            'type' => request('type'),
        ]);
        return $this->successResponse(['data' => $platform->toArray()]);
    }

    public function update()
    {
        $platform_id = request('platform_id');
        $platform = Platform::find($platform_id);
        $platform->name = request('name');
        $platform->type = request('type');
        $platform->save();
        return $this->successResponse(['data' => $platform->toArray()]);

    }

    public function delete()
    {
        $platform_id = request('platform_id');
        Platform::destroy($platform_id);
        return $this->successResponse([
            'message' => 'Platform was deleted.'
        ]);
    }
}
