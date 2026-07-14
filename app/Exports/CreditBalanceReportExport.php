<?php

namespace App\Exports;

use App\Libraries\AppLibrary;
use App\Http\Requests\PaginateRequest;
use App\Http\Controllers\Admin\CreditBalanceReportController;
use Maatwebsite\Excel\Concerns\WithHeadings;
use Maatwebsite\Excel\Concerns\FromCollection;

class CreditBalanceReportExport implements FromCollection, WithHeadings
{

    public CreditBalanceReportController $controller;
    public PaginateRequest $request;

    public function __construct(CreditBalanceReportController $controller, $request)
    {
        $this->controller = $controller;
        $this->request    = $request;
    }

    public function collection(): \Illuminate\Support\Collection
    {
        $creditBalanceReportArray  = [];
        $usersArray = $this->controller->customerList($this->request);

        foreach ($usersArray as $user) {
            $creditBalanceReportArray[] = [
                $user->name,
                $user->email,
                $user->country_code . '' . $user->phone,
                AppLibrary::flatAmountFormat($user->total_spent ?? 0),
                $user->total_orders ?? 0,
            ];
        }
        return collect($creditBalanceReportArray);
    }

    public function headings(): array
    {
        return [
            trans('all.label.name'),
            trans('all.label.email'),
            trans('all.label.phone'),
            trans('all.label.balance'),
            trans('all.label.total_orders', [], 'Total Orders'),
        ];
    }
}
