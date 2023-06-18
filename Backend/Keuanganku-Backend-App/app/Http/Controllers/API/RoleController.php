<?php

namespace App\Http\Controllers\API;

use Illuminate\Http\Request;
use App\Common\CommonFormatter;
use Illuminate\Http\JsonResponse;
use Spatie\Permission\Models\Role;
use App\Http\Controllers\Controller;

class RoleController extends Controller
{

    function __construct()
    {
        $this->middleware('permission:role-read', ['only' => ['index', 'show']]);
        $this->middleware('permission:role-create', ['only' => ['store']]);
        $this->middleware('permission:role-edit', ['only' => ['update']]);
        $this->middleware('permission:role-delete', ['only' => ['destroy']]);
    }
    function index(): JsonResponse
    {
        $roles = Role::all();
        return CommonFormatter::success('Success Get Roles', $roles);

    }

    function store(Request $request): JsonResponse
    {
        $request->validate([
            'name' => 'required|unique:roles,name'
        ]);
        Role::create([
            'name' => $request->name
        ]);
        return CommonFormatter::success('Success Create Role', null);
    }

    function show($id): JsonResponse
    {
        $role = Role::find($id);
        if (!$role) {
            return CommonFormatter::fail(404, 'Role Not Found');
        }
        return CommonFormatter::success('Success Get Role', $role);
    }

    function update(Request $request, $id): JsonResponse
    {
        $role = Role::find($id);
        if (!$role) {
            return CommonFormatter::fail(404, 'Role Not Found');
        }
        $request->validate([
            'name' => 'required|unique:roles,name,' . $id
        ]);
        $role->update([
            'name' => $request->name
        ]);
        return CommonFormatter::success('Success Update Role', null);
    }

    function destroy($id): JsonResponse
    {
        $role = Role::find($id);
        if (!$role) {
            return CommonFormatter::fail(404, 'Role Not Found');
        }
        $role->delete();
        return CommonFormatter::success('Success Delete Role', null);
    }
}