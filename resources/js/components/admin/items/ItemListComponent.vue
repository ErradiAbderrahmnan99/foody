<template>
    <LoadingComponent :props="loading" />
    <div class="col-12">
        <div class="db-card">
            <div class="db-card-header border-none">
                <h3 class="db-card-title">{{ $t('menu.items') }}</h3>
                <div class="db-card-filter">
                    <TableLimitComponent :method="list" :search="props.search" :page="paginationPage" />
                    <FilterComponent @click.prevent="handleSlide('item-filter')" />
                    <div class="dropdown-group">
                        <ExportComponent />
                        <div
                            class="dropdown-list db-card-filter-dropdown-list transition-all duration-300 scale-y-0 origin-top">
                            <PrintComponent :props="printObj" />
                            <ExcelComponent :method="xls" />
                        </div>
                    </div>
                    <div v-if="permissionChecker('items_create')" class="dropdown-group">
                        <ImportComponent />
                        <div
                            class="dropdown-list db-card-filter-dropdown-list transition-all duration-300 scale-y-0 origin-top">
                            <SampleFileComponent @click="downloadSample" />
                            <UploadFileComponent :dataModal="'itemUpload'" @click="uploadModal('#itemUpload')" />
                        </div>
                    </div>
                    <ItemUploadComponent v-on:list="list" />
                    <ItemCreateComponent :props="props" v-if="permissionChecker('items_create')" />
                </div>
            </div>

            <div class="table-filter-div" id="item-filter">
                <form class="p-4 sm:p-5 mb-5" @submit.prevent="search">
                    <div class="row">
                        <div class="col-12 sm:col-6 md:col-4 xl:col-3">
                            <label for="name" class="db-field-title after:hidden">{{
                                $t("label.name")
                            }}</label>
                            <input id="name" v-model="props.search.name" type="text" class="db-field-control" />
                        </div>
                        <div class="col-12 sm:col-6 md:col-4 xl:col-3">
                            <label for="price" class="db-field-title after:hidden">{{
                                $t("label.price")
                            }}</label>
                            <input id="price" v-on:keypress="numberOnly($event)" v-model="props.search.price"
                                type="text" class="db-field-control" />
                        </div>
                        <div class="col-12 sm:col-6 md:col-4 xl:col-3">
                            <label for="item_category_id" class="db-field-title">{{
                                $t("label.category")
                            }}</label>

                            <vue-select class="db-field-control f-b-custom-select" id="item_category_id"
                                v-model="props.search.item_category_id" :options="itemCategories" label-by="name"
                                value-by="id" :closeOnSelect="true" :searchable="true" :clearOnClose="true"
                                placeholder="--" search-placeholder="--" />
                        </div>

                        <div class="col-12 sm:col-6 md:col-4 xl:col-3">
                            <label for="tax_id" class="db-field-title">{{
                                $t("label.tax")
                            }}</label>

                            <vue-select class="db-field-control f-b-custom-select" id="tax_id"
                                v-model="props.search.tax_id" :options="taxes" label-by="name" value-by="id"
                                :closeOnSelect="true" :searchable="true" :clearOnClose="true" placeholder="--"
                                search-placeholder="--" />
                        </div>
                        <div class="col-12 sm:col-6 md:col-4 xl:col-3">
                            <label for="searchItemType" class="db-field-title after:hidden">{{
                                $t("label.item_type")
                            }}</label>
                            <vue-select class="db-field-control f-b-custom-select" id="searchItemType"
                                v-model="props.search.item_type" :options="[
                                    { id: enums.itemTypeEnum.VEG, name: $t('label.veg') },
                                    { id: enums.itemTypeEnum.NON_VEG, name: $t('label.non_veg') },
                                ]" label-by="name" value-by="id" :closeOnSelect="true" :searchable="true"
                                :clearOnClose="true" placeholder="--" search-placeholder="--" />
                        </div>

                        <div class="col-12 sm:col-6 md:col-4 xl:col-3">
                            <label for="searchIsFeatured" class="db-field-title after:hidden">{{
                                $t("label.is_featured")
                            }}</label>
                            <vue-select class="db-field-control f-b-custom-select" id="searchIsFeatured"
                                v-model="props.search.is_featured" :options="[
                                    { id: enums.askEnum.YES, name: $t('label.yes') },
                                    { id: enums.askEnum.NO, name: $t('label.no') },
                                ]" label-by="name" value-by="id" :closeOnSelect="true" :searchable="true"
                                :clearOnClose="true" placeholder="--" search-placeholder="--" />
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
                <table class="db-table custom-items-table" id="print" :dir="direction">
                    <thead class="db-table-head bg-slate-50/75 border-b border-gray-100 text-[#475569]">
                        <tr class="db-table-head-tr">
                            <th class="db-table-head-th px-6 py-4 text-xs font-bold uppercase tracking-wider text-left">
                                {{ $t('label.name') }}
                            </th>
                            <th class="db-table-head-th px-6 py-4 text-xs font-bold uppercase tracking-wider text-left">
                                {{ $t('label.category') }}
                            </th>
                            <th class="db-table-head-th px-6 py-4 text-xs font-bold uppercase tracking-wider text-left">
                                {{ $t('label.price') }}
                            </th>
                            <th class="db-table-head-th px-6 py-4 text-xs font-bold uppercase tracking-wider text-left">
                                {{ $t('label.status') }}
                            </th>
                            <th class="db-table-head-th px-6 py-4 text-xs font-bold uppercase tracking-wider text-left hidden-print"
                                v-if="permissionChecker('items_show') || permissionChecker('items_edit') || permissionChecker('items_delete')">
                                {{ $t('label.action') }}
                            </th>
                        </tr>
                    </thead>
                    <tbody class="db-table-body divide-y divide-gray-50 bg-white" v-if="items.length > 0">
                        <tr class="db-table-body-tr hover:bg-slate-50/50 transition-colors duration-200" v-for="item in items" :key="item.id">
                            <td class="db-table-body-td px-6 py-4.5 whitespace-nowrap">
                                <div class="flex items-center gap-4.5">
                                    <div class="relative w-11 h-11 rounded-xl overflow-hidden bg-slate-50 flex-shrink-0 border border-slate-100 shadow-sm transition-all duration-300 hover:scale-105">
                                        <img :src="item.thumb" class="w-full h-full object-cover" :alt="item.name" />
                                    </div>
                                    <div>
                                        <div class="font-bold text-[#1e293b] text-[15px] leading-snug">
                                            {{ textShortener(item.name, 40) }}
                                        </div>
                                        <div class="text-[11px] text-[#94a3b8] mt-1 flex items-center gap-2 font-medium">
                                            <span class="inline-block px-1.5 py-0.5 rounded bg-slate-100 text-slate-500 font-bold uppercase tracking-wider scale-[0.9] origin-left">ID: {{ item.id }}</span>
                                            <span v-if="item.item_type !== undefined" class="inline-block px-1.5 py-0.5 rounded text-[10px]" :class="item.item_type === enums.itemTypeEnum.VEG ? 'bg-emerald-50 text-emerald-600 border border-emerald-100' : 'bg-rose-50 text-rose-600 border border-rose-100'">
                                                {{ item.item_type === enums.itemTypeEnum.VEG ? 'Veg' : 'Non-Veg' }}
                                            </span>
                                        </div>
                                    </div>
                                </div>
                            </td>
                            <td class="db-table-body-td px-6 py-4.5 whitespace-nowrap">
                                <span class="inline-flex items-center px-3 py-1 rounded-full text-xs font-semibold bg-indigo-50 text-indigo-700 border border-indigo-100/50">
                                    {{ item.category_name }}
                                </span>
                            </td>
                            <td class="db-table-body-td px-6 py-4.5 whitespace-nowrap font-bold text-slate-800 text-[15px]">
                                {{ item.flat_price }}
                            </td>
                            <td class="db-table-body-td px-6 py-4.5 whitespace-nowrap">
                                <span class="inline-flex items-center gap-1.5 px-3 py-1 rounded-full text-xs font-semibold transition-all duration-200"
                                      :class="item.status === enums.statusEnum.ACTIVE ? 'bg-emerald-50 text-emerald-700 border border-emerald-100 shadow-[0_2px_8px_-3px_rgba(16,185,129,0.08)]' : 'bg-rose-50 text-rose-700 border border-rose-100 shadow-[0_2px_8px_-3px_rgba(244,63,94,0.08)]'">
                                    <span class="w-1.5 h-1.5 rounded-full" :class="item.status === enums.statusEnum.ACTIVE ? 'bg-emerald-500' : 'bg-rose-500'"></span>
                                    {{ enums.statusEnumArray[item.status] }}
                                </span>
                            </td>
                            <td class="db-table-body-td px-6 py-4.5 whitespace-nowrap hidden-print"
                                v-if="permissionChecker('items_show') || permissionChecker('items_edit') || permissionChecker('items_delete')">
                                <div class="flex items-center gap-2">
                                    <SmIconViewComponent :link="'admin.item.show'" :id="item.id"
                                        v-if="permissionChecker('items_show')" />
                                    <SmIconSidebarModalEditComponent @click="edit(item)"
                                        v-if="permissionChecker('items_edit')" />
                                    <SmIconDeleteComponent @click="destroy(item.id)"
                                        v-if="permissionChecker('items_delete')" />
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
                v-if="items.length > 0">
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
import ItemCreateComponent from "./ItemCreateComponent";
import alertService from "../../../services/alertService";
import statusEnum from "../../../enums/modules/statusEnum";
import askEnum from "../../../enums/modules/askEnum";
import itemTypeEnum from "../../../enums/modules/itemTypeEnum";
import PaginationTextComponent from "../components/pagination/PaginationTextComponent";
import PaginationBox from "../components/pagination/PaginationBox";
import PaginationSMBox from "../components/pagination/PaginationSMBox";
import appService from "../../../services/appService";
import TableLimitComponent from "../components/TableLimitComponent";
import SmIconSidebarModalEditComponent from "../components/buttons/SmIconSidebarModalEditComponent";
import SmIconDeleteComponent from "../components/buttons/SmIconDeleteComponent";
import SmIconViewComponent from "../components/buttons/SmIconViewComponent";
import FilterComponent from "../components/buttons/collapse/FilterComponent";
import ExportComponent from "../components/buttons/export/ExportComponent";
import PrintComponent from "../components/buttons/export/PrintComponent";
import ExcelComponent from "../components/buttons/export/ExcelComponent";
import displayModeEnum from "../../../enums/modules/displayModeEnum";
import SampleFileComponent from "../components/buttons/import/SampleFileComponent.vue";
import UploadFileComponent from "../components/buttons/import/UploadFileComponent.vue";
import ImportComponent from "../components/buttons/import/ImportComponent.vue";
import ItemUploadComponent from './ItemUploadComponent.vue';
import ENV from '../../../config/env';

export default {
    name: "ItemListComponent",
    components: {
        TableLimitComponent,
        PaginationSMBox,
        PaginationBox,
        PaginationTextComponent,
        ItemCreateComponent,
        LoadingComponent,
        SmIconSidebarModalEditComponent,
        SmIconDeleteComponent,
        SmIconViewComponent,
        FilterComponent,
        ExportComponent,
        PrintComponent,
        ExcelComponent,
        SampleFileComponent,
        UploadFileComponent,
        ImportComponent,
        ItemUploadComponent
    },
    data() {
        return {
            loading: {
                isActive: false
            },
            enums: {
                statusEnum: statusEnum,
                itemTypeEnum: itemTypeEnum,
                askEnum: askEnum,
                statusEnumArray: {
                    [statusEnum.ACTIVE]: this.$t("label.active"),
                    [statusEnum.INACTIVE]: this.$t("label.inactive")
                }
            },
            printLoading: true,
            printObj: {
                id: "print",
                popTitle: this.$t("menu.items"),
            },
            taxProps: {
                search: {
                    paginate: 0,
                    order_column: 'id',
                    order_type: 'asc'
                }
            },
            categoryProps: {
                search: {
                    paginate: 0,
                    order_column: 'id',
                    order_type: 'asc'
                }
            },
            props: {
                form: {
                    name: "",
                    price: "",
                    description: "",
                    caution: "",
                    is_featured: askEnum.YES,
                    item_type: itemTypeEnum.VEG,
                    item_category_id: null,
                    tax_id: null,
                    status: statusEnum.ACTIVE,
                },
                search: {
                    paginate: 1,
                    page: 1,
                    per_page: 10,
                    order_column: 'id',
                    order_type: 'desc',
                    name: "",
                    price: "",
                    item_category_id: null,
                    status: null,
                    tax_id: null,
                    item_type: null,
                    is_featured: null
                }
            },
            ENV: ENV
        }
    },
    mounted() {
        this.list();
        this.loading.isActive = true;
        this.props.search.page = 1;
        this.$store.dispatch('itemCategory/lists', this.categoryProps.search).then(res => {
            this.loading.isActive = false;
        }).catch((err) => {
            this.loading.isActive = false;
        });
        this.$store.dispatch('tax/lists', this.taxProps.search).then(res => {
            this.loading.isActive = false;
        }).catch((err) => {
            this.loading.isActive = false;
        });
    },
    computed: {
        items: function () {
            return this.$store.getters['item/lists'];
        },
        pagination: function () {
            return this.$store.getters['item/pagination'];
        },
        paginationPage: function () {
            return this.$store.getters['item/page'];
        },
        itemCategories: function () {
            return this.$store.getters["itemCategory/lists"];
        },
        taxes: function () {
            return this.$store.getters['tax/lists'];
        },
        direction: function () {
            return this.$store.getters['frontendLanguage/show'].display_mode === displayModeEnum.RTL ? 'rtl' : 'ltr';
        },

    },
    methods: {
        permissionChecker(e) {
            return appService.permissionChecker(e);
        },
        statusClass: function (status) {
            return appService.statusClass(status);
        },
        textShortener: function (text, number = 30) {
            return appService.textShortener(text, number);
        },
        numberOnly: function (e) {
            return appService.floatNumber(e);
        },
        handleSlide: function (id) {
            return appService.handleSlide(id);
        },
        search: function () {
            this.list();
        },
        clear: function () {
            this.props.search.paginate = 1;
            this.props.search.page = 1;
            this.props.search.name = "";
            this.props.search.price = "";
            this.props.search.item_category_id = null;
            this.props.search.status = null;
            this.props.search.tax_id = null;
            this.props.search.item_type = null;
            this.props.search.is_featured = null;
            this.list();
        },
        list: function (page = 1) {
            this.loading.isActive = true;
            this.props.search.page = page;
            this.$store.dispatch('item/lists', this.props.search).then(res => {
                this.loading.isActive = false;
            }).catch((err) => {
                this.loading.isActive = false;
            });
        },
        edit: function (item) {
            appService.sideDrawerShow();
            this.loading.isActive = true;
            this.$store.dispatch('item/edit', item.id);
            this.loading.isActive = false;
            this.props.errors = {};
            this.props.form = {
                name: item.name,
                price: item.flat_price,
                description: item.description,
                caution: item.caution,
                is_featured: item.is_featured,
                item_type: item.item_type,
                tax_id: item.tax_id,
                item_category_id: item.item_category_id,
                status: item.status,
            };
        },
        destroy: function (id) {
            appService.destroyConfirmation().then((res) => {
                try {
                    this.loading.isActive = true;
                    this.$store.dispatch('item/destroy', { id: id, search: this.props.search }).then((res) => {
                        this.loading.isActive = false;
                        alertService.successFlip(null, this.$t('menu.items'));
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
            this.$store.dispatch("item/export", this.props.search).then((res) => {
                this.loading.isActive = false;
                const blob = new Blob([res.data], {
                    type: "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
                });
                const link = document.createElement("a");
                link.href = URL.createObjectURL(blob);
                link.download = this.$t("menu.items");
                link.click();
                URL.revokeObjectURL(link.href);
            }).catch((err) => {
                this.loading.isActive = false;
                alertService.error(err.response.data.message);
            });
        },
        uploadModal: function (id) {
            appService.modalShow(id);
        },
        downloadSample: function () {
            this.loading.isActive = true;
            this.$store.dispatch("item/downloadSample").then((res) => {
                this.loading.isActive = false;
                const url = window.URL.createObjectURL(
                    new Blob([res.data])
                );
                const link = document.createElement("a");
                link.href = url;
                link.download =
                    "" + "Item Import Sample." + 'xlsx';
                link.click();
                URL.revokeObjectURL(link.href);
            }).catch((err) => {
                this.loading.isActive = false;
            });
        }
    }
}
</script>

<style scoped>
/* Custom items table specific styles */
.custom-items-table {
    border-collapse: separate;
    border-spacing: 0;
    width: 100%;
}

.custom-items-table :deep(.db-table-body-td) {
    padding: 1.125rem 1.5rem;
    vertical-align: middle;
}

.custom-items-table :deep(.db-table-head-th) {
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