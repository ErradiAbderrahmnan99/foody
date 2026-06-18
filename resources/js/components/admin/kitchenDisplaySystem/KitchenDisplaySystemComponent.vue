<template>
  <LoadingComponent :props="loading" />
  <div class="row md:mt-4 lg:mt-0">
    <div class="lg:hidden flex items-center w-full px-4 mb-3">
      <button
        class="kitchen-board db-tab-btn active text-base text-black font-semibold h-[38px] bg-white flex items-center justify-center rounded-l-lg px-7 border border-gray-200"
        data-tab="#item-order">{{ $t('label.items_board') }}</button>
      <button
        class="kitchen-board db-tab-btn text-base text-black font-semibold h-[38px] bg-white flex items-center justify-center rounded-r-lg px-7 border border-l-0 border-gray-200"
        data-tab="#today-order">{{ $t('label.todays_order') }}</button>
    </div>
    
    <!-- Items Board Left Column -->
    <div id="item-order" class="col-12 lg:col-3 db-tab-div active lg:block hidden">
      <div class="db-card rounded-2xl w-full border border-gray-100/80 shadow-[0_4px_24px_rgba(0,0,0,0.02)] bg-white overflow-hidden">
        <div class="h-screen md:h-[calc(100vh-127px)] overflow-hidden flex flex-col">
          <div class="p-4 border-b border-gray-100 bg-slate-50/50 flex items-center justify-between">
            <h3 class="text-[16px] font-bold text-slate-800 flex items-center gap-2">
              <span class="w-2 h-2 rounded-full bg-primary animate-pulse"></span>
              {{ $t('label.items_board') }}
            </h3>
            <span class="px-2 py-0.5 rounded-md text-[10px] font-bold bg-primary/10 text-primary">
              {{ orderItems ? orderItems.length : 0 }} Types
            </span>
          </div>
          <ul class="flex-1 thin-scrolling overflow-auto pb-16 divide-y divide-gray-50">
            <li v-for="orderItem in (orderItems || [])" :key="orderItem"
              class="px-4 py-3.5 flex items-start justify-between gap-3 hover:bg-slate-50/40 transition-colors duration-150">
              <div class="flex-1">
                <h5 class="text-sm font-bold text-slate-800 leading-tight mb-1.5">{{ orderItem.item_name }}</h5>
                <div class="flex flex-col gap-1.5">
                  <p v-if="orderItem.item_variations.length > 0"
                    class="text-[11px] font-medium text-slate-500 capitalize flex flex-wrap items-center">
                    <span v-for="(variation, index) in orderItem.item_variations" :key="index" class="inline-flex items-center bg-slate-100 text-slate-600 px-1.5 py-0.5 rounded mr-1 mb-1">
                      {{ variation.variation_name }}: {{ variation.name }}
                    </span>
                  </p>
                  <div class="flex items-center gap-1.5 text-[11px]" v-if="orderItem.item_extras.length > 0">
                    <span class="font-semibold text-indigo-600 bg-indigo-50 border border-indigo-100 px-1.5 py-0.5 rounded">
                      {{ $t('label.extras') }}:
                    </span>
                    <span class="text-slate-500 font-medium">
                      <span v-for="(extra, index) in orderItem.item_extras" :key="index">
                        {{ extra.name }}<span v-if="index + 1 < orderItem.item_extras.length">, </span>
                      </span>
                    </span>
                  </div>
                  <div class="flex items-center gap-1.5 text-[11px]" v-if="orderItem.instruction">
                    <span class="font-semibold text-rose-600 bg-rose-50 border border-rose-100 px-1.5 py-0.5 rounded">
                      {{ $t('label.instruction') }}:
                    </span>
                    <span class="text-slate-500 font-medium italic">"{{ orderItem.instruction }}"</span>
                  </div>
                </div>
              </div>
              <div
                class="text-sm font-black min-w-[28px] h-7 rounded-lg bg-primary/10 border border-primary/20 text-primary flex items-center justify-center px-1.5 shadow-sm">
                {{ orderItem.quantity }}
              </div>
            </li>
          </ul>
        </div>
      </div>
    </div>

    <!-- Today's Orders Right Column -->
    <div id="today-order" class="col-12 lg:col-9 db-tab-div lg:block hidden">
      <div class="ordersTab">
        <!-- Filter Tabs & Search Header -->
        <div class="db-card px-4 py-3.5 mb-4 rounded-2xl border border-gray-100/80 shadow-[0_4px_24px_rgba(0,0,0,0.02)] bg-white">
          <div class="swiper kitchen-swiper !flex flex-col gap-3 xl:flex-row items-center justify-between">
            <Swiper dir="ltr" :speed="1000" slidesPerView="auto" :spaceBetween="12" :loop="false"
              class="md:grid sm:grid-cols-2 lg:grid-cols-4 gap-2 md:w-fit lg:!w-full w-full">
              <SwiperSlide class="!w-fit">
                <button type="button" v-on:click="list()"
                  class="filter-tab-btn"
                  :class="!props.search.status ? 'active' : ''">
                  <span class="capitalize whitespace-nowrap text-sm font-bold">{{ $t("label.all_orders") }}</span>
                </button>
              </SwiperSlide>
              <SwiperSlide class="!w-fit">
                <button type="button" v-on:click="list(enums.orderStatusEnum.ACCEPT)"
                  :class="props.search.status === enums.orderStatusEnum.ACCEPT ? 'active' : ''"
                  class="filter-tab-btn">
                  <span class="capitalize whitespace-nowrap text-sm font-bold">{{ $t("label.confirmed") }}</span>
                </button>
              </SwiperSlide>
              <SwiperSlide class="!w-fit">
                <button type="button" v-on:click="list(enums.orderStatusEnum.PREPARING)"
                  :class="props.search.status === enums.orderStatusEnum.PREPARING ? 'active' : ''"
                  class="filter-tab-btn">
                  <span class="capitalize whitespace-nowrap text-sm font-bold">{{ $t("label.preparing") }}</span>
                </button>
              </SwiperSlide>
              <SwiperSlide class="!w-fit">
                <button type="button" v-on:click="list(enums.orderStatusEnum.PREPARED)"
                  :class="props.search.status === enums.orderStatusEnum.PREPARED ? 'active' : ''"
                  class="filter-tab-btn">
                  <span class="capitalize whitespace-nowrap text-sm font-bold">{{ $t("label.done") }}</span>
                </button>
              </SwiperSlide>
            </Swiper>

            <form @submit.prevent="search"
              class="header-search-group group flex items-center gap-2 px-3.5 xl:!max-w-[320px] w-full h-11 rounded-xl transition-all border border-solid border-slate-200 bg-slate-50/50 focus-within:bg-white focus-within:border-primary focus-within:ring-2 focus-within:ring-primary/10 shadow-inner">
              <i class="lab lab-search-normal text-slate-400 group-focus-within:text-primary transition-colors text-[16px]"></i>
              <input type="text" v-model="props.search.order_serial_no" placeholder="Search Order..."
                class="header-search-field w-full h-full text-sm appearance-none bg-transparent focus:outline-none placeholder:font-normal placeholder:text-slate-400 text-slate-700" />
              <button type="button" @click.prevent="searchReset"
                class="modal-close lab lab-close-circle-line text-slate-400 hover:text-rose-500 transition-colors invisible group-focus-within:visible"></button>
            </form>
          </div>
        </div>

        <!-- Dine-in & Takeaway Side-by-Side Boards -->
        <div class="grid grid-cols-1 md:grid-cols-2 gap-4" @click="closeFilterSlide($event)">
          <!-- Dine-in Card -->
          <div class="db-card rounded-2xl h-fit border border-gray-100 shadow-[0_4px_24px_rgba(0,0,0,0.02)] bg-white overflow-hidden">
            <div class="p-4 bg-slate-50/50 flex items-center justify-between" :class="dineinOrders.length > 0 ? 'border-b border-slate-100' : ''">
              <h3 class="text-base font-bold text-slate-800 flex items-center gap-2">
                <i class="lab lab-dining-table text-lg text-primary"></i>
                {{ $t("label.dinein_orders") }}
              </h3>
              <span class="px-2 py-0.5 rounded-md text-[10px] font-bold bg-primary/10 text-primary">
                {{ dineinOrders.length }} Orders
              </span>
            </div>
            <div v-if="dineinOrders.length > 0" class="p-4 flex flex-col gap-4">
              <div v-for="dineinOrder in dineinOrders" :key="dineinOrder.id" class="w-full rounded-2xl border border-slate-100 overflow-hidden shadow-sm hover:shadow-md transition-shadow duration-200">
                <div class="py-3 px-4 w-full flex items-center justify-between bg-gradient-to-r from-blue-50/80 to-indigo-50/40 border-b border-indigo-100/40">
                  <div class="flex items-center gap-1.5 text-indigo-700 font-bold">
                    <i class="lab lab-processing text-[16px] animate-spin-slow"></i>
                    <span class="text-sm">#{{ dineinOrder.order_serial_no }}</span>
                  </div>

                  <span class="py-1 px-2.5 rounded-full text-[10px] font-bold leading-none capitalize border shadow-sm"
                    :class="dineinOrder.status === enums.orderStatusEnum.PREPARED ? 'bg-emerald-50 text-emerald-700 border-emerald-200' : (dineinOrder.status === enums.orderStatusEnum.ACCEPT ? 'bg-primary/10 text-primary border-primary/20' : 'bg-amber-50 text-amber-700 border-amber-200')">
                    {{ dineinOrder.status === enums.orderStatusEnum.PREPARED ? $t("label.done") : (dineinOrder.status === enums.orderStatusEnum.ACCEPT ? $t("label.confirmed") : dineinOrder.status_name) }}
                  </span>
                </div>
                <div class="w-full pt-3 pb-4 px-4 bg-white">
                  <div class="flex flex-col gap-1 mb-3">
                    <p class="text-sm font-semibold text-slate-600">
                      {{ $t("label.table_no") }}: <span class="text-slate-800 font-bold bg-slate-100 px-2 py-0.5 rounded-md text-xs ml-1">{{ dineinOrder.table_name }}</span>
                    </p>
                    <p class="text-sm font-semibold text-slate-600">
                      {{ $t("label.token_no") }}: <span class="text-slate-800 font-bold bg-slate-100 px-2 py-0.5 rounded-md text-xs ml-1">{{ dineinOrder.token ? dineinOrder.token : $t("label.online") }}</span>
                    </p>
                  </div>
                  <button type="button" @click="openFilterSlide($event)"
                    class="filter group text-slate-400 hover:text-primary transition-colors text-xs font-semibold flex justify-between items-center w-full py-1.5 border-t border-dashed border-slate-100">
                    <span class="flex items-center gap-1"><i class="fa-regular fa-clock text-[10px]"></i> {{ dineinOrder.order_datetime }}</span>
                    <div
                      class="flex items-center justify-center w-6 h-6 rounded-full bg-slate-100 text-xs font-semibold transition-all duration-300 group-hover:bg-primary/10 group-hover:text-primary">
                      <i class="icon text-slate-500 fa-solid fa-chevron-down"></i>
                    </div>
                  </button>
                  <div style="height: 0px" class="overflow-hidden transition-all duration-500">
                    <div class="py-2.5">
                      <div v-for="item in dineinOrder.order_items" :key="item.id"
                        class="flex items-start gap-2.5 py-3 border-b border-dashed border-slate-100 last:border-none">
                        <h4 class="text-sm font-black text-primary bg-primary/5 px-2 py-0.5 rounded-md">{{ item.quantity }}x</h4>
                        <div class="flex-1">
                          <h5 class="text-sm font-bold text-slate-800">{{ item.item_name }}</h5>
                          <p v-if="item.item_variations.length !== 0"
                            class="text-[11px] font-semibold text-slate-400 capitalize mt-1">
                            <span v-for="(variation, index) in item.item_variations" :key="index" class="inline-block bg-slate-100 text-slate-600 px-1.5 py-0.5 rounded mr-1">
                              {{ variation.variation_name }}: {{ variation.name }}
                            </span>
                          </p>
                          <div class="flex items-center gap-1 mt-1 text-[11px]" v-if="item.item_extras.length > 0">
                            <span class="font-semibold text-indigo-600 bg-indigo-50 border border-indigo-100 px-1.5 py-0.5 rounded">
                              {{ $t('label.extras') }}:
                            </span>
                            <span class="text-slate-500 font-medium">
                              <span v-for="(extra, index) in item.item_extras" :key="index">
                                {{ extra.name }}<span v-if="index + 1 < item.item_extras.length">, </span>
                              </span>
                            </span>
                          </div>
                        </div>
                      </div>
                    </div>
                    <div class="pt-2">
                      <button v-if="dineinOrder.status === enums.orderStatusEnum.ACCEPT" type="button"
                        @click="orderStatus(dineinOrder.id, enums.orderStatusEnum.PREPARING)"
                        class="rounded-xl w-full h-10 flex justify-center items-center text-sm font-bold bg-primary text-white hover:opacity-90 active:scale-[0.98] transition-all shadow-md shadow-primary/20">
                        {{ $t("label.start_preparing") }}
                      </button>
                      <button v-if="dineinOrder.status === enums.orderStatusEnum.PREPARING" type="button"
                        @click="orderStatus(dineinOrder.id, enums.orderStatusEnum.PREPARED)"
                        class="rounded-xl w-full h-10 flex justify-center items-center text-sm font-bold bg-emerald-600 text-white hover:opacity-90 active:scale-[0.98] transition-all shadow-md shadow-emerald-600/20">
                        {{ $t("label.mark_done") }}
                      </button>
                    </div>
                  </div>
                </div>
              </div>
            </div>
            <div v-else class="p-8 text-center text-slate-400 text-sm">
              <i class="fa-regular fa-folder-open text-3xl mb-2 block"></i>
              No orders available
            </div>
          </div>

          <!-- Takeaway Card -->
          <div class="db-card rounded-2xl h-fit border border-gray-100 shadow-[0_4px_24px_rgba(0,0,0,0.02)] bg-white overflow-hidden">
            <div class="p-4 bg-slate-50/50 flex items-center justify-between" :class="takeawayOrders.length > 0 ? 'border-b border-slate-100' : ''">
              <h3 class="text-base font-bold text-slate-800 flex items-center gap-2">
                <i class="lab lab-waiter text-lg text-primary"></i>
                {{ $t("label.takeaway") }}
              </h3>
              <span class="px-2 py-0.5 rounded-md text-[10px] font-bold bg-primary/10 text-primary">
                {{ takeawayOrders.length }} Orders
              </span>
            </div>
            <div v-if="takeawayOrders.length > 0" class="p-4 flex flex-col gap-4">
              <div v-for="takeawayOrder in takeawayOrders" :key="takeawayOrder.id" class="w-full rounded-2xl border border-slate-100 overflow-hidden shadow-sm hover:shadow-md transition-shadow duration-200">
                <div class="py-3 px-4 w-full flex items-center justify-between bg-gradient-to-r from-purple-50/80 to-pink-50/40 border-b border-purple-100/40">
                  <div class="flex items-center gap-1.5 text-purple-700 font-bold">
                    <i class="lab lab-processing text-[16px] animate-spin-slow"></i>
                    <span class="text-sm">#{{ takeawayOrder.order_serial_no }}</span>
                  </div>
                  <span class="py-1 px-2.5 rounded-full text-[10px] font-bold leading-none capitalize border shadow-sm"
                    :class="takeawayOrder.status === enums.orderStatusEnum.PREPARED ? 'bg-emerald-50 text-emerald-700 border-emerald-200' : (takeawayOrder.status === enums.orderStatusEnum.ACCEPT ? 'bg-primary/10 text-primary border-primary/20' : 'bg-amber-50 text-amber-700 border-amber-200')">
                    {{ takeawayOrder.status === enums.orderStatusEnum.PREPARED ? $t("label.done") : (takeawayOrder.status === enums.orderStatusEnum.ACCEPT ? $t("label.confirmed") : takeawayOrder.status_name) }}
                  </span>
                </div>
                <div class="w-full pt-3 pb-4 px-4 bg-white">
                  <div class="flex flex-col gap-1 mb-3">
                    <p class="text-sm font-semibold text-slate-600">
                      {{ $t("label.token_no") }}: <span class="text-slate-800 font-bold bg-slate-100 px-2 py-0.5 rounded-md text-xs ml-1">{{ takeawayOrder.token ? takeawayOrder.token : $t("label.online") }}</span>
                    </p>
                  </div>
                  <button type="button" @click="openFilterSlide($event)"
                    class="filter group text-slate-400 hover:text-primary transition-colors text-xs font-semibold flex justify-between items-center w-full py-1.5 border-t border-dashed border-slate-100">
                    <span class="flex items-center gap-1"><i class="fa-regular fa-clock text-[10px]"></i> {{ takeawayOrder.order_datetime }}</span>
                    <div
                      class="flex items-center justify-center w-6 h-6 rounded-full bg-slate-100 text-xs font-semibold transition-all duration-300 group-hover:bg-primary/10 group-hover:text-primary">
                      <i class="icon text-slate-500 fa-solid fa-chevron-down"></i>
                    </div>
                  </button>
                  <div style="height: 0px" class="overflow-hidden transition-all duration-500">
                    <div class="py-2.5">
                      <div v-for="item in takeawayOrder.order_items" :key="item.id"
                        class="flex items-start gap-2.5 py-3 border-b border-dashed border-slate-100 last:border-none">
                        <h4 class="text-sm font-black text-primary bg-primary/5 px-2 py-0.5 rounded-md">{{ item.quantity }}x</h4>
                        <div class="flex-1">
                          <h5 class="text-sm font-bold text-slate-800">{{ item.item_name }}</h5>
                          <p v-if="item.item_variations.length !== 0"
                            class="text-[11px] font-semibold text-slate-400 capitalize mt-1">
                            <span v-for="(variation, index) in item.item_variations" :key="index" class="inline-block bg-slate-100 text-slate-600 px-1.5 py-0.5 rounded mr-1">
                              {{ variation.variation_name }}: {{ variation.name }}
                            </span>
                          </p>
                          <div class="flex items-center gap-1 mt-1 text-[11px]" v-if="item.item_extras.length > 0">
                            <span class="font-semibold text-indigo-600 bg-indigo-50 border border-indigo-100 px-1.5 py-0.5 rounded">
                              {{ $t('label.extras') }}:
                            </span>
                            <span class="text-slate-500 font-medium">
                              <span v-for="(extra, index) in item.item_extras" :key="index">
                                {{ extra.name }}<span v-if="index + 1 < item.item_extras.length">, </span>
                              </span>
                            </span>
                          </div>
                        </div>
                      </div>
                    </div>
                    <div class="pt-2">
                      <button v-if="takeawayOrder.status === enums.orderStatusEnum.ACCEPT" type="button"
                        @click="orderStatus(takeawayOrder.id, enums.orderStatusEnum.PREPARING)"
                        class="rounded-xl w-full h-10 flex justify-center items-center text-sm font-bold bg-primary text-white hover:opacity-90 active:scale-[0.98] transition-all shadow-md shadow-primary/20">
                        {{ $t("label.start_preparing") }}
                      </button>
                      <button v-if="takeawayOrder.status === enums.orderStatusEnum.PREPARING" type="button"
                        @click="orderStatus(takeawayOrder.id, enums.orderStatusEnum.PREPARED)"
                        class="rounded-xl w-full h-10 flex justify-center items-center text-sm font-bold bg-emerald-600 text-white hover:opacity-90 active:scale-[0.98] transition-all shadow-md shadow-emerald-600/20">
                        {{ $t("label.mark_done") }}
                      </button>
                    </div>
                  </div>
                </div>
              </div>
            </div>
            <div v-else class="p-8 text-center text-slate-400 text-sm">
              <i class="fa-regular fa-folder-open text-3xl mb-2 block"></i>
              No orders available
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>
<script>
import LoadingComponent from "../components/LoadingComponent";
import orderTypeEnum from "../../../enums/modules/orderTypeEnum";
import statusEnum from "../../../enums/modules/statusEnum";
import orderStatusEnum from "../../../enums/modules/orderStatusEnum";
import askEnum from "../../../enums/modules/askEnum";
import alertService from "../../../services/alertService";
import appService from "../../../services/appService";
import { Swiper, SwiperSlide } from "swiper/vue";


export default {
  name: "KitchenDisplaySystemComponent",
  components: {
    LoadingComponent,
    Swiper,
    SwiperSlide
  },
  data() {
    return {
      loading: {
        isActive: false,
      },
      props: {
        search: {
          paginate: 0,
          order_column: "id",
          order_by: "desc",
          order_serial_no: "",
          status: "",
        },
      },
      dineinOrders: [],
      takeawayOrders: [],
      enums: {
        statusEnum: statusEnum,
        orderTypeEnum: orderTypeEnum,
        orderStatusEnum: orderStatusEnum,
        askEnum: askEnum,
      },
      autoRefreshInterval: null,
    };
  },
  computed: {
    orders: function () {
      return this.$store.getters["kitchenDisplaySystemOrder/lists"];
    },
    orderItems: function () {
      return this.$store.getters["kitchenDisplaySystemOrder/orderItems"];
    },
  },
  mounted() {
    this.closeSidebar();
    this.items();
    this.list();
    this.startAutoRefresh();
  },
  methods: {
    startAutoRefresh() {
      if (this.$route.path.includes('kitchen-display-system')) {
        this.autoRefreshInterval = setInterval(() => {
          this.items();
          this.list(this.props.search.status);
        }, 30000);
      }
    },
    openFilterSlide(event) {
      return appService.openFilterSlide(event);
    },
    closeFilterSlide(event) {
      return appService.closeFilterSlide(event);
    },

    stopAutoRefresh() {
      if (this.autoRefreshInterval) {
        clearInterval(this.autoRefreshInterval);
        this.autoRefreshInterval = null;
      }
    },
    list: function (status = "") {
      if (status) {
        this.props.search.status = status;
      } else {
        this.props.search.status = "";
      }
      this.loading.isActive = true;
      this.$store
        .dispatch("kitchenDisplaySystemOrder/lists", this.props.search)
        .then((res) => {
          this.dineinOrders = res.data.data.filter(
            (item) => item.order_type === orderTypeEnum.DINING_TABLE
          );
          this.takeawayOrders = res.data.data.filter(
            (item) => item.order_type === orderTypeEnum.TAKEAWAY
          );

          this.loading.isActive = false;
        })
        .catch((err) => {
          this.loading.isActive = false;
        });
    },
    items: function () {
      this.loading.isActive = true;
      this.$store
        .dispatch("kitchenDisplaySystemOrder/orderItems")
        .then((res) => {
          this.loading.isActive = false;
        })
        .catch((err) => {
          this.loading.isActive = false;
        });
    },
    openSidebar: function () {
      document?.querySelector(".db-main")?.classList?.remove("expand");
      document?.querySelector(".db-sidebar")?.classList?.remove("active");
      const activeMenu = document.querySelector('.db-sidebar-nav-item.active');
      if (activeMenu) {
        activeMenu.classList.remove('active');
      }
      document?.querySelector('.db-sidebar-nav-menu')?.parentElement?.classList?.add('active');
    },
    closeSidebar: function () {
      document?.querySelector(".db-main")?.classList?.add("expand");
      document?.querySelector(".db-sidebar")?.classList?.add("active");
    },
    search: function () {
      if (typeof this.props.search.order_serial_no !== "undefined" && this.props.search.order_serial_no !== "") {
        this.list();
      } else {
        this.list();
      }
    },
    searchReset: function () {
      this.props.search.order_serial_no = "";
      this.list();
    },
    orderStatus: function (id, status) {
      try {
        this.loading.isActive = true;
        this.$store.dispatch("kitchenDisplaySystemOrder/changeStatus", {
          id: id,
          status: status,
        }).then((res) => {
          this.loading.isActive = false;
          alertService.successFlip(
            1,
            this.$t("label.status")
          );
          this.list();
          this.items();
        }).catch((err) => {
          this.loading.isActive = false;
          alertService.error(err.response.data.message);
        });
      } catch (err) {
        this.loading.isActive = false;
        alertService.error(err.response.data.message);
      }
    },
    toggleFilter(index) {
      if (this.expandedFilter === index) {
        this.expandedFilter = null; // Collapse if the same button is clicked
      } else {
        this.expandedFilter = index; // Expand the clicked button
      }
    },
  },
  beforeUnmount() {
    this.stopAutoRefresh();
    this.openSidebar();

  },
};
</script>

<style scoped>
/* Filter tab button custom design */
.filter-tab-btn {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    height: 44px;
    padding: 0 1.5rem;
    border-radius: 12px;
    font-weight: 700;
    transition: all 0.25s cubic-bezier(0.4, 0, 0.2, 1);
    background-color: #ffffff;
    border: 1px solid #e2e8f0;
    color: #475569;
    box-shadow: 0 1px 2px 0 rgba(0, 0, 0, 0.05);
    cursor: pointer;
}

.filter-tab-btn:hover {
    color: #696cff;
    border-color: rgba(105, 108, 255, 0.3);
    background-color: rgba(105, 108, 255, 0.05);
}

.filter-tab-btn.active {
    color: #ffffff !important;
    background-color: #696cff !important;
    border-color: #696cff !important;
    box-shadow: 0 4px 14px rgba(105, 108, 255, 0.35) !important;
}

/* Custom spin animation speed */
.animate-spin-slow {
    animation: spin 8s linear infinite;
}

@keyframes spin {
    from {
        transform: rotate(0deg);
    }
    to {
        transform: rotate(360deg);
    }
}
</style>