<?php

namespace Database\Seeders;

use App\Enums\Ask;
use App\Models\Address;
use App\Enums\Role as EnumRole;
use Illuminate\Database\Seeder;
use App\Models\User;
use App\Enums\Status;


class UserTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
$admin      = User::create([
            'name'              => 'Youssef El Amrani',
            'email'             => 'admin@example.com',
            'phone'             => '0661234567',
            'username'          => 'admin',
            'email_verified_at' => now(),
            'password'          => bcrypt('123456'),
            'branch_id'         => 0,
            'status'            => Status::ACTIVE,
            'country_code'      => '+212',
            'is_guest'          => Ask::NO
        ]);
        $admin->assignRole(EnumRole::ADMIN);

        
            Address::create([
                'label'     => 'Home',
                'address'   => 'Boulevard Mohammed V, Casablanca',
                'apartment' => rand(0, 999) . ', Maârif',
                'latitude'  => '33.5731',
                'longitude' => '-7.5898',
                'user_id'   => $admin->id,
            ]);
            Address::create([
                'label'     => 'Work',
                'address'   => 'Rue des Far, Casablanca',
                'apartment' => rand(0, 999) . ', Bourgogne',
                'latitude'  => '33.5950',
                'longitude' => '-7.6187',
                'user_id'   => $admin->id,
            ]);
        

        $customer = User::create([
            'name'              => 'Client de passage',
            'email'             => 'walkingcustomer@example.com',
            'phone'             => '0670123456',
            'username'          => 'default-customer',
            'email_verified_at' => now(),
            'password'          => bcrypt('123456'),
            'branch_id'         => 0,
            'status'            => Status::ACTIVE,
            'country_code'      => '+212',
            'is_guest'          => Ask::NO
        ]);
        $customer->assignRole(EnumRole::CUSTOMER);

        
            Address::create([
                'label'     => 'Home',
                'address'   => 'Avenue Hassan II, Rabat',
                'apartment' => rand(0, 999) . ', Agdal',
                'latitude'  => '33.9716',
                'longitude' => '-6.8498',
                'user_id'   => $customer->id,
            ]);
            Address::create([
                'label'     => 'Work',
                'address'   => 'Rue Oukaimeden, Rabat',
                'apartment' => rand(0, 999) . ', Hay Riad',
                'latitude'  => '33.9566',
                'longitude' => '-6.8722',
                'user_id'   => $customer->id,
            ]);
        

        
            $customerOne = User::create([
                'name'              => 'Amine Bennani',
                'email'             => 'customer@example.com',
                'phone'             => '0655987654',
                'username'          => 'amine-bennani',
                'email_verified_at' => now(),
                'password'          => bcrypt('123456'),
                'branch_id'         => 0,
                'status'            => Status::ACTIVE,
                'country_code'      => '+212',
                'is_guest'          => Ask::NO
            ]);
            $customerOne->assignRole(EnumRole::CUSTOMER);
            Address::create([
                'label'     => 'Home',
                'address'   => 'Avenue Mohammed VI, Marrakech',
                'apartment' => rand(0, 999) . ', Guéliz',
                'latitude'  => '31.6340',
                'longitude' => '-8.0100',
                'user_id'   => $customerOne->id,
            ]);
            Address::create([
                'label'     => 'Work',
                'address'   => 'Place Jemaa el-Fna, Marrakech',
                'apartment' => rand(0, 999) . ', Médina',
                'latitude'  => '31.6258',
                'longitude' => '-7.9891',
                'user_id'   => $customerOne->id,
            ]);
            $employeeOne = User::create([
                'name'              => 'Karim Tazi',
                'email'             => 'branchmanager@example.com',
                'phone'             => '0662345678',
                'username'          => 'karim-tazi',
                'email_verified_at' => now(),
                'password'          => bcrypt('123456'),
                'branch_id'         => 1,
                'status'            => Status::ACTIVE,
                'country_code'      => '+212',
                'is_guest'          => Ask::NO
            ]);
            $employeeOne->assignRole(EnumRole::BRANCH_MANAGER);
            Address::create([
                'label'     => 'Home',
                'address'   => 'Boulevard Zerktouni, Casablanca',
                'apartment' => rand(0, 999) . ', Maârif',
                'latitude'  => '33.5884',
                'longitude' => '-7.6325',
                'user_id'   => $employeeOne->id,
            ]);
            Address::create([
                'label'     => 'Work',
                'address'   => 'Rue Tarik Ibn Ziad, Casablanca',
                'apartment' => rand(0, 999) . ', Centre Ville',
                'latitude'  => '33.5950',
                'longitude' => '-7.6119',
                'user_id'   => $employeeOne->id,
            ]);

            $employeeTwo = User::create([
                'name'              => 'Omar Cherkaoui',
                'email'             => 'omar@example.com',
                'phone'             => '0673456789',
                'username'          => 'omar-cherkaoui',
                'email_verified_at' => now(),
                'password'          => bcrypt('123456'),
                'branch_id'         => 2,
                'status'            => Status::ACTIVE,
                'country_code'      => '+212',
                'is_guest'          => Ask::NO
            ]);
            $employeeTwo->assignRole(EnumRole::BRANCH_MANAGER);
            Address::create([
                'label'     => 'Home',
                'address'   => 'Avenue Allal Ben Abdellah, Rabat',
                'apartment' => rand(0, 999) . ', Centre Ville',
                'latitude'  => '34.0209',
                'longitude' => '-6.8363',
                'user_id'   => $employeeTwo->id,
            ]);
            Address::create([
                'label'     => 'Work',
                'address'   => 'Rue Souika, Rabat',
                'apartment' => rand(0, 999) . ', Médina',
                'latitude'  => '34.0253',
                'longitude' => '-6.8341',
                'user_id'   => $employeeTwo->id,
            ]);

            $posOperatorOne = User::create([
                'name'              => 'Fatima Zahra Idrissi',
                'email'             => 'posoperator@example.com',
                'phone'             => '0668765432',
                'username'          => 'fatima-idrissi',
                'email_verified_at' => now(),
                'password'          => bcrypt('123456'),
                'branch_id'         => 1,
                'status'            => Status::ACTIVE,
                'country_code'      => '+212',
                'is_guest'          => Ask::NO
            ]);
            $posOperatorOne->assignRole(EnumRole::POS_OPERATOR);
            Address::create([
                'label'     => 'Home',
                'address'   => 'Rue Ibnou Rochd, Casablanca',
                'apartment' => rand(0, 999) . ', Gauthier',
                'latitude'  => '33.5860',
                'longitude' => '-7.6280',
                'user_id'   => $posOperatorOne->id,
            ]);
            Address::create([
                'label'     => 'Work',
                'address'   => 'Boulevard d\'Anfa, Casablanca',
                'apartment' => rand(0, 999) . ', Anfa',
                'latitude'  => '33.5793',
                'longitude' => '-7.6467',
                'user_id'   => $posOperatorOne->id,
            ]);

            $posOperatorTwo = User::create([
                'name'              => 'Salma Ouazzani',
                'email'             => 'salma@example.com',
                'phone'             => '0679876543',
                'username'          => 'salma-ouazzani',
                'email_verified_at' => now(),
                'password'          => bcrypt('123456'),
                'branch_id'         => 2,
                'status'            => Status::ACTIVE,
                'country_code'      => '+212',
                'is_guest'          => Ask::NO
            ]);
            $posOperatorTwo->assignRole(EnumRole::POS_OPERATOR);
            Address::create([
                'label'     => 'Home',
                'address'   => 'Avenue Moulay Youssef, Rabat',
                'apartment' => rand(0, 999) . ', Hassan',
                'latitude'  => '34.0132',
                'longitude' => '-6.8326',
                'user_id'   => $posOperatorTwo->id,
            ]);
            Address::create([
                'label'     => 'Work',
                'address'   => 'Rue Al Marsa, Rabat',
                'apartment' => rand(0, 999) . ', Les Oudayas',
                'latitude'  => '34.0310',
                'longitude' => '-6.8400',
                'user_id'   => $posOperatorTwo->id,
            ]);

            $stuffOne = User::create([
                'name'              => 'Hamza Berrada',
                'email'             => 'stuff@example.com',
                'phone'             => '0661122334',
                'username'          => 'hamza-berrada',
                'email_verified_at' => now(),
                'password'          => bcrypt('123456'),
                'branch_id'         => 1,
                'status'            => Status::ACTIVE,
                'country_code'      => '+212',
                'is_guest'          => Ask::NO
            ]);
            $stuffOne->assignRole(EnumRole::STUFF);
            Address::create([
                'label'     => 'Home',
                'address'   => 'Rue Sebou, Casablanca',
                'apartment' => rand(0, 999) . ', Racine',
                'latitude'  => '33.5870',
                'longitude' => '-7.6350',
                'user_id'   => $stuffOne->id,
            ]);
            Address::create([
                'label'     => 'Work',
                'address'   => 'Boulevard Bir Anzarane, Casablanca',
                'apartment' => rand(0, 999) . ', Maârif',
                'latitude'  => '33.5780',
                'longitude' => '-7.6340',
                'user_id'   => $stuffOne->id,
            ]);

            $stuffTwo = User::create([
                'name'              => 'Nadia El Fassi',
                'email'             => 'nadia@example.com',
                'phone'             => '0675544332',
                'username'          => 'nadia-elfassi',
                'email_verified_at' => now(),
                'password'          => bcrypt('123456'),
                'branch_id'         => 2,
                'status'            => Status::ACTIVE,
                'country_code'      => '+212',
                'is_guest'          => Ask::NO
            ]);
            $stuffTwo->assignRole(EnumRole::STUFF);
            Address::create([
                'label'     => 'Home',
                'address'   => 'Avenue Ibn Sina, Rabat',
                'apartment' => rand(0, 999) . ', Agdal',
                'latitude'  => '33.9830',
                'longitude' => '-6.8560',
                'user_id'   => $stuffTwo->id,
            ]);
            Address::create([
                'label'     => 'Work',
                'address'   => 'Rue Abou Inane, Rabat',
                'apartment' => rand(0, 999) . ', Hassan',
                'latitude'  => '34.0170',
                'longitude' => '-6.8350',
                'user_id'   => $stuffTwo->id,
            ]);
            $waiter = User::create([
                'name'              => 'Rachid Alaoui',
                'email'             => 'waiter@example.com',
                'phone'             => '0663344556',
                'username'          => 'rachid-alaoui',
                'email_verified_at' => now(),
                'password'          => bcrypt('123456'),
                'branch_id'         => 1,
                'status'            => Status::ACTIVE,
                'country_code'      => '+212',
                'is_guest'          => Ask::NO
            ]);
            $waiter->assignRole(EnumRole::WAITER);
            Address::create([
                'label'     => 'Home',
                'address'   => 'Rue Al Amir Abdelkader, Casablanca',
                'apartment' => rand(0, 999) . ', Derb Sultan',
                'latitude'  => '33.5680',
                'longitude' => '-7.5970',
                'user_id'   => $waiter->id,
            ]);
            Address::create([
                'label'     => 'Work',
                'address'   => 'Boulevard de la Corniche, Casablanca',
                'apartment' => rand(0, 999) . ', Ain Diab',
                'latitude'  => '33.5930',
                'longitude' => '-7.6700',
                'user_id'   => $waiter->id,
            ]);

            $chef = User::create([
                'name'              => 'Mourad Benkirane',
                'email'             => 'chef@example.com',
                'phone'             => '0667788990',
                'username'          => 'mourad-benkirane',
                'email_verified_at' => now(),
                'password'          => bcrypt('123456'),
                'branch_id'         => 1,
                'status'            => Status::ACTIVE,
                'country_code'      => '+212',
                'is_guest'          => Ask::NO
            ]);
            $chef->assignRole(EnumRole::CHEF);
            Address::create([
                'label'     => 'Home',
                'address'   => 'Rue Allal El Fassi, Casablanca',
                'apartment' => rand(0, 999) . ', Sidi Maârouf',
                'latitude'  => '33.5440',
                'longitude' => '-7.6530',
                'user_id'   => $chef->id,
            ]);
            Address::create([
                'label'     => 'Work',
                'address'   => 'Boulevard Ghandi, Casablanca',
                'apartment' => rand(0, 999) . ', Maârif',
                'latitude'  => '33.5770',
                'longitude' => '-7.6310',
                'user_id'   => $chef->id,
            ]);
        
    }
}