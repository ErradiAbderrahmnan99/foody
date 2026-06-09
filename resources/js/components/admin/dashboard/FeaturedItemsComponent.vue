<!-- FeaturedItemsComponent -->
<template>
  <LoadingComponent :props="loading" />
  <div class="col-12 xl:col-6">
    <div class="bg-white rounded-2xl border border-gray-100 shadow-sm hover:shadow-md transition-all duration-300">
      <div class="flex items-center gap-3 px-6 py-4 border-b border-gray-100">
        <div class="w-10 h-10 rounded-xl bg-[#FFF9E6] flex items-center justify-center">
          <i class="lab lab-total-menu-items lab-font-size-20 !text-[#D97706]"></i>
        </div>
        <h3 class="font-semibold text-gray-800 text-base">{{ $t('label.featured_items') }}</h3>
      </div>
      <div class="p-6">
        <ul class="grid grid-cols-2 sm:grid-cols-4 gap-4">
          <li 
            class="group w-full rounded-xl border border-gray-100 shadow-sm overflow-hidden transition-all duration-300 hover:shadow-lg hover:-translate-y-1 hover:border-[#1AB759]/30" 
            v-if="featured_items.length > 0"
            v-for="featured_item in featured_items" 
            :key="featured_item"
          >
            <div class="relative overflow-hidden">
              <img 
                class="w-full h-28 object-cover transform group-hover:scale-105 transition-transform duration-300" 
                :src="featured_item.thumb" 
                alt="product"
              >
              <div class="absolute inset-0 bg-gradient-to-t from-black/20 to-transparent opacity-0 group-hover:opacity-100 transition-opacity duration-300"></div>
            </div>
            <div class="p-2.5">
              <h4 class="text-xs font-semibold text-gray-700 capitalize truncate">{{ featured_item.name }}</h4>
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
  name: "FeaturedItemsComponent",
  components: { LoadingComponent },
  data() {
    return {
      loading: { isActive: false },
      featured_items: {},
    };
  },
  mounted() { this.featuredItems(); },
  methods: {
    featuredItems: function () {
      this.loading.isActive = true;
      this.$store.dispatch('dashboard/featuredItems').then(res => {
        this.featured_items = res.data.data;
        this.loading.isActive = false;
      }).catch(() => { this.loading.isActive = false; });
    },
  },
}
</script>