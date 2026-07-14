<?php

namespace Tests\Feature;

use Tests\TestCase;
use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;

class LoginControllerTest extends TestCase
{
    use RefreshDatabase;

    protected function setUp(): void
    {
        parent::setUp();
        $this->seed();
    }

    /**
     * Test login succeeds with correct credentials.
     */
    public function test_login_succeeds_with_correct_credentials()
    {
        $response = $this->withHeaders([
            'x-api-key' => env('MIX_API_KEY'),
        ])->postJson('/api/auth/login', [
            'email' => 'admin@example.com',
            'password' => '123456',
        ]);

        $response->assertStatus(201);
        $response->assertJsonStructure([
            'message',
            'token',
            'branch_id',
            'user',
            'menu',
            'permission',
            'defaultPermission',
            'defaultMenu'
        ]);
        $this->assertEquals('Login Successfully.', $response->json('message'));
    }

    /**
     * Test login fails with invalid credentials.
     */
    public function test_login_fails_with_invalid_credentials()
    {
        $response = $this->withHeaders([
            'x-api-key' => env('MIX_API_KEY'),
        ])->postJson('/api/auth/login', [
            'email' => 'admin@example.com',
            'password' => 'wrongpassword',
        ]);

        $response->assertStatus(400);
        $response->assertJsonStructure([
            'errors' => [
                'validation'
            ]
        ]);
    }

    /**
     * Test logout revokes token.
     */
    public function test_logout_revokes_token()
    {
        $user = User::where('email', 'admin@example.com')->first();
        $token = $user->createToken('auth_token')->plainTextToken;
        
        $response = $this->withHeaders([
            'Authorization' => 'Bearer ' . $token,
            'x-api-key' => env('MIX_API_KEY'),
            'Accept' => 'application/json'
        ])->postJson('/api/auth/logout');

        $response->assertStatus(200);
        $response->assertJson([
            'message' => 'Logged Out Successfully.'
        ]);
    }
}
