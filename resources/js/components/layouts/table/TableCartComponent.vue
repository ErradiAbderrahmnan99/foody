<template>
    <aside @click="closeBackdrop($event)" id="cart"
        class="w-screen h-[calc(100vh-58px)] lg:h-[calc(100vh-74px)] fixed top-[58px] lg:top-[74px] left-0 z-[60] opacity-0 invisible bg-[#0F172A]/80 backdrop-blur-sm transition-all duration-300">
        <div class="max-w-sm w-full h-full absolute top-0 right-0 translate-x-full bg-[#1E293B] border-l border-[#334155] shadow-2xl transition-transform duration-300 ease-in-out flex flex-col">

            <div :class="carts.length === 0 ? 'flex items-center justify-center flex-col text-center flex-1' : 'flex-1 thin-scrolling overflow-y-auto'"
                class="p-5 relative">
                
                <div class="flex items-center justify-between mb-6">
                    <h3 class="text-xl font-bold capitalize text-white">
                        {{ $t('label.my_cart') }}
                    </h3>
                    <button @click.prevent="closeCanvas('cart')"
                        class="flex items-center justify-center w-8 h-8 rounded-full bg-[#0F172A] text-[#94A3B8] hover:text-red-400 hover:bg-red-500/10 transition-colors xmark-btn">
                        <i class="fa-solid fa-xmark"></i>
                    </button>
                </div>

                <div v-if="carts.length === 0"
                    class="flex items-center justify-center flex-col text-center mt-10">
                    <img class="w-40 mb-8 opacity-80" :src="setting.image_cart" alt="Empty Cart">
                    <p class="text-sm font-medium text-[#94A3B8] max-w-xs">{{ $t('message.empty_cart') }}</p>
                </div>

                <div v-if="carts.length > 0" class="space-y-4">
                    <div v-for="(cart, index) in carts" :key="index"
                        class="p-3 bg-[#0F172A] border border-[#334155] rounded-xl transition-all hover:border-[#475569]">
                        <div class="flex items-center gap-3">
                            <img class="w-16 h-16 rounded-lg object-cover flex-shrink-0 border border-[#334155]" :src="cart.image" alt="thumbnail">
                            <div class="w-full">
                                <a href="#" class="text-sm font-semibold capitalize transition text-white hover:text-primary line-clamp-1">
                                    {{ cart.name }}
                                </a>
                                
                                <p v-if="Object.keys(cart.item_variations.variations).length !== 0"
                                    class="capitalize text-xs text-[#94A3B8] mt-1 mb-2">
                                    <span v-for="(variation, variationName, idx) in cart.item_variations.names" :key="variationName">
                                        {{ variationName }}: {{ variation }}
                                        <span v-if="idx + 1 < Object.keys(cart.item_variations.names).length">, </span>
                                    </span>
                                </p>
                                
                                <div class="flex items-center justify-between gap-2 mt-2">
                                    <h3 class="text-sm font-bold text-white">
                                        {{ currencyFormat(cart.total, setting.site_digit_after_decimal_point, setting.site_default_currency_symbol, setting.site_currency_position) }}
                                    </h3>
                                    
                                    <div class="flex items-center bg-[#1E293B] rounded-lg border border-[#334155] overflow-hidden p-0.5">
                                        <button @click.prevent="quantityDecrement(index)"
                                            class="flex items-center justify-center w-7 h-7 rounded-md text-[#94A3B8] hover:bg-[#334155] hover:text-white transition-colors">
                                            <i :class="cart.quantity === 1 ? 'fa-trash-can text-red-400' : 'fa-minus'" class="fa-solid text-[10px]"></i>
                                        </button>
                                        <input v-on:keypress="onlyNumber($event)" v-on:keyup="quantityUp(index, $event)"
                                            type="number" :value="cart.quantity"
                                            class="w-8 text-center text-xs font-bold text-white bg-transparent border-none focus:outline-none focus:ring-0 appearance-none p-0">
                                        <button @click.prevent="quantityIncrement(index)"
                                            class="flex items-center justify-center w-7 h-7 rounded-md text-[#94A3B8] hover:bg-[#334155] hover:text-white transition-colors">
                                            <i class="fa-solid fa-plus text-[10px]"></i>
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div v-if="cart.item_extras.extras.length > 0 || cart.instruction !== ''"
                            class="mt-3 pt-3 border-t border-[#334155] flex flex-col gap-1.5">
                            <div v-if="cart.item_extras.extras.length > 0" class="flex gap-2 items-start">
                                <span class="capitalize text-xs font-medium text-[#94A3B8]">{{ $t('label.extras') }}:</span>
                                <p class="text-xs text-[#E2E8F0] leading-relaxed">
                                    <span v-for="(extra, idx) in cart.item_extras.names" :key="idx">
                                        {{ extra }}<span v-if="idx + 1 < cart.item_extras.names.length">, </span>
                                    </span>
                                </p>
                            </div>
                            <div v-if="cart.instruction !== ''" class="flex gap-2 items-start">
                                <span class="capitalize text-xs font-medium text-[#94A3B8] whitespace-nowrap">{{ $t('label.instruction') }}:</span>
                                <p class="text-xs text-yellow-400/90 italic leading-relaxed">{{ cart.instruction }}</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div v-if="carts.length > 0" class="p-5 bg-[#1E293B] border-t border-[#334155] shrink-0">
                <div class="flex items-center justify-between gap-2 rounded-xl p-4 mb-4 bg-[#0F172A] border border-[#334155]">
                    <h3 class="capitalize text-sm font-semibold text-[#E2E8F0]">{{ $t('label.subtotal') }}</h3>
                    <h4 class="text-lg font-bold text-primary">
                        {{ currencyFormat(subtotal, setting.site_digit_after_decimal_point, setting.site_default_currency_symbol, setting.site_currency_position) }}
                    </h4>
                </div>
                <router-link @click.prevent="closeSidebar"
                    :to="{ name: 'table.checkout', params: { slug: this.$route.params.slug } }"
                    class="block w-full text-center capitalize font-bold text-[15px] py-3.5 px-4 rounded-xl text-white bg-primary hover:opacity-90 active:scale-[0.98] transform transition-all duration-200 shadow-lg shadow-primary/25">
                    {{ $t('button.proceed_checkout') }}
                </router-link>
            </div>
        </div>
    </aside>
</template>

<script>
import appService from "../../../services/appService";

export default {
    name: "TableCartComponent",
    computed: {
        setting: function () { return this.$store.getters['frontendSetting/lists']; },
        carts: function () { return this.$store.getters['tableCart/lists']; },
        subtotal: function () { return this.$store.getters['tableCart/subtotal']; },
    },
    methods: {
        onlyNumber: function (e) { return appService.onlyNumber(e); },
        currencyFormat(amount, decimal, currency, position) { return appService.currencyFormat(amount, decimal, currency, position); },
        closeBackdrop: function (e) { return appService.closeBackdrop(e); },
        closeCanvas: function (id) { return appService.closeCanvas(id); },
        closeSidebar: function () {
            const cart = document.getElementById('cart');
            const body = document.querySelector('body');
            cart?.classList?.remove('active');
            body.style.overflowY = "auto";
        },
        quantityUp: function (id, e) {
            if (e.target.value > 0) { this.$store.dispatch('tableCart/quantity', { id: id, status: e.target.value }).then().catch(); }
        },
        quantityIncrement: function (id) { this.$store.dispatch('tableCart/quantity', { id: id, status: "increment" }).then().catch(); },
        quantityDecrement: function (id) { this.$store.dispatch('tableCart/quantity', { id: id, status: "decrement" }).then().catch(); }
    }
}
</script>