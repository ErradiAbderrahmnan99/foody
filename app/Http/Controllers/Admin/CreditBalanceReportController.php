<?php

namespace App\Http\Controllers\Admin;

use Exception;
use App\Models\User;
use App\Enums\Role;
use App\Enums\OrderStatus;
use Maatwebsite\Excel\Facades\Excel;
use App\Http\Requests\PaginateRequest;
use App\Exports\CreditBalanceReportExport;
use App\Http\Resources\CreditBalanceUserResource;

class CreditBalanceReportController extends AdminController
{

    public function __construct()
    {
        parent::__construct();
        $this->middleware(['permission:credit-balance-report'])->only('index', 'export');
    }

    public function index(PaginateRequest $request): \Illuminate\Http\Response | \Illuminate\Http\Resources\Json\AnonymousResourceCollection | \Illuminate\Contracts\Foundation\Application | \Illuminate\Contracts\Routing\ResponseFactory
    {
        try {
            return CreditBalanceUserResource::collection($this->customerList($request));
        } catch (Exception $exception) {
            return response(['status' => false, 'message' => $exception->getMessage()], 422);
        }
    }

    public function export(PaginateRequest $request): \Illuminate\Http\Response | \Symfony\Component\HttpFoundation\BinaryFileResponse | \Illuminate\Contracts\Foundation\Application | \Illuminate\Contracts\Routing\ResponseFactory
    {
        try {
            return Excel::download(new CreditBalanceReportExport($this, $request), 'Credit-balance-Report.xlsx');
        } catch (Exception $exception) {
            return response(['status' => false, 'message' => $exception->getMessage()], 422);
        }
    }

    public function customerList(PaginateRequest $request)
    {
        $requests    = $request->all();
        $method      = $request->get('paginate', 0) == 1 ? 'paginate' : 'get';
        $methodValue = $request->get('paginate', 0) == 1 ? $request->get('per_page', 10) : '*';
        $orderColumn = $request->get('order_column') ?? 'id';
        $orderType   = $request->get('order_type') ?? 'desc';

        $userFilter = ['name', 'email', 'phone'];

        return User::with('media')
            ->whereHas('roles', function ($query) {
                $query->where('id', Role::CUSTOMER);
            })
            ->withSum(['orders as total_spent' => function ($query) {
                $query->where('status', OrderStatus::DELIVERED);
            }], 'total')
            ->withCount(['orders as total_orders' => function ($query) {
                $query->where('status', OrderStatus::DELIVERED);
            }])
            ->where(function ($query) use ($requests, $userFilter) {
                foreach ($requests as $key => $request) {
                    if (in_array($key, $userFilter)) {
                        $query->where($key, 'like', '%' . $request . '%');
                    }
                }
            })
            ->orderBy($orderColumn, $orderType)
            ->$method($methodValue);
    }
}
