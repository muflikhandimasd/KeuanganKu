<?php

namespace App\Http\Controllers\API;

use Illuminate\Http\Request;
use App\Common\CommonFormatter;
use Illuminate\Http\JsonResponse;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Validator;

class AccountController extends Controller
{

    function index(): JsonResponse
    {
        $user = auth()->user();
        $accounts = $user->accounts;
        return CommonFormatter::success('Success Get Accounts', $accounts);
    }

    function store(Request $request): JsonResponse
    {
        $user = auth()->user();
        $validator = Validator::make(request()->all(), [
            'name' => 'required|string|max:255',
        ]);
        if ($validator->fails()) {
            return CommonFormatter::fail(400, $validator->errors()->first());
        }
        $user->accounts()->create([
            'name' => $request->name,
            'user_id' => $user->id,
        ]);
        return CommonFormatter::success('Success Create Account', null);
    }

    function show($id): JsonResponse
    {
        $user = auth()->user();
        $account = $user->accounts()->find($id);
        if (!$account) {
            return CommonFormatter::fail(404, 'Account Not Found');
        }
        return CommonFormatter::success('Success Get Account', $account);
    }

    function update(Request $request, $id): JsonResponse
    {
        $user = auth()->user();
        $account = $user->accounts()->find($id);
        if (!$account) {
            return CommonFormatter::fail(404, 'Account Not Found');
        }
        $validator = Validator::make(request()->all(), [
            'name' => 'required|string|max:255',
        ]);
        if ($validator->fails()) {
            return CommonFormatter::fail(400, $validator->errors()->first());
        }
        $account->update([
            'name' => $request->name,
        ]);
        return CommonFormatter::success('Success Update Account', null);
    }

    function destroy($id): JsonResponse
    {
        $user = auth()->user();
        $account = $user->accounts()->find($id);
        if (!$account) {
            return CommonFormatter::fail(404, 'Account Not Found');
        }
        $account->delete();
        return CommonFormatter::success('Success Delete Account', null);
    }
}