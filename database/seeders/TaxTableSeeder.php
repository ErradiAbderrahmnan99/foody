<?php

namespace Database\Seeders;

use Dipokhalder\EnvEditor\EnvEditor;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use App\Enums\TaxType;
use App\Enums\Status;
use App\Models\Tax;

class TaxTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $envService = new EnvEditor();
        if ($envService->getValue('DEMO')) {
            Tax::insert([
                [
                    'name'       => 'TVA',
                    'code'       => 'TVA-0%',
                    'tax_rate'   => 0,
                    'type'       => TaxType::PERCENTAGE,
                    'status'     => Status::ACTIVE,
                    'created_at' => now(),
                    'updated_at' => now()
                ],
                [
                    'name'       => 'TVA',
                    'code'       => 'TVA-12%',
                    'tax_rate'   => 12,
                    'type'       => TaxType::PERCENTAGE,
                    'status'     => Status::ACTIVE,
                    'created_at' => now(),
                    'updated_at' => now()
                ],
                [
                    'name'       => 'TVA',
                    'code'       => 'TVA-20%',
                    'tax_rate'   => 20,
                    'type'       => TaxType::PERCENTAGE,
                    'status'     => Status::ACTIVE,
                    'created_at' => now(),
                    'updated_at' => now()
                ]
            ]);
        }
    }
}
