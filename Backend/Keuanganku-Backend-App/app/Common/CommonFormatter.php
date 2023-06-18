<?php

namespace App\Common;

class CommonFormatter
{
    /**
     * @param string $message
     * @param mixed $data
     * @return \Illuminate\Http\JsonResponse
     */
    public static function success(string $message = 'Success', mixed $data)
    {
        return response()->json([
            'status' => true,
            'message' => $message,
            'data' => $data
        ]);
    }

    /**
     * @param int $code
     * @param string $message
     * @return \Illuminate\Http\JsonResponse
     */
    public static function fail(int $code = 400, string $message = 'Gagal')
    {
        return response()->json([
            'status' => false,
            'message' => $message,
            'data' => null
        ], $code);
    }
}