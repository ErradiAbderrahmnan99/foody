<template>
    <LoadingComponent :props="loading" />

    <header class="bg-[#1E293B] border-b border-[#334155] sticky top-0 z-50 transition-all duration-300" ref="ffHeader">
        <div class="container flex flex-col lg:flex-row items-center justify-between py-3">
            <div class="w-full flex items-center justify-between gap-3 xl:gap-8 lg:justify-start lg:w-fit">
                <router-link :to="{ name: 'table.menu.table', params: { slug: this.$route.params.slug } }"
                    class="flex-shrink-0 transition-transform hover:scale-105">
                    <img class="w-28 sm:w-40 drop-shadow-md" :src="setting.theme_logo" alt="logo">
                </router-link>

                <div class="flex items-center gap-2 lg:hidden">
                    <div v-if="setting.site_language_switch === enums.activityEnum.ENABLE"
                        class="block relative dropdown-group w-full sm:w-fit">
                        <button
                            class="flex items-center justify-center gap-1.5 w-fit rounded-xl capitalize text-sm font-medium h-9 px-3 border transition-all text-[#E2E8F0] bg-[#0F172A] border-[#334155] hover:border-[#475569] dropdown-btn">
                            <img :src="language.image" alt="flag" class="w-4 h-4 rounded-full object-cover">
                            <span class="whitespace-nowrap">{{ language.name }}</span>
                        </button>
                        <ul v-if="languages.length > 0"
                            class="p-2 min-w-[150px] rounded-xl shadow-2xl absolute top-12 right-0 z-10 border border-[#334155] bg-[#1E293B] transition-all duration-300 origin-top scale-y-0 dropdown-list">
                            <li @click="changeLanguage(language.id, language.code)" v-for="language in languages" :key="language.id"
                                class="flex items-center gap-2 py-2 px-3 rounded-lg cursor-pointer hover:bg-[#334155] transition-colors">
                                <img :src="language.image" alt="flag" class="w-4 h-4 rounded-full object-cover">
                                <span class="text-[#E2E8F0] capitalize text-sm font-medium">{{ language.name }}</span>
                            </li>
                        </ul>
                    </div>

                    <button @click.prevent="openCanvas('cart')" type="button"
                        class="webcart flex items-center justify-center gap-2 w-fit rounded-xl capitalize font-semibold h-9 px-3.5 transition-all text-white bg-primary hover:opacity-90 shadow-lg shadow-primary/20">
                        <i class="fa-solid fa-bag-shopping text-sm"></i>
                        <span class="whitespace-nowrap text-sm">
                            {{ currencyFormat(subtotal, setting.site_digit_after_decimal_point, setting.site_default_currency_symbol, setting.site_currency_position) }}
                        </span>
                    </button>
                </div>
            </div>

            <div class="flex flex-col items-center justify-end gap-4 w-full mt-4 lg:flex-row lg:w-fit lg:mt-0">
                <form @submit.prevent="search"
                    class="header-search-group group flex items-center justify-center border border-[#334155] gap-2 px-3 w-full lg:w-64 h-10 rounded-xl transition-all bg-[#0F172A] focus-within:ring-2 focus-within:ring-primary focus-within:border-transparent shadow-inner">
                    <button type="submit" class="text-[#94A3B8] group-focus-within:text-primary transition-colors">
                        <i class="lab lab-search-normal text-lg"></i>
                    </button>
                    <input type="search" v-model="searchItem" :placeholder="$t('button.search')"
                        class="header-search-field w-full h-full bg-transparent border-none text-sm appearance-none text-[#E2E8F0] placeholder-[#475569] focus:outline-none focus:ring-0">
                    <button v-if="searchItem" type="button" @click.prevent="searchReset"
                        class="transition text-red-400 hover:text-red-300">
                        <i class="lab lab-close-circle-line text-lg"></i>
                    </button>
                </form>

                <div v-if="setting.site_language_switch === enums.activityEnum.ENABLE"
                    class="hidden lg:block relative dropdown-group w-full sm:w-fit">
                    <button
                        class="flex items-center justify-center gap-1.5 w-fit rounded-xl capitalize text-sm font-medium h-10 px-3.5 border transition-all text-[#E2E8F0] bg-[#0F172A] border-[#334155] hover:border-[#475569] dropdown-btn">
                        <img :src="language.image" alt="flag" class="w-4 h-4 rounded-full object-cover">
                        <span class="whitespace-nowrap">{{ language.name }}</span>
                    </button>
                    <ul v-if="languages.length > 0"
                        class="p-2 min-w-[150px] rounded-xl shadow-2xl absolute top-12 right-0 z-10 border border-[#334155] bg-[#1E293B] transition-all duration-300 origin-top scale-y-0 dropdown-list">
                        <li @click="changeLanguage(language.id, language.code)" v-for="language in languages" :key="language.id"
                            class="flex items-center gap-2 py-2 px-3 rounded-lg cursor-pointer hover:bg-[#334155] transition-colors">
                            <img :src="language.image" alt="flag" class="w-4 h-4 rounded-full object-cover">
                            <span class="text-[#E2E8F0] capitalize text-sm font-medium">{{ language.name }}</span>
                        </li>
                    </ul>
                </div>

                <button @click.prevent="openCanvas('cart')"
                    class="webcart hidden lg:flex items-center justify-center gap-2 w-fit rounded-xl capitalize font-semibold h-10 px-4 transition-all text-white bg-primary hover:opacity-90 active:scale-95 shadow-lg shadow-primary/20">
                    <i class="fa-solid fa-bag-shopping text-sm"></i>
                    <span class="whitespace-nowrap">
                        {{ currencyFormat(subtotal, setting.site_digit_after_decimal_point, setting.site_default_currency_symbol, setting.site_currency_position) }}
                    </span>
                </button>
            </div>
        </div>
    </header>
</template>

<script>
import statusEnum from "../../../enums/modules/statusEnum";
import appService from "../../../services/appService";
import LoadingComponent from "../../frontend/components/LoadingComponent";
import activityEnum from "../../../enums/modules/activityEnum";

export default {
    name: "TableNavbarComponent",
    components: { LoadingComponent },
    data() {
        return {
            loading: { isActive: false },
            searchItem: "",
            enums: { activityEnum: activityEnum },
            languageProps: { paginate: 0, order_column: "id", order_type: "asc", status: statusEnum.ACTIVE }
        }
    },
    computed: {
        setting: function () { return this.$store.getters['frontendSetting/lists']; },
        language: function () { return this.$store.getters['frontendLanguage/show']; },
        languages: function () { return this.$store.getters['frontendLanguage/lists']; },
        subtotal: function () { return this.$store.getters['tableCart/subtotal']; }
    },
    mounted() {
        window.addEventListener('scroll', () => {
            const resetRoutes = ['table.tableOrder.details', 'table.page', 'table.checkout'];
            if (this.$refs.ffHeader) {
                if (!resetRoutes.includes(this.$route.name)) {
                    if (window.scrollY > 0) {
                        this.$refs.ffHeader.classList.add('shadow-xl', 'bg-opacity-95', 'backdrop-blur-md');
                    } else {
                        this.$refs.ffHeader.classList.remove('shadow-xl', 'bg-opacity-95', 'backdrop-blur-md');
                    }
                }
            }
        });

        this.loading.isActive = true;
        this.$store.dispatch('frontendSetting/lists').then(res => {
            this.defaultLanguage = res.data.data.site_default_language;
            const globalState = this.$store.getters['globalState/lists'];
            if (globalState.language_id > 0) { this.defaultLanguage = globalState.language_id; }
            this.$store.dispatch('frontendLanguage/lists', this.languageProps).then().catch();
            this.$store.dispatch('frontendLanguage/show', this.defaultLanguage).then(res => {
                this.$i18n.locale = res.data.data.code;
                this.$store.dispatch("globalState/init", { language_code: res.data.data.code });
            }).catch();
            window.setTimeout(() => {
                this.$store.dispatch('tableDiningTable/show', this.$route.params.slug).then(res => {
                    this.$store.dispatch('tableCart/initTable', res.data.data);
                }).catch((err) => { });
            }, 300);
            this.loading.isActive = false;
        }).catch((err) => { this.loading.isActive = false; });
    },
    methods: {
        changeLanguage: function (id, code) {
            this.defaultLanguage = id;
            this.$store.dispatch("globalState/set", { language_id: id, language_code: code }).then(res => {
                this.$store.dispatch('frontendLanguage/show', id).then(res => {
                    this.$i18n.locale = res.data.data.code;
                }).catch();
            }).catch();
        },
        currencyFormat(amount, decimal, currency, position) { return appService.currencyFormat(amount, decimal, currency, position); },
        search: function () {
            if (typeof this.searchItem !== "undefined" && this.searchItem !== "") {
                this.$router.push({ name: "table.search", query: { s: this.searchItem } });
                this.searchItem = "";
            }
        },
        searchReset: function () { this.searchItem = ""; },
        openCanvas: function (id) { return appService.openCanvas(id); },
    }
}
</script>