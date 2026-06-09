<template>
    <LoadingComponent :props="loading" />
    <section class="py-10 min-h-screen bg-[#0F172A]">
        <div class="container mx-auto px-4 sm:px-6 max-w-[1024px]">
            <!-- Back Navigation -->
            <router-link :to="{ name: 'table.menu.table', params: { slug: this.$route.params.slug } }"
                class="inline-flex items-center gap-2 mb-6 text-sm font-medium text-[#94A3B8] hover:text-primary transition-colors duration-200 group">
                <i class="lab lab-undo text-lg transform group-hover:-translate-x-1 transition-transform"></i>
                <span>{{ $t('label.back_to_home') }}</span>
            </router-link>

            <div class="grid grid-cols-1 md:grid-cols-12 gap-8">
                <!-- Left Column: Details & Payment -->
                <div class="md:col-span-7 flex flex-col gap-6">
                    
                    <!-- Table Information Card -->
                    <div class="rounded-2xl bg-[#1E293B] border border-[#334155] shadow-xl overflow-hidden">
                        <h3 class="capitalize font-semibold p-5 border-b border-[#334155] text-white tracking-wide">
                            {{ $t('label.table') }}
                        </h3>
                        <div class="p-5 flex items-center gap-4 bg-[#0F172A]/50">
                            <div class="w-12 h-12 rounded-full bg-primary/10 flex items-center justify-center text-primary flex-shrink-0">
                                <i class="fa-solid fa-utensils text-xl"></i>
                            </div>
                            <div>
                                <p class="text-sm font-medium text-[#94A3B8] capitalize mb-0.5">{{ $t('label.inside') }}</p>
                                <p class="font-bold text-lg text-white">{{ table.name }}</p>
                            </div>
                        </div>
                    </div>

                    <!-- Payment Method Card -->
                    <div class="rounded-2xl bg-[#1E293B] border border-[#334155] shadow-xl overflow-hidden">
                        <h3 class="capitalize font-semibold p-5 border-b border-[#334155] text-white tracking-wide">
                            {{ $t('label.payment_method') }}
                        </h3>
                        <ul class="p-5 flex flex-col gap-3">
                            <!-- Cash / Card Option -->
                            <li>
                                <label class="relative flex items-center p-4 cursor-pointer rounded-xl border border-[#334155] bg-[#0F172A] hover:border-[#475569] transition-all duration-200">
                                    <input type="radio" v-model="paymentMethod" value="cashCard" class="peer sr-only">
                                    <div class="w-5 h-5 rounded-full border-2 border-[#475569] peer-checked:border-primary peer-checked:bg-primary mr-4 flex items-center justify-center transition-all flex-shrink-0">
                                        <div class="w-2 h-2 rounded-full bg-white opacity-0 peer-checked:opacity-100 transition-opacity"></div>
                                    </div>
                                    <div class="flex flex-col">
                                        <span class="text-[#E2E8F0] font-semibold text-base peer-checked:text-white transition-colors">{{ $t('label.cash_card') }}</span>
                                    </div>
                                    <!-- Optional Icon to right -->
                                    <i class="fa-solid fa-money-bill-wave absolute right-5 text-[#475569] opacity-50 text-xl"></i>
                                </label>
                            </li>
                            <!-- Digital Payment Option -->
                            <li>
                                <label class="relative flex items-center p-4 cursor-pointer rounded-xl border border-[#334155] bg-[#0F172A] hover:border-[#475569] transition-all duration-200">
                                    <input type="radio" v-model="paymentMethod" value="digitalPayment" class="peer sr-only">
                                    <div class="w-5 h-5 rounded-full border-2 border-[#475569] peer-checked:border-primary peer-checked:bg-primary mr-4 flex items-center justify-center transition-all flex-shrink-0">
                                        <div class="w-2 h-2 rounded-full bg-white opacity-0 peer-checked:opacity-100 transition-opacity"></div>
                                    </div>
                                    <div class="flex flex-col">
                                        <span class="text-[#E2E8F0] font-semibold text-base peer-checked:text-white transition-colors">{{ $t('label.digital_payment') }}</span>
                                    </div>
                                    <i class="fa-solid fa-mobile-screen-button absolute right-5 text-[#475569] opacity-50 text-xl"></i>
                                </label>
                            </li>
                        </ul>
                    </div>

                    <!-- Desktop Place Order Button -->
                    <button type="button"
                        class="hidden md:block w-full h-14 mt-2 rounded-xl capitalize font-bold text-[15px] text-white bg-primary hover:opacity-90 active:scale-[0.98] transform transition-all duration-200 shadow-lg shadow-primary/25"
                        @click="orderSubmit">
                        {{ $t('button.place_order') }}
                    </button>
                </div>

                <!-- Right Column: Cart Summary (Sticky) -->
                <div class="md:col-span-5 relative">
                    <div class="rounded-2xl bg-[#1E293B] border border-[#334155] shadow-xl overflow-hidden sticky top-[100px] flex flex-col max-h-[calc(100vh-120px)]">
                        
                        <div class="p-5 border-b border-[#334155] bg-[#1E293B]">
                            <h3 class="capitalize font-bold text-lg text-white flex items-center gap-2">
                                <i class="fa-solid fa-receipt text-primary"></i>
                                {{ $t('label.cart_summary') }}
                            </h3>
                        </div>
                        
                        <!-- Cart Items List -->
                        <div class="p-5 overflow-y-auto thin-scrolling flex-1 bg-[#0F172A]/30">
                            <div v-for="(cart, index) in carts" :key="index"
                                class="mb-5 pb-5 border-b last:mb-0 last:pb-0 last:border-b-0 border-[#334155]/50">
                                
                                <div class="flex items-start gap-4 relative">
                                    <!-- Quantity Badge -->
                                    <span class="absolute -top-2 -left-2 flex items-center justify-center w-6 h-6 text-xs font-bold rounded-full text-white bg-primary shadow-md border-2 border-[#1E293B] z-10">
                                        {{ cart.quantity }}
                                    </span>
                                    
                                    <img :src="cart.image" alt="thumbnail"
                                        class="w-16 h-16 rounded-xl object-cover border border-[#334155] bg-[#0F172A] flex-shrink-0">
                                    
                                    <div class="flex-1 min-w-0">
                                        <div class="flex justify-between items-start gap-2 mb-1">
                                            <h4 class="text-sm font-bold capitalize text-white truncate pr-2">
                                                {{ cart.name }}
                                            </h4>
                                            <h4 class="text-sm font-bold text-white whitespace-nowrap">
                                                {{ currencyFormat(cart.total, setting.site_digit_after_decimal_point, setting.site_default_currency_symbol, setting.site_currency_position) }}
                                            </h4>
                                        </div>

                                        <p v-if="Object.keys(cart.item_variations.variations).length !== 0"
                                            class="capitalize text-xs text-[#94A3B8] mb-1.5 leading-snug">
                                            <span v-for="(variation, variationName, idx) in cart.item_variations.names" :key="variationName">
                                                {{ variationName }}: {{ variation }}
                                                <span v-if="idx + 1 < Object.keys(cart.item_variations.names).length">, </span>
                                            </span>
                                        </p>

                                        <ul v-if="cart.item_extras.extras.length > 0 || cart.instruction !== ''"
                                            class="flex flex-col gap-1 mt-2 p-2 rounded-lg bg-[#0F172A] border border-[#334155]">
                                            <li v-if="cart.item_extras.extras.length > 0" class="flex items-start gap-2">
                                                <span class="capitalize text-[11px] font-medium text-[#94A3B8] whitespace-nowrap mt-0.5">{{ $t('label.extras') }}:</span>
                                                <p class="text-[11px] text-[#E2E8F0] leading-relaxed">
                                                    <span v-for="(extra, idx) in cart.item_extras.names" :key="idx">
                                                        {{ extra }}<span v-if="idx + 1 < cart.item_extras.names.length">, </span>
                                                    </span>
                                                </p>
                                            </li>
                                            <li v-if="cart.instruction !== ''" class="flex items-start gap-2 mt-1 pt-1 border-t border-[#334155]/50">
                                                <span class="capitalize text-[11px] font-medium text-[#94A3B8] whitespace-nowrap mt-0.5">{{ $t('label.instruction') }}:</span>
                                                <p class="text-[11px] text-yellow-400/90 italic leading-relaxed">{{ cart.instruction }}</p>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Totals & Mobile Button -->
                        <div class="bg-[#1E293B] border-t border-[#334155]">
                            <div class="p-5 pb-4 border-b border-dashed border-[#334155]">
                                <div class="flex items-center justify-between">
                                    <span class="text-sm font-medium text-[#94A3B8] capitalize">{{ $t('label.subtotal') }}</span>
                                    <span class="text-sm font-semibold text-white">
                                        {{ currencyFormat(subtotal, setting.site_digit_after_decimal_point, setting.site_default_currency_symbol, setting.site_currency_position) }}
                                    </span>
                                </div>
                            </div>
                            
                            <div class="p-5 pt-4">
                                <div class="flex items-center justify-between mb-5">
                                    <h4 class="text-base font-bold text-white capitalize">{{ $t('label.total') }}</h4>
                                    <h5 class="text-xl font-bold text-primary">
                                        {{ currencyFormat(subtotal, setting.site_digit_after_decimal_point, setting.site_default_currency_symbol, setting.site_currency_position) }}
                                    </h5>
                                </div>
                                
                                <button type="button"
                                    class="block md:hidden w-full h-14 rounded-xl capitalize font-bold text-[15px] text-white bg-primary hover:opacity-90 active:scale-[0.98] transform transition-all duration-200 shadow-lg shadow-primary/25"
                                    @click="orderSubmit">
                                    {{ $t('button.place_order') }}
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</template>

<script>
// ... existing script exact match below
import LoadingComponent from "../../table/components/LoadingComponent.vue";
import appService from "../../../services/appService";
import sourceEnum from "../../../enums/modules/sourceEnum";
import _ from "lodash";
import OrderTypeEnum from "../../../enums/modules/orderTypeEnum";
import IsAdvanceOrderEnum from "../../../enums/modules/isAdvanceOrderEnum";
import router from "../../../router";
import alertService from "../../../services/alertService";

export default {
    name: "CheckoutComponent",
    components: { LoadingComponent },
    data() {
        return {
            loading: {
                isActive: false,
            },
            placeOrderShow: false,
            paymentMethod: null,
            checkoutProps: {
                form: {
                    dining_table_id: null,
                    customer_id: 2,
                    branch_id: null,
                    subtotal: 0,
                    discount: 0,
                    delivery_charge: 0,
                    delivery_time: null,
                    total: 0,
                    order_type: OrderTypeEnum.DINING_TABLE,
                    is_advance_order: IsAdvanceOrderEnum.NO,
                    source: sourceEnum.WEB,
                    address_id: null,
                    items: []
                }
            },
        }
    },
    mounted() {
        if (this.$store.getters['tableCart/lists'].length === 0) {
            this.$router.push({ name: 'table.menu.table', params: { slug: this.$route.params.slug } });
        }
    },
    computed: {
        setting: function () {
            return this.$store.getters['frontendSetting/lists'];
        },
        carts: function () {
            return this.$store.getters['tableCart/lists'];
        },
        subtotal: function () {
            return this.$store.getters['tableCart/subtotal'];
        },
        table: function () {
            return this.$store.getters['tableCart/table'];
        }
    },
    methods: {
        currencyFormat: function (amount, decimal, currency, position) {
            return appService.currencyFormat(amount, decimal, currency, position);
        },
        orderSubmit: function () {
            if (!this.paymentMethod) {
                return alertService.error(this.$t('message.payment_method'));
            }
            this.loading.isActive = true;
            this.checkoutProps.form.dining_table_id = this.table.id;
            this.checkoutProps.form.branch_id = this.table.branch_id;
            this.checkoutProps.form.subtotal = this.subtotal;
            this.checkoutProps.form.total = parseFloat(this.subtotal).toFixed(this.setting.site_digit_after_decimal_point);
            this.checkoutProps.form.items = [];
            _.forEach(this.carts, (item, index) => {
                let item_variations = [];
                if (Object.keys(item.item_variations.variations).length > 0) {
                    _.forEach(item.item_variations.variations, (value, index) => {
                        item_variations.push({
                            "id": value,
                            "item_id": item.item_id,
                            "item_attribute_id": index,
                        });
                    });
                }

                if (Object.keys(item.item_variations.names).length > 0) {
                    let i = 0;
                    _.forEach(item.item_variations.names, (value, index) => {
                        item_variations[i].variation_name = index;
                        item_variations[i].name = value;
                        i++;
                    });
                }

                let item_extras = [];
                if (item.item_extras.extras.length) {
                    _.forEach(item.item_extras.extras, (value) => {
                        item_extras.push({
                            id: value,
                            item_id: item.item_id,
                        });
                    });
                }

                if (item.item_extras.names.length) {
                    let i = 0;
                    _.forEach(item.item_extras.names, (value) => {
                        item_extras[i].name = value;
                        i++;
                    });
                }

                this.checkoutProps.form.items.push({
                    item_id: item.item_id,
                    item_price: item.convert_price,
                    branch_id: this.checkoutProps.form.branch_id,
                    instruction: item.instruction,
                    quantity: item.quantity,
                    discount: item.discount,
                    total_price: item.total,
                    item_variation_total: item.item_variation_total,
                    item_extra_total: item.item_extra_total,
                    item_variations: item_variations,
                    item_extras: item_extras
                });
            });
            this.checkoutProps.form.items = JSON.stringify(this.checkoutProps.form.items);

            this.$store.dispatch('tableDiningOrder/save', this.checkoutProps.form).then(orderResponse => {
                this.checkoutProps.form.subtotal = 0;
                this.checkoutProps.form.discount = 0;
                this.checkoutProps.form.delivery_charge = 0;
                this.checkoutProps.form.delivery_time = null;
                this.checkoutProps.form.total = 0;
                this.checkoutProps.form.items = [];

                this.$store.dispatch('tableCart/resetCart').then(res => {
                    this.loading.isActive = false;
                    this.$store.dispatch('tableCart/paymentMethod', this.paymentMethod).then().catch();
                    router.push({ name: "table.menu.table", params: { slug: this.table.slug }, query: { id: orderResponse.data.data.id } });
                }).catch();
            }).catch((err) => {
                this.loading.isActive = false;
                if (typeof err.response.data.errors === 'object') {
                    _.forEach(err.response.data.errors, (error) => {
                        alertService.error(error[0]);
                    });
                }
            })
        }
    },
    watch: {
        carts: {
            handler(newVal) {
                if (!newVal || newVal.length === 0) {
                    this.$router.push({
                        name: 'table.menu.table',
                        params: { slug: this.$route.params.slug }
                    });
                }
            },
            deep: true,
            immediate: true
        }
    }
}
</script>