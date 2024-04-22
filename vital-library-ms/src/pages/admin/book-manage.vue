<script setup>
import VTopAdminBar from '@/components/VTopAdminBar.vue';
import VBookListContainer from '@/components/VBookListContainer.vue';
import VFonts from "@/components/VFonts.vue";
import { ref, onMounted } from "vue";

const searchResults = ref([]);

onMounted(() => {
    searchBooks('');
});

const searchBooks = async (query) => {
    searchResults.value = [];
    try {
        const response = await fetch(`http://localhost:5000/books?q=${query}`, {
            method: 'GET',
            headers: {
                'Content-Type': 'application/json',
                // 'Access-Control-Allow-Origin': '*',
                // 允许跨域访问
            },
        });
        if (!response.ok) {
            throw new Error('Network response was not ok');
        }
        const data = await response.json();
        searchResults.value = Array.isArray(data) ? data : [];
        console.log(data);
    } catch (error) {
        console.error('Error searching books:', error);
        searchResults.value = [];
    }
};

</script>

<template>
    <VTopAdminBar></VTopAdminBar>
    <div class="empty200px" style="height: 100px; width: 100%;"></div>
    <div class="title-box">
        <h1>BOOK <span class="title-usrnme">MANAGEMENT</span> User Interface</h1>
    </div>
    <div class="list-title">Book List</div>
    <div class="ctrl-box">
        <router-link to="/book-manage-add"><button class="add-book">ADD NEW BOOK</button></router-link>
    </div>
    <VBookListContainer :searchResults="searchResults"></VBookListContainer>
</template>

<style>
a {
    text-decoration: none;
}

body {
    padding: 0;
    margin: 0;
    background-color: rgb(50, 50, 50);
}

.ctrl-box {
    width: 100%;
    display: flex;
    justify-content: center;
    align-items: center;
    margin-bottom: 20px;
}

.add-book {
    width: 150px;
    height: 40px;
    cursor: pointer;
    outline: none;
    border: 2px solid rgb(150, 150, 150);
    background-color: rgba(255, 255, 255, 0.25);
    color: white;
    transition-duration: 0.4s;
}

.add-book:hover {
    background-color: rgb(228, 68, 68);
}

.add-book:active {
    transition-duration: 0s;
    background-color: rgba(228, 68, 68, 0.5);
}

.list-title {
    width: 100%;
    height: 50px;
    color: white;
    text-align: center;
    font-size: 30px;
    font-family: apex;
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