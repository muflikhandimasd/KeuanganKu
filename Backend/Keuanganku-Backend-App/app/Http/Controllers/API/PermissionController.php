<?php

namespace App\Http\Controllers\API;

use Illuminate\Http\Request;
use App\Common\CommonFormatter;
use Illuminate\Http\JsonResponse;
use App\Http\Controllers\Controller;
use Spatie\Permission\Models\Permission;

class PermissionController extends Controller
{
    function __construct()
    {
        $this->middleware('permission:permission-read', ['only' => ['index', 'show']]);
        $this->middleware('permission:permission-create', ['only' => ['store']]);
        $this->middleware('permission:permission-edit', ['only' => ['update']]);
        $this->middleware('permission:permission-delete', ['only' => ['destroy']]);
    }
    function index(): JsonResponse
    {
        $permissions = Permission::all();
        return CommonFormatter::success('Success Get Permissions', $permissions);
    }

    function store(Request $request): JsonResponse
    {
        $request->validate([
            'name' => 'required|unique:permissions,name'
        ]);

        foreach ($request->name as $value) {
            Permission::create([
                'name' => $value
            ]);
        }
        return CommonFormatter::success('Success Create Permission', null);
    }

    function show($id): JsonResponse
    {
        $permission = Permission::find($id);
        if (!$permission) {
            return CommonFormatter::fail(404, 'Permission Not Found');
        }
        return CommonFormatter::success('Success Get Permission', $permission);
    }

    function update(Request $request, $id): JsonResponse
    {
        $permission = Permission::find($id);
        if (!$permission) {
            return CommonFormatter::fail(404, 'Permission Not Found');
        }
        $request->validate([
            'name' => 'required|unique:permissions,name,' . $id
        ]);
        $permission->update([
            'name' => $request->name
        ]);
        return CommonFormatter::success('Success Update Permission', null);
    }

    function destroy($id): JsonResponse
    {
        $permission = Permission::find($id);
        if (!$permission) {
            return CommonFormatter::fail(404, 'Permission Not Found');
        }
        $permission->delete();
        return CommonFormatter::success('Success Delete Permission', null);
    }
}