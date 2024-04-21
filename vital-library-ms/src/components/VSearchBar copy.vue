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
        <input class="search-ipt" type="text" placeholder="Search The Book You Want" v-model="searchQuery">
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

.search-ipt {
    width: 400px;
    height: 50px;
    box-sizing: border-box;
    outline: none;
    border: 1px solid transparent;
    background-color: white;
    transition-duration: 0.4s;
}

.search-ipt:hover {
    background-color: rgb(230, 230, 230);
}

.search-ipt:focus {
    background-color: rgb(200, 200, 200);
    border: 1px solid rgb(228, 68, 68);
}

.search-button {
    height: 50px;
    width: 100px;
    box-sizing: border-box;
    background-color: rgb(228, 68, 68);
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

.search-button:hover {
    background-color: rgb(178, 55, 55);
}
</style>