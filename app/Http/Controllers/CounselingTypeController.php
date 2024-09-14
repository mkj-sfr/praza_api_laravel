<?php

namespace App\Http\Controllers;

use App\Models\CounselingType;
use Illuminate\Http\Request;
use App\Traits\ApiResponseController;

class CounselingTypeController extends Controller
{
    use ApiResponseController;

    public function show()
    {
        $counseling_types = CounselingType::all();
        if($counseling_types) {
            return $this->successResponse(['data' => $counseling_types]);
        }
        return $this->notFoundResponse([
            'message' => 'No counseling types were found'
        ]);
    }

    public function show_single()
    {
        $counseling_type_id = request('counseling_type_id');
        $counseling_type = CounselingType::find($counseling_type_id);
        if($counseling_type) {
            return $this->successResponse(['data' => $counseling_type->toArray()]);
        }
        return $this->notFoundResponse([
            'message' => 'Counseling type not found'
        ]);
    }

    public function create()
    {
        $counseling_type = CounselingType::create([
            'name' => request('name'),
        ]);
        return $this->successResponse(['data' => $counseling_type->toArray()]);
    }

    public function update()
    {
        $counseling_type_id = request('counseling_type_id');
        $counseling_type = CounselingType::find($counseling_type_id);
        $counseling_type->name = request('name');
        $counseling_type->save();
        return $this->successResponse(['data' => $counseling_type->toArray()]);
    }

    public function delete()
    {
        $counseling_type_id = request('counseling_type_id');
        CounselingType::destroy($counseling_type_id);
        return $this->successResponse([
            'message' => 'Counseling type deleted successfully'
        ]);
    }
}
