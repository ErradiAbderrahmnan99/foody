<?php

namespace App\Services;


use Smartisan\Settings\Facades\Settings;


class SmsService
{
    public string $gateway;

    public function gateway() : string
    {
        $this->gateway = '';
        return $this->gateway;
    }
}
