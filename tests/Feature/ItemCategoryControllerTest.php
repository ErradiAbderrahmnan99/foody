<?php

namespace Tests\Feature;

use Tests\TestCase;
use App\Models\User;
use App\Models\ItemCategory;
use Illuminate\Foundation\Testing\RefreshDatabase;

class ItemCategoryControllerTest extends TestCase
{
    use RefreshDatabase;

    protected User $adminUser;

    protected function setUp(): void
    {
        parent::setUp();
        $this->seed();
        $this->adminUser = User::where('email', 'admin@example.com')->first();
    }

    /**
     * Test admin can view item categories list.
     */
    public function test_admin_can_view_item_categories_list()
    {
        $response = $this->actingAs($this->adminUser, 'sanctum')
            ->withHeaders([
                'x-api-key' => env('MIX_API_KEY'),
            ])->getJson('/api/admin/setting/item-category');

        $response->assertStatus(200);
        $response->assertJsonStructure([
            'data' => [
                '*' => [
                    'id',
                    'name',
                    'slug',
                    'status',
                ]
            ]
        ]);
    }

    /**
     * Test admin can create an item category.
     */
    public function test_admin_can_create_item_category()
    {
        $categoryData = [
            'name' => 'Italian Pizzas',
            'description' => 'Delicious hand-tossed pizzas',
            'status' => 5, // Active Status
        ];

        $response = $this->actingAs($this->adminUser, 'sanctum')
            ->withHeaders([
                'x-api-key' => env('MIX_API_KEY'),
            ])->postJson('/api/admin/setting/item-category', $categoryData);

        $response->assertStatus(201);
        $response->assertJsonPath('data.name', 'Italian Pizzas');

        $this->assertDatabaseHas('item_categories', [
            'name' => 'Italian Pizzas',
            'description' => 'Delicious hand-tossed pizzas',
        ]);
    }

    /**
     * Test admin can view specific category details.
     */
    public function test_admin_can_view_item_category_details()
    {
        $category = ItemCategory::first();

        $response = $this->actingAs($this->adminUser, 'sanctum')
            ->withHeaders([
                'x-api-key' => env('MIX_API_KEY'),
            ])->getJson('/api/admin/setting/item-category/show/' . $category->id);

        $response->assertStatus(200);
        $response->assertJsonPath('data.id', $category->id);
    }

    /**
     * Test admin can update an item category.
     */
    public function test_admin_can_update_item_category()
    {
        $category = ItemCategory::first();

        $updateData = [
            'name' => 'Updated Italian Pizzas',
            'description' => 'New description',
            'status' => 5,
        ];

        $response = $this->actingAs($this->adminUser, 'sanctum')
            ->withHeaders([
                'x-api-key' => env('MIX_API_KEY'),
            ])->putJson('/api/admin/setting/item-category/' . $category->id, $updateData);

        $response->assertStatus(200);
        $response->assertJsonPath('data.name', 'Updated Italian Pizzas');

        $this->assertDatabaseHas('item_categories', [
            'id' => $category->id,
            'name' => 'Updated Italian Pizzas',
        ]);
    }

    /**
     * Test admin can delete an item category.
     */
    public function test_admin_can_delete_item_category()
    {
        $category = ItemCategory::create([
            'name' => 'To Be Deleted',
            'slug' => 'to-be-deleted',
            'status' => 5,
        ]);

        $response = $this->actingAs($this->adminUser, 'sanctum')
            ->withHeaders([
                'x-api-key' => env('MIX_API_KEY'),
            ])->deleteJson('/api/admin/setting/item-category/' . $category->id);

        $response->assertStatus(202);

        $this->assertDatabaseMissing('item_categories', [
            'id' => $category->id,
        ]);
    }
}
