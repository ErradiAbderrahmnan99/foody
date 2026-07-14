<?php

namespace Tests\Feature;

use Tests\TestCase;
use App\Models\User;
use App\Models\Item;
use App\Models\DiningTable;
use App\Models\Branch;
use App\Models\FrontendOrder;
use App\Enums\OrderType;
use App\Enums\Ask;
use App\Enums\Source;
use Illuminate\Foundation\Testing\RefreshDatabase;

class TableOrderControllerTest extends TestCase
{
    use RefreshDatabase;

    protected User $customer;
    protected DiningTable $table;
    protected Branch $branch;
    protected Item $item;

    protected function setUp(): void
    {
        parent::setUp();
        $this->seed();

        $this->customer = User::where('email', 'customer@example.com')->first();
        $this->table = DiningTable::first();
        $this->branch = Branch::first();
        $this->item = Item::first();
    }

    /**
     * Test placing a dining table order.
     */
    public function test_can_place_dining_table_order()
    {
        $itemsPayload = [
            [
                'item_id' => $this->item->id,
                'branch_id' => $this->branch->id,
                'item_name' => $this->item->name,
                'item_price' => $this->item->price,
                'quantity' => 2,
                'discount' => 0,
                'item_variations' => [],
                'item_extras' => [],
                'instruction' => 'No onions',
                'item_variation_total' => 0,
                'item_extra_total' => 0,
                'total_price' => floatval($this->item->price) * 2
            ]
        ];

        $orderData = [
            'dining_table_id' => $this->table->id,
            'customer_id' => $this->customer->id,
            'branch_id' => $this->branch->id,
            'subtotal' => floatval($this->item->price) * 2,
            'total' => floatval($this->item->price) * 2,
            'order_type' => OrderType::DINING_TABLE,
            'is_advance_order' => Ask::NO,
            'source' => Source::WEB,
            'items' => json_encode($itemsPayload)
        ];

        $response = $this->withHeaders([
            'x-api-key' => env('MIX_API_KEY'),
        ])->postJson('/api/table/dining-order', $orderData);

        $response->assertStatus(201);
        $response->assertJsonStructure([
            'data' => [
                'id',
                'order_serial_no',
                'total_currency_price',
                'order_type',
                'status',
            ]
        ]);

        $this->assertDatabaseHas('orders', [
            'dining_table_id' => $this->table->id,
            'user_id' => $this->customer->id,
            'order_type' => OrderType::DINING_TABLE,
        ]);
    }

    /**
     * Test showing dining table order details.
     */
    public function test_can_show_dining_table_order()
    {
        // First we create a frontend order
        $order = FrontendOrder::create([
            'order_serial_no' => '190626001',
            'user_id' => $this->customer->id,
            'dining_table_id' => $this->table->id,
            'branch_id' => $this->branch->id,
            'subtotal' => 50.00,
            'discount' => 0.00,
            'total' => 50.00,
            'order_type' => OrderType::DINING_TABLE,
            'is_advance_order' => Ask::NO,
            'source' => Source::WEB,
            'status' => 1, // Pending
            'order_datetime' => now()->toDateTimeString(),
        ]);

        $response = $this->withHeaders([
            'x-api-key' => env('MIX_API_KEY'),
        ])->getJson('/api/table/dining-order/show/' . $order->id);

        $response->assertStatus(200);
        $response->assertJsonPath('data.id', $order->id);
    }
}
