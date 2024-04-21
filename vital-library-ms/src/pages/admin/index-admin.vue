<script setup>
import VTopBar from '@/components/VTopBar.vue';
import VSearchBar from "@/components/VSearchBar.vue";
import VFonts from "@/components/VFonts.vue";
import axios from "axios";
import { ref } from "vue";

const searchResults = ref([]);

const showResults = ref(false);

// const searchBooks = async (query) => {
//     searchResults.value = [];
//     try {
//         const response = await axios.get(`http://localhost:3000/books?q=${query}`);
//         // 确保 response.data 是一个数组，即使它是空的
//         searchResults.value = Array.isArray(response.data) ? response.data : [];
//         showResults.value = true; // 无论 searchResults 是否为空，都显示结果区域
//     } catch (error) {
//         console.error('Error searching books:', error);
//         searchResults.value = [];
//         showResults.value = true;
//     }
// };

// fetch data from the server
const searchBooks = async (query) => {
    searchResults.value = [];
    try {
        const response = await fetch(`http://192.168.0.101:5000`, {
            method: 'GET',
            headers: {
                'Content-Type': 'application/json',
                // 可选的其他请求头
                'Access-Control-Allow-Origin': '*',
                // 允许跨域访问
            },
            // GET 请求通常不包含请求体，因此 body 可以为空
            // body: JSON.stringify({}),
        });
        if (!response.ok) {
            throw new Error('Network response was not ok');
        }
        const data = await response.json();
        searchResults.value = Array.isArray(data) ? data : [];
        showResults.value = true;
        console.log(data);
    } catch (error) {
        console.error('Error searching books:', error);
        searchResults.value = [];
        showResults.value = true;
    }
};


</script>

<template>
    <VTopBar></VTopBar>
    <div class="title-box">
        <h1>ViTAL Library Management System</h1>
    </div>
    <VSearchBar @search="searchBooks"></VSearchBar>
    <div v-if="showResults" class="result-box">
        <ul v-if="searchResults.length">
            <li v-for="book in searchResults" :key="book.id">{{ book.title }}</li>
            <p>Pretend this is a book list</p>
        </ul>
        <p class="search-result" v-else>No results found.</p>
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