<?php

namespace Database\Seeders;


use App\Enums\Status;
use App\Models\Language;
use Illuminate\Database\Seeder;
use App\Enums\DisplayMode;


class LanguageTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        Language::truncate();
        $englishLanguageArray = [
            'name'              => 'English',
            'code'              => 'en',
            'display_mode'      => DisplayMode::LTR,
            'status'            => Status::ACTIVE
        ];

        $arabicLanguageArray = [
            'name'              => 'Arabic',
            'code'              => 'ar',
            'display_mode'      => DisplayMode::RTL,
            'status'            => Status::ACTIVE
        ];

        $frenchLanguageArray = [
            'name'              => 'French',
            'code'              => 'fr',
            'display_mode'      => DisplayMode::LTR,
            'status'            => Status::ACTIVE
        ];

        $englishLanguage = Language::create($englishLanguageArray);
        if(file_exists(public_path('/images/language/english.png'))) {
            $englishLanguage->addMedia(public_path('/images/language/english.png'))->preservingOriginal()->toMediaCollection('language');
        }

        $arabicLanguage = Language::create($arabicLanguageArray);
        if (file_exists(public_path('/images/language/arabic.png'))) {
            $arabicLanguage->addMedia(public_path('/images/language/arabic.png'))->preservingOriginal()->toMediaCollection('language');
        }

        $frenchLanguage = Language::create($frenchLanguageArray);
        if (file_exists(public_path('/images/language/french.png'))) {
            $frenchLanguage->addMedia(public_path('/images/language/french.png'))->preservingOriginal()->toMediaCollection('language');
        }
    }
}
