<?php


namespace App\Traits;

trait ApiResponseController
{
    public function successResponse($data)
    {
        $data['http_status'] = 200;
        return response()->json($data);
    }

    public function errorResponse($data)
    {
        $data['http_status'] = 401;
        return response()->json($data);
    }

    public function accessDeniedResponse($data)
    {
        $data['http_status'] = 403;
        return response()->json($data);
    }

    public function notFoundResponse($data)
    {
        $data['http_status'] = 404;
        return response()->json($data);
    }
}
