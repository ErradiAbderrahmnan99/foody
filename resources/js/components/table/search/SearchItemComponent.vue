<template>
    <LoadingComponent :props="loading" />
    <section class="pb-16 pt-8 min-h-screen bg-[#0F172A] text-white">
        <div class="container mx-auto px-4 sm:px-6 max-w-[1024px]">
            <div class="flex gap-4 flex-col sm:flex-row items-center justify-between mb-6">
                <h2 class="capitalize text-[26px] leading-[40px] font-semibold text-center sm:text-left text-primary">
                    {{ props.search.name }}
                </h2>
                <div class="flex items-center gap-3" v-if="props.search.name">
                    <button type="button" class="lab lab-row-vertical lab-font-size-20 text-xl"
                        v-on:click="itemProps.design = itemDesignEnum.LIST"
                        :class="itemProps.design === itemDesignEnum.LIST ? 'text-primary' : 'text-[#94A3B8]'"></button>
                    <button type="button" class="lab lab-element-3 lab-font-size-20 text-xl"
                        v-on:click="itemProps.design = itemDesignEnum.GRID"
                        :class="itemProps.design === itemDesignEnum.GRID ? 'text-primary' : 'text-[#94A3B8]'"></button>
                </div>
            </div>
            <ItemComponent :items="items" :type="itemProps.type" :design="itemProps.design" v-if="items.length > 0" />

            <div class="mt-20 flex flex-col items-center justify-center" v-else>
                <div class="max-w-[200px] mx-auto opacity-70 mb-8">
                    <img class="w-full drop-shadow-2xl" :src="setting.image_order_not_found" alt="image_order_not_found">
                </div>
                <span class="text-base font-medium text-[#94A3B8] bg-[#1E293B] px-6 py-3 rounded-2xl border border-[#334155] mb-6 block text-center">
                    {{ $t('message.no_items_found') }}
                </span>
                <router-link :to="{ name: 'table.menu.table', params: { slug: this.$route.params.slug } }"
                    class="block w-full mx-auto max-w-[250px] py-3.5 px-4 rounded-xl capitalize font-bold text-[15px] text-center bg-primary text-white hover:opacity-90 active:scale-[0.98] transform transition-all duration-200 shadow-lg shadow-primary/25">
                    {{ $t('button.go_home') }}
                </router-link>
            </div>
        </div>
    </section>
</template>

<script>
import ItemComponent from "../components/ItemComponent";
import itemDesignEnum from "../../../enums/modules/itemDesignEnum";
import statusEnum from "../../../enums/modules/statusEnum";
import alertService from "../../../services/alertService";
import LoadingComponent from "../components/LoadingComponent";

export default {
    name: "SearchItemComponent",
    components: {
        ItemComponent,
        LoadingComponent
    },
    data() {
        return {
            loading: {
                isActive: false,
            },
            itemDesignEnum: itemDesignEnum,
            items: {},
            itemProps: {
                design: itemDesignEnum.LIST,
                type: null,
            },
            props: {
                search: {
                    paginate: 0,
                    order_column: 'id',
                    order_type: 'asc',
                    name: "",
                    status: statusEnum.ACTIVE,
                }
            },
        };
    },
    computed: {
        setting: function () {
            return this.$store.getters['frontendSetting/lists'];
        }
    },
    mounted() {
        if (typeof this.$route.query.s !== "undefined" && this.$route.query.s !== "") {
            this.props.search.name = this.$route.query.s;
            this.loading.isActive = true;
            this.$store.dispatch("frontendItem/lists", this.props.search).then((res) => {
                this.items = res.data.data;
                this.loading.isActive = false;
            }).catch((err) => {
                this.loading.isActive = false;
            });
        }
    },
    methods: {
        searItems: function () {
            if (typeof this.$route.query.s !== "undefined" && this.$route.query.s !== "") {
                this.props.search.name = this.$route.query.s;
                this.loading.isActive = true;
                this.$store.dispatch("frontendItem/lists", this.props.search).then((res) => {
                    this.items = res.data.data;
                    this.loading.isActive = false;
                }).catch((err) => {
                    this.loading.isActive = false;
                    alertService.error(err.response.data.message);
                });
            }
        }

    },
    watch: {
        $route() {
            this.searItems();
        }
    }
};
</script>