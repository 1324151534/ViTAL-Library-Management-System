<script setup>
import VTopBar from '@/components/VTopBar.vue';
import VFonts from "@/components/VFonts.vue";
</script>

<template>
    <VTopBar></VTopBar>
    <div class="title-box">
        <h1>Notification Page</h1>
    </div>
</template>

<style>
body {
    padding: 0;
    margin: 0;
}

.title-box {
    display: flex;
    align-items: center;
    justify-content: center;
    width: 100%;
    height: 200px;
    font-family: "MiSans"
}

@font-face {
    font-family: "MiSans";
    src: url('@/assets/fonts/MiSans/MiSans-Normal.ttf');
    font-weight: normal;
    font-style: normal;
}
</style>