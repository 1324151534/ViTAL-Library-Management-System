<script setup>
import { ref, onMounted, computed } from "vue";
import VTopAdminBar from '@/components/VTopAdminBar.vue';
import VInput from '@/components/VInput.vue';
import VFonts from "@/components/VFonts.vue";
import { useRouter } from "vue-router";

const router = useRouter();
const book = ref({});
const url = window.location.href;
const id = url.split('/')[url.split('/').length - 1];

onMounted(() => {
    // no need
});

const goBack = () => {
    router.go(-1);
}

const addBook = () => {
    // 检查所有字段是否为空
    const requiredFields = ['title', 'author', 'isbn', 'available', 'description', 'publication_year', 'publisher', 'genre', 'language'];
    const missingFields = [];

    requiredFields.forEach(field => {
        if (!book.value[field]) {
            missingFields.push(field);
        }
    });

    if (missingFields.length > 0) {
        alert(`Please fill in the following fields: ${missingFields.join(', ')}`);
        return;
    }

    fetch(`http://localhost:5000/books`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify(book.value), // 发送书本信息的 JSON 数据
    })
        .then(response => {
            if (!response.ok) {
                throw new Error('Network response was not ok');
            }

            alert('Book add successfully');
            goBack();
        })
        .catch(error => {
            console.error('Error updating book:', error);
        });

};

const available = computed({
    get() {
        return book.value.available === 'true';
    },
    set(newValue) {
        book.value.available = newValue ? 'true' : 'false';
    }
});

const updateAvailable = (event) => {
    book.available = event.target.checked;
};

function showBook() {
    alert(JSON.stringify(book));
}

const fetchBookDetail = async () => {
    try {
        const response = await fetch(`http://localhost:5000/books/${id}`, {
            method: 'GET',
            headers: {
                'Content-Type': 'application/json',
            },
        });

        if (!response.ok) {
            throw new Error('Network response was not ok');
        }

        book.value = await response.json();
    } catch (error) {
        console.error('Error fetching book details:', error);
    }
};
</script>

<template>
    <VTopAdminBar></VTopAdminBar>
    <div class="empty200px" style="height: 100px; width: 100%;"></div>
    <div class="list-title-modify">Add <span class="list-title-red">Book</span></div>

    <div class="input-box">
        <div class="input-text">
            Title:
            <input type="text" class="vinput" v-model="book.title">
        </div>
    </div>

    <div class="input-box">
        <div class="input-text">
            ISBN:
            <input type="text" class="vinput" v-model="book.isbn">
        </div>
    </div>

    <div class="input-box">
        <div class="input-text">
            Available:
            <input type="checkbox" class="vinput" @change="updateAvailable($event)" v-model="book.available">
            {{ book.available }}
        </div>
    </div>

    <div class="input-box">
        <div class="input-text">
            Author:
            <input type="text" class="vinput" v-model="book.author">
        </div>
    </div>

    <div class="input-box">
        <div class="input-text">
            Description:
            <textarea type="text" class="vinput vinput-warp" v-model="book.description"></textarea>
        </div>
    </div>

    <div class="input-box">
        <div class="input-text">
            Publication Year:
            <input type="text" class="vinput" v-model="book.publication_year">
        </div>
    </div>

    <div class="input-box">
        <div class="input-text">
            Publisher:
            <input type="text" class="vinput" v-model="book.publisher">
        </div>
    </div>

    <div class="input-box">
        <div class="input-text">
            Genre:
            <input type="text" class="vinput" v-model="book.genre">
        </div>
    </div>

    <div class="input-box">
        <div class="input-text">
            Language:
            <input type="text" class="vinput" v-model="book.language">
        </div>
    </div>

    <div class="mod-btns">
        <button id="smt-btn" class="summit-btn" @click="addBook">Summit</button>
    </div>
</template>

<style>
.close-btn {
    position: absolute;
    top: 10px;
    right: 10px;
    width: 30px;
    height: 30px;
    font-size: 20px;
    font-weight: bold;
    color: #fff;
    background-color: #ff0000;
    border: none;
    border-radius: 50%;
    cursor: pointer;
}

a {
    text-decoration: none;
}

body {
    padding: 0;
    margin: 0;
    background-color: rgb(50, 50, 50);
}

.mod-btns {
    width: 100%;
    display: flex;
    justify-content: center;
    align-items: center;
    margin-bottom: 50px;
}

.summit-btn {
    width: 250px;
    height: 50px;
    font-size: 20px;
    font-family: apex;
    background-color: rgba(255, 255, 255, 0.3);
    color: white;
    outline: none;
    border: none;
    cursor: pointer;
    border-radius: 200px;
    transition-duration: 0.2s;
}

.summit-btn:hover {
    background-color: rgb(228, 68, 68);
}

.summit-btn:active {
    background-color: rgba(228, 68, 68, 0.5);
}

.list-title-modify {
    width: 100%;
    height: 50px;
    margin-top: 40px;
    margin-bottom: 40px;
    color: white;
    text-align: center;
    font-size: 30px;
    font-family: apex;
}

.list-title-red {
    color: rgb(228, 68, 68);
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

.result-box {
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

.input-box {
    width: 80%;
    margin: auto;
    margin-bottom: 10px;
    max-width: 600px;
    height: auto;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: flex-start;
    color: white;
}

.input-text {
    width: 100%;
    text-align: left;
    font-size: 20px;
    margin-bottom: 10px;
    font-family: Arial, Helvetica, sans-serif;
}

.vinput {
    width: 100%;
    height: 50px;
    background-color: rgba(255, 255, 255, 0.1);
    border: 2px solid rgba(255, 255, 255, 0.4);
    outline: none;
    box-sizing: border-box;
    border-radius: 200px;
    padding: 10px;
    color: white;
    margin-top: 10px;
}

.vinput:hover {
    background-color: rgba(255, 255, 255, 0.2);
}

.vinput:focus {
    background-color: rgba(255, 255, 255, 0.05);
    border: 2px solid rgb(228, 68, 68);
}

.vinput-warp {
    height: 300px;
    border-radius: 30px;
    padding: 20px;
    font-family: Arial, Helvetica, sans-serif;
    text-wrap: wrap;
}
</style>