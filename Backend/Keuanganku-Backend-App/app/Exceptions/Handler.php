<?php

namespace App\Exceptions;

use Throwable;
use Illuminate\Http\Request;
use App\Common\CommonFormatter;
use Symfony\Component\Routing\Exception\RouteNotFoundException;
use Illuminate\Foundation\Exceptions\Handler as ExceptionHandler;

class Handler extends ExceptionHandler
{
    /**
     * The list of the inputs that are never flashed to the session on validation exceptions.
     *
     * @var array<int, string>
     */
    protected $dontFlash = [
        'current_password',
        'password',
        'password_confirmation',
    ];

    /**
     * Register the exception handling callbacks for the application.
     */
    public function register(): void
    {
        $this->renderable(function (\Spatie\Permission\Exceptions\UnauthorizedException $e, Request $request) {
            if ($request->is('api/*')) {
                return CommonFormatter::fail(403, 'You dont have permission to access this');
            }

        });
        $this->renderable(function (RouteNotFoundException $e, Request $request) {
            if ($request->is('api/*')) {
                return CommonFormatter::fail(401, 'Please Login First');
            }

        });
    }
}