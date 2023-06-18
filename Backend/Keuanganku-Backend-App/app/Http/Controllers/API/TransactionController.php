<?php

namespace App\Http\Controllers\API;

use Illuminate\Http\Request;
use App\Common\CommonFormatter;
use Illuminate\Http\JsonResponse;
use App\Http\Controllers\Controller;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\Validator;

class TransactionController extends Controller
{
    function index(): JsonResponse
    {
        $account = $this->getAccount();
        $transactions = $account->transactions->sortByDesc('id')->values();
        return CommonFormatter::success('Success Get Transactions', $transactions);
    }

    function store(Request $request): JsonResponse
    {
        $account = $this->getAccount();
        $validator = Validator::make(request()->all(), [
            'account_id' => 'required|exists:accounts,id',
            'type' => 'required|string|max:255',
            'amount' => 'required|numeric',
            'date' => 'required|date',
            'description' => 'string|max:255',
        ]);
        if ($validator->fails()) {
            return CommonFormatter::fail(400, $validator->errors()->first());
        }
        $account->transactions()->create([
            'account_id' => $request->account_id,
            'type' => $request->type,
            'amount' => $request->amount,
            'date' => $request->date,
            'description' => $request->description,
        ]);
        return CommonFormatter::success('Success Create Transaction', null);
    }

    function show($id): JsonResponse
    {
        $account = $this->getAccount();
        $transaction = $account->transactions()->find($id);
        if (!$transaction) {
            return CommonFormatter::fail(404, 'Transaction Not Found');
        }
        return CommonFormatter::success('Success Get Transaction', $transaction);
    }

    function update(Request $request, $id): JsonResponse
    {
        $account = $this->getAccount();
        $transaction = $account->transactions()->find($id);
        if (!$transaction) {
            return CommonFormatter::fail(404, 'Transaction Not Found');
        }
        $validator = Validator::make(request()->all(), [
            'account_id' => 'required|exists:accounts,id',
            'type' => 'required|string|max:255',
            'amount' => 'required|numeric',
            'date' => 'required|date',
            'description' => 'string|max:255',
        ]);
        if ($validator->fails()) {
            return CommonFormatter::fail(400, $validator->errors()->first());
        }
        $transaction->update([
            'account_id' => $request->account_id,
            'type' => $request->type,
            'amount' => $request->amount,
            'date' => $request->date,
            'description' => $request->description,
        ]);
        return CommonFormatter::success('Success Update Transaction', null);
    }

    function destroy($id): JsonResponse
    {
        $account = $this->getAccount();
        $transaction = $account->transactions()->find($id);
        if (!$transaction) {
            return CommonFormatter::fail(404, 'Transaction Not Found');
        }
        $transaction->delete();
        return CommonFormatter::success('Success Delete Transaction', null);
    }

    private function getAccount(): mixed
    {
        $validator = Validator::make(request()->all(), [
            'account_id' => 'required|integer|exists:accounts,id',
        ]);
        if ($validator->fails()) {
            return CommonFormatter::fail(400, $validator->errors()->first());
        }
        $account = auth()->user()->accounts()->find(request()->account_id);
        if (!$account) {
            return CommonFormatter::fail(404, 'Account Not Found');
        }
        return $account;

    }
}