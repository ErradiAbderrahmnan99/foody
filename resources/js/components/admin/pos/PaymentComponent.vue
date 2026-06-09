<template>
    <LoadingComponent :props="loading" />

    <div id="orderpayment" class="modal">
        <div class="modal-dialog max-w-[420px] w-full rounded-3xl overflow-hidden border border-white/[0.08] shadow-2xl shadow-black/60 bg-[#0F1117]">

            <!-- Header -->
            <div class="flex justify-between items-center px-6 py-5 border-b border-white/[0.06]">
                <div>
                    <p class="text-[10px] font-semibold text-gray-500 uppercase tracking-widest mb-0.5">Checkout</p>
                    <h3 class="font-bold text-lg text-white">{{ $t("label.order_payment") }}</h3>
                </div>
                <button
                    class="modal-close w-8 h-8 rounded-xl bg-white/[0.06] flex items-center justify-center text-gray-400 hover:text-white hover:bg-white/10 transition-all"
                    @click="reset"
                >
                    <svg width="14" height="14" viewBox="0 0 24 24" fill="none"><path d="M18 6 6 18M6 6l12 12" stroke="currentColor" stroke-width="2" stroke-linecap="round"/></svg>
                </button>
            </div>

            <div class="p-6">
                <!-- Total Amount Display -->
                <div class="rounded-2xl bg-gradient-to-r from-[#0ECFAD]/10 to-[#0ECFAD]/5 border border-[#0ECFAD]/20 flex items-center justify-between px-5 py-4 mb-6">
                    <div>
                        <p class="text-[10px] font-semibold text-gray-500 uppercase tracking-wider mb-1">{{ $t("label.total_amount") }}</p>
                        <p class="text-2xl font-black text-[#0ECFAD] tracking-tight">
                            {{ currencyFormat(props.form.total, setting.site_digit_after_decimal_point, setting.site_default_currency_symbol, setting.site_currency_position) }}
                        </p>
                    </div>
                    <div class="w-12 h-12 rounded-2xl bg-[#0ECFAD]/10 border border-[#0ECFAD]/20 flex items-center justify-center">
                        <svg width="22" height="22" viewBox="0 0 24 24" fill="none" class="text-[#0ECFAD]"><rect x="2" y="5" width="20" height="14" rx="3" stroke="currentColor" stroke-width="1.5"/><path d="M2 10h20" stroke="currentColor" stroke-width="1.5"/><circle cx="7" cy="15" r="1" fill="currentColor"/></svg>
                    </div>
                </div>

                <!-- Payment Method -->
                <div class="mb-5">
                    <p class="text-[10px] font-semibold text-gray-500 uppercase tracking-widest mb-3">{{ $t("label.select_payment_method") }}</p>
                    <div class="flex gap-3">
                        <button
                            data-tab="#cash"
                            type="button"
                            class="flex-1 flex flex-col items-center gap-2.5 rounded-2xl py-4 px-3 border transition-all duration-200"
                            :class="props.form.pos_payment_method === posPaymentMethodEnum.CASH
                                ? 'bg-[#0ECFAD]/10 border-[#0ECFAD]/40 shadow-lg shadow-[#0ECFAD]/10'
                                : 'bg-white/[0.03] border-white/[0.06] hover:border-white/20'"
                            @click="paymentMethod(posPaymentMethodEnum.CASH, 'cashInput')"
                        >
                            <div :class="props.form.pos_payment_method === posPaymentMethodEnum.CASH ? 'bg-[#0ECFAD]/20' : 'bg-white/[0.06]'" class="w-10 h-10 rounded-xl flex items-center justify-center transition-colors">
                                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" :class="props.form.pos_payment_method === posPaymentMethodEnum.CASH ? 'text-[#0ECFAD]' : 'text-gray-500'"><rect x="2" y="6" width="20" height="12" rx="2" stroke="currentColor" stroke-width="1.5"/><circle cx="12" cy="12" r="3" stroke="currentColor" stroke-width="1.5"/><path d="M6 12h.01M18 12h.01" stroke="currentColor" stroke-width="2" stroke-linecap="round"/></svg>
                            </div>
                            <span class="text-xs font-bold" :class="props.form.pos_payment_method === posPaymentMethodEnum.CASH ? 'text-[#0ECFAD]' : 'text-gray-500'">{{ $t("label.cash") }}</span>
                        </button>
                        <button
                            data-tab="#card"
                            type="button"
                            class="flex-1 flex flex-col items-center gap-2.5 rounded-2xl py-4 px-3 border transition-all duration-200"
                            :class="props.form.pos_payment_method === posPaymentMethodEnum.CARD
                                ? 'bg-[#0ECFAD]/10 border-[#0ECFAD]/40 shadow-lg shadow-[#0ECFAD]/10'
                                : 'bg-white/[0.03] border-white/[0.06] hover:border-white/20'"
                            @click="paymentMethod(posPaymentMethodEnum.CARD, 'cardInput')"
                        >
                            <div :class="props.form.pos_payment_method === posPaymentMethodEnum.CARD ? 'bg-[#0ECFAD]/20' : 'bg-white/[0.06]'" class="w-10 h-10 rounded-xl flex items-center justify-center transition-colors">
                                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" :class="props.form.pos_payment_method === posPaymentMethodEnum.CARD ? 'text-[#0ECFAD]' : 'text-gray-500'"><rect x="2" y="5" width="20" height="14" rx="3" stroke="currentColor" stroke-width="1.5"/><path d="M2 10h20" stroke="currentColor" stroke-width="1.5"/><rect x="5" y="14" width="5" height="2" rx="1" fill="currentColor"/></svg>
                            </div>
                            <span class="text-xs font-bold" :class="props.form.pos_payment_method === posPaymentMethodEnum.CARD ? 'text-[#0ECFAD]' : 'text-gray-500'">{{ $t("label.card") }}</span>
                        </button>
                    </div>
                </div>

                <!-- Cash Input -->
                <div id="cash" class="data-tab hidden" :class="props.form.pos_payment_method === posPaymentMethodEnum.CASH ? 'active' : ''">
                    <div class="mb-4">
                        <label class="text-[10px] font-semibold text-gray-500 uppercase tracking-wider block mb-2">{{ $t("label.received_amount") }}</label>
                        <input
                            id="cashInput"
                            ref="cashInput"
                            type="text"
                            v-on:keypress="floatNumber($event)"
                            class="h-12 w-full rounded-2xl border border-white/10 bg-white/[0.05] py-1.5 px-4 text-white font-bold text-base focus:outline-none focus:border-[#0ECFAD]/50 focus:ring-1 focus:ring-[#0ECFAD]/20 transition-all placeholder:text-gray-600"
                            placeholder="0.00"
                        >
                    </div>
                </div>

                <!-- Card Input -->
                <div id="card" class="data-tab hidden" :class="props.form.pos_payment_method === posPaymentMethodEnum.CARD ? 'active' : ''">
                    <div class="mb-4">
                        <label class="text-[10px] font-semibold text-gray-500 uppercase tracking-wider block mb-2">{{ $t('label.enter_card_last_4_digits') }}</label>
                        <input
                            id="cardInput"
                            type="number"
                            ref="cardInput"
                            class="h-12 w-full rounded-2xl border border-white/10 bg-white/[0.05] py-1.5 px-4 text-white font-bold text-base focus:outline-none focus:border-[#0ECFAD]/50 focus:ring-1 focus:ring-[#0ECFAD]/20 transition-all placeholder:text-gray-600"
                            placeholder="••••"
                        >
                    </div>
                </div>

                <!-- Numpad -->
                <div
                    class="grid grid-cols-4 gap-2 mb-5"
                    v-if="props.form.pos_payment_method === posPaymentMethodEnum.CASH || props.form.pos_payment_method === posPaymentMethodEnum.CARD"
                >
                    <button :onclick="`solve('1', '${inputIdName}')`" class="numpad-key">1</button>
                    <button :onclick="`solve('2', '${inputIdName}')`" class="numpad-key">2</button>
                    <button :onclick="`solve('3', '${inputIdName}')`" class="numpad-key">3</button>
                    <button :onclick="`Back('${inputIdName}')`" class="numpad-key row-span-2 flex items-center justify-center bg-white/[0.04] hover:bg-red-500/10 hover:text-red-400 border-red-500/10">
                        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none"><path d="M16.9997 3.75H10.2797C8.86969 3.75 7.52969 4.34 6.57969 5.39L3.04969 9.27C1.63969 10.82 1.63969 13.18 3.04969 14.73L6.57969 18.61C7.52969 19.65 8.86969 20.25 10.2797 20.25H16.9997C19.7597 20.25 21.9997 18.01 21.9997 15.25V8.75C21.9997 5.99 19.7597 3.75 16.9997 3.75ZM16.5297 13.94C16.8197 14.23 16.8197 14.71 16.5297 15C16.3797 15.15 16.1897 15.22 15.9997 15.22C15.8097 15.22 15.6197 15.15 15.4697 15L13.5297 13.06L11.5897 15C11.4397 15.15 11.2497 15.22 11.0597 15.22C10.8697 15.22 10.6797 15.15 10.5297 15C10.2397 14.71 10.2397 14.23 10.5297 13.94L12.4697 12L10.5297 10.06C10.2397 9.77 10.2397 9.29 10.5297 9C10.8197 8.71 11.2997 8.71 11.5897 9L13.5297 10.94L15.4697 9C15.7597 8.71 16.2397 8.71 16.5297 9C16.8197 9.29 16.8197 9.77 16.5297 10.06L14.5897 12L16.5297 13.94Z" fill="currentColor"/></svg>
                    </button>
                    <button :onclick="`solve('4', '${inputIdName}')`" class="numpad-key">4</button>
                    <button :onclick="`solve('5', '${inputIdName}')`" class="numpad-key">5</button>
                    <button :onclick="`solve('6', '${inputIdName}')`" class="numpad-key">6</button>
                    <button :onclick="`solve('7', '${inputIdName}')`" class="numpad-key">7</button>
                    <button :onclick="`solve('8', '${inputIdName}')`" class="numpad-key">8</button>
                    <button :onclick="`solve('9', '${inputIdName}')`" class="numpad-key">9</button>
                    <button :onclick="`Clear('${inputIdName}')`" type="reset" class="numpad-key row-span-2 text-red-400 bg-red-500/[0.07] hover:bg-red-500/15 border-red-500/10 text-sm">
                        CLR
                    </button>
                    <button :onclick="`solve('00', '${inputIdName}')`" class="numpad-key">00</button>
                    <button :onclick="`solve('0', '${inputIdName}')`" class="numpad-key">0</button>
                    <button
                        :onclick="props.form.pos_payment_method === posPaymentMethodEnum.CASH ? `solve('.', '${inputIdName}')` : ''"
                        class="numpad-key"
                        :class="props.form.pos_payment_method !== posPaymentMethodEnum.CASH ? 'opacity-30 cursor-not-allowed' : ''"
                    >.</button>
                </div>

                <!-- Confirm Button -->
                <button
                    @click="confirmOrder"
                    type="button"
                    class="w-full py-4 rounded-2xl text-base font-bold text-[#0F1117] bg-[#0ECFAD] hover:bg-[#0ab898] transition-all shadow-xl shadow-[#0ECFAD]/25 active:scale-[0.98] flex items-center justify-center gap-2"
                >
                    <svg width="18" height="18" viewBox="0 0 24 24" fill="none"><path d="M20 6 9 17l-5-5" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"/></svg>
                    {{ $t("label.confirm_and_print") }}
                </button>
            </div>
        </div>
    </div>

    <ReceiptComponent :order="order" />
</template>

<style scoped>
.numpad-key {
    @apply bg-white/[0.05] hover:bg-white/10 active:bg-white/15 rounded-xl py-3 flex items-center justify-center text-base font-bold text-gray-300 transition-all border border-white/[0.06] select-none cursor-pointer;
}
</style>

<script>
import LoadingComponent from "../components/LoadingComponent";
import appService from "../../../services/appService";
import alertService from "../../../services/alertService";
import ReceiptComponent from "./ReceiptComponent";
import posPaymentMethodEnum from "../../../enums/modules/posPaymentMethodEnum";
import sourceEnum from "../../../enums/modules/sourceEnum";
import isAdvanceOrderEnum from "../../../enums/modules/isAdvanceOrderEnum";
import orderTypeEnum from "../../../enums/modules/orderTypeEnum";

export default {
    name: "PaymentComponent",
    components: { LoadingComponent, ReceiptComponent },
    props: { props: Object },
    data() {
        return {
            loading: { isActive: false },
            order: {},
            posPaymentMethodEnum: posPaymentMethodEnum,
            inputIdName: "cashInput"
        };
    },
    computed: {
        setting: function () { return this.$store.getters['frontendSetting/lists']; },
    },
    methods: {
        currencyFormat: function (amount, decimal, currency, position) { return appService.currencyFormat(amount, decimal, currency, position); },
        floatNumber(e) { return appService.floatNumber(e); },
        reset: function () {
            Object.keys(this.$refs).forEach(refName => { if (this.$refs[refName].value !== undefined) { this.$refs[refName].value = ""; } });
            this.$props.props.form.pos_payment_note = "";
            appService.modalHide('#orderpayment');
        },
        paymentMethod: function (method, Idname = "") {
            if (Idname) { this.inputIdName = Idname; }
            Object.keys(this.$refs).forEach(refName => { if (this.$refs[refName].value !== undefined) { this.$refs[refName].value = ""; } });
            this.$props.props.form.pos_payment_method = method;
            this.$props.props.form.pos_payment_note = "";
        },
        confirmOrder: function () {
            try {
                if (this.$props.props.form.pos_payment_method === this.posPaymentMethodEnum.CASH && this.$refs.cashInput.value) {
                    this.$props.props.form.pos_received_amount = this.$refs.cashInput.value;
                } else { this.$props.props.form.pos_received_amount = null; }
                if (this.$props.props.form.pos_payment_method === this.posPaymentMethodEnum.CARD && this.$refs.cardInput.value) {
                    this.$props.props.form.pos_payment_note = this.$refs.cardInput.value;
                } else { this.$props.props.form.pos_payment_note = ""; }
                this.$store.dispatch("defaultAccess/show").then((res) => {
                    this.$props.props.form.branch_id = res.data.data.branch_id;
                    this.$store.dispatch('posOrder/save', this.$props.props.form).then(orderResponse => {
                        const now = new Date();
                        const hh = String(now.getHours()).padStart(2, '0');
                        const mm = String(now.getMinutes()).padStart(2, '0');
                        const ss = String(now.getSeconds()).padStart(2, '0');
                        this.$props.props.form.token = hh + mm + ss;
                        this.$props.props.form.subtotal = null;
                        this.$props.props.form.discount = 0;
                        this.$props.props.form.delivery_time = null;
                        this.$props.props.form.delivery_charge = null;
                        this.$props.props.form.total = 0;
                        this.$props.props.form.order_type = orderTypeEnum.DINING_TABLE;
                        this.$props.props.form.is_advance_order = isAdvanceOrderEnum.NO;
                        this.$props.props.form.source = sourceEnum.POS;
                        this.$props.props.form.address_id = null;
                        this.$props.props.form.dining_table_id = null;
                        this.$props.props.form.coupon_id = null;
                        this.$props.props.form.items = [];
                        this.$props.props.form.pos_payment_method = this.posPaymentMethodEnum.CASH;
                        this.$props.props.form.pos_payment_note = null;
                        this.$props.props.form.pos_received_amount = null;
                        appService.modalHide('#orderpayment');
                        this.$store.dispatch('posCart/resetCart').then(res => { this.loading.isActive = false; }).catch();
                        this.$store.dispatch('posOrder/show', orderResponse.data.data.id).then(res => { this.order = res.data.data; this.loading.isActive = false; }).catch((error) => { this.loading.isActive = false; alertService.error(error.response.data.message); });
                        this.reset();
                        appService.modalShow('#receiptModal');
                    }).catch((err) => {
                        this.loading.isActive = false;
                        if (typeof err.response.data.errors === 'object') { _.forEach(err.response.data.errors, (error) => { alertService.error(error[0]); }); }
                    });
                }).catch((err) => { this.loading.isActive = false; });
            } catch (err) { this.loading.isActive = false; alertService.error(err); }
        },
    },
};
</script>