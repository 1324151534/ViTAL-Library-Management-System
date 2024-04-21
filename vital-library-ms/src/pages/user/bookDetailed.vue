<script setup>
import { ref, onMounted } from 'vue';

// 创建响应式变量
const book = {};
const bookId = 0;

const url = window.location.href;
// 组件加载后调用 fetchBookDetail 函数
const id = url.split('/')[url.split('/').length - 1];
onMounted(() => {
    fetchBookDetail();
});

// 异步获取书籍详情信息
const fetchBookDetail = async () => {
    // 从路由参数中获取书籍 ID
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
        book.value = data; // 更新 book 变量的值
        document.getElementById('id').innerHTML = book.value.id;
        document.getElementById('title').innerHTML = book.value.title;
        document.getElementById('author').innerHTML = book.value.author;
    } catch (error) {
        console.error('Error fetching book details:', error);
    }
};
</script>

<template>
    <div class="book-detailed">
        <h1>书籍详情页</h1>
        <p>书籍 ID: <div id="id"></div></p>

        <p>书籍名称: <div id="title"></div></p>
        <p>作者: <div id="author"></div></p>
    </div>
</template>

<style>
.book-detailed{
    color: white;
}
</style>