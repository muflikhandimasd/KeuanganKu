<?php

namespace App\Http\Controllers\API;

use Carbon\Carbon;
use App\Models\User;
use App\Mail\OtpMail;
use Illuminate\Http\Request;
use App\Common\CommonFormatter;
use App\Models\VerificationCode;
use Illuminate\Http\JsonResponse;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Mail;
use Illuminate\Support\Facades\Validator;

class AuthController extends Controller
{
    function register(): JsonResponse
    {
        $validator = Validator::make(request()->all(), [
            'email' => 'required|email|unique:users,email',
            'name' => 'required|string|max:255',
            'role' => 'string|max:255',
            'phone' => 'required|string|max:255|unique:users,phone',
            'address' => 'string|max:255',
        ]);
        if ($validator->fails()) {
            return CommonFormatter::fail(400, $validator->errors()->first());
        }
        $user = User::create([
            'email' => request('email'),
            'name' => request('name'),
            'phone' => request('phone'),
            'address' => request('address'),
        ]);
        if (request('role') != '') {
            $user->assignRole(request('role'));
        } else {
            $user->assignRole('user');
        }
        return CommonFormatter::success('Success Register, Please Login', null);
    }


    // Generate OTP
    public function sendOtp(Request $request)
    {

        $validator = Validator::make(request()->all(), [
            'email' => 'required|email|exists:users,email'
        ]);

        if ($validator->fails()) {
            return CommonFormatter::fail(400, $validator->errors()->first());
        }

        # Generate An OTP
        $verificationCode = $this->generateOtp($request->email);

        $message = "Your OTP To Login is - " . $verificationCode->otp;
        # Return With OTP 
        Mail::to($request->email)->send(new OtpMail($verificationCode->otp));

        return CommonFormatter::success('Success Send OTP, Please Check Your Email', $message);
    }

    private function generateOtp($email)
    {
        $user = User::where('email', $email)->first();

        # User Does not Have Any Existing OTP
        $verificationCode = VerificationCode::where('user_id', $user->id)->latest()->first();

        $now = Carbon::now();

        if ($verificationCode && $now->isBefore($verificationCode->expire_at)) {
            return $verificationCode;
        }

        // Create a New OTP
        return VerificationCode::create([
            'user_id' => $user->id,
            'otp' => rand(123456, 999999),
            'expire_at' => Carbon::now()->addMinutes(10)
        ]);
    }



    public function login(Request $request)
    {


        $validator = Validator::make(request()->all(), [
            'email' => 'required|email|exists:users,email',
            'otp' => 'required|numeric'
        ]);

        if ($validator->fails()) {
            return CommonFormatter::fail(400, $validator->errors()->first());
        }

        # Get User
        $user = User::where('email', $request->email)->first();

        # Get OTP
        $verificationCode = VerificationCode::where('user_id', $user->id)->latest()->first();

        # Check If OTP is Expired
        $now = Carbon::now();
        if ($now->isAfter($verificationCode->expire_at)) {
            return CommonFormatter::fail(400, 'OTP Expired');
        }

        # Check If OTP is Valid
        if ($verificationCode->otp != $request->otp) {
            return CommonFormatter::fail(400, 'Invalid OTP');
        }
        $verificationCode->delete();
        $token = $user->createToken('auth_token')->plainTextToken;
        $role = $user->getRoleNames()->first();
        $userData = [
            'id' => $user->id,
            'email' => $user->email,
            'name' => $user->name,
            'phone' => $user->phone,
            'address' => $user->address,
        ];
        $response = array_merge($userData, ['token' => $token, 'role' => $role,]);
        return CommonFormatter::success('Success Login', $response);

    }

    public function logout(): JsonResponse
    {
        auth()->user()->tokens()->delete();
        return CommonFormatter::success('Success Logout', null);
    }


}