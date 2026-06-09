<template>
    <LoadingComponent :props="loading" />
    <section class="min-h-screen flex items-center justify-center py-12 px-4 sm:px-6 lg:px-8 bg-[#0F172A]">
        <div class="w-full max-w-md space-y-6">
            <!-- Main Password Reset Card -->
            <div class="bg-[#1E293B] border border-[#334155] shadow-2xl rounded-3xl p-8 sm:p-10">
                <div class="mb-8 text-center">
                    <h2 class="text-2xl font-bold tracking-tight text-white capitalize">
                        {{ $t('label.forget_password') }}
                    </h2>
                    <p class="mt-2 text-sm text-[#94A3B8]">
                        Enter your email and we'll send you a link to reset your password.
                    </p>
                </div>

                <form @submit.prevent="forgetPassword" class="space-y-5">
                    <!-- Email Input -->
                    <div>
                        <label for="formEmail" class="block text-sm font-medium text-[#E2E8F0] mb-1.5 capitalize">
                            {{ $t('label.email') }}
                        </label>
                        <input type="email" 
                            :class="[
                                'w-full h-12 rounded-xl bg-[#0F172A] border px-4 text-white placeholder-[#475569] focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent transition-all duration-200',
                                errors.email ? 'border-red-500 focus:ring-red-500' : 'border-[#334155]'
                            ]" 
                            v-model="form.email" 
                            id="formEmail"
                            placeholder="name@example.com">
                        <p class="mt-1.5 text-xs text-red-400 font-medium" v-if="errors.email">{{ errors.email[0] }}</p>
                    </div>

                    <!-- Submit Button -->
                    <button type="submit"
                        class="w-full h-12 mt-6 text-center capitalize font-semibold rounded-xl text-white bg-primary hover:opacity-90 active:scale-[0.98] transform transition-all duration-200 shadow-lg shadow-primary/25">
                        {{ $t('label.next') }}
                    </button>

                    <!-- Back to Login Navigation -->
                    <div class="pt-4 text-center">
                        <span class="text-sm text-[#94A3B8] mr-1">
                            {{ $t('label.already_have_an_account') }}
                        </span>
                        <router-link class="text-sm font-medium text-primary hover:text-primary/80 transition-colors" :to="{ name: 'auth.login' }">
                            {{ $t('button.login') }}
                        </router-link>
                    </div>
                </form>
            </div>
        </div>
    </section>
</template>

<script>
import alertService from "../../../services/alertService";
import LoadingComponent from "../components/LoadingComponent";

export default {
    name: "ForgetPasswordComponent",
    components: { LoadingComponent },
    data() {
        return {
            loading: {
                isActive: false,
            },
            form: {
                email: ""
            },
            errors: {}
        }
    },
    methods: {
        forgetPassword: function () {
            try {
                this.loading.isActive = true;
                this.$store.dispatch('forgetPassword', this.form).then((res) => {
                    this.loading.isActive = false;
                    alertService.success(res.data.message);
                    this.$router.push({ name: 'auth.verifyEmail' });
                }).catch((err) => {
                    this.loading.isActive = false;
                    this.errors = err.response.data.errors;
                })
            } catch (err) {
                this.loading.isActive = false;
                alertService.error(err);
            }
        }
    }
}
</script>