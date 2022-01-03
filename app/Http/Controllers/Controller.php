<?php

namespace App\Http\Controllers;

use App\Mail\InitFinished;
use Illuminate\Foundation\Auth\Access\AuthorizesRequests;
use Illuminate\Foundation\Bus\DispatchesJobs;
use Illuminate\Foundation\Validation\ValidatesRequests;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Routing\Controller as BaseController;

class Controller extends BaseController
{
    use AuthorizesRequests, DispatchesJobs, ValidatesRequests;

    /**
     * @param Request $request
     * @return JsonResponse
     */
    public function notify(Request $request): JsonResponse
    {
        \Mail::to('knobiks@gmail.com')
            ->send(new InitFinished($request->get('hostname'), $_SERVER['REMOTE_ADDR'] ?? null));

        return response()->json();
    }
}
