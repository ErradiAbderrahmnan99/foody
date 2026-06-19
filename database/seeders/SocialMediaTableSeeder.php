<?php

namespace Database\Seeders;


use App\Enums\OtpDigitLimit;
use App\Enums\OtpExpireTime;
use App\Enums\OtpType;
use Dipokhalder\EnvEditor\EnvEditor;
use Illuminate\Database\Seeder;

use Smartisan\Settings\Facades\Settings;

class SocialMediaTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $envService = new EnvEditor();

        Settings::group('social_media')->set([
            'social_media_facebook'  => '',
            'social_media_youtube'   => '',
            'social_media_instagram' => '',
            'social_media_twitter'   => ''
        ]);

        Settings::group('otp')->set([
            'otp_type'        => OtpType::BOTH,
            'otp_digit_limit' => OtpDigitLimit::FOUR,
            'otp_expire_time' => OtpExpireTime::TEN,
        ]);
    }
}
