<?php

namespace App\Common;

class CommonFormatter
{
    public static function success(string $message = 'Success', mixed $data)
    {
        return response()->json([
            'status' => true,
            'message' => $message,
            'data' => $data
        ]);
    }
    public static function fail(int $code = 400, string $message = 'Gagal')
    {
        return response()->json([
            'status' => false,
            'message' => $message,
            'data' => null
        ], $code);
    }
}