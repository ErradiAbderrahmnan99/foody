<!-- SalesSummaryComponent -->
<template>
  <LoadingComponent :props="loading" />
  <div class="col-12 xl:col-6">
    <div class="bg-white rounded-2xl border border-gray-100 shadow-sm hover:shadow-md transition-all duration-300">
      <div class="flex items-center justify-between px-6 py-4 border-b border-gray-100">
        <div class="flex items-center gap-3">
          <div class="w-10 h-10 rounded-xl bg-[#E0FFED] flex items-center justify-center">
            <i class="lab lab-sale-summary lab-font-size-20 !text-[#1AB759]"></i>
          </div>
          <h3 class="font-semibold text-gray-800 text-base">{{ $t('label.sales_summary') }}</h3>
        </div>
        <div id="sales-range" class="cursor-pointer flex items-center gap-2 bg-gray-50 hover:bg-gray-100 transition-colors px-3 py-2 rounded-xl custom-datepicker">
          <i class="lab lab-calendar lab-font-size-18 !text-[#1AB759]"></i>
          <Datepicker 
            hideInputIcon 
            autoApply 
            :enableTimePicker="false" 
            utc="false"
            @update:modelValue="salesSummary" 
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

      <div class="p-6">
        <div class="flex gap-6 mb-6">
          <div class="flex-1 bg-gradient-to-br from-[#E0FFED] to-[#F0FFF7] rounded-xl p-4">
            <div class="flex items-center gap-2.5 mb-1">
              <div class="w-8 h-8 rounded-lg bg-[#1AB759]/20 flex items-center justify-center">
                <i class="lab lab-sale-summary lab-font-size-16 !text-[#1AB759]"></i>
              </div>
              <h3 class="font-bold text-xl text-gray-900">{{ total_sales }}</h3>
            </div>
            <p class="text-xs text-gray-500 font-medium capitalize pl-0.5">{{ $t("label.total_sales") }}</p>
          </div>
          <div class="flex-1 bg-gradient-to-br from-[#F5F3FF] to-[#FAF9FF] rounded-xl p-4">
            <div class="flex items-center gap-2.5 mb-1">
              <div class="w-8 h-8 rounded-lg bg-[#8262FE]/20 flex items-center justify-center">
                <i class="lab lab-sale-summary lab-font-size-16 !text-[#8262FE]"></i>
              </div>
              <h3 class="font-bold text-xl text-gray-900">{{ avg_per_day }}</h3>
            </div>
            <p class="text-xs text-gray-500 font-medium capitalize pl-0.5">{{ $t("label.avg_sales_per_day") }}</p>
          </div>
        </div>
        <div id="area-chart"></div>
      </div>
    </div>
  </div>
</template>

<script>
import LoadingComponent from "../components/LoadingComponent";
import Datepicker from "@vuepic/vue-datepicker";
import "@vuepic/vue-datepicker/dist/main.css";
import { endOfMonth, startOfMonth, subMonths } from 'date-fns';

export default {
  name: "SalesSummaryComponent",
  components: { LoadingComponent, Datepicker },
  data() {
    return {
      loading: { isActive: false },
      date: null,
      first_date: null,
      last_date: null,
      total_sales: null,
      avg_per_day: null,
      presetRanges: [
        { label: 'Today', range: [new Date(), new Date()] },
        { label: 'This month', range: [startOfMonth(new Date()), endOfMonth(new Date())] },
        { label: 'Last month', range: [startOfMonth(subMonths(new Date(), 1)), endOfMonth(subMonths(new Date(), 1))] },
      ]
    };
  },
  mounted() {
    const date = new Date();
    const startDate = new Date(date.getFullYear(), date.getMonth(), 1);
    const endDate = new Date(date.getFullYear(), date.getMonth() + 1, 0);
    this.date = [startDate, endDate];
    this.salesSummary();
  },
  methods: {
    salesSummary: function (e) {
      let date = { first_date: '', last_date: '' };
      if (e) {
        this.first_date = e[0]; this.last_date = e[1];
        date.first_date = e[0]; date.last_date = e[1];
      }
      this.loading.isActive = true;
      this.$store.dispatch("dashboard/salesSummary", date).then((res) => {
        this.total_sales = res.data.data.total_sales;
        this.avg_per_day = res.data.data.avg_per_day;
        let options = {
          series: [{ name: this.$t('label.sales'), data: res.data.data.per_day_sales }],
          chart: {
            type: 'area', height: 250, fontFamily: 'inherit',
            parentHeightOffset: 0, zoom: { enabled: false }, toolbar: { show: false },
          },
          xaxis: { tooltip: { enabled: false }, axisBorder: { show: false } },
          stroke: { width: 3, lineCap: "round", curve: "smooth" },
          colors: ["#1AB759"],
          grid: { show: false },
          yaxis: { show: false },
          dataLabels: { enabled: false },
        };
        let chart = new ApexCharts(document.querySelector("#area-chart"), options);
        chart.render();
        if (date.first_date !== '' && date.last_date !== '') {
          chart.updateSeries([{ data: res.data.data.per_day_sales }]);
        }
        this.loading.isActive = false;
      }).catch(() => { this.loading.isActive = false; });
    },
  }
}
</script>