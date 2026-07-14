<?php

namespace Tests\Feature;

use Tests\TestCase;
use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Support\Facades\Hash;

class ProfileControllerTest extends TestCase
{
    use RefreshDatabase;

    protected User $user;

    protected function setUp(): void
    {
        parent::setUp();
        $this->seed();
        $this->user = User::where('email', 'customer@example.com')->first();
    }

    /**
     * Test retrieving the authenticated user profile.
     */
    public function test_user_can_view_profile()
    {
        $response = $this->actingAs($this->user, 'sanctum')
            ->withHeaders([
                'x-api-key' => env('MIX_API_KEY'),
            ])->getJson('/api/profile');

        $response->assertStatus(200);
        $response->assertJsonPath('data.email', 'customer@example.com');
    }

    /**
     * Test updating profile details.
     */
    public function test_user_can_update_profile()
    {
        $profileData = [
            'first_name' => 'Will',
            'last_name' => 'Smithy',
            'email' => 'customer@example.com',
            'phone' => '61234567', // 8 digits required by ValidPhone
            'country_code' => '+212'
        ];

        $response = $this->actingAs($this->user, 'sanctum')
            ->withHeaders([
                'x-api-key' => env('MIX_API_KEY'),
            ])->putJson('/api/profile', $profileData);

        $response->assertStatus(200);
        $response->assertJsonPath('data.name', 'Will Smithy');

        $this->assertDatabaseHas('users', [
            'id' => $this->user->id,
            'name' => 'Will Smithy'
        ]);
    }

    /**
     * Test changing profile password.
     */
    public function test_user_can_change_password()
    {
        $passwordData = [
            'old_password' => '123456',
            'password' => 'newpassword123',
            'password_confirmation' => 'newpassword123'
        ];

        $response = $this->actingAs($this->user, 'sanctum')
            ->withHeaders([
                'x-api-key' => env('MIX_API_KEY'),
            ])->putJson('/api/profile/change-password', $passwordData);

        $response->assertStatus(200);
        $response->assertJsonPath('data.email', 'customer@example.com');

        $this->user->refresh();
        $this->assertTrue(Hash::check('newpassword123', $this->user->password));
    }
}
