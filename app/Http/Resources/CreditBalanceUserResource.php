<?php

namespace App\Http\Resources;


use App\Libraries\AppLibrary;
use Illuminate\Http\Resources\Json\JsonResource;

class CreditBalanceUserResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @param \Illuminate\Http\Request $request
     * @return array
     */
    public function toArray($request): array
    {
        return [
            "id"               => $this->id,
            "name"             => $this->name,
            "first_name"       => $this->FirstName,
            "last_name"        => $this->LastName,
            "phone"            => $this->phone,
            "email"            => $this->email,
            'username'         => $this->username,
            "balance"          => AppLibrary::flatAmountFormat($this->total_spent ?? 0),
            "currency_balance" => AppLibrary::currencyAmountFormat($this->total_spent ?? 0),
            "total_orders"     => $this->total_orders ?? 0,
            "country_code"     => $this->country_code,
        ];
    }
}
