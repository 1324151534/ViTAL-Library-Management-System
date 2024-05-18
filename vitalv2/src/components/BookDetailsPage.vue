<template>
    <div class="book-detail-container">
        <!-- Header Section -->
        <header class="header">
            <h1 @click="goToBookList">ViTAL LMS</h1>
            <div class="user-container">
                <span v-if="currentUser" class="user-info">Welcome, </span>
                <el-button type="text" @click="goToUserProfile">{{ currentUser }}</el-button>
            </div>
        </header>

        <!-- Book Details Section -->
        <div class="book-details">
            <h1>{{ book.title }}</h1>
            <div class="details">
                <div class="image">
                    <img :src="book.cover_image" alt="Book Cover">
                </div>
                <div class="info">
                    <p><strong>Author:</strong> {{ book.author }}</p>
                    <p><strong>Type:</strong> {{ book.type }}</p>
                    <p><strong>ISBN:</strong> {{ book.isbn }}</p>
                    <p><strong>Location:</strong> {{ book.location }}</p>
                    <p><strong>Quantity:</strong> {{ book.quantity }}</p>
                    <p><strong>Description:</strong> {{ book.description }}</p>
                    <p><strong>Published Date:</strong> {{ book.published_date }}</p>
                    <p><strong>Created At:</strong> {{ book.created_at }}</p>
                    <p><strong>Updated At:</strong> {{ book.updated_at }}</p>
                </div>
            </div>
        </div>

        <!-- Button Section -->
        <div class="button-section">
            <el-button type="primary" @click="addShopList">Add to Shopping List</el-button>
            <el-button type="info" plain @click="goToBookList">Return to Book List</el-button>
        </div>
    </div>
</template>

<script>
import axios from 'axios';

export default {
    data() {
        return {
            currentUser: null,
            book: {} // 存储书籍详细信息
        };
    },
    methods: {
        async fetchBookDetails() {
            const currentUser = localStorage.getItem('currentUser');
            if (currentUser) {
                this.currentUser = currentUser;
                console.log(currentUser);
            }
            try {
                const bookId = this.$route.params.id; // 从路由参数中获取书籍ID
                const response = await axios.get(`http://localhost:5000/api/books/${bookId}`);
                this.book = response.data;
            } catch (error) {
                console.error('Error fetching book details:', error);
            }
        },
        goToBookList() {
            this.$router.push({ name: 'BookList' });
        },
        addShopList() {
            // 借书逻辑
        },
        goToUserProfile() {
            // 进入用户个人资料页面的逻辑
        }
    },
    mounted() {
        this.fetchBookDetails(); // 获取书籍详细信息
    }
};
</script>

<style scoped>
.header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 20px;
    background-color: #00000010;
    color: #fff;
    position: relative;
    z-index: 999;
}

.header h1 {
    margin: 0;
    font-size: 24px;
    color: #333;
    width: 150px;
}

.user-info {
    color: black;
}

@keyframes bk-dtl-in {
    0% {
        opacity: 0;
        transform: translateY(-50px);
    }
    75% {
        transform: translateY(0px);
    }
    100% {
        opacity: 1;
    }
}

.book-details {
    animation: bk-dtl-in 1s;
    max-width: 800px;
    margin: 0 auto;
    padding: 20px;
}

.book-details h1 {
    text-align: center;
}

.details {
    display: flex;
}

.image {
    margin-right: 20px;
}

.image img {
    max-width: 200px;
    height: auto;
}

.info {
    flex: 1;
}

.button-section {
    margin-top: 20px;
    text-align: center;
}

.user-container {
    width: 150px;
}
</style>
