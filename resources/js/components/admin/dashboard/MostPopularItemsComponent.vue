<!-- MostPopularItemsComponent -->
<template>
  <LoadingComponent :props="loading" />
  <div class="col-12 xl:col-6">
    <div class="bg-white rounded-2xl border border-gray-100 shadow-sm hover:shadow-md transition-all duration-300">
      <div class="flex items-center gap-3 px-6 py-4 border-b border-gray-100">
        <div class="w-10 h-10 rounded-xl bg-[#EEECFF] flex items-center justify-center">
          <i class="lab lab-total-orders lab-font-size-20 !text-[#8262FE]"></i>
        </div>
        <h3 class="font-semibold text-gray-800 text-base">{{ $t('label.most_popular_items') }}</h3>
      </div>
      <div class="p-6">
        <ul class="grid grid-cols-1 sm:grid-cols-2 gap-4">
          <li 
            class="group flex rounded-xl border border-gray-100 shadow-sm overflow-hidden transition-all duration-300 hover:shadow-lg hover:-translate-y-0.5 hover:border-[#8262FE]/30" 
            v-if="popular_items.length > 0"
            v-for="popular_item in popular_items" 
            :key="popular_item"
          >
            <div class="relative overflow-hidden w-24 shrink-0">
              <img 
                class="w-24 h-full object-cover transform group-hover:scale-105 transition-transform duration-300" 
                :src="popular_item.thumb" 
                alt="product"
              >
            </div>
            <div class="py-3 px-4 flex flex-col justify-between overflow-hidden flex-1 bg-gradient-to-r from-white to-gray-50/50">
              <h4 class="text-sm overflow-hidden whitespace-nowrap text-ellipsis font-semibold text-gray-800 capitalize">
                {{ popular_item.name }}
              </h4>
              <span class="inline-flex items-center gap-1">
                <span class="w-1.5 h-1.5 rounded-full bg-[#1AB759]"></span>
                <h5 class="text-xs font-medium capitalize text-[#1AB759]">{{ popular_item.category_name }}</h5>
              </span>
              <h6 class="text-sm font-bold text-gray-900">{{ popular_item.currency_price }}</h6>
            </div>
          </li>
        </ul>
      </div>
    </div>
  </div>
</template>

<script>
import LoadingComponent from "../components/LoadingComponent";
export default {
  name: "MostPopularItemsComponent",
  components: { LoadingComponent },
  data() {
    return {
      loading: { isActive: false },
      popular_items: {},
    };
  },
  mounted() { this.popularItems(); },
  methods: {
    popularItems: function () {
      this.loading.isActive = true;
      this.$store.dispatch('dashboard/mostPopularItems').then(res => {
        this.popular_items = res.data.data;
        this.loading.isActive = false;
      }).catch(() => { this.loading.isActive = false; });
    },
  },
}
</script>