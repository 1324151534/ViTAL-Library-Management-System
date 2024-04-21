<script setup>
import VFonts from "@/components/VFonts.vue";
import { ref } from "vue";

const searchQuery = ref("");
const emit = defineEmits(['search']);

const handleSearch = () => {
    if (searchQuery.value.trim() !== "") {
        emit('search', searchQuery.value.trim());
    }
    else {
        alert('Please input something!');
    }
};
</script>

<template>
    <div class="SearchBar-box">
        <input type="text" placeholder="Search The Book You Want" v-model="searchQuery">
        <button type="submit" class="search-button" @click="handleSearch">Search</button>
    </div>
</template>

<style>
.SearchBar-box {
    display: flex;
    align-items: center;
    justify-content: center;
    width: 100%;
    height: 50px;
    font-family: "MiSans";
}

.search-button {
    background-color: #4CAF50;
    border: none;
    color: white;
    padding: 5px 20px;
    text-align: center;
    text-decoration: none;
    display: inline-block;
    font-size: 16px;
    margin: 4px 2px;
    cursor: pointer;
    font-family: "MiSans";
}
</style>