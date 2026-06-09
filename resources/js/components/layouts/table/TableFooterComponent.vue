<template>
    <LoadingComponent :props="loading" />

    <footer class="bg-[#0F172A] border-t border-[#334155]">
        <div class="container mx-auto px-4 sm:px-6 lg:px-8">
            <div class="flex flex-col-reverse md:flex-row items-center justify-between gap-4 py-8">
                <p class="text-sm text-[#94A3B8] font-medium tracking-wide">
                    {{ setting.site_copyright }}
                </p>
                <nav v-if="pages.length > 0" class="flex flex-wrap justify-center items-center gap-x-6 gap-y-2">
                    <router-link v-for="page in pages" :key="page.slug" 
                        class="text-sm capitalize font-medium text-[#E2E8F0] hover:text-primary transition-colors duration-200"
                        :to="{ name: 'table.page', params: { slug: this.$route.params.slug, pageSlug: page.slug } }">
                        {{ page.title }}
                    </router-link>
                </nav>
            </div>
        </div>
    </footer>
</template>

<script>
import statusEnum from "../../../enums/modules/statusEnum";
import menuSectionEnum from "../../../enums/modules/menuSectionEnum";
import LoadingComponent from "../../frontend/components/LoadingComponent";

export default {
    name: "TableFooterComponent",
    components: { LoadingComponent },
    data() {
        return { loading: { isActive: false } }
    },
    computed: {
        setting: function () { return this.$store.getters['frontendSetting/lists']; },
        pages: function () { return this.$store.getters['frontendPage/lists']; }
    },
    mounted() {
        this.loading.isActive = true;
        this.$store.dispatch("frontendPage/lists", {
            paginate: 0, order_column: "id", order_type: "asc",
            menu_section_id: menuSectionEnum.FOOTER, status: statusEnum.ACTIVE
        }).then(res => { this.loading.isActive = false; }).catch((err) => { this.loading.isActive = false; });
    }
}
</script>