<template>
    <LoadingComponent :props="loading" />

    <div class="col-12">
        <div class="db-card">
            <div class="db-card-header border-none">
                <h3 class="db-card-title">{{ $t('menu.dining_tables') }}</h3>
                <div class="db-card-filter">
                    <TableLimitComponent :method="list" :search="props.search" :page="paginationPage" />
                    <FilterComponent @click.prevent="handleSlide('dining-table-filter')" />
                    <div class="dropdown-group">
                        <ExportComponent />
                        <div
                            class="dropdown-list db-card-filter-dropdown-list transition-all duration-300 scale-y-0 origin-top">
                            <PrintComponent :props="printObj" />
                            <ExcelComponent :method="xls" />
                        </div>
                    </div>
                    <DiningTableCreateComponent :props="props" />
                </div>
            </div>

            <div class="table-filter-div" id="dining-table-filter">
                <form class="p-4 sm:p-5 mb-5" @submit.prevent="search">
                    <div class="row">
                        <div class="col-12 sm:col-6 md:col-4 xl:col-3">
                            <label for="name" class="db-field-title after:hidden">{{
                                $t("label.name")
                            }}</label>
                            <input id="name" v-model="props.search.name" type="text" class="db-field-control" />
                        </div>
                        <div class="col-12 sm:col-6 md:col-4 xl:col-3">
                            <label for="size" class="db-field-title after:hidden">{{
                                $t("label.size")
                            }}</label>
                            <input id="size" v-on:keypress="numberOnly($event)" v-model="props.search.size" type="text"
                                class="db-field-control" />
                        </div>

                        <div class="col-12 sm:col-6 md:col-4 xl:col-3">
                            <label for="searchStatus" class="db-field-title after:hidden">{{
                                $t("label.status")
                            }}</label>
                            <vue-select class="db-field-control f-b-custom-select" id="searchStatus"
                                v-model="props.search.status" :options="[
                                    { id: enums.statusEnum.ACTIVE, name: $t('label.active') },
                                    { id: enums.statusEnum.INACTIVE, name: $t('label.inactive') },
                                ]" label-by="name" value-by="id" :closeOnSelect="true" :searchable="true"
                                :clearOnClose="true" placeholder="--" search-placeholder="--" />
                        </div>

                        <div class="col-12">
                            <div class="flex flex-wrap gap-3 mt-4">
                                <button class="db-btn py-2 text-white bg-primary">
                                    <i class="lab lab-search-line lab-font-size-16"></i>
                                    <span>{{ $t("button.search") }}</span>
                                </button>
                                <button class="db-btn py-2 text-white bg-gray-600" @click="clear">
                                    <i class="lab lab-cross-line-2 lab-font-size-22"></i>
                                    <span>{{ $t("button.clear") }}</span>
                                </button>
                            </div>
                        </div>
                    </div>
                </form>
            </div>

            <div class="db-table-responsive rounded-xl border border-gray-100 bg-white overflow-hidden shadow-[0_4px_24px_rgba(0,0,0,0.03)]">
                <table class="db-table custom-tables-table" id="print">
                    <thead class="db-table-head bg-slate-50/75 border-b border-gray-100 text-[#475569]">
                        <tr class="db-table-head-tr">
                            <th class="db-table-head-th px-6 py-4 text-xs font-bold uppercase tracking-wider text-left">{{ $t('label.name') }}</th>
                            <th class="db-table-head-th px-6 py-4 text-xs font-bold uppercase tracking-wider text-left">{{ $t('label.size') }}</th>
                            <th class="db-table-head-th px-6 py-4 text-xs font-bold uppercase tracking-wider text-left">{{ $t('label.status') }}</th>
                            <th class="db-table-head-th px-6 py-4 text-xs font-bold uppercase tracking-wider text-left hidden-print"
                                v-if="permissionChecker('dining_tables_show') || permissionChecker('dining_tables_edit') || permissionChecker('dining_tables_delete')">
                                {{ $t('label.action') }}
                            </th>
                        </tr>
                    </thead>
                    <tbody class="db-table-body divide-y divide-gray-50 bg-white" v-if="diningTables.length > 0">
                        <tr class="db-table-body-tr hover:bg-slate-50/50 transition-colors duration-200" v-for="diningTable in diningTables" :key="diningTable.id">
                            <td class="db-table-body-td px-6 py-4.5 whitespace-nowrap">
                                <div class="flex items-center gap-4.5">
                                    <div class="w-11 h-11 rounded-xl bg-indigo-50 border border-indigo-100/60 flex items-center justify-center text-indigo-600 flex-shrink-0 shadow-sm transition-transform duration-300 hover:scale-105">
                                        <i class="lab lab-dining-table text-lg"></i>
                                    </div>
                                    <div>
                                        <span class="font-bold text-[#1e293b] text-[15px] block leading-tight">{{ diningTable.name }}</span>
                                        <span class="text-[10px] text-[#94a3b8] font-semibold uppercase tracking-wider block mt-1">ID: {{ diningTable.id }}</span>
                                    </div>
                                </div>
                            </td>
                            <td class="db-table-body-td px-6 py-4.5 whitespace-nowrap">
                                <span class="inline-flex items-center px-3 py-1 rounded-full text-xs font-semibold bg-slate-100 text-slate-700 border border-slate-200/50">
                                    {{ diningTable.size }} {{ $t('label.seats') || 'Seats' }}
                                </span>
                            </td>
                            <td class="db-table-body-td px-6 py-4.5 whitespace-nowrap">
                                <span class="inline-flex items-center gap-1.5 px-3 py-1 rounded-full text-xs font-semibold transition-all duration-200"
                                      :class="diningTable.status === enums.statusEnum.ACTIVE ? 'bg-emerald-50 text-emerald-700 border border-emerald-100 shadow-[0_2px_8px_-3px_rgba(16,185,129,0.08)]' : 'bg-rose-50 text-rose-700 border border-rose-100 shadow-[0_2px_8px_-3px_rgba(244,63,94,0.08)]'">
                                    <span class="w-1.5 h-1.5 rounded-full" :class="diningTable.status === enums.statusEnum.ACTIVE ? 'bg-emerald-500' : 'bg-rose-500'"></span>
                                    {{ enums.statusEnumArray[diningTable.status] }}
                                </span>
                            </td>
                            <td class="db-table-body-td px-6 py-4.5 whitespace-nowrap hidden-print"
                                v-if="permissionChecker('dining_tables_show') || permissionChecker('dining_tables_edit') || permissionChecker('dining_tables_delete')">
                                <div class="flex items-center gap-2">
                                    <SmIconQrCodeComponent :link="diningTable.qr" />
                                    <SmIconViewComponent :link="'admin.diningTable.show'" :id="diningTable.id"
                                        v-if="permissionChecker('dining_tables_show')" />
                                    <SmIconSidebarModalEditComponent @click="edit(diningTable)"
                                        v-if="permissionChecker('dining_tables_edit')" />
                                    <SmIconDeleteComponent @click="destroy(diningTable.id)"
                                        v-if="permissionChecker('dining_tables_delete') && demoChecker(diningTable.id)" />
                                </div>
                            </td>
                        </tr>
                    </tbody>
                    <tbody class="db-table-body" v-else>
                        <tr class="db-table-body-tr">
                            <td class="db-table-body-td text-center" colspan="7">
                                <div class="p-4">
                                    <div class="max-w-[300px] mx-auto mt-2">
                                        <img class="w-full h-full" :src="ENV.API_URL + '/images/default/not-found.png'"
                                            alt="Not Found">
                                    </div>
                                    <span class="d-block mt-3 text-lg">{{ $t('message.no_data_available') }}</span>
                                </div>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>

            <div class="flex items-center justify-between border-t border-gray-200 bg-white px-4 py-6"
                v-if="diningTables.length > 0">
                <PaginationSMBox :pagination="pagination" :method="list" />
                <div class="hidden sm:flex sm:flex-1 sm:items-center sm:justify-between">
                    <PaginationTextComponent :props="{ page: paginationPage }" />
                    <PaginationBox :pagination="pagination" :method="list" />
                </div>
            </div>
        </div>
    </div>
</template>
<script>
import LoadingComponent from "../components/LoadingComponent";
import DiningTableCreateComponent from "./DiningTableCreateComponent";
import alertService from "../../../services/alertService";
import PaginationTextComponent from "../components/pagination/PaginationTextComponent";
import PaginationBox from "../components/pagination/PaginationBox";
import PaginationSMBox from "../components/pagination/PaginationSMBox";
import appService from "../../../services/appService";
import statusEnum from "../../../enums/modules/statusEnum";
import TableLimitComponent from "../components/TableLimitComponent";
import SmIconDeleteComponent from "../components/buttons/SmIconDeleteComponent";
import SmIconSidebarModalEditComponent from "../components/buttons/SmIconSidebarModalEditComponent";
import SmIconQrCodeComponent from "../components/buttons/SmIconQrCodeComponent";
import SmIconViewComponent from "../components/buttons/SmIconViewComponent";
import ExportComponent from "../components/buttons/export/ExportComponent";
import PrintComponent from "../components/buttons/export/PrintComponent";
import ExcelComponent from "../components/buttons/export/ExcelComponent";
import FilterComponent from "../components/buttons/collapse/FilterComponent";
import ENV from "../../../config/env";

export default {
    name: "DiningTableListComponent",
    components: {
        TableLimitComponent,
        PaginationSMBox,
        PaginationBox,
        PaginationTextComponent,
        DiningTableCreateComponent,
        LoadingComponent,
        SmIconDeleteComponent,
        SmIconSidebarModalEditComponent,
        SmIconQrCodeComponent,
        SmIconViewComponent,
        ExportComponent,
        PrintComponent,
        ExcelComponent,
        FilterComponent
    },
    data() {
        return {
            loading: {
                isActive: false
            },
            printLoading: true,
            printObj: {
                id: "print",
                popTitle: this.$t("menu.dining_tables"),
            },
            enums: {
                statusEnum: statusEnum,
                statusEnumArray: {
                    [statusEnum.ACTIVE]: this.$t("label.active"),
                    [statusEnum.INACTIVE]: this.$t("label.inactive")
                }
            },
            props: {
                form: {
                    branch_id: null,
                    name: "",
                    size: "",
                    status: statusEnum.ACTIVE,
                },
                search: {
                    paginate: 1,
                    page: 1,
                    per_page: 10,
                    order_column: 'id',
                    order_type: 'desc',
                    name: "",
                    size: "",
                    status: null,
                }
            },
            ENV: ENV
        }
    },
    computed: {
        diningTables: function () {
            return this.$store.getters['diningTable/lists'];
        },
        pagination: function () {
            return this.$store.getters['diningTable/pagination'];
        },
        paginationPage: function () {
            return this.$store.getters['diningTable/page'];
        }
    },
    mounted() {
        this.list();
    },
    methods: {
        permissionChecker(e) {
            return appService.permissionChecker(e);
        },
        demoChecker: function (tableId) {
            return true;
        },
        numberOnly: function (e) {
            return appService.floatNumber(e);
        },
        statusClass: function (status) {
            return appService.statusClass(status);
        },
        textShortener: function (text, number = 30) {
            return appService.textShortener(text, number);
        },
        handleSlide: function (id) {
            return appService.handleSlide(id);
        },
        list: function (page = 1) {
            this.loading.isActive = true;
            this.props.search.page = page;
            this.$store.dispatch('diningTable/lists', this.props.search).then(res => {
                this.loading.isActive = false;
            }).catch((err) => {
                this.loading.isActive = false;
            });
        },
        search: function () {
            this.list();
        },
        clear: function () {
            this.props.search.paginate = 1;
            this.props.search.page = 1;
            this.props.search.name = "";
            this.props.search.size = "";
            this.props.search.status = null;
            this.list();
        },
        edit: function (diningTable) {
            appService.sideDrawerShow();
            this.loading.isActive = true;
            this.$store.dispatch('diningTable/edit', diningTable.id);
            this.props.form = {
                branch_id: diningTable.branch_id,
                name: diningTable.name,
                size: diningTable.size,
                status: diningTable.status,
            };
            this.loading.isActive = false;
        },
        destroy: function (id) {
            appService.destroyConfirmation().then((res) => {
                try {
                    this.loading.isActive = true;
                    this.$store.dispatch('diningTable/destroy', { id: id, search: this.props.search }).then((res) => {
                        this.loading.isActive = false;
                        alertService.successFlip(null, this.$t('menu.dining_tables'));
                    }).catch((err) => {
                        this.loading.isActive = false;
                        alertService.error(err.response.data.message);
                    })
                } catch (err) {
                    this.loading.isActive = false;
                    alertService.error(err.response.data.message);
                }
            }).catch((err) => {
                this.loading.isActive = false;
            })
        },
        xls: function () {
            this.loading.isActive = true;
            this.$store.dispatch("diningTable/export", this.props.search).then((res) => {
                this.loading.isActive = false;
                const blob = new Blob([res.data], {
                    type: "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
                });
                const link = document.createElement("a");
                link.href = URL.createObjectURL(blob);
                link.download = this.$t("menu.dining_tables");
                link.click();
                URL.revokeObjectURL(link.href);
            }).catch((err) => {
                this.loading.isActive = false;
                alertService.error(err.response.data.message);
            });
        },
    }
}
</script>

<style scoped>
/* Custom dining tables table specific styles */
.custom-tables-table {
    border-collapse: separate;
    border-spacing: 0;
    width: 100%;
}

.custom-tables-table :deep(.db-table-body-td) {
    padding: 1.125rem 1.5rem;
    vertical-align: middle;
}

.custom-tables-table :deep(.db-table-head-th) {
    padding: 1rem 1.5rem;
    vertical-align: middle;
}

/* Action button premium styling override */
:deep(.db-table-action) {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    transition: all 0.2s ease;
}

:deep(.db-table-action i) {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    width: 32px;
    height: 32px;
    font-size: 14px;
    border-radius: 8px;
    margin: 0;
    padding: 0;
    transition: all 0.22s cubic-bezier(0.4, 0, 0.2, 1);
    border: 1px solid transparent;
}

:deep(.db-table-action.qr-code i) {
    color: #f59e0b;
    background-color: #fef3c7;
    border-color: #fde68a;
}

:deep(.db-table-action.qr-code:hover i) {
    color: #ffffff;
    background-color: #f59e0b;
    border-color: #f59e0b;
    box-shadow: 0 4px 12px rgba(245, 158, 11, 0.18);
}

:deep(.db-table-action.view i) {
    color: #4f46e5;
    background-color: #f5f3ff;
    border-color: #e0e7ff;
}

:deep(.db-table-action.view:hover i) {
    color: #ffffff;
    background-color: #4f46e5;
    border-color: #4f46e5;
    box-shadow: 0 4px 12px rgba(79, 70, 229, 0.18);
}

:deep(.db-table-action.edit i) {
    color: #059669;
    background-color: #ecfdf5;
    border-color: #d1fae5;
}

:deep(.db-table-action.edit:hover i) {
    color: #ffffff;
    background-color: #059669;
    border-color: #059669;
    box-shadow: 0 4px 12px rgba(5, 150, 105, 0.18);
}

:deep(.db-table-action.delete i) {
    color: #dc2626;
    background-color: #fef2f2;
    border-color: #fee2e2;
}

:deep(.db-table-action.delete:hover i) {
    color: #ffffff;
    background-color: #dc2626;
    border-color: #dc2626;
    box-shadow: 0 4px 12px rgba(220, 38, 38, 0.18);
}

/* Tooltip custom styling */
:deep(.db-tooltip) {
    font-size: 10px;
    font-weight: 700;
    letter-spacing: 0.5px;
    border-radius: 6px;
    padding: 4px 8px;
    background-color: #1e293b;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
    transition: all 0.2s ease;
}

@media print {
    .hidden-print {
        display: none !important;
    }
}
</style>