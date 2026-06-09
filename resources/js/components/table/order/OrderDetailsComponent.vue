<template>
    <LoadingComponent :props="loading" />
    <section class="pt-8 pb-16 min-h-screen bg-[#0F172A] text-white">
        <div class="container max-w-3xl mx-auto px-4 sm:px-6">
            <div class="flex items-start flex-col md:flex-row gap-6">
                <div class="w-full">
                    <div class="p-6 mb-6 rounded-2xl border border-[#334155] bg-[#1E293B] shadow-xl text-white">
                        <h3 class="text-sm leading-6 mb-1 font-semibold">{{ $t("label.order_id") }}: <span
                                class="text-primary font-bold">#{{ order.order_serial_no }}</span></h3>
                        <p class="text-xs text-[#94A3B8] font-light mb-4">{{ order.order_datetime }}</p>
                        <div class="flex flex-wrap items-center gap-2 mb-2">
                            <span class="text-sm capitalize text-[#94A3B8]">{{ $t("label.order_type") }}:</span>
                            <span class="text-sm capitalize font-bold text-white">
                                {{ enums.orderTypeEnumArray[order.order_type] }}
                            </span>
                        </div>
                        <div class="flex flex-wrap items-center gap-2 mb-6">
                            <span class="text-sm capitalize text-[#94A3B8]">{{ $t("label.table_name") }}:</span>
                            <span class="text-sm capitalize font-bold text-white">
                                {{ order.table_name }}
                            </span>
                        </div>

                        <OrderStatusComponent :props="order" />

                        <div class="mt-6 pt-6 border-t border-[#334155]">
                            <h3 class="font-bold text-base mb-3 text-white">{{ orderBranch.name }}</h3>
                            <div class="flex items-center justify-between gap-5">
                                <div class="flex items-start justify-start gap-2.5">
                                    <i
                                        class="lab lab-location text-sm leading-none mt-1.5 flex-shrink-0 text-primary"></i>
                                    <span class="text-sm leading-6 text-[#E2E8F0]">{{ orderBranch.address }}</span>
                                </div>
                                <div class="flex gap-4"
                                    v-if="parseInt(order.status) !== parseInt(enums.orderStatusEnum.REJECTED) && parseInt(order.status) !== parseInt(enums.orderStatusEnum.CANCELED)">
                                    <a :href="'tel:' + orderBranch.phone"
                                        class="w-10 h-10 rounded-full flex items-center justify-center bg-primary/10 text-primary border border-primary/20 hover:bg-primary hover:text-white transition-all"><i
                                            class="lab lab-call-calling text-base"></i></a>
                                </div>
                            </div>
                        </div>

                        <div class="mt-4" v-if="parseInt(order.status) === parseInt(enums.orderStatusEnum.REJECTED)">
                            <h3 class="capitalize font-medium text-sm leading-6 mb-2 text-white">{{ $t("label.reason") }}:</h3>
                            <p class="text-sm text-red-400 mb-2">{{ order.reason }}</p>
                        </div>
                    </div>

                    <div v-if="parseInt(order.status) !== parseInt(enums.orderStatusEnum.REJECTED) && parseInt(order.status) !== parseInt(enums.orderStatusEnum.CANCELED)"
                        class="p-6 rounded-2xl border border-[#334155] bg-[#1E293B] shadow-xl text-white mb-6 md:mb-0">
                        <h3 class="capitalize font-bold text-base mb-4 text-white">{{ $t("label.payment_info") }}</h3>
                        <ul class="flex flex-col gap-3 mb-6">
                            <li class="flex items-center gap-2">
                                <span class="capitalize text-sm text-[#94A3B8]">{{ $t("label.method") }}:</span>
                                <span v-if="order.transaction" class="capitalize text-sm font-semibold text-white">
                                    {{ order.transaction.payment_method }} ({{ order.transaction.transaction_no }})
                                </span>
                                <span v-else-if="paymentMethod === 'digitalPayment'"
                                    class="capitalize text-sm font-semibold text-white">
                                    {{ $t('label.digital_payment') }}
                                </span>
                                <span v-else class="capitalize text-sm font-semibold text-white">
                                    {{ enums.paymentTypeEnumArray[order.payment_method] }}
                                </span>
                            </li>
                            <li class="flex items-center gap-2">
                                <span class="capitalize text-sm text-[#94A3B8]">{{ $t("label.status") }}:</span>
                                <span class="capitalize text-sm font-bold"
                                    :class="enums.paymentStatusEnum.PAID === order.payment_status ? 'text-green-400' : 'text-red-400'">
                                    {{ enums.paymentStatusEnumArray[order.payment_status] }}
                                </span>
                            </li>
                        </ul>
                        <a v-if="order.payment_status === enums.paymentStatusEnum.UNPAID && paymentMethod === 'digitalPayment'"
                            :href="'/payment/' + order.id + '/pay'"
                            class="block w-full py-3.5 rounded-xl text-center font-bold text-[15px] text-white bg-primary hover:opacity-90 active:scale-[0.98] transform transition-all duration-200 shadow-lg shadow-primary/25">
                            {{ $t('button.pay_now') }}
                        </a>
                    </div>
                </div>
                <div class="w-full rounded-2xl border border-[#334155] bg-[#1E293B] shadow-xl text-white">
                    <div class="p-6 border-b border-[#334155]">
                        <h3 class="font-bold text-base capitalize mb-6 text-white">{{ $t('label.order_details') }}</h3>
                        <div class="pl-3">
                            <div class="mb-5 pb-5 border-b last:mb-0 last:pb-0 last:border-b-0 border-[#334155]/50"
                                v-if="orderItems.length > 0" v-for="item in orderItems" :key="item">
                                <div class="flex items-center gap-4 relative">
                                    <h3
                                        class="absolute top-5 -left-3 text-xs w-[24px] h-[24px] leading-[24px] text-center font-bold rounded-full text-white bg-primary shadow-md">
                                        {{ item.quantity }}
                                    </h3>
                                    <img class="w-16 h-16 rounded-xl flex-shrink-0 object-cover border border-[#334155] bg-[#0F172A]" :src="item.item_image"
                                        alt="thumbnail">
                                    <div class="w-full min-w-0">
                                        <a href="#"
                                            class="text-sm font-bold capitalize transition text-white hover:text-primary truncate block">
                                            {{ item.item_name }}
                                        </a>

                                        <p v-if="item.item_variations.length > 0" class="capitalize text-xs text-[#94A3B8] mt-1 mb-1">
                                            <span v-for="variation in item.item_variations" :key="variation">
                                                <span class="capitalize text-xs w-fit whitespace-nowrap">
                                                    {{ variation.variation_name }}:&nbsp;
                                                </span>
                                                <span class="text-xs">
                                                    {{ variation.name }}
                                                </span>
                                            </span>
                                        </p>

                                        <h3 class="text-xs font-black text-white mt-1">{{ item.total_currency_price }}</h3>
                                    </div>
                                </div>
                                <ul class="flex flex-col gap-1 mt-3 pl-3 border-l-2 border-primary/20">
                                    <li class="flex gap-1 items-start" v-if="item.item_extras.length > 0">
                                        <h3 class="capitalize text-[11px] font-medium text-[#94A3B8] w-fit whitespace-nowrap">
                                            {{ $t('label.extras') }}:
                                        </h3>
                                        <p class="text-[11px] text-[#E2E8F0]" v-for="(extra, index) in item.item_extras">
                                            {{ extra.name }}<span v-if="index + 1 < item.item_extras.length">, </span>
                                        </p>
                                    </li>
                                    <li class="flex gap-1 items-start" v-if="item.instruction">
                                        <h3 class="capitalize text-[11px] font-medium text-[#94A3B8] w-fit whitespace-nowrap">
                                            {{ $t('label.instruction') }}:</h3>
                                        <p class="text-[11px] text-yellow-400/90 italic leading-relaxed">{{ item.instruction }}</p>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <div class="p-6">
                        <div class="rounded-xl border border-[#334155] bg-[#0F172A]/50">
                            <ul class="flex flex-col gap-2 p-4 border-b border-dashed border-[#334155]">
                                <li class="flex items-center justify-between text-[#E2E8F0]">
                                    <span class="text-sm font-medium capitalize">{{ $t("label.subtotal") }}</span>
                                    <span class="text-sm font-bold">
                                        {{ order.subtotal_currency_price }}
                                    </span>
                                </li>
                            </ul>
                            <div class="flex items-center justify-between p-4">
                                <h4 class="text-sm font-bold capitalize text-white">{{ $t("label.total") }}</h4>
                                <h5 class="text-base font-black text-primary">
                                    {{ order.total_currency_price }}
                                </h5>
                            </div>
                        </div>
                    </div>
                    <div class="p-6 pt-0">
                        <OrderReceiptComponent :order="order" :orderBranch="orderBranch" :orderItems="orderItems" />
                    </div>
                </div>
            </div>
        </div>
    </section>
</template>

<script>
import LoadingComponent from "../../table/components/LoadingComponent.vue";
import OrderStatusComponent from "../../table/components/OrderStatusComponent.vue";
import OrderReceiptComponent from "../../table/order/OrderReceiptComponent.vue";
import orderTypeEnum from "../../../enums/modules/orderTypeEnum";
import orderStatusEnum from "../../../enums/modules/orderStatusEnum";
import paymentStatusEnum from "../../../enums/modules/paymentStatusEnum";
import paymentTypeEnum from "../../../enums/modules/paymentTypeEnum";
import activityEnum from "../../../enums/modules/activityEnum";
import router from "../../../router";

export default {
    name: "OrderDetailsComponent",
    components: { OrderReceiptComponent, OrderStatusComponent, LoadingComponent },
    data() {
        return {
            loading: {
                isActive: false,
            },
            enums: {
                activityEnum: activityEnum,
                orderStatusEnum: orderStatusEnum,
                paymentStatusEnum: paymentStatusEnum,
                orderTypeEnumArray: {
                    [orderTypeEnum.DELIVERY]: this.$t("label.delivery"),
                    [orderTypeEnum.TAKEAWAY]: this.$t("label.takeaway"),
                    [orderTypeEnum.DINING_TABLE]: this.$t("label.dining_table")
                },
                paymentStatusEnumArray: {
                    [paymentStatusEnum.PAID]: this.$t("label.paid"),
                    [paymentStatusEnum.UNPAID]: this.$t("label.unpaid")
                },
                paymentTypeEnumArray: {
                    [paymentTypeEnum.CASH_ON_DELIVERY]: this.$t("label.cash_card"),
                    [paymentTypeEnum.E_WALLET]: this.$t("label.e_wallet"),
                    [paymentTypeEnum.PAYPAL]: this.$t("label.paypal")
                },
            }
        }
    },
    computed: {
        setting: function () {
            return this.$store.getters['frontendSetting/lists'];
        },
        order: function () {
            return this.$store.getters['tableDiningOrder/show'];
        },
        orderBranch: function () {
            return this.$store.getters['tableDiningOrder/orderBranch'];
        },
        orderItems: function () {
            return this.$store.getters['tableDiningOrder/orderItems'];
        },
        paymentMethod: function () {
            return this.$store.getters['tableCart/paymentMethod'];
        },
        table: function () {
            return this.$store.getters['tableCart/table'];
        }
    },
    mounted() {
        this.loading.isActive = true;
        if (this.$route.params.id && this.paymentMethod) {
            this.loading.isActive = true;
            this.$store.dispatch("tableDiningOrder/show", this.$route.params.id).then(res => {
                this.loading.isActive = false;
            }).catch((error) => {
                this.loading.isActive = false;
            });
        } else {
            router.push({ name: 'table.menu.table', params: { slug: this.table.slug } });
        }
    },
    beforeUnmount() {
        this.$store.dispatch("tableCart/resetPaymentMethod").then().catch();
    }
}
</script>