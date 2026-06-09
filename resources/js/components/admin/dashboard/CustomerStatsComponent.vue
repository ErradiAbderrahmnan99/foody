<!-- CustomerStatsComponent -->
<template>
  <LoadingComponent :props="loading" />
  <div class="col-12 xl:col-6">
    <div class="bg-white rounded-2xl border border-gray-100 shadow-sm hover:shadow-md transition-all duration-300">
      <div class="flex items-center justify-between px-6 py-4 border-b border-gray-100">
        <div class="flex items-center gap-3">
          <div class="w-10 h-10 rounded-xl bg-[#E0FFED] flex items-center justify-center">
            <i class="lab lab-total-orders lab-font-size-20 !text-[#1AB759]"></i>
          </div>
          <h3 class="font-semibold text-gray-800 text-base">{{ $t('label.order_stats') }}</h3>
        </div>
        <div id="customer-range" class="cursor-pointer flex items-center gap-2 bg-gray-50 hover:bg-gray-100 transition-colors px-3 py-2 rounded-xl custom-datepicker">
          <i class="lab lab-calendar lab-font-size-18 !text-[#1AB759]"></i>
          <Datepicker 
            hideInputIcon 
            autoApply 
            :enableTimePicker="false" 
            utc="false" 
            @update:modelValue="customerStates"
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
        <div id="column-chart"></div>
      </div>
    </div>
  </div>
</template>

<script>
import LoadingComponent from "../components/LoadingComponent";
import Datepicker from "@vuepic/vue-datepicker";
import "@vuepic/vue-datepicker/dist/main.css";
import { ref, onMounted } from 'vue';
import { endOfMonth, endOfYear, startOfMonth, startOfYear, subMonths, subYears } from 'date-fns';

export default {
  name: "CustomerStatsComponent",
  components: { LoadingComponent, Datepicker },
  data() {
    return {
      loading: { isActive: false },
      date: null,
      first_date: null,
      last_date: null,
      presetRanges: [
        { label: 'Today', range: [new Date(), new Date()] },
        { label: 'This month', range: [startOfMonth(new Date()), endOfMonth(new Date())] },
        {
          label: 'Last month',
          range: [startOfMonth(subMonths(new Date(), 1)), endOfMonth(subMonths(new Date(), 1))],
        },
        { label: 'This year', range: [startOfYear(new Date()), endOfYear(new Date())] },
        {
          label: 'Last year',
          range: [startOfYear(subYears(new Date(), 1)), endOfYear(subYears(new Date(), 1))]
        },
      ]
    };
  },
  mounted() {
    const date = new Date();
    const startDate = new Date(date.getFullYear(), date.getMonth(), 1);
    const endDate = new Date(date.getFullYear(), date.getMonth() + 1, 0);
    this.date = [startDate, endDate];
    this.customerStates();
  },
  methods: {
    customerStates: function (e) {
      let date = { first_date: '', last_date: '' };
      if (e) {
        this.first_date = e[0];
        this.last_date = e[1];
        date.first_date = e[0];
        date.last_date = e[1];
      }
      this.loading.isActive = true;
      this.$store.dispatch("dashboard/customerStates", date).then((res) => {
        let options = {
          series: [{ name: this.$t('menu.customers'), data: res.data.data.total_customers }],
          chart: {
            type: 'bar', height: 300, parentHeightOffset: 0,
            zoom: { enabled: false }, toolbar: { show: false },
          },
          plotOptions: { bar: { horizontal: false, columnWidth: '40%', endingShape: 'rounded' } },
          stroke: { show: true, width: 2, colors: ['#1AB759'] },
          xaxis: { categories: res.data.data.times },
          fill: { opacity: 1 },
          tooltip: { style: { fontSize: '14px', fontFamily: 'inherit' } },
          colors: ['#1AB759'],
          grid: { show: false },
          yaxis: { show: false },
          dataLabels: { enabled: false },
        };
        let chart = new ApexCharts(document.querySelector("#column-chart"), options);
        chart.render();
        if (date.first_date !== '' && date.last_date !== '') {
          chart.updateSeries([{ data: res.data.data.total_customers }]);
        }
        this.loading.isActive = false;
      }).catch(() => { this.loading.isActive = false; });
    },
  },
}
</script>