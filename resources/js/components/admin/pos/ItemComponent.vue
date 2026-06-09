<template>
    <!-- Items Grid -->
    <div class="grid gap-3 grid-cols-[repeat(auto-fill,_minmax(145px,_1fr))] sm:grid-cols-[repeat(auto-fill,_minmax(175px,_1fr))] mb-8 md:mb-0">
        <div
            v-for="item in items"
            :key="item"
            class="group relative rounded-2xl border border-gray-100 bg-white overflow-hidden hover:shadow-xl hover:shadow-gray-200/60 hover:-translate-y-1 transition-all duration-300 cursor-pointer"
            @click.prevent="variationModalShow(item)"
        >
            <!-- Image -->
            <div class="relative overflow-hidden" style="aspect-ratio: 4/3;">
                <img
                    class="w-full h-full object-cover transition-transform duration-500 group-hover:scale-110"
                    :src="item.thumb"
                    alt=""
                >
                <!-- Offer badge -->
                <div v-if="item.offer && item.offer.length > 0" class="absolute top-2 left-2 bg-[#0ECFAD] text-white text-[9px] font-black px-2 py-0.5 rounded-full uppercase tracking-wide">
                    SALE
                </div>
            </div>

            <!-- Info -->
            <div class="p-3">
                <h3 class="text-xs font-bold text-gray-800 mb-1.5 truncate leading-snug">{{ textShortener(item.name, 25) }}</h3>
                <div class="flex items-center justify-between gap-1.5">
                    <div>
                        <span class="text-sm font-extrabold text-[#0ECFAD]">{{ item.offer.length > 0 ? item.offer[0].currency_price : item.currency_price }}</span>
                        <span v-if="item.offer.length > 0" class="ml-1 text-[10px] text-gray-400 line-through">{{ item.currency_price }}</span>
                    </div>
                    <button
                        @click.stop.prevent="variationModalShow(item)"
                        class="w-7 h-7 rounded-xl bg-[#0ECFAD]/10 border border-[#0ECFAD]/20 text-[#0ECFAD] flex items-center justify-center hover:bg-[#0ECFAD] hover:text-white hover:border-transparent transition-all duration-200 flex-shrink-0"
                    >
                        <svg width="12" height="12" viewBox="0 0 24 24" fill="none"><path d="M12 5v14M5 12h14" stroke="currentColor" stroke-width="2.5" stroke-linecap="round"/></svg>
                    </button>
                </div>
            </div>
        </div>
    </div>

    <!-- ======= INFO MODAL ======= -->
    <div id="item-info-modal" ref="itemInfoModal" class="modal ff-modal info-modal">
        <div class="modal-dialog rounded-2xl border border-white/[0.08] bg-[#0F1117] shadow-2xl" v-if="itemInfo">
            <div class="modal-header flex items-start gap-3 px-5 py-4 border-b border-white/[0.06]">
                <h3 class="modal-title text-sm font-bold text-white flex-1">{{ itemInfo.name }}</h3>
                <button class="modal-close w-7 h-7 rounded-xl bg-white/[0.06] flex items-center justify-center text-gray-400 hover:text-white hover:bg-white/10 transition-all" @click.prevent="infoModalHide">
                    <svg width="12" height="12" viewBox="0 0 24 24" fill="none"><path d="M18 6 6 18M6 6l12 12" stroke="currentColor" stroke-width="2" stroke-linecap="round"/></svg>
                </button>
            </div>
            <div class="modal-body px-5 py-4 text-sm text-gray-400">{{ itemInfo.caution }}</div>
        </div>
    </div>

    <!-- ======= VARIATION MODAL ======= -->
    <div id="item-variation-modal" ref="itemVariationModal" class="modal ff-modal !bg-[#0B0C10]/90 !backdrop-blur-md transition-all duration-300">
        <div class="modal-dialog max-w-[600px] h-[90vh] md:h-auto md:max-h-[85vh] rounded-t-[32px] md:rounded-[32px] border border-white/[0.08] bg-[#0F1117] shadow-2xl overflow-hidden mt-auto md:mt-10 flex flex-col" v-if="item">
            
            <!-- Modal Header / Cover Image -->
            <div class="relative w-full h-48 md:h-64 flex-shrink-0 bg-[#0B0C10]">
                <img class="w-full h-full object-cover" :src="item.cover || item.thumb" alt="thumbnail">
                <div class="absolute inset-0 bg-gradient-to-t from-[#0F1117] via-[#0F1117]/40 to-transparent"></div>
                
                <button class="absolute top-4 right-4 w-10 h-10 rounded-full bg-black/50 backdrop-blur-md border border-white/10 flex items-center justify-center text-white hover:bg-white hover:text-black transition-all shadow-lg z-10" @click.prevent="variationModalHide">
                    <svg width="14" height="14" viewBox="0 0 24 24" fill="none"><path d="M18 6 6 18M6 6l12 12" stroke="currentColor" stroke-width="2.5" stroke-linecap="round"/></svg>
                </button>

                <div class="absolute bottom-0 left-0 w-full px-6 pb-4">
                    <div class="flex items-end justify-between gap-4">
                        <div>
                            <h2 class="text-2xl md:text-3xl font-black text-white capitalize mb-1 drop-shadow-md">{{ item.name }}</h2>
                            <p class="text-[15px] font-bold text-[#0ECFAD] drop-shadow-md">{{ item.offer.length > 0 ? item.offer[0].currency_price : item.currency_price }}</p>
                        </div>
                        <button v-if="item.caution" type="button" class="w-8 h-8 rounded-full bg-black/80 backdrop-blur flex items-center justify-center text-yellow-500 hover:text-yellow-400 transition-colors border border-yellow-500/20 mb-1"
                            data-modal="#item-info-modal" @click.prevent="infoModalShow(item.name, item.caution)">
                            <i class="fa-solid fa-circle-info text-xs"></i>
                        </button>
                    </div>
                </div>
            </div>

            <!-- Modal Body -->
            <div class="flex-1 overflow-y-auto thin-scrolling relative">
                <div class="px-6 py-5">
                    <p class="text-sm text-gray-400 mb-8 leading-relaxed">{{ item.description }}</p>

                    <!-- Quantity Section -->
                    <div class="flex items-center justify-between mb-8 pb-6 border-b border-white/[0.06]">
                        <label class="text-base font-bold text-white tracking-wide">{{ $t('label.quantity') }}</label>
                        <div class="flex items-center gap-4 bg-black/45 border border-white/[0.08] rounded-full p-1.5 shadow-inner">
                            <button @click.prevent="quantityDecrement" class="w-10 h-10 rounded-full bg-white/[0.06] flex items-center justify-center text-gray-400 hover:text-white hover:bg-white/10 transition-all shadow-sm">
                                <svg width="12" height="12" viewBox="0 0 24 24" fill="none"><path d="M5 12h14" stroke="currentColor" stroke-width="3" stroke-linecap="round"/></svg>
                            </button>
                            <input type="number" v-on:keypress="onlyNumber($event)" v-on:keyup="quantityUp" v-model="temp.quantity" class="w-10 text-center text-lg font-black text-white bg-transparent focus:outline-none appearance-none">
                            <button @click.prevent="quantityIncrement" class="w-10 h-10 rounded-full bg-[#0ECFAD] flex items-center justify-center text-[#0F1117] hover:opacity-90 transition-all shadow-md shadow-[#0ECFAD]/30">
                                <svg width="12" height="12" viewBox="0 0 24 24" fill="none"><path d="M12 5v14M5 12h14" stroke="currentColor" stroke-width="3" stroke-linecap="round"/></svg>
                            </button>
                        </div>
                    </div>

                    <!-- Variations (multiple attributes - dropdowns) -->
                    <div class="mb-8" v-if="item.itemAttributes.length > 1">
                        <label class="text-lg font-bold text-white block mb-4">{{ $t('label.variations') || 'Options' }}</label>
                        <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
                            <div v-for="itemAttribute in item.itemAttributes" :key="itemAttribute.id">
                                <label class="text-xs text-gray-400 block mb-2 uppercase tracking-wider font-bold">{{ itemAttribute.name }}</label>
                                <div class="relative group">
                                    <svg class="absolute top-1/2 right-4 -translate-y-1/2 text-gray-400 pointer-events-none group-hover:text-white transition-colors" width="14" height="14" viewBox="0 0 24 24" fill="none"><path d="m6 9 6 6 6-6" stroke="currentColor" stroke-width="2.5" stroke-linecap="round"/></svg>
                                    <select
                                        @change.prevent="changeVariationAdjust(itemAttribute.id, temp.item_variations.variations[itemAttribute.id])"
                                        v-model="temp.item_variations.variations[itemAttribute.id]"
                                        class="w-full h-14 rounded-2xl bg-white/[0.04] border border-white/[0.08] text-white text-sm px-5 pr-10 appearance-none focus:outline-none focus:border-[#0ECFAD]/50 focus:ring-1 focus:ring-[#0ECFAD]/50 transition-all capitalize shadow-inner cursor-pointer"
                                    >
                                        <option :value="variation.id" v-for="variation in item.variations[itemAttribute.id]" :key="variation" class="bg-[#1a1d2e] text-white">
                                            {{ variation.name }} <span v-if="variation.convert_price > 0">(+{{ variation.currency_price }})</span>
                                        </option>
                                    </select>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Variations (single attribute - pills) -->
                    <div class="mb-8" v-else-if="item.itemAttributes.length > 0">
                        <label class="text-lg font-bold text-white block mb-4">{{ item.itemAttributes[0].name }}</label>
                        <div class="flex flex-wrap gap-3">
                            <label v-for="variation in item.variations[item.itemAttributes[0].id]" :key="variation.id"
                                :for="variation.item_attribute_id + '-' + variation.name"
                                :class="temp.item_variations.variations[variation.item_attribute_id] === variation.id
                                    ? 'bg-[#0ECFAD] text-[#0F1117] border-[#0ECFAD] shadow-lg shadow-[#0ECFAD]/25'
                                    : 'bg-white/[0.04] border-white/[0.08] text-gray-400 hover:border-white/20 hover:text-white'"
                                class="cursor-pointer px-5 py-3 rounded-2xl border transition-all duration-200 flex flex-col items-center justify-center min-w-[100px]"
                            >
                                <input
                                    :value="variation.id"
                                    @click="changeVariation(variation.item_attribute_id, variation.id, variation.name, variation.convert_price)"
                                    v-model="temp.item_variations.variations[variation.item_attribute_id]"
                                    type="radio"
                                    :id="variation.item_attribute_id + '-' + variation.name"
                                    class="sr-only"
                                >
                                <span class="text-sm font-bold capitalize">{{ variation.name }}</span>
                                <span v-if="variation.price > 0" class="text-xs mt-1 font-medium opacity-80">+{{ variation.currency_price }}</span>
                            </label>
                        </div>
                    </div>

                    <!-- Extras -->
                    <div class="mb-8" v-if="item.extras.length > 0">
                        <label class="text-lg font-bold text-white block mb-4">{{ $t('label.extras') }}</label>
                        <div class="grid grid-cols-1 sm:grid-cols-2 gap-3">
                            <label v-for="extra in item.extras" :key="extra.id"
                                :for="extra.id + extra.name"
                                :class="temp.item_extras.extras.includes(extra.id) ? 'bg-[#0ECFAD]/10 border-[#0ECFAD] text-white' : 'bg-white/[0.04] border-white/[0.08] text-gray-400 hover:border-white/20'"
                                class="cursor-pointer px-4 py-3.5 rounded-2xl border transition-all duration-200 flex items-center justify-between"
                            >
                                <div class="flex items-center gap-3">
                                    <div class="relative w-5 h-5 flex items-center justify-center flex-shrink-0">
                                        <input
                                            :id="extra.id + extra.name"
                                            @change.prevent="changeExtra($event, extra.id, extra.name)"
                                            :value="extra.id"
                                            type="checkbox"
                                            class="peer appearance-none w-5 h-5 border-2 border-white/20 rounded-md bg-white/[0.04] checked:bg-[#0ECFAD] checked:border-[#0ECFAD] focus:outline-none transition-all cursor-pointer"
                                        >
                                        <i class="fa-solid fa-check absolute text-[#0F1117] text-[10px] opacity-0 peer-checked:opacity-100 pointer-events-none transition-opacity"></i>
                                    </div>
                                    <span class="text-sm font-bold capitalize">{{ extra.name }}</span>
                                </div>
                                <span class="text-sm font-bold text-[#0ECFAD]">+{{ extra.currency_price }}</span>
                            </label>
                        </div>
                    </div>

                    <!-- Addons -->
                    <div class="mb-8" v-if="item.addons.length > 0">
                        <label class="text-lg font-bold text-white block mb-4">{{ $t('label.addons') }}</label>
                        <div class="grid grid-cols-1 gap-4">
                            <div v-for="addon in item.addons" :key="addon.id"
                                :class="addons[addon.id] ? 'border-[#0ECFAD] bg-[#0ECFAD]/5' : 'border-white/[0.08] bg-white/[0.04]'"
                                class="rounded-2xl border flex overflow-hidden transition-all duration-200 h-[88px]"
                            >
                                <img class="w-24 h-full object-cover flex-shrink-0 bg-white/[0.08] cursor-pointer" :src="addon.thumb" @click.prevent="changeAddon(addon)">
                                <div class="p-3 flex flex-col justify-between flex-1 cursor-pointer" @click.prevent="changeAddon(addon)">
                                    <div>
                                        <h4 class="text-sm font-bold text-white capitalize truncate">{{ addon.addon_item_name }}</h4>
                                        <p v-if="addon.variation_names.length > 0" class="text-xs text-gray-500 truncate mt-0.5">
                                            <span v-for="(v, i) in addon.variation_names" :key="i">{{ v.name }}<span v-if="i + 1 < addon.variation_names.length">, </span></span>
                                        </p>
                                    </div>
                                    <span class="text-sm font-black text-[#0ECFAD]">{{ addon.total_currency_price }}</span>
                                </div>
                                
                                <div class="px-3 flex items-center justify-center border-l border-white/[0.06] bg-black/20">
                                    <div v-if="addons[addon.id]" class="flex flex-col items-center gap-2" @click.stop>
                                        <button @click.prevent="addonQuantityIncrement(addon.id)" class="w-6 h-6 flex items-center justify-center rounded-full bg-black/40 text-white hover:text-[#0ECFAD] transition-all shadow">
                                            <svg width="10" height="10" viewBox="0 0 24 24" fill="none"><path d="M12 5v14M5 12h14" stroke="currentColor" stroke-width="3" stroke-linecap="round"/></svg>
                                        </button>
                                        <span class="text-xs font-bold text-white w-6 text-center">{{ addonQuantity[addon.id] }}</span>
                                        <button @click.prevent="addonQuantityDecrement(addon.id)" class="w-6 h-6 flex items-center justify-center rounded-full bg-black/40 text-white hover:text-red-400 transition-all shadow">
                                            <svg width="10" height="10" viewBox="0 0 24 24" fill="none"><path d="M5 12h14" stroke="currentColor" stroke-width="3" stroke-linecap="round"/></svg>
                                        </button>
                                    </div>
                                    <button v-else @click.prevent="changeAddon(addon)" class="w-8 h-8 rounded-full bg-black/40 text-gray-400 hover:text-white hover:bg-[#0ECFAD] hover:border-transparent transition-all border border-white/[0.08] flex items-center justify-center">
                                        <svg width="12" height="12" viewBox="0 0 24 24" fill="none"><path d="M12 5v14M5 12h14" stroke="currentColor" stroke-width="3" stroke-linecap="round"/></svg>
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Special Instructions -->
                    <div class="mb-4">
                        <label class="text-sm font-bold text-white block mb-2"><i class="fa-regular fa-note-sticky text-gray-500 mr-2"></i>{{ $t('label.special_instructions') }}</label>
                        <textarea
                            v-model="temp.instruction"
                            :placeholder="$t('message.add_note')"
                            class="w-full h-20 rounded-2xl bg-white/[0.04] border border-white/[0.08] text-sm text-white px-4 py-3 placeholder:text-gray-600 focus:outline-none focus:border-[#0ECFAD]/50 transition-all resize-none shadow-inner"
                        ></textarea>
                        <small class="text-red-400 text-xs font-bold mt-2 block" v-if="instructionError">{{ instructionError }}</small>
                    </div>
                </div>
            </div>

            <!-- Footer / Add to Cart Button -->
            <div class="p-6 border-t border-white/[0.06] bg-[#0F1117] shadow-[0_-10px_30px_-15px_rgba(0,0,0,0.5)] z-20">
                <button
                    type="button"
                    :disabled="temp.total_price <= 0"
                    @click.prevent="addToCart"
                    class="w-full flex items-center justify-between rounded-2xl py-4 px-6 font-bold text-[#0F1117] bg-[#0ECFAD] shadow-xl shadow-[#0ECFAD]/15 hover:opacity-90 active:scale-[0.98] transition-all duration-300 disabled:opacity-50 disabled:shadow-none disabled:cursor-not-allowed group"
                >
                    <span class="text-base uppercase tracking-wide font-black">{{ $t('button.add_to_cart') || 'Add to Cart' }}</span>
                    <div class="flex items-center gap-3">
                        <span class="text-lg font-black bg-black/10 px-3 py-1 rounded-lg">{{ currencyFormat(temp.total_price, setting.site_digit_after_decimal_point, setting.site_default_currency_symbol, setting.site_currency_position) }}</span>
                    </div>
                </button>
            </div>
        </div>
    </div>
</template>

<script>
import appService from "../../../services/appService";
import _ from "lodash";
import alertService from "../../../services/alertService";
import { Swiper, SwiperSlide } from 'swiper/vue';
import 'swiper/css';
export default {
    name: "itemComponent",
    components: { Swiper, SwiperSlide },
    props: { items: Object },
    data() {
        return {
            item: null,
            itemInfo: null,
            addons: {},
            addonQuantity: {},
            itemArrays: [],
            settings: { itemsToShow: 4.3, wrapAround: false, snapAlign: "start" },
            addonSettings: { itemsToShow: 3, wrapAround: false, snapAlign: "start" },
            temp: {
                name: "", image: "", item_id: 0, quantity: 0, discount: 0, currency_price: 0, convert_price: 0,
                item_variations: { variations: {}, names: {} },
                item_extras: { extras: [], names: [] },
                item_variation_total: 0, item_extra_total: 0, total_price: 0, instruction: "",
            },
            instructionError: ""
        }
    },
    computed: {
        setting: function () { return this.$store.getters['frontendSetting/lists']; },
    },
    methods: {
        onlyNumber: function (e) { return appService.onlyNumber(e); },
        textShortener: function (text, number) { return appService.textShortener(text, number); },
        currencyFormat: function (amount, decimal, currency, position) { return appService.currencyFormat(amount, decimal, currency, position); },
        infoModalShow: function (name, caution) {
            this.itemInfo = { name, caution };
            this.$refs.itemInfoModal?.classList?.add("active");
            document.body.style.overflowY = "hidden";
        },
        infoModalHide: function () {
            this.itemInfo = null;
            this.$refs.itemInfoModal?.classList?.remove("active");
            document.body.style.overflowY = "auto";
        },
        variationModalShow: function (selectedItem) {
            this.$store.dispatch('item/details', selectedItem.id).then((res) => {
                const item = res.data.data;
                this.item = item;
                if (this.item.itemAttributes.length > 0) {
                    _.forEach(this.item.itemAttributes, (element) => {
                        if (typeof this.item.variations[element.id][0] !== "undefined") {
                            this.temp.item_variations.variations[this.item.variations[element.id][0].item_attribute_id] = this.item.variations[element.id][0].id;
                            this.temp.item_variations.names[element.name] = this.item.variations[element.id][0].name;
                            this.temp.item_variation_total += this.item.variations[element.id][0].convert_price;
                        }
                    });
                }
                if (this.item.addons.length > 0) { _.forEach(this.item.addons, (addon) => { this.addonQuantity[addon.id] = 1; }); }
                this.temp.name = this.item.name;
                this.temp.image = this.item.thumb;
                this.temp.item_id = this.item.id;
                this.temp.quantity = 1;
                this.temp.discount = 0;
                this.temp.convert_price = item.offer.length > 0 ? item.offer[0].convert_price : item.convert_price;
                this.temp.currency_price = item.offer.length > 0 ? item.offer[0].currency_price : item.currency_price;
                this.temp.total_price = (item.offer.length > 0 ? item.offer[0].convert_price : item.convert_price) + this.temp.item_variation_total;
                this.$refs.itemVariationModal?.classList?.add("active");
                document.body.style.overflowY = "hidden";
            }).catch({});
        },
        variationModalHide: function () {
            this.item = null;
            this.temp = { name: "", image: "", item_id: 0, quantity: 0, discount: 0, currency_price: 0, convert_price: 0, item_variations: { variations: {}, names: {} }, item_extras: { extras: [], names: [] }, item_variation_total: 0, item_extra_total: 0, total_price: 0, instruction: "" };
            this.$refs.itemVariationModal?.classList?.remove("active");
            document.body.style.overflowY = "auto";
        },
        changeVariation: function (attributeId, variationId, variationName, variationPrice) {
            this.temp.item_variations.variations[attributeId] = variationId;
            _.forEach(this.item.itemAttributes, (element) => { if (element.id === attributeId) { this.temp.item_variations.names[element.name] = variationName; } });
            this.totalPriceSetup();
        },
        changeVariationAdjust: function (attributeId, variationId) {
            _.forEach(this.item.variations[attributeId], (variation) => { if (variation.id === variationId) { this.changeVariation(attributeId, variationId, variation.name, variation.convert_price); } });
        },
        changeExtra: function (e, id, name) {
            if (e.target.checked) { this.temp.item_extras.extras.push(id); this.temp.item_extras.names.push(name); }
            else {
                for (let i = 0; i < this.temp.item_extras.extras.length; i++) { if (this.temp.item_extras.extras[i] === id) { this.temp.item_extras.extras.splice(i, 1); } }
                for (let i = 0; i < this.temp.item_extras.names.length; i++) { if (this.temp.item_extras.names[i] === name) { this.temp.item_extras.names.splice(i, 1); } }
            }
            this.totalPriceSetup();
        },
        totalPriceSetup: function () {
            let item_variation_total = 0, item_extra_total = 0, item_addon_total = 0;
            _.forEach(this.temp.item_variations.variations, (variationId, attributeId) => { _.forEach(this.item.variations[attributeId], (itemVariation) => { if (variationId === itemVariation.id) { item_variation_total += itemVariation.convert_price; } }); });
            _.forEach(this.temp.item_extras.extras, (extraId) => { _.forEach(this.item.extras, (itemExtra) => { if (extraId === itemExtra.id) { item_extra_total += itemExtra.convert_price; } }); });
            _.forEach(this.addons, (addon) => { item_addon_total += (addon.total_price * addon.quantity); });
            this.temp.item_variation_total = item_variation_total;
            this.temp.item_extra_total = item_extra_total;
            this.temp.total_price = parseFloat((((this.item.offer.length > 0 ? this.item.offer[0].convert_price : this.item.convert_price) + this.temp.item_variation_total + this.temp.item_extra_total) * this.temp.quantity) + item_addon_total);
        },
        quantityUp: function () { if (this.temp.quantity === 0) { this.temp.quantity = 1; } this.totalPriceSetup(); },
        quantityIncrement: function () { this.temp.quantity++; if (this.temp.quantity <= 0) { this.temp.quantity = 1; } this.totalPriceSetup(); },
        quantityDecrement: function () { this.temp.quantity--; if (this.temp.quantity <= 0) { this.temp.quantity = 1; } this.totalPriceSetup(); },
        addonQuantityUp: function (id) {
            if (typeof this.addonQuantity[id] !== "undefined") { if (this.addonQuantity[id] === 0) { this.addonQuantity[id] = 1; } }
            if (typeof this.addons[id] !== "undefined") { this.addons[id].quantity = this.addonQuantity[id]; }
            this.totalPriceSetup();
        },
        addonQuantityIncrement: function (id) {
            if (typeof this.addonQuantity[id] !== "undefined") { this.addonQuantity[id]++; if (this.addonQuantity[id] <= 0) { this.addonQuantity[id] = 1; } if (typeof this.addons[id] !== "undefined") { this.addons[id].quantity = this.addonQuantity[id]; } this.totalPriceSetup(); }
        },
        addonQuantityDecrement: function (id) {
            if (typeof this.addonQuantity[id] !== "undefined") { this.addonQuantity[id]--; if (this.addonQuantity[id] <= 0) { this.addonQuantity[id] = 1; } if (typeof this.addons[id] !== "undefined") { this.addons[id].quantity = this.addonQuantity[id]; } this.totalPriceSetup(); }
        },
        changeAddon: function (addon) {
            if (typeof this.addons[addon.id] === "undefined") {
                this.addons[addon.id] = { name: addon.addon_item_name, image: addon.thumb, item_id: addon.item_addon_id, quantity: this.addonQuantity[addon.id], discount: 0, currency_price: addon.offer.length > 0 ? addon.offer[0].currency_price : addon.addon_item_currency_price, convert_price: addon.offer.length > 0 ? addon.offer[0].convert_price : addon.addon_item_convert_price, item_variations: { variations: {}, names: {} }, item_extras: { extras: [], names: [] }, item_variation_total: addon.variation_total_convert_price, item_extra_total: 0, total_price: addon.total_convert_price, instruction: "" };
                if (addon.variations !== "undefined" && Object.keys(addon.variations).length !== 0) { _.forEach(addon.variations, (variationId, attributeId) => { this.addons[addon.id].item_variations.variations[attributeId] = variationId; }); }
                if (addon.variation_names.length > 0) { _.forEach(addon.variation_names, (variation) => { this.addons[addon.id].item_variations.names[variation.attribute_name] = variation.name; }); }
            } else { delete this.addons[addon.id]; }
            this.totalPriceSetup();
        },
        addToCart: function () {
            this.itemArrays = [{ name: this.temp.name, image: this.temp.image, item_id: this.temp.item_id, quantity: this.temp.quantity, discount: this.temp.discount, currency_price: this.temp.currency_price, convert_price: this.temp.convert_price, item_variations: this.temp.item_variations, item_extras: this.temp.item_extras, item_variation_total: this.temp.item_variation_total, item_extra_total: this.temp.item_extra_total, instruction: this.temp.instruction }];
            if (this.addons !== "undefined" && Object.keys(this.addons).length !== 0) { _.forEach(this.addons, (addon) => { this.itemArrays.push({ name: addon.name, image: addon.image, item_id: addon.item_id, quantity: addon.quantity, discount: addon.discount, price: addon.price, currency_price: addon.currency_price, convert_price: addon.convert_price, item_variations: addon.item_variations, item_extras: addon.item_extras, item_variation_total: addon.item_variation_total, item_extra_total: addon.item_extra_total, instruction: addon.instruction }); }); }
            if (this.itemArrays.length > 0) {
                this.$store.dispatch("posCart/lists", this.itemArrays).then((res) => {
                    this.item = null;
                    this.temp = { name: "", image: "", item_id: 0, quantity: 0, discount: 0, currency_price: 0, convert_price: 0, item_variations: { variations: {}, names: {} }, item_extras: { extras: [], names: [] }, item_variation_total: 0, item_extra_total: 0, total_price: 0, instruction: "" };
                    this.addons = {};
                    this.itemArrays = [];
                    alertService.success(this.$t('message.add_to_cart'));
                    appService.modalHide('#item-variation-modal');
                }).catch();
            }
        },
    },
    watch: {
        'temp.instruction'(val) {
            if (val.length > 190) { this.temp.instruction = val.slice(0, 190); this.instructionError = this.$t("message.special_instructions_limit"); }
            if (val.length < 190) { this.instructionError = ""; }
        }
    }
}
</script>