<script setup>
import { ref, onMounted } from 'vue';

// 创建响应式变量
const bookId = ref(null);
const book = ref({});

// 组件加载后调用 fetchBookDetail 函数
onMounted(() => {
    fetchBookDetail();
});

// 异步获取书籍详情信息
const fetchBookDetail = async () => {
    // 从路由参数中获取书籍 ID
    const id = bookId.value;

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
        console.log(data);
    } catch (error) {
        console.error('Error fetching book details:', error);
    }
};
</script>

<template>
    <div>
        <h1>书籍详情页</h1>
        <p>书籍 ID: {{ bookId }}</p>
        <p>书籍名称: {{ book.title }}</p>
        <p>作者: {{ book.author }}</p>
    </div>
</template>
