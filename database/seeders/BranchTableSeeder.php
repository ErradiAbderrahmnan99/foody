<?php

namespace Database\Seeders;

use App\Enums\Status;
use App\Models\Branch;
use Illuminate\Database\Seeder;

class BranchTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        Branch::create([
            'name'      => 'Casablanca - Maârif',
            'email'     => 'casablanca@foody.com',
            'phone'     => '+212661234567',
            'latitude'  => 33.5731,
            'longitude' => -7.5898,
            'city'      => 'Casablanca',
            'state'     => 'Casablanca-Settat',
            'zip_code'  => '20250',
            'address'   => 'Boulevard Zerktouni, Résidence Al Fath, N°25, Maârif, Casablanca 20250',
            'status'    => Status::ACTIVE,
        ]);
        Branch::create([
            'name'      => 'Rabat - Agdal',
            'email'     => 'rabat@foody.com',
            'phone'     => '+212670123456',
            'latitude'  => 33.9716,
            'longitude' => -6.8498,
            'city'      => 'Rabat',
            'state'     => 'Rabat-Salé-Kénitra',
            'zip_code'  => '10080',
            'address'   => 'Avenue Ibn Sina, Immeuble Atlas, N°12, Agdal, Rabat 10080',
            'status'    => Status::ACTIVE,
        ]);
        
    }
}
