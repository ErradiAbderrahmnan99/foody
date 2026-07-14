<?php

namespace Tests\Feature;

use Tests\TestCase;
use App\Models\User;
use App\Models\Item;
use App\Models\ItemCategory;
use App\Models\Tax;
use App\Models\ItemAttribute;
use Illuminate\Foundation\Testing\RefreshDatabase;

class ItemControllerTest extends TestCase
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
     * Test admin can view items list.
     */
    public function test_admin_can_view_items_list()
    {
        $response = $this->actingAs($this->adminUser, 'sanctum')
            ->withHeaders([
                'x-api-key' => env('MIX_API_KEY'),
            ])->getJson('/api/admin/item');

        $response->assertStatus(200);
        $response->assertJsonStructure([
            'data' => [
                '*' => [
                    'id',
                    'name',
                    'slug',
                    'price',
                    'status',
                ]
            ]
        ]);
    }

    /**
     * Test admin can create a menu item.
     */
    public function test_admin_can_create_item()
    {
        $category = ItemCategory::first();
        $tax = Tax::first();
        $attribute = ItemAttribute::first();

        $itemData = [
            'name' => 'Gourmet Burger',
            'item_category_id' => $category->id,
            'tax_id' => $tax->id,
            'item_type' => 1,
            'price' => '85.00',
            'is_featured' => 5, // Yes
            'status' => 5, // Active
            'order' => 1,
            'description' => 'Best gourmet burger in town',
            'variations' => json_encode([
                [
                    'item_attribute_id' => $attribute->id,
                    'name' => 'Double Patty',
                    'price' => '115.00'
                ]
            ])
        ];

        $response = $this->actingAs($this->adminUser, 'sanctum')
            ->withHeaders([
                'x-api-key' => env('MIX_API_KEY'),
            ])->postJson('/api/admin/item', $itemData);

        $response->assertStatus(201);
        $response->assertJsonPath('data.name', 'Gourmet Burger');

        $this->assertDatabaseHas('items', [
            'name' => 'Gourmet Burger',
            'price' => '85.00'
        ]);
    }

    /**
     * Test admin can view specific item details.
     */
    public function test_admin_can_view_item_details()
    {
        $item = Item::first();

        $response = $this->actingAs($this->adminUser, 'sanctum')
            ->withHeaders([
                'x-api-key' => env('MIX_API_KEY'),
            ])->getJson('/api/admin/item/show/' . $item->id);

        $response->assertStatus(200);
        $response->assertJsonPath('data.id', $item->id);
    }

    /**
     * Test admin can update an item.
     */
    public function test_admin_can_update_item()
    {
        $item = Item::first();
        $category = ItemCategory::first();
        $tax = Tax::first();
        $attribute = ItemAttribute::first();

        $updateData = [
            'name' => 'Updated Burger King',
            'item_category_id' => $category->id,
            'tax_id' => $tax->id,
            'item_type' => 1,
            'price' => '99.99',
            'is_featured' => 5,
            'status' => 5,
            'order' => 1,
            'description' => 'Updated desc',
            'variations' => json_encode([
                [
                    'item_attribute_id' => $attribute->id,
                    'name' => 'Single Patty',
                    'price' => '89.99'
                ]
            ])
        ];

        $response = $this->actingAs($this->adminUser, 'sanctum')
            ->withHeaders([
                'x-api-key' => env('MIX_API_KEY'),
            ])->putJson('/api/admin/item/' . $item->id, $updateData);

        $response->assertStatus(200);
        $response->assertJsonPath('data.name', 'Updated Burger King');

        $this->assertDatabaseHas('items', [
            'id' => $item->id,
            'name' => 'Updated Burger King',
            'price' => '99.99'
        ]);
    }

    /**
     * Test admin can delete an item.
     */
    public function test_admin_can_delete_item()
    {
        $item = Item::first();

        $response = $this->actingAs($this->adminUser, 'sanctum')
            ->withHeaders([
                'x-api-key' => env('MIX_API_KEY'),
            ])->deleteJson('/api/admin/item/' . $item->id);

        $response->assertStatus(202);

        $this->assertSoftDeleted('items', [
            'id' => $item->id,
        ]);
    }
}
