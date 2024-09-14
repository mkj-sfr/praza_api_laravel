<?php

namespace App\Http\Controllers;

use App\Models\Page;
use Illuminate\Http\Request;
use App\Traits\ApiResponseController;
use App\Http\Requests\RegisterPageRequest;
use App\Http\Requests\UpdatePageRequest;

class PageController extends Controller
{
    use ApiResponseController;

    public function show()
    {
        $pages = Page::with('roles')->get();
        if($pages->toArray()) {
            return $this->successResponse($pages->toArray());
        }
        return $this->notFoundResponse([
            'message' => 'No pages were found.'
        ]);
    }

    public function show_single()
    {
        $page_id = request('page_id');
        $page = Page::find($page_id);
        return $this->successResponse($page->toArray());
    }

    public function create(RegisterPageRequest $request)
    {
        $validated = $request->validated();
        $page = Page::create($validated);
        return $this->successResponse($page->toArray());
    }

    public function update(UpdatePageRequest $request)
    {
        $page_id = $request->page_id;
        $request->request->remove('id');
        $validated = $request->validated();
        $page = Page::find($page_id);
        if ($page) {
            $page->update($validated);
            $page = Page::find($page_id);
            return $this->successResponse($page->toArray());
        }
        return $this->notFoundResponse([
            'message' => 'Page was not found.'
        ]);
    }

    public function delete()
    {
        $page_id = request('page_id');
        $page = Page::find($page_id);
        if($page){
            if(Page::destroy($page_id)) {
                return $this->successResponse([
                    'message' => "Page named $page->name was deleted."
                ]);
            }
            return $this->errorResponse([
                'message' => 'Page was not deleted.'
            ]);
        }
        return $this->notFoundResponse([
            'message' => 'Page was not found.'
        ]);
    }
}
