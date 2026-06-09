<template>
    <LoadingComponent :props="loading" />
    <PoscustomerComponent v-on:onCustomverCreate="onCustomverCreate" />

    <!-- Main Menu Area -->
    <div class="md:w-[calc(100%-340px)] lg:w-[calc(100%-320px)] xl:w-[calc(100%-377px)]">

        <!-- Search Bar -->
        <div class="relative mb-5">
            <div class="flex items-center w-full h-12 rounded-2xl bg-white border border-gray-100 shadow-sm ring-0 focus-within:ring-2 focus-within:ring-[#0ECFAD]/30 focus-within:border-[#0ECFAD] transition-all duration-200">
                <span class="pl-4 pr-3 text-gray-300">
                    <svg width="18" height="18" viewBox="0 0 24 24" fill="none"><circle cx="11" cy="11" r="7" stroke="currentColor" stroke-width="2"/><path d="m16.5 16.5 4 4" stroke="currentColor" stroke-width="2" stroke-linecap="round"/></svg>
                </span>
                <input
                    type="text"
                    v-model="props.search.name"
                    :placeholder="$t('label.search_by_menu_item')"
                    class="w-full h-full text-sm text-gray-700 placeholder:text-gray-400 bg-transparent focus:outline-none"
                    @keyup.enter="search"
                >
                <button
                    @click="resetName"
                    type="button"
                    v-if="props.search.name"
                    class="px-4 text-gray-300 hover:text-red-400 transition-colors"
                >
                    <svg width="16" height="16" viewBox="0 0 24 24" fill="none"><circle cx="12" cy="12" r="9" stroke="currentColor" stroke-width="2"/><path d="m15 9-6 6M9 9l6 6" stroke="currentColor" stroke-width="2" stroke-linecap="round"/></svg>
                </button>
                <button @click="search" type="button" class="mr-2 px-4 h-8 rounded-xl text-xs font-semibold text-white bg-[#0ECFAD] hover:bg-[#0ab898] transition-colors whitespace-nowrap">
                    {{ $t('label.search') || 'Search' }}
                </button>
            </div>
        </div>

        <!-- Categories Swiper -->
        <div class="mb-6" v-if="categories.length > 1">
            <Swiper dir="ltr" :speed="600" slidesPerView="auto" :spaceBetween="10" class="!pb-1">
                <SwiperSlide class="!w-fit" v-for="(category, index) in categories" :key="category">
                    <router-link
                        v-if="index === 0"
                        to="#"
                        @click.prevent="allCategory"
                        :class="props.search.item_category_id === ''
                            ? 'bg-[#0ECFAD] text-white shadow-lg shadow-[#0ECFAD]/25 scale-[1.02]'
                            : 'bg-white border border-gray-100 text-gray-500 hover:border-[#0ECFAD]/30 hover:text-[#0ECFAD]'"
                        class="flex flex-col items-center gap-2.5 py-3.5 px-4 rounded-2xl transition-all duration-200 w-[90px]"
                    >
                        <img class="h-7 w-7 object-contain" :src="category.thumb" alt="">
                        <span class="text-[11px] font-semibold leading-tight text-center capitalize">{{ category.name }}</span>
                    </router-link>
                    <router-link
                        v-else
                        to="#"
                        @click.prevent="setCategory(category.id)"
                        :class="props.search.item_category_id === category.id
                            ? 'bg-[#0ECFAD] text-white shadow-lg shadow-[#0ECFAD]/25 scale-[1.02]'
                            : 'bg-white border border-gray-100 text-gray-500 hover:border-[#0ECFAD]/30 hover:text-[#0ECFAD]'"
                        class="flex flex-col items-center gap-2.5 py-3.5 px-4 rounded-2xl transition-all duration-200 w-[90px]"
                    >
                        <img class="h-7 w-7 object-contain" :src="category.thumb" alt="">
                        <span class="text-[11px] font-semibold leading-tight text-center capitalize">{{ category.name }}</span>
                    </router-link>
                </SwiperSlide>
            </Swiper>
        </div>

        <!-- Items Grid -->
        <ItemComponent :items="items" v-if="items.length > 0" />

        <!-- Empty States -->
        <div class="flex flex-col items-center justify-center py-20" v-else-if="items.length === 0 && !props.search.name">
            <div class="w-36 h-36 rounded-3xl bg-gray-50 flex items-center justify-center mb-5">
                <img class="w-24 opacity-60" :src="setting.image_order_not_found" alt="">
            </div>
            <p class="text-gray-400 text-sm font-medium">{{ $t('message.no_data_available') }}</p>
        </div>
        <div class="flex flex-col items-center justify-center py-20" v-else-if="items.length === 0 && props.search.name">
            <div class="w-36 h-36 rounded-3xl bg-gray-50 flex items-center justify-center mb-5">
                <img class="w-24 opacity-60" :src="setting.item_not_found" alt="">
            </div>
            <p class="text-gray-400 text-sm font-medium">{{ $t('message.no_items_found') }}</p>
            <button @click="resetName" class="mt-3 text-xs text-[#0ECFAD] font-semibold hover:underline">Clear search</button>
        </div>
    </div>

    <!-- ======= POS CART SIDEBAR (Dark) ======= -->
    <div
        id="pos-cart"
        class="db-pos-cartDiv fixed top-0 ltr:right-0 rtl:left-0 w-full h-screen z-50
               md:z-10 md:top-[85px] ltr:md:right-5 rtl:md:left-5
               md:w-[322px] lg:w-[305px] xl:w-[360px]
               md:h-[calc(100vh-105px)] rounded-none md:rounded-3xl
               overflow-hidden flex flex-col
               bg-[#0F1117] border border-white/[0.06]
               shadow-2xl shadow-black/40
               transition-all duration-300"
    >
        <!-- Cart Header -->
        <div class="flex-shrink-0 px-5 pt-5 pb-4 bg-gradient-to-b from-[#0F1117] to-[#0F1117]">
            <!-- Mobile close -->
            <div class="md:hidden flex justify-between items-center mb-4">
                <span class="text-white text-sm font-bold">Order Cart</span>
                <button class="db-pos-cartCls w-8 h-8 rounded-xl bg-white/10 flex items-center justify-center text-gray-400 hover:text-white hover:bg-white/20 transition-all" @click="closePosCart('pos-cart')">
                    <svg width="14" height="14" viewBox="0 0 24 24" fill="none"><path d="M18 6 6 18M6 6l12 12" stroke="currentColor" stroke-width="2" stroke-linecap="round"/></svg>
                </button>
            </div>

            <!-- Customer Select -->
            <div class="flex gap-2 mb-3">
                <vue-select
                    class="db-field-control flex-1 text-sm rounded-xl text-white border-white/10 bg-white/[0.06] pos-dark-select"
                    id="customer"
                    v-model="checkoutProps.form.customer_id"
                    :options="customers"
                    label-by="name"
                    value-by="id"
                    :closeOnSelect="true"
                    :searchable="true"
                    :clearOnClose="true"
                    :placeholder="$t('label.select_customer')"
                    :search-placeholder="$t('label.search_customer')"
                />
                <button
                    data-modal="#customerModal"
                    @click.prevent="addCustomer"
                    type="button"
                    class="flex-shrink-0 w-10 h-10 rounded-xl bg-[#0ECFAD] hover:bg-[#0ab898] text-white flex items-center justify-center transition-colors shadow-lg shadow-[#0ECFAD]/20"
                >
                    <svg width="16" height="16" viewBox="0 0 24 24" fill="none"><path d="M12 5v14M5 12h14" stroke="currentColor" stroke-width="2.5" stroke-linecap="round"/></svg>
                </button>
            </div>

            <!-- Token -->
            <input
                v-on:keypress="onlyNumber($event)"
                class="w-full px-4 h-10 text-sm rounded-xl border border-white/10 bg-white/[0.06] text-white placeholder:text-gray-500 focus:outline-none focus:border-[#0ECFAD]/50 focus:ring-1 focus:ring-[#0ECFAD]/20 transition-all mb-3"
                id="token"
                v-model="checkoutProps.form.token"
                :placeholder="$t('label.token_no')"
            />

            <!-- Order Type Toggle -->
            <div class="bg-white/[0.04] rounded-2xl p-3 border border-white/[0.06]">
                <p class="text-[10px] font-semibold text-gray-500 uppercase tracking-wider mb-2.5">{{ $t('label.select_order_type') }}</p>
                <div class="flex gap-2">
                    <label
                        @click="dineInOrder"
                        ref="dineIn"
                        for="dinein"
                        data-dine="#dine"
                        class="flex-1 flex items-center justify-center gap-2 py-2.5 px-3 rounded-xl border cursor-pointer transition-all duration-200 active"
                        :class="'border-white/10 bg-white/[0.04] text-gray-400 hover:border-[#0ECFAD]/30'"
                    >
                        <div class="custom-radio sm">
                            <input ref="dineInInput" type="radio" id="dinein" name="orderType" :value="orderTypeEnums.dineIn" v-model="checkoutProps.form.order_type" class="custom-radio-field" />
                            <span class="custom-radio-span"></span>
                        </div>
                        <svg width="14" height="14" viewBox="0 0 24 24" fill="none"><rect x="3" y="10" width="18" height="2" rx="1" fill="currentColor"/><rect x="6" y="12" width="2" height="7" rx="1" fill="currentColor"/><rect x="16" y="12" width="2" height="7" rx="1" fill="currentColor"/><rect x="4" y="19" width="16" height="2" rx="1" fill="currentColor"/><path d="M8 10V7a4 4 0 0 1 8 0v3" stroke="currentColor" stroke-width="1.5" stroke-linecap="round"/></svg>
                        <span class="text-xs font-semibold">{{ $t('label.dine_in') }}</span>
                    </label>
                    <label
                        ref="takeAway"
                        @click="takeAwayOrder"
                        for="takeway"
                        class="flex-1 flex items-center justify-center gap-2 py-2.5 px-3 rounded-xl border cursor-pointer transition-all duration-200"
                        :class="'border-white/10 bg-white/[0.04] text-gray-400 hover:border-[#0ECFAD]/30'"
                    >
                        <div class="custom-radio sm">
                            <input ref="takeAwayInput" type="radio" id="takeway" name="orderType" :value="orderTypeEnums.takeAway" v-model="checkoutProps.form.order_type" class="custom-radio-field" />
                            <span class="custom-radio-span"></span>
                        </div>
                        <svg width="14" height="14" viewBox="0 0 24 24" fill="none"><path d="M6 2 3 6v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2V6l-3-4z" stroke="currentColor" stroke-width="1.5" stroke-linejoin="round"/><path d="M3 6h18M16 10a4 4 0 0 1-8 0" stroke="currentColor" stroke-width="1.5" stroke-linecap="round"/></svg>
                        <span class="text-xs font-semibold">{{ $t('label.takeaway') }}</span>
                    </label>
                </div>
                <div ref="dineInDiv" id="dine" class="h-auto hidden transition mt-2.5">
                    <vue-select
                        class="db-field-control text-sm rounded-xl text-white border-white/10 bg-white/[0.06] pos-dark-select"
                        id="diningtables"
                        :options="diningtables"
                        v-model="checkoutProps.form.dining_table_id"
                        value-by="id"
                        label-by="name"
                        :closeOnSelect="true"
                        :searchable="true"
                        :clearOnClose="true"
                        :placeholder="$t('label.select_table')"
                        :search-placeholder="$t('label.search_table')"
                    />
                </div>
            </div>
        </div>

        <!-- Cart Items - Scrollable -->
        <div class="flex-1 overflow-y-auto thin-scrolling px-3 py-2" style="scrollbar-width: thin; scrollbar-color: #1e2030 transparent;">
            <!-- Empty cart state -->
            <div v-if="!carts || carts.length === 0" class="flex flex-col items-center justify-center h-full py-12 opacity-40">
                <svg width="48" height="48" viewBox="0 0 24 24" fill="none" class="text-gray-500 mb-3"><path d="M6 2 3 6v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2V6l-3-4z" stroke="currentColor" stroke-width="1.5"/><path d="M3 6h18M16 10a4 4 0 0 1-8 0" stroke="currentColor" stroke-width="1.5" stroke-linecap="round"/></svg>
                <p class="text-gray-500 text-xs font-medium">Cart is empty</p>
            </div>

            <!-- Cart Items -->
            <div v-for="(cart, index) in carts" :key="index" class="group flex gap-3 py-3 border-b border-white/[0.05] last:border-0">
                <!-- Delete -->
                <button @click.prevent="deleteCartItem(index)" class="flex-shrink-0 w-6 h-6 mt-0.5 rounded-lg bg-white/[0.04] text-gray-600 hover:bg-red-500/20 hover:text-red-400 flex items-center justify-center transition-all">
                    <svg width="11" height="11" viewBox="0 0 24 24" fill="none"><path d="M3 6h18M8 6V4h8v2M19 6l-1 14H6L5 6" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/></svg>
                </button>

                <!-- Item Info -->
                <div class="flex-1 min-w-0">
                    <h3 class="text-xs font-semibold text-white/90 truncate mb-0.5">{{ cart.name }}</h3>
                    <p v-if="Object.keys(cart.item_variations.variations).length !== 0" class="mb-0.5">
                        <span v-for="(variation, variationName, index) in cart.item_variations.names" class="text-[10px] text-gray-500">
                            <span class="text-gray-600">{{ variationName }}:</span> {{ variation }}
                        </span>
                    </p>
                    <ul v-if="cart.item_extras.extras.length > 0 || cart.instruction !== ''">
                        <li v-if="cart.item_extras.extras.length > 0">
                            <span class="text-[10px] text-gray-600">{{ $t('label.extras') }}: </span>
                            <span class="text-[10px] text-gray-500">
                                <span v-for="(extra, index) in cart.item_extras.names">{{ extra }}<span v-if="index + 1 < cart.item_extras.extras.length">, </span></span>
                            </span>
                        </li>
                        <li v-if="cart.instruction !== ''">
                            <span class="text-[10px] text-gray-600">{{ $t('label.instruction') }}: </span>
                            <span class="text-[10px] text-gray-500">{{ cart.instruction }}</span>
                        </li>
                    </ul>
                </div>

                <!-- Qty + Price -->
                <div class="flex-shrink-0 flex flex-col items-end gap-2">
                    <span class="text-xs font-bold text-[#0ECFAD]">
                        {{ currencyFormat(cart.total, setting.site_digit_after_decimal_point, setting.site_default_currency_symbol, setting.site_currency_position) }}
                    </span>
                    <div class="flex items-center gap-1 bg-white/[0.06] rounded-lg p-0.5">
                        <button
                            @click.prevent="cartQuantityDecrement(index)"
                            :class="cart.quantity === 1 ? 'text-red-400' : 'text-gray-400'"
                            class="w-5 h-5 flex items-center justify-center rounded-md hover:bg-white/10 transition-all text-[9px]"
                        >
                            <svg width="8" height="8" viewBox="0 0 24 24" fill="none" v-if="cart.quantity > 1"><path d="M5 12h14" stroke="currentColor" stroke-width="3" stroke-linecap="round"/></svg>
                            <svg width="8" height="8" viewBox="0 0 24 24" fill="none" v-else><path d="M3 6h18M8 6V4h8v2M19 6l-1 14H6L5 6" stroke="currentColor" stroke-width="2" stroke-linecap="round"/></svg>
                        </button>
                        <input
                            v-on:keypress="onlyNumber($event)"
                            v-on:keyup="cartQuantityUp(index, $event)"
                            type="number"
                            :value="cart.quantity"
                            class="w-5 text-center text-[11px] font-bold text-white bg-transparent focus:outline-none"
                        >
                        <button @click.prevent="cartQuantityIncrement(index)" class="w-5 h-5 flex items-center justify-center rounded-md hover:bg-white/10 text-gray-400 hover:text-[#0ECFAD] transition-all">
                            <svg width="8" height="8" viewBox="0 0 24 24" fill="none"><path d="M12 5v14M5 12h14" stroke="currentColor" stroke-width="3" stroke-linecap="round"/></svg>
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Cart Footer -->
        <div class="flex-shrink-0 px-4 pb-5 pt-3 bg-[#0F1117] border-t border-white/[0.06]">
            <!-- Discount Input -->
            <div class="flex h-10 rounded-xl border border-white/10 bg-white/[0.04] overflow-hidden mb-3 focus-within:border-[#0ECFAD]/40 transition-all" v-if="carts.length > 0">
                <div class="dropdown-group h-full relative">
                    <button class="flex items-center justify-start w-20 h-full text-xs font-semibold px-3 text-gray-400 bg-white/[0.04] border-r border-white/10 gap-1 dropdown-btn">
                        <span v-if="discountType === discountTypeEnum.PERCENTAGE" class="flex-1">%</span>
                        <span v-else class="flex-1 text-xs">{{ $t("label.fixed") }}</span>
                        <svg width="10" height="10" viewBox="0 0 24 24" fill="none"><path d="m6 9 6 6 6-6" stroke="currentColor" stroke-width="2" stroke-linecap="round"/></svg>
                    </button>
                    <ul class="p-1.5 rounded-xl shadow-2xl absolute bottom-11 ltr:left-0 rtl:right-0 z-10 bg-[#1a1d2e] border border-white/10 transition-all duration-200 origin-bottom scale-y-0 dropdown-list w-28">
                        <li
                            class="flex items-center px-2.5 py-2 rounded-lg cursor-pointer hover:bg-white/[0.06] text-xs font-semibold text-gray-300"
                            v-for="option in [
                                { name: $t('label.percentage'), value: discountTypeEnum.PERCENTAGE },
                                { name: $t('label.fixed'), value: discountTypeEnum.FIXED }
                            ]"
                            :key="option"
                            @click="selectDiscount(option.value)"
                        >{{ option.name }}</li>
                    </ul>
                </div>
                <input
                    v-on:keypress="floatNumber($event)"
                    v-model="discount"
                    type="text"
                    :placeholder="$t('label.add_discount')"
                    class="w-full h-full px-3 text-xs bg-transparent text-white focus:outline-none placeholder:text-gray-600"
                >
                <button
                    @click.prevent="applyDiscount"
                    type="submit"
                    class="flex-shrink-0 px-4 h-full text-xs font-bold text-white bg-[#0ECFAD] hover:bg-[#0ab898] transition-colors"
                >
                    {{ $t('button.apply') }}
                </button>
            </div>

            <!-- Summary -->
            <div class="rounded-2xl bg-white/[0.04] border border-white/[0.06] p-3.5 mb-3.5">
                <div class="flex justify-between text-xs text-gray-500 mb-2">
                    <span>{{ $t("label.sub_total") }}</span>
                    <span class="text-gray-400 font-semibold">{{ currencyFormat(subtotal, setting.site_digit_after_decimal_point, setting.site_default_currency_symbol, setting.site_currency_position) }}</span>
                </div>
                <div class="flex justify-between text-xs text-gray-500 mb-3">
                    <span>{{ $t("label.discount") }}</span>
                    <span class="text-red-400 font-semibold">-{{ currencyFormat(posDiscount, setting.site_digit_after_decimal_point, setting.site_default_currency_symbol, setting.site_currency_position) }}</span>
                </div>
                <div class="h-px bg-white/[0.06] mb-3"></div>
                <div class="flex justify-between items-center">
                    <span class="text-sm font-bold text-white">{{ $t("label.total") }}</span>
                    <span class="text-lg font-extrabold text-[#0ECFAD]">{{ currencyFormat(subtotal - posDiscount, setting.site_digit_after_decimal_point, setting.site_default_currency_symbol, setting.site_currency_position) }}</span>
                </div>
            </div>

            <!-- Action Buttons -->
            <div class="flex gap-2" v-if="carts.length > 0">
                <button
                    @click.prevent="resetCart"
                    class="flex-1 py-3 rounded-2xl text-sm font-bold text-gray-500 bg-white/[0.04] border border-white/[0.06] hover:bg-red-500/10 hover:text-red-400 hover:border-red-500/20 transition-all"
                >
                    {{ $t('button.cancel') }}
                </button>
                <button
                    @click.prevent="orderSubmit"
                    class="flex-1 py-3 rounded-2xl text-sm font-bold text-[#0F1117] bg-[#0ECFAD] hover:bg-[#0ab898] transition-all shadow-lg shadow-[#0ECFAD]/20 active:scale-[0.98]"
                >
                    {{ $t('button.order') }}
                </button>
            </div>
        </div>
    </div>

    <!-- Mobile Cart Button -->
    <button
        @click="openPosCart('pos-cart')"
        type="button"
        class="db-pos-cartBtn fixed md:hidden bottom-0 z-10 left-0 w-full h-16 flex items-center justify-between px-5 bg-[#0F1117] border-t border-white/10 shadow-2xl"
    >
        <div class="flex items-center gap-3">
            <div class="relative w-10 h-10 rounded-2xl bg-[#0ECFAD]/10 border border-[#0ECFAD]/20 flex items-center justify-center">
                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" class="text-[#0ECFAD]"><path d="M6 2 3 6v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2V6l-3-4z" stroke="currentColor" stroke-width="1.5"/><path d="M3 6h18M16 10a4 4 0 0 1-8 0" stroke="currentColor" stroke-width="1.5" stroke-linecap="round"/></svg>
                <span class="absolute -top-1.5 -right-1.5 w-4 h-4 rounded-full bg-[#0ECFAD] text-[#0F1117] text-[9px] font-black flex items-center justify-center">{{ totalItems() }}</span>
            </div>
            <span class="text-sm font-semibold text-white">{{ totalItems() }} {{ $t('label.items') }}</span>
        </div>
        <span class="text-base font-extrabold text-[#0ECFAD]">
            {{ currencyFormat(subtotal - posDiscount, setting.site_digit_after_decimal_point, setting.site_default_currency_symbol, setting.site_currency_position) }}
        </span>
    </button>

    <PaymentComponent :props="checkoutProps" />
</template>
<script>
import LoadingComponent from "../components/LoadingComponent";
import 'vue3-carousel/dist/carousel.css';
import ItemComponent from "./ItemComponent";
import sourceEnum from "../../../enums/modules/sourceEnum";
import orderTypeEnum from "../../../enums/modules/orderTypeEnum";
import isAdvanceOrderEnum from "../../../enums/modules/isAdvanceOrderEnum";
import statusEnum from "../../../enums/modules/statusEnum";
import roleEnum from "../../../enums/modules/roleEnum";
import appService from "../../../services/appService";
import discountTypeEnum from "../../../enums/modules/discountTypeEnum";
import alertService from "../../../services/alertService";
import PaymentComponent from "./PaymentComponent";
import PoscustomerComponent from './PosCustomerComponent';
import posPaymentMethodEnum from "../../../enums/modules/posPaymentMethodEnum";
import { Swiper, SwiperSlide } from 'swiper/vue';
import 'swiper/css';

export default {
    name: "PosComponent",
    components: {
        LoadingComponent,
        ItemComponent,
        PoscustomerComponent,
        Swiper,
        SwiperSlide,
        PaymentComponent
    },
    data() {
        return {
            loading: {
                isActive: false,
            },
            order: {},
            discount: null,
            checkoutProps: {
                form: {
                    branch_id: null,
                    subtotal: 0,
                    token: "",
                    customer_id: null,
                    discount: 0,
                    delivery_charge: 0,
                    delivery_time: null,
                    total: 0,
                    order_type: orderTypeEnum.POS,
                    is_advance_order: isAdvanceOrderEnum.NO,
                    pos_payment_method: posPaymentMethodEnum.CASH,
                    pos_payment_note: '',
                    source: sourceEnum.POS,
                    address_id: null,
                    items: [],
                    dining_table_id: null,
                    pos_received_amount: null,
                }
            },
            props: {
                search: {
                    paginate: 0,
                    order_column: "id",
                    order_type: "asc",
                    name: "",
                    item_category_id: "",
                    status: statusEnum.ACTIVE
                },
            },
            categoryProps: {
                paginate: 0,
                order_column: "sort",
                order_type: "asc",
                status: statusEnum.ACTIVE
            },
            settings: {
                itemsToShow: 6.2,
                wrapAround: false,
                snapAlign: "start"
            },
            breakpoints: {
                200: { itemsToShow: 1.4, wrapAround: false, snapAlign: 'start' },
                250: { itemsToShow: 1.9, wrapAround: false, snapAlign: 'start' },
                300: { itemsToShow: 2.3, wrapAround: false, snapAlign: 'start' },
                375: { itemsToShow: 3, wrapAround: true, snapAlign: 'start' },
                540: { itemsToShow: 4.3, wrapAround: false, snapAlign: 'start' },
                700: { itemsToShow: 5.2, wrapAround: false, snapAlign: 'start' },
                768: { itemsToShow: 3.2, wrapAround: false, snapAlign: 'start' },
                830: { itemsToShow: 3.6, wrapAround: false, snapAlign: 'start' },
                900: { itemsToShow: 4.3, wrapAround: false, snapAlign: 'start' },
                960: { itemsToShow: 5.3, wrapAround: false, snapAlign: 'start' },
                1024: { snapAlign: 'start', itemsToShow: 3.5, wrapAround: false },
                1100: { snapAlign: 'start', itemsToShow: 4.1, wrapAround: false },
                1180: { snapAlign: 'start', itemsToShow: 4.8, wrapAround: false },
                1280: { snapAlign: 'start', itemsToShow: 5.2, wrapAround: false },
                1400: { snapAlign: 'start', itemsToShow: 5.8, wrapAround: false },
                1600: { snapAlign: 'start', itemsToShow: 6.8, wrapAround: false },
                1700: { snapAlign: 'start', itemsToShow: 7.8, wrapAround: false },
                1800: { snapAlign: 'start', itemsToShow: 8.8, wrapAround: false },
                1920: { snapAlign: 'start', itemsToShow: 9.8, wrapAround: false },
                2000: { snapAlign: 'start', itemsToShow: 10.8, wrapAround: false },
                2100: { snapAlign: 'start', itemsToShow: 11.8, wrapAround: false }
            },
            statusEnum: statusEnum,
            discountTypeEnum: discountTypeEnum,
            posPaymentMethodEnum: posPaymentMethodEnum,
            discountType: discountTypeEnum.PERCENTAGE,
            orderTypeEnums: {
                dineIn: orderTypeEnum.DINING_TABLE,
                takeAway: orderTypeEnum.TAKEAWAY
            },
        }
    },
    computed: {
        setting: function () { return this.$store.getters['frontendSetting/lists']; },
        categories: function () { return this.$store.getters["posCategory/lists"]; },
        items: function () { return this.$store.getters["item/lists"]; },
        customers: function () { return this.$store.getters['user/lists']; },
        carts: function () { return this.$store.getters['posCart/lists']; },
        subtotal: function () { return this.$store.getters['posCart/subtotal']; },
        posDiscount: function () { return this.$store.getters['posCart/discount']; },
        diningtables: function () { return this.$store.getters["diningTable/lists"]; },
    },
    mounted() {
        this.closeSidebar();
        this.$refs.dineIn.click();
        this.itemCategories();
        this.itemList();
        const now = new Date();
        const hh = String(now.getHours()).padStart(2, '0');
        const mm = String(now.getMinutes()).padStart(2, '0');
        const ss = String(now.getSeconds()).padStart(2, '0');
        this.checkoutProps.form.token = hh + mm + ss;
        try {
            this.loading.isActive = true;
            this.$store.dispatch("defaultAccess/show").then((res) => {
                this.checkoutProps.form.branch_id = res.data.data.branch_id;
            }).catch((err) => { this.loading.isActive = false; });
            this.customerList();
            this.loading.isActive = true;
            this.$store.dispatch("company/lists").then((res) => {
                this.company.name = res.data.data.company_name;
                this.company.email = res.data.data.company_email;
                this.company.phone = res.data.data.company_phone;
                this.company.address = res.data.data.company_address;
                this.loading.isActive = false;
            }).catch((err) => { this.loading.isActive = false; });
            this.loading.isActive = true;
            this.$store.dispatch("diningTable/lists", {
                order_column: 'id',
                order_type: 'desc',
                status: statusEnum.ACTIVE,
            }).then((res) => { this.loading.isActive = false; }).catch((err) => { this.loading.isActive = false; });
        } catch (err) { this.loading.isActive = false; }
    },
    methods: {
        onlyNumber: function (e) { return appService.onlyNumber(e); },
        floatNumber: function (e) { return appService.floatNumber(e); },
        currencyFormat: function (amount, decimal, currency, position) { return appService.currencyFormat(amount, decimal, currency, position); },
        openPosCart: function (id) { return appService.openPosCart(id); },
        closePosCart: function (id) { return appService.closePosCart(id); },
        resetName: function () { this.props.search.name = ""; this.itemList(); },
        selectDiscount(value) { this.discountType = value; },
        search: function () { this.itemList(); },
        customerList: function (id = null) {
            this.loading.isActive = true;
            this.$store.dispatch('user/lists', { order_column: 'id', order_type: 'asc', status: statusEnum.ACTIVE }).then((res) => {
                this.checkoutProps.form.customer_id = id === null ? res.data.data[1].id : id;
                this.loading.isActive = false;
            }).catch((err) => { this.loading.isActive = false; });
        },
        allCategory: function () { this.props.search.name = ""; this.props.search.item_category_id = ""; this.itemList(); },
        itemCategories: function (page = 1) {
            this.loading.isActive = true;
            this.props.search.page = page;
            this.$store.dispatch("posCategory/lists", this.categoryProps).then((res) => { this.loading.isActive = false; }).catch((err) => { this.loading.isActive = false; });
        },
        itemList: function (page = 1) {
            this.loading.isActive = true;
            this.props.search.page = page;
            this.$store.dispatch("item/lists", this.props.search).then((res) => { this.loading.isActive = false; }).catch((err) => { this.loading.isActive = false; });
        },
        setCategory: function (id) { this.props.search.item_category_id = id; this.itemList(); },
        cartQuantityUp: function (id, e) { if (e.target.value > 0) { this.$store.dispatch('posCart/quantity', { id: id, status: e.target.value }).then().catch(); } },
        cartQuantityIncrement: function (id) { this.$store.dispatch('posCart/quantity', { id: id, status: "increment" }).then().catch(); },
        cartQuantityDecrement: function (id) { this.$store.dispatch('posCart/quantity', { id: id, status: "decrement" }).then().catch(); },
        deleteCartItem: function (id) { this.$store.dispatch('posCart/deleteCartItem', { id: id, status: "decrement" }).then().catch(); },
        applyDiscount: function () {
            if (this.discountType == discountTypeEnum.FIXED) {
                if (this.subtotal < this.discount) { return alertService.error(this.$t('message.discount_fixed_error_message')); }
                else { this.checkoutProps.form.discount = parseFloat(+this.discount).toFixed(this.setting.site_digit_after_decimal_point); this.$store.dispatch('posCart/discount', this.checkoutProps.form.discount).then().catch(); }
            } else {
                if (this.discount > 100) { return alertService.error(this.$t('message.discount_error_message')); }
                else { this.checkoutProps.form.discount = parseFloat((this.subtotal * this.discount) / 100).toFixed(this.setting.site_digit_after_decimal_point); this.$store.dispatch('posCart/discount', this.checkoutProps.form.discount).then().catch(); }
            }
        },
        resetCart: function () { this.$store.dispatch('posCart/resetCart').then(res => {}).catch(); },
        orderSubmit: function () {
            this.loading.isActive = true;
            this.checkoutProps.form.subtotal = this.subtotal;
            this.checkoutProps.form.total = parseFloat(this.subtotal - this.checkoutProps.form.discount).toFixed(this.setting.site_digit_after_decimal_point);
            this.checkoutProps.form.items = [];
            this.checkoutProps.form.pos_payment_note = this.checkoutProps.form.pos_payment_method === posPaymentMethodEnum.CASH ? null : this.checkoutProps.form.pos_payment_note;
            _.forEach(this.carts, (item, index) => {
                let item_variations = [];
                if (Object.keys(item.item_variations.variations).length > 0) {
                    _.forEach(item.item_variations.variations, (value, index) => { item_variations.push({ "id": value, "item_id": item.item_id, "item_attribute_id": index }); });
                }
                if (Object.keys(item.item_variations.names).length > 0) {
                    let i = 0;
                    _.forEach(item.item_variations.names, (value, index) => { item_variations[i].variation_name = index; item_variations[i].name = value; i++; });
                }
                let item_extras = [];
                if (item.item_extras.extras.length) { _.forEach(item.item_extras.extras, (value) => { item_extras.push({ id: value, item_id: item.item_id }); }); }
                if (item.item_extras.names.length) { let i = 0; _.forEach(item.item_extras.names, (value) => { item_extras[i].name = value; i++; }); }
                this.checkoutProps.form.items.push({ item_id: item.item_id, item_price: item.convert_price, branch_id: this.checkoutProps.form.branch_id, instruction: item.instruction, quantity: item.quantity, discount: item.discount, total_price: item.total, item_variation_total: item.item_variation_total, item_extra_total: item.item_extra_total, item_variations: item_variations, item_extras: item_extras });
            });
            this.checkoutProps.form.items = JSON.stringify(this.checkoutProps.form.items);
            this.loading.isActive = false;
            if (!this.checkoutProps.form.token) { return alertService.error(this.$t("message.token_field_required")); }
            if (this.checkoutProps.form.order_type === orderTypeEnum.DINING_TABLE && !this.checkoutProps.form.dining_table_id) { return alertService.error(this.$t("message.table_field_required")); }
            appService.modalShow('#orderpayment');
        },
        totalItems: function () {
            if (this.carts.length > 0) {
                let totalItem = 0;
                this.carts.forEach(cart => { totalItem += cart.quantity; });
                return totalItem;
            }
            return 0;
        },
        addCustomer: function () { appService.modalShow("#customerModal"); },
        onCustomverCreate: function (customerId) { appService.modalHide(); this.customerList(customerId); },
        closeSidebar: function () {
            this.$store.dispatch("globalState/set", { topSidebar: false });
            document?.querySelector(".db-sidebar")?.classList?.add("active");
            document?.querySelector(".db-main")?.classList?.add("expand");
        },
        dineInOrder: function () {
            this.$refs.dineIn.classList.add('active');
            this.$refs.dineInDiv.classList.add('block');
            this.$refs.dineInDiv.classList.remove('hidden');
            this.$refs.takeAway.classList.remove('active');
        },
        takeAwayOrder: function () {
            this.checkoutProps.form.dining_table_id = null;
            this.$refs.takeAway.classList.add('active');
            this.$refs.dineIn.classList.remove('active');
            this.$refs.dineInDiv.classList.add('hidden');
            this.$refs.dineInDiv.classList.remove('block');
        },
    },
    watch: {
        carts: {
            handler(newCarts) {
                if (!newCarts || newCarts.length === 0) {
                    this.discount = null;
                    this.discountType = discountTypeEnum.PERCENTAGE;
                    this.$nextTick(() => {
                        if (this.$refs.dineIn) {
                            this.$refs.dineIn.click();
                            if (this.customers.length > 1) {
                                this.checkoutProps.form.customer_id = this.customers[1].id;
                            }
                        }
                    });
                }
            },
            deep: true,
            immediate: true
        }
    },
}
</script>