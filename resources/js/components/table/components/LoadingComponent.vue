<template>
    <transition name="fade">
        <div v-if="props.isActive" 
             class="fixed inset-0 z-[9999] flex flex-col items-center justify-center bg-[#0F172A]/80 backdrop-blur-md">
            
            <div class="relative flex items-center justify-center w-20 h-20">
                <div class="absolute w-full h-full border-4 border-[#1E293B] rounded-full"></div>
                
                <div class="absolute w-full h-full border-4 border-transparent border-t-primary border-r-primary/30 rounded-full animate-spin drop-shadow-[0_0_8px_rgba(var(--color-primary),0.5)]"></div>
                
                <div class="absolute w-12 h-12 border-4 border-transparent border-b-white/50 border-l-white/10 rounded-full animate-[spin_1.5s_linear_infinite_reverse]"></div>
            </div>

            <p class="mt-6 text-sm font-semibold text-[#94A3B8] tracking-[0.2em] uppercase animate-pulse">
                {{ $t('message.loading') || 'Loading...' }}
            </p>

        </div>
    </transition>
</template>

<script>
export default {
    name: "LoadingComponent",
    // Note: You can now uninstall 'vue-element-loading' via npm/yarn
    props: {
        props: {
            type: Object,
            required: true
        }
    }
}
</script>

<style scoped>
/* Smooth fade in and out for the entire overlay */
.fade-enter-active,
.fade-leave-active {
    transition: opacity 0.4s ease, backdrop-filter 0.4s ease;
}

.fade-enter-from,
.fade-leave-to {
    opacity: 0;
    backdrop-filter: blur(0px);
}
</style>