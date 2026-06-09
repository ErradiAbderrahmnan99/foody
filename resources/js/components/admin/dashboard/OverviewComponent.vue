<!-- OverviewComponent -->
<template>
  <LoadingComponent :props="loading" />
  <div class="mb-9">
    <div class="flex items-center justify-between mb-6">
      <div>
        <p class="text-sm text-gray-500 mb-0.5">{{ $t("menu.dashboard") }}</p>
        <h4 class="font-bold text-2xl text-gray-900 capitalize">{{ $t("menu.overview") }}</h4>
      </div>
      <div class="relative cursor-pointer custom-datepicker">
        <div class="flex items-center gap-2 bg-white border border-gray-200 hover:border-[#1AB759] transition-colors px-4 py-2.5 rounded-xl shadow-sm">
          <i class="lab lab-calendar lab-font-size-18 !text-[#1AB759]"></i>
          <Datepicker 
            hideInputIcon 
            autoApply 
            :enableTimePicker="false" 
            utc="false"
            @update:modelValue="handleDate" 
            v-model="date" 
            range 
            :preset-ranges="presetRanges"
            inputClassName="!text-sm !text-gray-600 !font-medium cursor-pointer"
          >
            <template #yearly="{ label, range, presetDateRange }">
              <span @click="presetDateRange(range)">{{ label }}</span>
            </template>
          </Datepicker>
        </div>
      </div>
    </div>

    <div class="row">
      <!-- Total Sales -->
      <div class="col-12 sm:col-6 xl:col-3">
        <div class="relative overflow-hidden p-5 rounded-2xl bg-gradient-to-br from-[#1AB759] to-[#13924A] shadow-sm hover:shadow-lg transition-all duration-300 hover:-translate-y-0.5">
          <div class="absolute top-0 right-0 w-24 h-24 bg-white/10 rounded-full -translate-y-8 translate-x-8"></div>
          <div class="absolute bottom-0 right-4 w-16 h-16 bg-white/10 rounded-full translate-y-6"></div>
          <div class="relative">
            <div class="w-11 h-11 rounded-xl bg-white/20 flex items-center justify-center mb-4">
              <i class="lab lab-total-sale lab-font-size-22 !text-white"></i>
            </div>
            <h4 class="font-bold text-2xl text-white mb-1">{{ total_sales }}</h4>
            <h3 class="font-medium text-sm text-white/80 capitalize">{{ $t('label.total_sales') }}</h3>
          </div>
        </div>
      </div>

      <!-- Total Orders -->
      <div class="col-12 sm:col-6 xl:col-3">
        <div class="relative overflow-hidden p-5 rounded-2xl bg-gradient-to-br from-[#8262FE] to-[#6344E0] shadow-sm hover:shadow-lg transition-all duration-300 hover:-translate-y-0.5">
          <div class="absolute top-0 right-0 w-24 h-24 bg-white/10 rounded-full -translate-y-8 translate-x-8"></div>
          <div class="absolute bottom-0 right-4 w-16 h-16 bg-white/10 rounded-full translate-y-6"></div>
          <div class="relative">
            <div class="w-11 h-11 rounded-xl bg-white/20 flex items-center justify-center mb-4">
              <i class="lab lab-total-orders lab-font-size-22 !text-white"></i>
            </div>
            <h4 class="font-bold text-2xl text-white mb-1">{{ total_orders }}</h4>
            <h3 class="font-medium text-sm text-white/80 capitalize">{{ $t('label.total_orders') }}</h3>
          </div>
        </div>
      </div>

      <!-- Total Customers -->
      <div class="col-12 sm:col-6 xl:col-3">
        <div class="relative overflow-hidden p-5 rounded-2xl bg-gradient-to-br from-[#1772FF] to-[#0D5BD4] shadow-sm hover:shadow-lg transition-all duration-300 hover:-translate-y-0.5">
          <div class="absolute top-0 right-0 w-24 h-24 bg-white/10 rounded-full -translate-y-8 translate-x-8"></div>
          <div class="absolute bottom-0 right-4 w-16 h-16 bg-white/10 rounded-full translate-y-6"></div>
          <div class="relative">
            <div class="w-11 h-11 rounded-xl bg-white/20 flex items-center justify-center mb-4">
              <i class="lab lab-total-customers lab-font-size-22 !text-white"></i>
            </div>
            <h4 class="font-bold text-2xl text-white mb-1">{{ total_customers }}</h4>
            <h3 class="font-medium text-sm text-white/80 capitalize">{{ $t('label.total_customers') }}</h3>
          </div>
        </div>
      </div>

      <!-- Total Menu Items -->
      <div class="col-12 sm:col-6 xl:col-3">
        <div class="relative overflow-hidden p-5 rounded-2xl bg-gradient-to-br from-[#D97706] to-[#B45309] shadow-sm hover:shadow-lg transition-all duration-300 hover:-translate-y-0.5">
          <div class="absolute top-0 right-0 w-24 h-24 bg-white/10 rounded-full -translate-y-8 translate-x-8"></div>
          <div class="absolute bottom-0 right-4 w-16 h-16 bg-white/10 rounded-full translate-y-6"></div>
          <div class="relative">
            <div class="w-11 h-11 rounded-xl bg-white/20 flex items-center justify-center mb-4">
              <i class="lab lab-total-menu-items lab-font-size-22 !text-white"></i>
            </div>
            <h4 class="font-bold text-2xl text-white mb-1">{{ total_menu_items }}</h4>
            <h3 class="font-medium text-sm text-white/80 capitalize">{{ $t('label.total_menu_items') }}</h3>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import LoadingComponent from "../components/LoadingComponent";
import Datepicker from "@vuepic/vue-datepicker";
import "@vuepic/vue-datepicker/dist/main.css";
import { ref } from 'vue';
import { endOfMonth, endOfYear, startOfMonth, startOfYear, subMonths, subYears } from 'date-fns';
export default {
  name: "OverviewComponent",
  components: { LoadingComponent, Datepicker },
  data() {
    return {
      loading: { isActive: false },
      date: null,
      first_date: null,
      last_date: null,
      total_sales: null,
      total_orders: null,
      total_customers: null,
      total_menu_items: null,
      presetRanges: [
        { label: 'Today', range: [new Date(), new Date()] },
        { label: 'This month', range: [startOfMonth(new Date()), endOfMonth(new Date())] },
        { label: 'Last month', range: [startOfMonth(subMonths(new Date(), 1)), endOfMonth(subMonths(new Date(), 1))] },
        { label: 'This year', range: [startOfYear(new Date()), endOfYear(new Date())] },
        { label: 'Last year', range: [startOfYear(subYears(new Date(), 1)), endOfYear(subYears(new Date(), 1))] },
      ]
    };
  },
  mounted() {
    const date = new Date();
    const startDate = new Date(date.getFullYear(), date.getMonth(), 1);
    const endDate = new Date(date.getFullYear(), date.getMonth() + 1, 0);
    this.date = [startDate, endDate];
    this.totalSales();
    this.totalOrders();
    this.totalCustomers();
    this.totalMenuItems();
  },
  methods: {
    handleDate: function (e) {
      if (e) {
        this.first_date = e[0]; this.last_date = e[1];
      } else {
        this.first_date = null; this.last_date = null;
      }
      this.totalSales(); this.totalOrders(); this.totalCustomers(); this.totalMenuItems();
    },
    totalSales: function () {
      this.loading.isActive = true;
      this.$store.dispatch("dashboard/totalSales", { first_date: this.first_date, last_date: this.last_date })
        .then((res) => { this.total_sales = res.data.data.total_sales; this.loading.isActive = false; })
        .catch(() => { this.loading.isActive = false; });
    },
    totalOrders: function () {
      this.loading.isActive = true;
      this.$store.dispatch("dashboard/totalOrders", { first_date: this.first_date, last_date: this.last_date })
        .then((res) => { this.total_orders = res.data.data.total_orders; this.loading.isActive = false; })
        .catch(() => { this.loading.isActive = false; });
    },
    totalCustomers: function () {
      this.loading.isActive = true;
      this.$store.dispatch("dashboard/totalCustomers", { first_date: this.first_date, last_date: this.last_date })
        .then((res) => { this.total_customers = res.data.data.total_customers; this.loading.isActive = false; })
        .catch(() => { this.loading.isActive = false; });
    },
    totalMenuItems: function () {
      this.loading.isActive = true;
      this.$store.dispatch("dashboard/totalMenuItems", { first_date: this.first_date, last_date: this.last_date })
        .then((res) => { this.total_menu_items = res.data.data.total_menu_items; this.loading.isActive = false; })
        .catch(() => { this.loading.isActive = false; });
    },
  },
}
</script>