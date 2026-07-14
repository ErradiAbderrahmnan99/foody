<?php

namespace Database\Seeders;


use Dipokhalder\EnvEditor\EnvEditor;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Artisan;
use Smartisan\Settings\Facades\Settings;

class CompanyTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        Settings::group('company')->set([
            'company_name'         => 'Foody - QrCode Restaurant Menu Maker and Contactless Menu Ordering system',
            'company_email'        => 'info@foody.com',
            'company_phone'        => '+212661234567',
            'company_website'      => 'https://foody.com',
            'company_city'         => 'Casablanca',
            'company_state'        => 'Casablanca-Settat',
            'company_country_code' => 'MAR',
            'company_zip_code'     => '20250',
            'company_address'      => 'Boulevard Mohammed V, Résidence Al Fath, N°25, Maârif, Casablanca 20250'
        ]);

        $envService = new EnvEditor();
        $envService->addData([
            'APP_NAME' => "Foody - QrCode Restaurant Menu Maker and Contactless Menu Ordering system"
        ]);
        Artisan::call('optimize:clear');
    }
}
