<script setup>
import { ref, onMounted } from 'vue';
import VTopBar from '@/components/VTopBar.vue';

const book = {};
const url = window.location.href;
const id = url.split('/')[url.split('/').length - 1];

onMounted(() => {
    fetchBookDetail();
});

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

        const data = await response.json();
        book.value = data;
        document.getElementById('id').innerHTML = book.value.id;
        document.getElementById('title').innerHTML = book.value.title;
        document.getElementById('author').innerHTML = book.value.author;
        document.getElementById('available').innerHTML = book.value.available;
        document.getElementById('ISBN').innerHTML = book.value.isbn;
        console.log(book);
    } catch (error) {
        console.error('Error fetching book details:', error);
    }
};

const borrowBook = async () => {
    try {
        if (!book.value.available) {
            alert('This book is not available for borrowing.');
            return;
        }

        const response = await fetch(`http://localhost:5000/books/${id}/borrow`, {
            method: 'PUT',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({}),
        });

        if (!response.ok) {
            throw new Error('Network response was not ok');
        }

        book.value.available = false;
        await fetchBookDetail();
    } catch (error) {
        console.error('Error borrowing book:', error);
    }
};
</script>

<template>
    <VTopBar></VTopBar>
    <div class="col-title">Book Detailed Page</div>
    <div class="book-detailed">
        <div class="col-line">Book ID: <div class="col-value" id="id"></div>
        </div>

        <div class="col-line">Book Name: <div class="col-value" id="title"></div>
        </div>
        <div class="col-line">Author: <div class="col-value" id="author"></div>
        </div>
        <div class="col-line">Available: <div class="col-value" id="available"></div>
        </div>
        <div class="col-line">ISBN: <div class="col-value" id="ISBN"></div>
        </div>
    </div>
    <div class="btns-box">
        <button class="bd-btn" @click="borrowBook">Borrow</button>
        <button class="bd-btn">Reserve</button>
    </div>
</template>

<style>
body {
    margin: 0;
    padding: 0;
    background-color: rgb(50, 50, 50);
}

.book-detailed {
    color: white;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    padding: 30px;
    border: 1px solid white;
    border-radius: 10px;
    width: 60%;
    min-width: 400px;
    max-width: 600px;
    margin: auto;
    font-family: 'Times New Roman', Times, serif;
}

.col-title {
    font-size: 40px;
    font-family: apex;
    display: flex;
    align-items: center;
    justify-content: center;
    margin-top: 40px;
    margin-bottom: 40px;
    width: 100%;
    color: white;
}

.col-line {
    display: flex;
    font-weight: bolder;
    height: 50px;
    width: 100%;
    align-items: center;
    justify-content: space-between;
    text-align: left;
    font-size: 25px;
    border-bottom: 1px solid rgba(255, 255, 255, 0.5);
}

.col-value {
    font-weight: lighter;
    margin-left: 5px;
    text-align: end;
    width: 300px;
}

.btns-box {
    width: 60%;
    min-width: 400px;
    max-width: 600px;
    margin: auto;
    margin-top: 40px;
    height: 50px;
    display: flex;
    justify-content: space-around;
    align-items: center;
}

.bd-btn {
    outline: none;
    border: none;
    box-sizing: border-box;
    height: 50px;
    width: calc(50% - 5px);
    font-size: 30px;
    font-family: apex;
    cursor: pointer;
    background-color: rgba(255, 255, 255, 0.2);
    transition-duration: 0.2s;
    color: white;
}

.bd-btn:hover {
    background-color: rgb(228, 68, 68);
}

.bd-btn:active {
    transition-duration: 0s;
    background-color: rgba(228, 68, 68, 0.5);
}
</style>