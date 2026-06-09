<template>
    <section class="pb-16 pt-6 min-h-screen bg-[#0F172A]">
        <div class="container mx-auto px-4 sm:px-6 max-w-[1024px]">
            <LoadingComponent :props="loading" />

            <div class="swiper mb-8 menu-swiper" v-if="categories.length > 1">
                <Swiper :speed="600" slidesPerView="auto" :spaceBetween="12" class="!pb-2" dir="ltr">
                    <SwiperSlide class="!w-fit" v-for="(category, index) in categories" :key="category.id || index">
                        <router-link
                            v-if="index === 0"
                            to="#"
                            @click.prevent="allCategory(category)"
                            :class="itemProps.search.item_category_id === ''
                                ? 'bg-primary text-white shadow-lg shadow-primary/25 scale-[1.02] border-transparent'
                                : 'bg-[#1E293B] border border-[#334155] text-[#94A3B8] hover:border-primary/50 hover:text-[#E2E8F0]'"
                            class="flex flex-col items-center gap-2.5 py-3.5 px-4 rounded-2xl transition-all duration-200 w-[90px]"
                        >
                            <img class="h-8 w-8 object-contain drop-shadow-md" :src="category.thumb" alt="">
                            <span class="text-[11px] font-bold leading-tight text-center capitalize truncate w-full">{{ category.name }}</span>
                        </router-link>
                        <router-link
                            v-else
                            to="#"
                            @click.prevent="setCategory(category.id, category.slug)"
                            :class="itemProps.search.item_category_id === category.id
                                ? 'bg-primary text-white shadow-lg shadow-primary/25 scale-[1.02] border-transparent'
                                : 'bg-[#1E293B] border border-[#334155] text-[#94A3B8] hover:border-primary/50 hover:text-[#E2E8F0]'"
                            class="flex flex-col items-center gap-2.5 py-3.5 px-4 rounded-2xl transition-all duration-200 w-[90px]"
                        >
                            <img class="h-8 w-8 object-contain drop-shadow-md" :src="category.thumb" alt="">
                            <span class="text-[11px] font-bold leading-tight text-center capitalize truncate w-full">{{ category.name }}</span>
                        </router-link>
                    </SwiperSlide>
                </Swiper>
            </div>

            <div v-if="categories.length > 0" class="flex flex-wrap gap-3 w-full mb-8 veg-navs">
                <button
                    :disabled="itemProps.property.type !== null && itemProps.property.type === enums.itemTypeEnum.VEG"
                    @click.prevent="itemProps.property.type === enums.itemTypeEnum.NON_VEG ? itemTypeReset() : itemTypeSet(enums.itemTypeEnum.NON_VEG)"
                    :class="itemProps.property.type === enums.itemTypeEnum.NON_VEG
                        ? 'bg-red-500/10 border-red-500/30 text-red-400 shadow-sm veg-active'
                        : 'bg-[#1E293B] border border-[#334155] text-[#94A3B8] hover:bg-[#334155] hover:text-[#E2E8F0] disabled:opacity-50 disabled:cursor-not-allowed'"
                    type="button"
                    class="flex items-center gap-2.5 w-fit pl-4 pr-5 py-2 rounded-full border transition-all duration-200"
                >
                    <img :src="setting.image_vag" alt="category" class="h-5 drop-shadow-sm">
                    <span class="capitalize text-xs font-bold tracking-wide">{{ $t('label.frontend_non_veg') }}</span>
                    <i class="lab-close-circle-line text-lg text-red-500 transition opacity-0 ltr:-ml-8 rtl:-mr-8 clear-item-type-filter font-fill-danger lab-font-size-24"></i>
                </button>
                <button
                    :disabled="itemProps.property.type !== null && itemProps.property.type === enums.itemTypeEnum.NON_VEG"
                    @click.prevent="itemProps.property.type === enums.itemTypeEnum.VEG ? itemTypeReset() : itemTypeSet(enums.itemTypeEnum.VEG)"
                    :class="itemProps.property.type === enums.itemTypeEnum.VEG
                        ? 'bg-green-500/10 border-green-500/30 text-green-400 shadow-sm veg-active'
                        : 'bg-[#1E293B] border border-[#334155] text-[#94A3B8] hover:bg-[#334155] hover:text-[#E2E8F0] disabled:opacity-50 disabled:cursor-not-allowed'"
                    type="button"
                    class="flex items-center gap-2.5 w-fit pl-4 pr-5 py-2 rounded-full border transition-all duration-200"
                >
                    <img :src="setting.image_non_vag" alt="category" class="h-5 drop-shadow-sm">
                    <span class="capitalize text-xs font-bold tracking-wide">{{ $t('label.veg') }}</span>
                    <i class="lab-close-circle-line text-lg text-red-500 transition opacity-0 ltr:-ml-8 rtl:-mr-8 clear-item-type-filter font-fill-danger lab-font-size-24"></i>
                </button>
            </div>

            <div v-if="Object.keys(category).length > 0" class="flex gap-4 items-center justify-between mb-6 pb-4 border-b border-[#334155]">
                <h2 class="capitalize text-2xl font-bold text-white tracking-wide">
                    {{ category.name }}
                </h2>
                <div class="flex items-center gap-1 bg-[#1E293B] p-1 rounded-xl border border-[#334155] shadow-inner">
                    <button
                        type="button"
                        v-on:click="itemProps.property.design = enums.itemDesignEnum.LIST"
                        :class="itemProps.property.design === enums.itemDesignEnum.LIST
                            ? 'bg-[#0F172A] text-primary shadow-sm border border-[#334155]'
                            : 'text-[#94A3B8] hover:text-white border border-transparent'"
                        class="w-9 h-9 rounded-lg flex items-center justify-center transition-all duration-200"
                    >
                        <i class="lab lab-row-vertical text-xl"></i>
                    </button>
                    <button
                        type="button"
                        v-on:click="itemProps.property.design = enums.itemDesignEnum.GRID"
                        :class="itemProps.property.design === enums.itemDesignEnum.GRID
                            ? 'bg-[#0F172A] text-primary shadow-sm border border-[#334155]'
                            : 'text-[#94A3B8] hover:text-white border border-transparent'"
                        class="w-9 h-9 rounded-lg flex items-center justify-center transition-all duration-200"
                    >
                        <i class="lab lab-element-3 text-xl"></i>
                    </button>
                </div>
            </div>

            <ItemComponent v-if="items.length > 0" :items="items" :type="itemProps.property.type" :design="itemProps.property.design" />
            
            <div class="mt-20 flex flex-col items-center justify-center" v-else>
                <div class="max-w-[200px] mx-auto opacity-70 mb-8">
                    <img class="w-full drop-shadow-2xl" :src="setting.image_order_not_found" alt="Not found">
                </div>
                <span class="text-base font-medium text-[#94A3B8] bg-[#1E293B] px-6 py-3 rounded-2xl border border-[#334155]">
                    {{ $t('message.no_data_available') }}
                </span>
            </div>
        </div>
    </section>
    
    <div v-if="Object.keys(order).length > 0" ref="confirmOrder" id="confirm-order"
        class="modal confirm-order ff-modal !bg-[#0F172A]/80 !backdrop-blur-sm transition-all duration-300">
        <div class="modal-dialog max-w-[400px] relative mt-20 mx-auto bg-[#1E293B] border border-[#334155] shadow-2xl rounded-3xl p-6 transform transition-transform">
            
            <button class="modal-close absolute top-4 right-4 flex items-center justify-center w-8 h-8 rounded-full bg-[#0F172A] text-[#94A3B8] hover:text-red-400 hover:bg-red-500/10 transition-colors"
                @click.prevent="closeModal">
                <i class="fa-solid fa-xmark text-lg"></i>
            </button>
            
            <div class="modal-body flex flex-col items-center pt-4">
                <h3 class="capitalize text-sm tracking-widest font-bold text-[#94A3B8] uppercase text-center mb-6">
                    {{ $t('message.order_thank_you') }}
                </h3>
                
                <img class="w-[100px] h-[100px] object-contain mx-auto mb-6 drop-shadow-[0_0_15px_rgba(var(--color-primary),0.3)]" :src="setting.image_confirm" alt="Success">
                
                <h3 class="capitalize text-2xl font-black text-center mb-4 text-white">
                    {{ $t('label.order_confirmed') }}
                </h3>
                
                <p class="text-[15px] leading-relaxed text-center text-[#E2E8F0] mb-8 px-2">
                    {{ $t('message.order_confirm') }}
                    <b class="font-bold text-primary">{{ $t('label.dining_table') }}.</b>
                    <strong class="block mt-2 font-medium text-[#94A3B8]"
                        v-if="setting.site_online_payment_gateway === enums.activityEnum.ENABLE && order.transaction === null && order.payment_status === enums.paymentStatusEnum.UNPAID && paymentMethod === 'digitalPayment'">
                        {{ $t('message.choosing_payment_options') }}
                    </strong>
                </p>

                <div class="flex flex-col sm:flex-row gap-3 w-full"
                    v-if="setting.site_online_payment_gateway === enums.activityEnum.ENABLE && order.transaction === null && order.payment_status === enums.paymentStatusEnum.UNPAID && paymentMethod === 'digitalPayment'">
                    <router-link @click.prevent="closeModal"
                        class="w-full h-12 flex items-center justify-center rounded-xl font-bold capitalize transition-all border border-[#334155] text-white hover:bg-[#334155]"
                        :to="{ name: 'table.tableOrder.details', params: { slug: this.$route.params.slug, id: order.id } }">
                        {{ $t('button.go_to_order') }}
                    </router-link>
                    <a :href="'/payment/' + order.id + '/pay'"
                        class="w-full h-12 flex items-center justify-center rounded-xl font-bold capitalize transition-all text-white bg-primary hover:opacity-90 active:scale-[0.98] shadow-lg shadow-primary/25">
                        {{ $t('button.pay_now') }}
                    </a>
                </div>

                <router-link v-else @click.prevent="closeModal"
                    class="w-full h-12 flex items-center justify-center rounded-xl font-bold capitalize transition-all text-white bg-primary hover:opacity-90 active:scale-[0.98] shadow-lg shadow-primary/25"
                    :to="{ name: 'table.tableOrder.details', params: { slug: this.$route.params.slug, id: order.id } }">
                    {{ $t('button.go_to_order') }}
                </router-link>
            </div>
        </div>
    </div>
</template>

<script>
// Logic exactly identical to your provided file
import LoadingComponent from "../../table/components/LoadingComponent.vue";
import statusEnum from "../../../enums/modules/statusEnum";
import ItemComponent from "../components/ItemComponent.vue";
import itemDesignEnum from "../../../enums/modules/itemDesignEnum";
import itemTypeEnum from "../../../enums/modules/itemTypeEnum";
import orderTypeEnum from "../../../enums/modules/orderTypeEnum";
import activityEnum from "../../../enums/modules/activityEnum";
import paymentStatusEnum from "../../../enums/modules/paymentStatusEnum";
import { Swiper, SwiperSlide } from 'swiper/vue';
import 'swiper/css';

export default {
    name: "TableMenuComponent",
    components: {
        ItemComponent,
        LoadingComponent,
        Swiper,
        SwiperSlide,
    },
    data() {
        return {
            loading: {
                isActive: false,
            },
            category: {
                id: 0,
                name: this.$t('label.all') + ' ' + this.$t('label.items')
            },
            categoryProps: {
                search: {
                    paginate: 0,
                    order_column: "sort",
                    order_type: "asc",
                    status: statusEnum.ACTIVE
                },
            },
            settings: {
                itemsToShow: 8,
                wrapAround: false,
                snapAlign: "start"
            },
            breakpoints: {
                200: { itemsToShow: 1.1, wrapAround: false, snapAlign: 'start', },
                250: { itemsToShow: 1.5, wrapAround: false, snapAlign: 'start', },
                300: { itemsToShow: 2.3, wrapAround: false, snapAlign: 'start', },
                375: { itemsToShow: 2.5, wrapAround: false, snapAlign: 'start', },
                540: { itemsToShow: 3.5, wrapAround: false, snapAlign: 'start', },
                700: { itemsToShow: 4.5, wrapAround: false, snapAlign: 'start', },
                1024: { snapAlign: 'start', itemsToShow: 7, wrapAround: false, },
                1180: { snapAlign: 'start', itemsToShow: 8, wrapAround: false, }
            },
            itemProps: {
                search: {
                    paginate: 0,
                    order_column: "id",
                    order_type: "asc",
                    item_category_id: "",
                    status: statusEnum.ACTIVE
                },
                property: {
                    design: itemDesignEnum.LIST,
                    type: null
                }
            },
            enums: {
                activityEnum: activityEnum,
                paymentStatusEnum: paymentStatusEnum,
                itemTypeEnum: itemTypeEnum,
                itemDesignEnum: itemDesignEnum,
                orderTypeEnumArray: {
                    [orderTypeEnum.DELIVERY]: this.$t("label.delivery"),
                    [orderTypeEnum.TAKEAWAY]: this.$t("label.takeaway"),
                    [orderTypeEnum.DINING_TABLE]: this.$t("label.dining_table")
                },
            }
        }
    },
    computed: {
        categories: function () { return this.$store.getters["tableItemCategory/lists"]; },
        items: function () { return this.$store.getters["frontendItem/lists"]; },
        setting: function () { return this.$store.getters['frontendSetting/lists']; },
        order: function () { return this.$store.getters['tableDiningOrder/show']; },
        paymentMethod: function () { return this.$store.getters['tableCart/paymentMethod']; }
    },
    mounted() {
        this.loading.isActive = true;
        this.itemList();
        this.$store.dispatch("tableItemCategory/lists", this.categoryProps.search).then(res => {
            this.loading.isActive = false;
        }).catch((err) => {
            this.loading.isActive = false;
        });

        if (Object.keys(this.$route.query).length > 0) {
            this.loading.isActive = true;
            this.$store.dispatch('tableDiningOrder/show', this.$route.query.id).then(res => {
                const modalTarget = this.$refs.confirmOrder;
                modalTarget?.classList?.add("active");
                document.body.style.overflowY = "hidden";
                this.loading.isActive = false;
            }).catch((err) => {
                this.loading.isActive = false;
            });
        }

    },
    methods: {
        closeModal: function () {
            const modalTarget = this.$refs.confirmOrder;
            modalTarget?.classList?.remove("active");
            document.body.style.overflowY = "auto";
            this.loading.isActive = false;
        },
        allCategory: function (category) {
            this.itemProps.search.item_category_id = "";
            this.category = { id: 0, name: category.name }
            this.itemList();
        },
        setCategory: function (id, slug = null) {
            this.itemProps.search.item_category_id = id;
            this.itemList();
            if (slug !== null) {
                this.loading.isActive = true;
                this.$store.dispatch("tableItemCategory/show", { slug: slug }).then((res) => {
                    this.category = res.data.data;
                    this.loading.isActive = false;
                }).catch((err) => {
                    this.loading.isActive = false;
                });
            }
        },
        itemList: function () {
            this.loading.isActive = true;
            this.$store.dispatch("frontendItem/lists", this.itemProps.search).then((res) => {
                this.loading.isActive = false;
            }).catch((err) => {
                this.loading.isActive = false;
            });
        },
        itemTypeSet: function (e) { this.itemProps.property.type = e; },
        itemTypeReset: function () { this.itemProps.property.type = null; },
    }
}
</script>