<template>
    <div v-if="design === itemDesignEnum.LIST" class="grid grid-cols-1 lg:grid-cols-2 gap-4 md:gap-6">
        <div v-for="item in items" :key="item.id" v-show="type === null || type === item.item_type"
            class="group flex gap-4 p-4 rounded-[24px] bg-[#1E293B] border border-[#334155] hover:border-primary/50 hover:bg-[#1E293B]/80 transition-all duration-300 cursor-pointer overflow-hidden"
            @click.prevent="variationModalShow(item)"
        >
            <div class="relative w-32 h-32 rounded-[18px] overflow-hidden flex-shrink-0 bg-[#0F172A] shadow-inner">
                <img class="w-full h-full object-cover transition-transform duration-700 group-hover:scale-110 opacity-90 group-hover:opacity-100" :src="item.thumb" alt="thumbnail">
                <div v-if="item.offer && item.offer.length > 0" class="absolute top-2 left-2 bg-primary text-white text-[10px] font-black px-2 py-0.5 rounded-full uppercase tracking-wider shadow-lg">
                    Sale
                </div>
            </div>

            <div class="flex-1 min-w-0 flex flex-col justify-between py-1">
                <div>
                    <div class="flex items-start justify-between gap-3">
                        <h3 class="text-lg font-bold text-white tracking-wide truncate capitalize">{{ item.name }}</h3>
                        <button v-if="item.caution" class="flex-shrink-0 text-[#94A3B8] hover:text-primary transition-colors mt-1" data-modal="#item-info-modal"
                            @click.stop.prevent="infoModalShow(item.name, item.caution)">
                            <svg width="16" height="16" viewBox="0 0 24 24" fill="none"><circle cx="12" cy="12" r="9" stroke="currentColor" stroke-width="2"/><path d="M12 8v4M12 16h.01" stroke="currentColor" stroke-width="2.5" stroke-linecap="round"/></svg>
                        </button>
                    </div>
                    <p class="text-sm text-[#94A3B8] line-clamp-2 mt-1 leading-relaxed pr-2">
                        {{ textShortener(item.description, 80) }}
                    </p>
                </div>
                
                <div class="flex items-center justify-between mt-3">
                    <div class="flex items-baseline gap-2">
                        <span class="text-lg font-black text-white">{{ item.offer.length > 0 ? item.offer[0].currency_price : item.currency_price }}</span>
                        <span v-if="item.offer.length > 0" class="text-xs text-[#475569] line-through font-medium">{{ item.currency_price }}</span>
                    </div>
                    <button @click.stop.prevent="variationModalShow(item)" 
                        class="px-5 py-2 rounded-full bg-[#0F172A] border border-[#334155] text-primary text-sm font-bold flex items-center gap-2 group-hover:bg-primary group-hover:text-white group-hover:border-transparent transition-all duration-300">
                        <span>{{ $t('button.add') || 'Add' }}</span>
                        <svg width="12" height="12" viewBox="0 0 24 24" fill="none"><path d="M12 5v14M5 12h14" stroke="currentColor" stroke-width="3" stroke-linecap="round"/></svg>
                    </button>
                </div>
            </div>
        </div>
    </div>

    <div v-else-if="design === itemDesignEnum.GRID"
        class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-6">
        <div v-for="item in items" :key="item.id" v-show="type === null || type === item.item_type"
            class="group relative flex flex-col rounded-[24px] bg-[#1E293B] border border-[#334155] overflow-hidden hover:border-primary/50 hover:shadow-2xl hover:shadow-black/50 hover:-translate-y-1 transition-all duration-300 cursor-pointer"
            @click.prevent="variationModalShow(item)"
        >
            <div class="relative w-full aspect-[4/3] bg-[#0F172A] overflow-hidden">
                <img class="w-full h-full object-cover transition-transform duration-700 group-hover:scale-105 opacity-90 group-hover:opacity-100" :src="item.cover" alt="product">
                <div class="absolute inset-0 bg-gradient-to-t from-[#1E293B] via-transparent to-transparent opacity-80"></div>
                
                <div v-if="item.offer && item.offer.length > 0" class="absolute top-3 left-3 bg-primary text-white text-xs font-black px-3 py-1 rounded-full uppercase tracking-wider shadow-lg">
                    SALE
                </div>
                
                <button v-if="item.caution" type="button" class="absolute top-3 right-3 w-8 h-8 rounded-full bg-[#0F172A]/80 backdrop-blur-sm flex items-center justify-center text-white hover:text-primary transition-colors border border-white/10"
                    data-modal="#item-info-modal" @click.stop.prevent="infoModalShow(item.name, item.caution)">
                    <svg width="14" height="14" viewBox="0 0 24 24" fill="none"><circle cx="12" cy="12" r="9" stroke="currentColor" stroke-width="2"/><path d="M12 8v4M12 16h.01" stroke="currentColor" stroke-width="2.5" stroke-linecap="round"/></svg>
                </button>
            </div>

            <div class="p-5 flex flex-col flex-1 -mt-4 relative z-10">
                <h3 class="text-[17px] font-bold text-white capitalize mb-1">{{ textShortener(item.name, 30) }}</h3>
                <p class="text-sm text-[#94A3B8] line-clamp-2 leading-relaxed mb-4 flex-1">{{ textShortener(item.description, 80) }}</p>
                
                <div class="flex items-center justify-between pt-4 border-t border-[#334155]/50">
                    <div class="flex flex-col">
                        <span v-if="item.offer.length > 0" class="text-[11px] text-[#475569] line-through font-medium leading-none mb-0.5">{{ item.currency_price }}</span>
                        <span class="text-lg font-black text-white leading-none">{{ item.offer.length > 0 ? item.offer[0].currency_price : item.currency_price }}</span>
                    </div>
                    <button @click.stop.prevent="variationModalShow(item)" 
                        class="w-10 h-10 rounded-full bg-[#0F172A] border border-[#334155] text-primary flex items-center justify-center group-hover:bg-primary group-hover:text-white group-hover:border-transparent transition-all duration-300">
                        <svg width="14" height="14" viewBox="0 0 24 24" fill="none"><path d="M12 5v14M5 12h14" stroke="currentColor" stroke-width="3" stroke-linecap="round"/></svg>
                    </button>
                </div>
            </div>
        </div>
    </div>
    <div id="item-info-modal" ref="itemInfoModal" class="modal ff-modal info-modal !bg-[#0F172A]/90 !backdrop-blur-md transition-all duration-300">
        <div class="modal-dialog rounded-[24px] border border-[#334155] bg-[#1E293B] shadow-2xl mt-20 max-w-sm" v-if="itemInfo">
            <div class="px-6 py-5 border-b border-[#334155] flex items-center justify-between">
                <div class="flex items-center gap-3">
                    <div class="w-8 h-8 rounded-full bg-yellow-500/10 flex items-center justify-center text-yellow-500">
                        <i class="fa-solid fa-circle-info"></i>
                    </div>
                    <h3 class="text-base font-bold text-white">{{ itemInfo.name }}</h3>
                </div>
                <button class="w-8 h-8 rounded-full bg-[#0F172A] flex items-center justify-center text-[#94A3B8] hover:text-white transition-all" @click.prevent="infoModalHide">
                    <svg width="12" height="12" viewBox="0 0 24 24" fill="none"><path d="M18 6 6 18M6 6l12 12" stroke="currentColor" stroke-width="2.5" stroke-linecap="round"/></svg>
                </button>
            </div>
            <div class="p-6 text-sm text-[#E2E8F0] leading-relaxed bg-[#0F172A]/30 rounded-b-[24px]">
                {{ itemInfo.caution }}
            </div>
        </div>
    </div>
    <div id="item-variation-modal" ref="itemVariationModal" class="modal ff-modal !bg-[#0F172A]/90 !backdrop-blur-md transition-all duration-300">
        <div class="modal-dialog max-w-[600px] h-[90vh] md:h-auto md:max-h-[90vh] rounded-t-[32px] md:rounded-[32px] border border-[#334155] bg-[#1E293B] shadow-2xl overflow-hidden mt-auto md:mt-10 flex flex-col" v-if="item">
            
            <div class="relative w-full h-48 md:h-64 flex-shrink-0 bg-[#0F172A]">
                <img class="w-full h-full object-cover" :src="item.cover || item.thumb" alt="thumbnail">
                <div class="absolute inset-0 bg-gradient-to-t from-[#1E293B] via-[#1E293B]/40 to-transparent"></div>
                
                <button class="absolute top-4 right-4 w-10 h-10 rounded-full bg-[#0F172A]/50 backdrop-blur-md border border-white/10 flex items-center justify-center text-white hover:bg-white hover:text-black transition-all shadow-lg z-10" @click.prevent="variationModalHide">
                    <svg width="14" height="14" viewBox="0 0 24 24" fill="none"><path d="M18 6 6 18M6 6l12 12" stroke="currentColor" stroke-width="2.5" stroke-linecap="round"/></svg>
                </button>

                <div class="absolute bottom-0 left-0 w-full px-6 pb-4">
                    <div class="flex items-end justify-between gap-4">
                        <div>
                            <h2 class="text-2xl md:text-3xl font-black text-white capitalize mb-1 drop-shadow-md">{{ item.name }}</h2>
                            <p class="text-[15px] font-bold text-primary drop-shadow-md">{{ item.offer.length > 0 ? item.offer[0].currency_price : item.currency_price }}</p>
                        </div>
                        <button v-if="item.caution" type="button" class="w-8 h-8 rounded-full bg-[#0F172A]/80 backdrop-blur flex items-center justify-center text-yellow-500 hover:text-yellow-400 transition-colors border border-yellow-500/20 mb-1"
                            data-modal="#item-info-modal" @click.prevent="infoModalShow(item.name, item.caution)">
                            <i class="fa-solid fa-circle-info"></i>
                        </button>
                    </div>
                </div>
            </div>

            <div class="flex-1 overflow-y-auto thin-scrolling relative">
                <div class="px-6 py-5">
                    <p class="text-sm text-[#94A3B8] mb-8 leading-relaxed">{{ item.description }}</p>

                    <div class="flex items-center justify-between mb-8 pb-6 border-b border-[#334155]/50">
                        <label class="text-base font-bold text-white tracking-wide">{{ $t('label.quantity') }}</label>
                        <div class="flex items-center gap-4 bg-[#0F172A] border border-[#334155] rounded-full p-1.5 shadow-inner">
                            <button @click.prevent="quantityDecrement" class="w-10 h-10 rounded-full bg-[#1E293B] flex items-center justify-center text-[#94A3B8] hover:text-white hover:bg-[#475569] transition-all shadow-sm">
                                <svg width="12" height="12" viewBox="0 0 24 24" fill="none"><path d="M5 12h14" stroke="currentColor" stroke-width="3" stroke-linecap="round"/></svg>
                            </button>
                            <input type="number" v-on:keypress="onlyNumber($event)" v-on:keyup="quantityUp" v-model="temp.quantity" class="w-10 text-center text-lg font-black text-white bg-transparent focus:outline-none appearance-none">
                            <button @click.prevent="quantityIncrement" class="w-10 h-10 rounded-full bg-primary flex items-center justify-center text-white hover:bg-primary/90 transition-all shadow-md shadow-primary/30">
                                <svg width="12" height="12" viewBox="0 0 24 24" fill="none"><path d="M12 5v14M5 12h14" stroke="currentColor" stroke-width="3" stroke-linecap="round"/></svg>
                            </button>
                        </div>
                    </div>

                    <div class="mb-8" v-if="item.itemAttributes.length > 1">
                        <label class="text-lg font-bold text-white block mb-4">{{ $t('label.variations') || 'Options' }}</label>
                        <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
                            <div v-for="itemAttribute in item.itemAttributes" :key="itemAttribute.id">
                                <label class="text-xs text-[#94A3B8] block mb-2 uppercase tracking-wider font-bold">{{ itemAttribute.name }}</label>
                                <div class="relative group">
                                    <svg class="absolute top-1/2 right-4 -translate-y-1/2 text-[#94A3B8] pointer-events-none group-hover:text-white transition-colors" width="14" height="14" viewBox="0 0 24 24" fill="none"><path d="m6 9 6 6 6-6" stroke="currentColor" stroke-width="2.5" stroke-linecap="round"/></svg>
                                    <select
                                        @change.prevent="changeVariationAdjust(itemAttribute.id, temp.item_variations.variations[itemAttribute.id])"
                                        v-model="temp.item_variations.variations[itemAttribute.id]"
                                        class="w-full h-14 rounded-2xl bg-[#0F172A] border border-[#334155] text-white text-sm px-5 pr-10 appearance-none focus:outline-none focus:border-primary focus:ring-1 focus:ring-primary transition-all capitalize shadow-inner cursor-pointer"
                                    >
                                        <option :value="variation.id" v-for="variation in item.variations[itemAttribute.id]" :key="variation">
                                            {{ variation.name }} <span v-if="variation.convert_price > 0">(+{{ variation.currency_price }})</span>
                                        </option>
                                    </select>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="mb-8" v-else-if="item.itemAttributes.length > 0">
                        <label class="text-lg font-bold text-white block mb-4">{{ item.itemAttributes[0].name }}</label>
                        <div class="flex flex-wrap gap-3">
                            <label v-for="variation in item.variations[item.itemAttributes[0].id]" :key="variation.id"
                                :for="variation.item_attribute_id + '-' + variation.name"
                                :class="temp.item_variations.variations[variation.item_attribute_id] === variation.id
                                    ? 'bg-primary text-white border-primary shadow-lg shadow-primary/20'
                                    : 'bg-[#0F172A] border-[#334155] text-[#94A3B8] hover:border-[#475569] hover:text-white'"
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

                    <div class="mb-8" v-if="item.extras.length > 0">
                        <label class="text-lg font-bold text-white block mb-4">{{ $t('label.extras') }}</label>
                        <div class="grid grid-cols-1 sm:grid-cols-2 gap-3">
                            <label v-for="extra in item.extras" :key="extra.id"
                                :for="extra.id + extra.name"
                                :class="temp.item_extras.extras.includes(extra.id) ? 'bg-primary/10 border-primary text-white' : 'bg-[#0F172A] border-[#334155] text-[#94A3B8] hover:border-[#475569]'"
                                class="cursor-pointer px-4 py-3.5 rounded-2xl border transition-all duration-200 flex items-center justify-between"
                            >
                                <div class="flex items-center gap-3">
                                    <div class="relative w-5 h-5 flex items-center justify-center flex-shrink-0">
                                        <input
                                            :id="extra.id + extra.name"
                                            @change.prevent="changeExtra($event, extra.id, extra.name)"
                                            :value="extra.id"
                                            type="checkbox"
                                            class="peer appearance-none w-5 h-5 border-2 border-[#475569] rounded-md bg-[#1E293B] checked:bg-primary checked:border-primary focus:outline-none transition-all cursor-pointer"
                                        >
                                        <i class="fa-solid fa-check absolute text-white text-[10px] opacity-0 peer-checked:opacity-100 pointer-events-none transition-opacity"></i>
                                    </div>
                                    <span class="text-sm font-bold capitalize">{{ extra.name }}</span>
                                </div>
                                <span class="text-sm font-bold text-primary">+{{ extra.currency_price }}</span>
                            </label>
                        </div>
                    </div>

                    <div class="mb-8" v-if="item.addons.length > 0">
                        <label class="text-lg font-bold text-white block mb-4">{{ $t('label.addons') }}</label>
                        <div class="grid grid-cols-1 gap-4">
                            <div v-for="addon in item.addons" :key="addon.id"
                                :class="addons[addon.id] ? 'border-primary bg-primary/5' : 'border-[#334155] bg-[#0F172A]'"
                                class="rounded-2xl border flex overflow-hidden transition-all duration-200 h-[88px]"
                            >
                                <img class="w-24 h-full object-cover flex-shrink-0 bg-[#1E293B] cursor-pointer" :src="addon.thumb" @click.prevent="changeAddon(addon)">
                                <div class="p-3 flex flex-col justify-between flex-1 cursor-pointer" @click.prevent="changeAddon(addon)">
                                    <div>
                                        <h4 class="text-sm font-bold text-white capitalize truncate">{{ addon.addon_item_name }}</h4>
                                        <p v-if="addon.variation_names.length > 0" class="text-xs text-[#94A3B8] truncate mt-0.5">
                                            <span v-for="(v, i) in addon.variation_names" :key="i">{{ v.name }}<span v-if="i + 1 < addon.variation_names.length">, </span></span>
                                        </p>
                                    </div>
                                    <span class="text-sm font-black text-primary">{{ addon.total_currency_price }}</span>
                                </div>
                                
                                <div class="px-3 flex items-center justify-center border-l border-[#334155]/50 bg-[#1E293B]/50">
                                    <div v-if="addons[addon.id]" class="flex flex-col items-center gap-2" @click.stop>
                                        <button @click.prevent="addonQuantityIncrement(addon.id)" class="w-6 h-6 flex items-center justify-center rounded-full bg-[#0F172A] text-white hover:text-primary transition-all shadow">
                                            <svg width="10" height="10" viewBox="0 0 24 24" fill="none"><path d="M12 5v14M5 12h14" stroke="currentColor" stroke-width="3" stroke-linecap="round"/></svg>
                                        </button>
                                        <span class="text-xs font-bold text-white w-6 text-center">{{ addonQuantity[addon.id] }}</span>
                                        <button @click.prevent="addonQuantityDecrement(addon.id)" class="w-6 h-6 flex items-center justify-center rounded-full bg-[#0F172A] text-white hover:text-red-400 transition-all shadow">
                                            <svg width="10" height="10" viewBox="0 0 24 24" fill="none"><path d="M5 12h14" stroke="currentColor" stroke-width="3" stroke-linecap="round"/></svg>
                                        </button>
                                    </div>
                                    <button v-else @click.prevent="changeAddon(addon)" class="w-8 h-8 rounded-full bg-[#0F172A] text-[#94A3B8] hover:text-white hover:bg-primary transition-all border border-[#334155] flex items-center justify-center">
                                        <svg width="12" height="12" viewBox="0 0 24 24" fill="none"><path d="M12 5v14M5 12h14" stroke="currentColor" stroke-width="3" stroke-linecap="round"/></svg>
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="mb-4">
                        <label class="text-sm font-bold text-white block mb-3"><i class="fa-regular fa-note-sticky text-[#94A3B8] mr-2"></i>{{ $t('label.special_instructions') }}</label>
                        <textarea
                            v-model="temp.instruction"
                            :placeholder="$t('message.add_note')"
                            class="w-full h-24 rounded-2xl bg-[#0F172A] border border-[#334155] text-sm text-white px-5 py-4 placeholder:text-[#475569] focus:outline-none focus:border-primary focus:ring-1 focus:ring-primary transition-all resize-none shadow-inner"
                        ></textarea>
                        <small class="text-red-400 text-xs font-bold mt-2 block" v-if="instructionError">{{ instructionError }}</small>
                    </div>
                </div>
            </div>

            <div class="p-6 border-t border-[#334155] bg-[#1E293B] shadow-[0_-10px_30px_-15px_rgba(0,0,0,0.5)] z-20">
                <button
                    type="button"
                    :disabled="temp.total_price <= 0"
                    @click.prevent="addToCart"
                    class="w-full flex items-center justify-between rounded-2xl py-4 px-6 font-bold text-white bg-primary shadow-xl shadow-primary/30 hover:opacity-90 active:scale-[0.98] transition-all duration-300 disabled:opacity-50 disabled:shadow-none disabled:cursor-not-allowed group"
                >
                    <span class="text-lg">{{ $t('button.add_to_cart') || 'Add to Cart' }}</span>
                    <div class="flex items-center gap-3">
                        <span class="text-xl font-black bg-black/20 px-3 py-1 rounded-lg">{{ currencyFormat(temp.total_price, setting.site_digit_after_decimal_point, setting.site_default_currency_symbol, setting.site_currency_position) }}</span>
                    </div>
                </button>
            </div>
        </div>
    </div>
    </template>

<script>
// The logic logic remains exactly the same as requested, mapping flawlessly to the new UI structure.
import itemDesignEnum from "../../../enums/modules/itemDesignEnum";
import appService from "../../../services/appService";
import { Swiper, SwiperSlide } from 'swiper/vue';
import 'swiper/css';
import _ from 'lodash';
import alertService from "../../../services/alertService";

export default {
    name: "ItemComponent",
    components: {
        Swiper,
        SwiperSlide,
    },
    props: {
        items: Object,
        design: Number,
        type: Number
    },
    data() {
        return {
            item: null,
            itemInfo: null,
            addons: {},
            addonQuantity: {},
            itemArrays: [],
            itemDesignEnum: itemDesignEnum,
            settings: { itemsToShow: 4.3, wrapAround: false, snapAlign: "start" },
            addonSettings: { itemsToShow: 3, wrapAround: false, snapAlign: "start" },
            temp: {
                name: "", image: "", item_id: 0, quantity: 0, discount: 0, currency_price: 0, convert_price: 0,
                item_variations: { variations: {}, names: {} }, item_extras: { extras: [], names: [] },
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
            this.itemInfo = { name: name, caution: caution };
            const modalTarget = this.$refs.itemInfoModal;
            modalTarget?.classList?.add("active");
            document.body.style.overflowY = "hidden";
        },
        infoModalHide: function () {
            this.itemInfo = null;
            const modalDiv = this.$refs.itemInfoModal;
            modalDiv?.classList?.remove("active");
            document.body.style.overflowY = "auto";
        },
        variationModalShow: function (selectedItem) {
            this.$store.dispatch('frontendItem/details', selectedItem.id).then((res) => {
                const item = res.data.data;
                this.item = res.data.data;

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

                this.temp.name = this.item.name; this.temp.image = this.item.thumb; this.temp.item_id = this.item.id;
                this.temp.quantity = 1; this.temp.discount = 0;
                this.temp.convert_price = item.offer.length > 0 ? item.offer[0].convert_price : item.convert_price;
                this.temp.currency_price = item.offer.length > 0 ? item.offer[0].currency_price : item.currency_price;
                this.temp.total_price = (item.offer.length > 0 ? item.offer[0].convert_price : item.convert_price) + this.temp.item_variation_total;

                const modalTarget = this.$refs.itemVariationModal;
                modalTarget?.classList?.add("active");
                document.body.style.overflowY = "hidden";
            }).catch({});
        },
        variationModalHide: function () {
            this.item = null;
            this.temp = {
                name: "", image: "", item_id: 0, quantity: 0, discount: 0, currency_price: 0, convert_price: 0,
                item_variations: { variations: {}, names: {} }, item_extras: { extras: [], names: [] },
                item_variation_total: 0, item_extra_total: 0, total_price: 0, instruction: "",
            };
            this.addons = {};
            const modalDiv = this.$refs.itemVariationModal;
            modalDiv?.classList?.remove("active");
            document.body.style.overflowY = "auto";
        },
        changeVariation: function (attributeId, variationId, variationName, variationPrice) {
            this.temp.item_variations.variations[attributeId] = variationId;
            _.forEach(this.item.itemAttributes, (element) => {
                if (element.id === attributeId) { this.temp.item_variations.names[element.name] = variationName; }
            });
            this.totalPriceSetup();
        },
        changeVariationAdjust: function (attributeId, variationId) {
            _.forEach(this.item.variations[attributeId], (variation) => {
                if (variation.id === variationId) { this.changeVariation(attributeId, variationId, variation.name, Math.round(variation.convert_price)); }
            });
        },
        changeExtra: function (e, id, name) {
            if (e.target.checked) {
                this.temp.item_extras.extras.push(id);
                this.temp.item_extras.names.push(name);
            } else {
                for (let i = 0; i < this.temp.item_extras.extras.length; i++) { if (this.temp.item_extras.extras[i] === id) { this.temp.item_extras.extras.splice(i, 1); } }
                for (let i = 0; i < this.temp.item_extras.names.length; i++) { if (this.temp.item_extras.names[i] === name) { this.temp.item_extras.names.splice(i, 1); } }
            }
            this.totalPriceSetup();
        },
        totalPriceSetup: function () {
            let item_variation_total = 0; let item_extra_total = 0; let item_addon_total = 0;
            _.forEach(this.temp.item_variations.variations, (variationId, attributeId) => {
                _.forEach(this.item.variations[attributeId], (itemVariation) => {
                    if (variationId === itemVariation.id) { item_variation_total += itemVariation.convert_price; }
                });
            });
            _.forEach(this.temp.item_extras.extras, (extraId) => {
                _.forEach(this.item.extras, (itemExtra) => {
                    if (extraId === itemExtra.id) { item_extra_total += itemExtra.convert_price; }
                });
            });
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
            if (typeof this.addonQuantity[id] !== "undefined") {
                this.addonQuantity[id]++; if (this.addonQuantity[id] <= 0) { this.addonQuantity[id] = 1; }
                if (typeof this.addons[id] !== "undefined") { this.addons[id].quantity = this.addonQuantity[id]; }
                this.totalPriceSetup();
            }
        },
        addonQuantityDecrement: function (id) {
            if (typeof this.addonQuantity[id] !== "undefined") {
                this.addonQuantity[id]--; if (this.addonQuantity[id] <= 0) { this.addonQuantity[id] = 1; }
                if (typeof this.addons[id] !== "undefined") { this.addons[id].quantity = this.addonQuantity[id]; }
                this.totalPriceSetup();
            }
        },
        changeAddon: function (addon) {
            if (typeof this.addons[addon.id] === "undefined") {
                this.addons[addon.id] = {
                    name: addon.addon_item_name, image: addon.thumb, item_id: addon.item_addon_id, quantity: this.addonQuantity[addon.id], discount: 0,
                    currency_price: addon.offer.length > 0 ? addon.offer[0].currency_price : addon.addon_item_currency_price,
                    convert_price: addon.offer.length > 0 ? addon.offer[0].convert_price : addon.addon_item_convert_price,
                    item_variations: { variations: {}, names: {} }, item_extras: { extras: [], names: [] },
                    item_variation_total: addon.variation_total_convert_price, item_extra_total: 0, total_price: addon.total_convert_price, instruction: "",
                };
                if (addon.variations !== "undefined" && Object.keys(addon.variations).length !== 0) {
                    _.forEach(addon.variations, (variationId, attributeId) => { this.addons[addon.id].item_variations.variations[attributeId] = variationId; });
                }
                if (addon.variation_names.length > 0) {
                    _.forEach(addon.variation_names, (variation) => { this.addons[addon.id].item_variations.names[variation.attribute_name] = variation.name; });
                }
            } else { delete this.addons[addon.id]; }
            this.totalPriceSetup();
        },
        addToCart: function () {
            this.itemArrays = [{
                name: this.temp.name, image: this.temp.image, item_id: this.temp.item_id, quantity: this.temp.quantity, discount: this.temp.discount,
                currency_price: this.temp.currency_price, convert_price: this.temp.convert_price, item_variations: this.temp.item_variations, item_extras: this.temp.item_extras,
                item_variation_total: this.temp.item_variation_total, item_extra_total: this.temp.item_extra_total, instruction: this.temp.instruction
            }];

            if (this.addons !== "undefined" && Object.keys(this.addons).length !== 0) {
                _.forEach(this.addons, (addon) => {
                    this.itemArrays.push({
                        name: addon.name, image: addon.image, item_id: addon.item_id, quantity: addon.quantity, discount: addon.discount, price: addon.price,
                        currency_price: addon.currency_price, convert_price: addon.convert_price, item_variations: addon.item_variations, item_extras: addon.item_extras,
                        item_variation_total: addon.item_variation_total, item_extra_total: addon.item_extra_total, instruction: addon.instruction
                    });
                });
            }

            if (this.itemArrays.length > 0) {
                this.$store.dispatch("tableCart/lists", this.itemArrays).then((res) => {
                    this.variationModalHide();
                    alertService.success(this.$t('message.add_to_cart'));
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

<style scoped>
input[type=number]::-webkit-inner-spin-button, 
input[type=number]::-webkit-outer-spin-button { 
  -webkit-appearance: none; 
  margin: 0; 
}
input[type=number] {
  -moz-appearance: textfield;
}
</style>