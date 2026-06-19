<template>
    <LoadingComponent :props="loading" />
    <section class="min-h-screen flex items-center justify-center py-12 px-4 sm:px-6 lg:px-8 bg-[#0F172A]">
        <div class="w-full max-w-md space-y-6">
            <!-- Main Login Card -->
            <div class="bg-[#1E293B] border border-[#334155] shadow-2xl rounded-3xl p-8 sm:p-10">
                <div class="mb-8 text-center">
                    <h2 class="text-2xl font-bold tracking-tight text-white capitalize">
                        {{ $t('label.welcome_back') }}
                    </h2>
                    <p class="mt-2 text-sm text-[#94A3B8]">Please enter your details to sign in.</p>
                </div>

                <!-- Error Alert -->
                <div v-if="errors.validation"
                    class="bg-red-500/10 border border-red-500/50 text-red-400 px-4 py-3 mb-6 rounded-xl flex items-start gap-3 transition-all"
                    role="alert">
                    <i class="lab lab-close-circle-line mt-0.5 text-lg"></i>
                    <span class="block sm:inline text-sm flex-auto font-medium">{{ errors.validation }}</span>
                    <button type="button" @click="close" class="text-red-400 hover:text-red-300 transition-colors">
                        <i class="fa-solid fa-xmark"></i>
                    </button>
                </div>

                <form @submit.prevent="login" class="space-y-5">
                    <!-- Email Input -->
                    <div>
                        <label for="formEmail" class="block text-sm font-medium text-[#E2E8F0] mb-1.5 capitalize">
                            {{ $t('label.email') }}
                        </label>
                        <input type="text" 
                            :class="[
                                'w-full h-12 rounded-xl bg-[#0F172A] border px-4 text-white placeholder-[#475569] focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent transition-all duration-200',
                                errors.email ? 'border-red-500 focus:ring-red-500' : 'border-[#334155]'
                            ]" 
                            v-model="form.email" 
                            id="formEmail"
                            placeholder="name@example.com">
                        <p class="mt-1.5 text-xs text-red-400 font-medium" v-if="errors.email">{{ errors.email[0] }}</p>
                    </div>

                    <!-- Password Input -->
                    <div>
                        <label for="formPassword" class="block text-sm font-medium text-[#E2E8F0] mb-1.5 capitalize">
                            {{ $t('label.password') }}
                        </label>
                        <input autocomplete="off" type="password" 
                            :class="[
                                'w-full h-12 rounded-xl bg-[#0F172A] border px-4 text-white placeholder-[#475569] focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent transition-all duration-200',
                                errors.password ? 'border-red-500 focus:ring-red-500' : 'border-[#334155]'
                            ]"
                            v-model="form.password" 
                            id="formPassword"
                            placeholder="••••••••">
                        <p class="mt-1.5 text-xs text-red-400 font-medium" v-if="errors.password">{{ errors.password[0] }}</p>
                    </div>

                    <!-- Remember Me & Forgot Password -->
                    <div class="flex items-center justify-between pt-2">
                        <div class="flex items-center gap-2">
                            <div class="relative flex items-center justify-center w-5 h-5">
                                <input type="checkbox" id="checkbox2" 
                                    class="peer appearance-none w-5 h-5 border border-[#475569] rounded bg-[#0F172A] checked:bg-primary checked:border-primary focus:outline-none focus:ring-2 focus:ring-primary/50 transition-all cursor-pointer">
                                <i class="fa-solid fa-check absolute text-white text-[10px] opacity-0 peer-checked:opacity-100 pointer-events-none transition-opacity"></i>
                            </div>
                            <label for="checkbox2" class="text-sm text-[#94A3B8] cursor-pointer hover:text-[#E2E8F0] transition-colors">
                                {{ $t('label.remember_me') }}
                            </label>
                        </div>
                        <router-link :to="{ name: 'auth.forgetPassword' }"
                            class="text-sm font-medium text-primary hover:text-primary/80 transition-colors capitalize">
                            {{ $t('button.forget_password') }}
                        </router-link>
                    </div>

                    <!-- Submit Button -->
                    <button type="submit"
                        class="w-full h-12 mt-4 text-center capitalize font-semibold rounded-xl text-white bg-primary hover:opacity-90 active:scale-[0.98] transform transition-all duration-200 shadow-lg shadow-primary/25">
                        {{ $t('button.login') }}
                    </button>
                </form>
            </div>

            <!-- Demo Quick Entry -->
            <div
                class="bg-[#1E293B] border border-[#334155] shadow-xl rounded-2xl p-6 transition-all">
                <h2 class="mb-4 text-center text-sm font-semibold text-[#94A3B8] uppercase tracking-wider">
                    {{ $t('message.for_quick_entree') }}
                </h2>
                <nav class="grid grid-cols-2 gap-3">
                    <button @click.prevent="setupCredit('admin')"
                        class="w-full h-11 rounded-xl text-sm font-medium capitalize text-[#E2E8F0] bg-[#0F172A] border border-[#334155] hover:border-orange-500/50 hover:bg-orange-500/10 transition-all">
                        <span class="w-2 h-2 rounded-full bg-orange-500 inline-block mr-2"></span>
                        {{ $t('label.admin') }}
                    </button>
                    <button @click.prevent="setupCredit('branchManager')"
                        class="w-full h-11 rounded-xl text-sm font-medium capitalize text-[#E2E8F0] bg-[#0F172A] border border-[#334155] hover:border-sky-500/50 hover:bg-sky-500/10 transition-all">
                        <span class="w-2 h-2 rounded-full bg-sky-500 inline-block mr-2"></span>
                        {{ $t('label.branch_manager') }}
                    </button>
                    <button @click.prevent="setupCredit('posOperator')"
                        class="w-full h-11 rounded-xl text-sm font-medium capitalize text-[#E2E8F0] bg-[#0F172A] border border-[#334155] hover:border-purple-500/50 hover:bg-purple-500/10 transition-all">
                        <span class="w-2 h-2 rounded-full bg-purple-500 inline-block mr-2"></span>
                        {{ $t('label.pos_operator') }}
                    </button>
                    <button @click.prevent="setupCredit('chef')"
                        class="w-full h-11 rounded-xl text-sm font-medium capitalize text-[#E2E8F0] bg-[#0F172A] border border-[#334155] hover:border-green-500/50 hover:bg-green-500/10 transition-all">
                        <span class="w-2 h-2 rounded-full bg-green-500 inline-block mr-2"></span>
                        {{ $t('label.chef_kitchen') }}
                    </button>
                </nav>
            </div>
        </div>
    </section>
</template>

<script>
// ... (Keep your exact existing script setup here, no logic changes needed)
import router from "../../../router";
import LoadingComponent from "../components/LoadingComponent";
import alertService from "../../../services/alertService";
import ENV from "../../../config/env";
import { routes } from "../../../router";
import appService from "../../../services/appService";

export default {
    name: "LoginComponent",
    components: { LoadingComponent },
    data() {
        return {
            loading: {
                isActive: false,
            },
            form: {
                email: "",
                password: ""
            },
            errors: {},
            permissions: {},
            firstMenu: null,
            demo: ENV.DEMO
        }
    },
    computed: {
        permission: function () {
            return this.$store.getters.authPermission;
        }
    },
    methods: {
        login: function () {
            try {
                this.loading.isActive = true;
                this.$store.dispatch('login', this.form).then((res) => {
                    this.loading.isActive = false;
                    alertService.success(res.data.message);
                    router.push({ name: "admin.dashboard" });

                    setTimeout(() => {
                        appService.recursiveRouter(routes, this.permission);
                    }, 300)

                }).catch((err) => {
                    this.loading.isActive = false;
                    this.errors = err.response.data.errors;
                })
            } catch (err) {
                this.loading.isActive = false;
            }
        },
        close: function () {
            this.errors = {}
        },
        setupCredit: function (e) {
            if (e === 'admin') {
                this.form.email = 'admin@example.com';
                this.form.password = '123456';
            } else if (e === 'customer') {
                this.form.email = 'customer@example.com';
                this.form.password = '123456';
            } else if (e === 'branchManager') {
                this.form.email = 'branchmanager@example.com';
                this.form.password = '123456';
            } else if (e === 'posOperator') {
                this.form.email = 'posoperator@example.com';
                this.form.password = '123456';
            } else if (e === 'chef') {
                this.form.email = 'chef@example.com';
                this.form.password = '123456';
            }
        }
    }
}
</script>