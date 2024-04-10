<script setup>
import VTopBar from '@/components/VTopBar.vue';
import VSearchBar from '@/components/VSearchBar.vue';
import VFonts from "@/components/VFonts.vue";
</script>

<template>
    <VTopBar></VTopBar>
    <div class="title-box">
        <h1>Search The book</h1>
    </div>
    <VSearchBar></VSearchBar>
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
</style>