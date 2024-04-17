<script setup>
import VTopBar from '@/components/VTopBar.vue';
import VSearchBar from '@/components/VSearchBar.vue';
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
    <VTopBar></VTopBar>
    <div class="title-box">
        <h1>Search The book</h1>
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
</style>