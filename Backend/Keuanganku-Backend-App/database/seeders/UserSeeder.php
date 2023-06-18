<?php

namespace Database\Seeders;

use App\Models\User;
use Illuminate\Database\Seeder;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;

class UserSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $users = ['admin@gmail.com', 'user@gmail.com'];
        foreach ($users as $key => $value) {
            $user = User::create([
                'email' => $value,
            ]);
            $user->assignRole($key == 0 ? 'admin' : 'user');
        }
    }
}