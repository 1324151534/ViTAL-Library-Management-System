<script setup>
import VTopAdminBar from '@/components/VTopAdminBar.vue';
import VAdminRecBox from '@/components/VAdminRecBox.vue';
import VSearchBar from "@/components/VSearchBar.vue";
import VFonts from "@/components/VFonts.vue";
import axios from "axios";
import { ref } from "vue";

const searchResults = ref([]);

const showResults = ref(false);

const searchBooks = async (query) => {
    searchResults.value = [];
    try {
        const response = await axios.get(`http://localhost:3000/books?q=${query}`);
        // 确保 response.data 是一个数组，即使它是空的
        searchResults.value = Array.isArray(response.data) ? response.data : [];
        showResults.value = true; // 无论 searchResults 是否为空，都显示结果区域
    } catch (error) {
        console.error('Error searching books:', error);
        searchResults.value = [];
        showResults.value = true;
    }
};

</script>

<template>
    <VTopAdminBar></VTopAdminBar>
    <div class="empty200px" style="height: 100px; width: 100%;"></div>
    <div class="title-box">
        <h1>Welcome, <span class="title-usrnme">$USERNAME$</span> !</h1>
    </div>
    <div class="admin-rec-container">
        <VAdminRecBox></VAdminRecBox>
        <VAdminRecBox></VAdminRecBox>
        <VAdminRecBox></VAdminRecBox>
    </div>
</template>

<style>
    body {
        overflow: auto;
        background-color: rgb(50, 50, 50);
    }
</style>

<style>
h1 {
    font-size: 40px;
}

body {
    padding: 0;
    margin: 0;
    background-color: rgb(50, 50, 50);
}

.admin-rec-container {
    width: 100%;
    margin: auto;
    display: flex;
    justify-content: center;
    align-items: center;
}

.title-box {
    color: white;
}

.title-usrnme {
    color: rgb(228, 68, 68);
    transition-duration: 0.4s;
}

.title-usrnme:hover {
    color: rgba(228, 68, 68, 0.8);
}

.title-box {
    display: flex;
    align-items: center;
    justify-content: center;
    width: 100%;
    height: 200px;
    font-family: apex;
}

.result-box{
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