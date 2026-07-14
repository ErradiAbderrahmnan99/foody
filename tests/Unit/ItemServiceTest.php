<?php

namespace Tests\Unit;

use Tests\TestCase;
use App\Models\Item;
use App\Models\ItemCategory;
use App\Models\Tax;
use App\Models\ItemAttribute;
use App\Services\ItemService;
use App\Http\Requests\ItemRequest;
use App\Http\Requests\PaginateRequest;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Support\Str;

class ItemServiceTest extends TestCase
{
    use RefreshDatabase;

    protected ItemService $itemService;

    protected function setUp(): void
    {
        parent::setUp();
        $this->seed();
        $this->itemService = $this->app->make(ItemService::class);
    }

    /**
     * Test simpleList returns items correctly.
     */
    public function test_simple_list_returns_items()
    {
        $request = new PaginateRequest([
            'paginate' => 0,
            'order_column' => 'id',
            'order_type' => 'desc',
        ]);

        $list = $this->itemService->simpleList($request);

        $this->assertNotEmpty($list);
        $this->assertInstanceOf(\Illuminate\Database\Eloquent\Collection::class, $list);
    }

    /**
     * Test storing a new item.
     */
    public function test_store_creates_new_item()
    {
        $category = ItemCategory::first();
        $tax = Tax::first();
        $attribute = ItemAttribute::first();

        $requestData = [
            'name' => 'Pizza Royale',
            'item_category_id' => $category->id,
            'tax_id' => $tax->id,
            'item_type' => 1,
            'price' => '120.50',
            'is_featured' => 5, // Yes
            'description' => 'A delicious pizza royale',
            'status' => 5, // Active Status
            'order' => 1,
            'variations' => json_encode([
                [
                    'item_attribute_id' => $attribute->id,
                    'name' => 'Large',
                    'price' => '150.00'
                ]
            ])
        ];

        $request = ItemRequest::create('/admin/item', 'POST', $requestData);
        $request->setContainer($this->app)->setRedirector($this->app->make(\Illuminate\Routing\Redirector::class));
        
        $validator = $this->app->make('validator')->make($requestData, $request->rules());
        $request->setValidator($validator);

        $item = $this->itemService->store($request);

        $this->assertInstanceOf(Item::class, $item);
        $this->assertEquals('Pizza Royale', $item->name);
        $this->assertEquals(Str::slug('Pizza Royale'), $item->slug);
        
        $this->assertDatabaseHas('items', [
            'id' => $item->id,
            'name' => 'Pizza Royale',
        ]);

        $this->assertDatabaseHas('item_variations', [
            'item_id' => $item->id,
            'item_attribute_id' => $attribute->id,
            'name' => 'Large',
            'price' => '150.00'
        ]);
    }

    /**
     * Test updating an existing item.
     */
    public function test_update_modifies_existing_item()
    {
        $item = Item::first();
        $category = ItemCategory::first();
        $tax = Tax::first();
        $attribute = ItemAttribute::first();

        $requestData = [
            'name' => 'Updated Pizza Name',
            'item_category_id' => $category->id,
            'tax_id' => $tax->id,
            'item_type' => 1,
            'price' => '130.00',
            'is_featured' => 5,
            'description' => 'Updated description',
            'status' => 5,
            'order' => 2,
            'variations' => json_encode([
                [
                    'item_attribute_id' => $attribute->id,
                    'name' => 'Medium',
                    'price' => '110.00'
                ]
            ])
        ];

        $request = ItemRequest::create('/admin/item/' . $item->id, 'PUT', $requestData);
        $request->setContainer($this->app)->setRedirector($this->app->make(\Illuminate\Routing\Redirector::class));
        
        $validator = $this->app->make('validator')->make($requestData, $request->rules());
        $request->setValidator($validator);

        $updatedItem = $this->itemService->update($request, $item);

        $this->assertEquals('Updated Pizza Name', $updatedItem->name);
        $this->assertEquals(Str::slug('Updated Pizza Name'), $updatedItem->slug);

        $this->assertDatabaseHas('items', [
            'id' => $item->id,
            'name' => 'Updated Pizza Name',
        ]);
    }

    /**
     * Test destroying an item.
     */
    public function test_destroy_removes_item()
    {
        $item = Item::first();
        
        $this->itemService->destroy($item);

        $this->assertSoftDeleted('items', [
            'id' => $item->id,
        ]);
    }
}
