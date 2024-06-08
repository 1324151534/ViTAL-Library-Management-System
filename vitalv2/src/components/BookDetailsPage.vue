<template>
    <div class="book-detail-container">
        <!-- Header Section -->
        <header class="header">
            <h1 style="display: flex;">ViTAL LMS <span
                    style="margin-left: 10px; color: gray; font-weight: lighter;">BOOK DETAIL</span></h1>
            <div class="user-container">
                <span style="margin-right: 20px;" v-if="currentUser" class="user-info">Welcome, {{ currentUser }}</span>
                <el-button v-if="currentUser" type="primary" @click="goToUserProfile">My Profile</el-button>
                <el-button v-else type="warning" @click="goToLogin">Login or Signup</el-button>
            </div>
        </header>

        <!-- Book Details Section -->
        <div class="book-details-container">
            <el-button icon="el-icon-arrow-left" style="font-size: larger;" type="text" class="returnBooklist"
                @click="goToBookList">Return Booklist</el-button>
            <h1>
                {{ book.title }}
            </h1>

            <div class="details">
                <div class="image">
                    <img :src="book.cover_image" alt="Book Cover">
                    <el-button style="margin-top: 20px;" type="primary" icon="el-icon-circle-plus"
                        @click="addToBorrowingList">Add to Borrowing List</el-button>
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

        <!-- Recommendations Section -->
        <div class="recommendations">
            <h2>{{ recommendNotiText }}</h2>
            <ul class="recommendations-container">
                <li v-for="rec in recommendations" :key="rec.book_id" class="book-item"
                    @click="viewBookDetails(rec.book_id)">
                    <img :src="rec.cover_image" alt="Book Cover" class="book-cover">
                    <div class="book-details">
                        <h3 style="text-wrap: nowrap;">{{ rec.title }}</h3>
                        <p><strong>Author:</strong> {{ rec.author }}</p>
                        <p><strong>Type:</strong> {{ rec.type }}</p>
                        <p><strong>ISBN:</strong> {{ rec.isbn }}</p>
                    </div>
                </li>
            </ul>
        </div>
    </div>
</template>

<script>
import axios from 'axios';

export default {
    data() {
        return {
            currentUser: null,
            book: {}, // 存储书籍详细信息
            recommendations: [], // 存储推荐书籍
            recommendNotiText: 'Recommended Books'
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
                this.fetchRecommendations(bookId); // 获取推荐书籍
            } catch (error) {
                console.error('Error fetching book details:', error);
            }
        },
        async fetchRecommendations(bookId) {
            try {
                const response = await axios.get('http://localhost:5000/api/books/recommendations', {
                    params: {
                        book_id: bookId,
                        author: this.book.author,
                        type: this.book.type
                    }
                });
                this.recommendations = response.data;
                if (response.data.length == 0) {
                    this.recommendNotiText = 'No Recommendations Available'
                }
                else {
                    this.recommendNotiText = 'Recommended Books'
                }
            } catch (error) {
                console.error('Error fetching recommendations:', error);
            }
        },
        goToBookList() {
            this.$router.push({ name: 'BookList' });
        },
        viewBookDetails(bookId) {
            if (bookId != this.book.book_id) {
                this.$router.push({ name: 'BookDetails', params: { id: bookId } });
            }
        },
        addToBorrowingList() {
            const userId = localStorage.getItem('currentUserId');
            const bookId = this.$route.params.id;

            if (userId) {
                axios.post(`http://localhost:5000/api/shopping_cart/add`, { user_id: userId, book_id: bookId })
                    .then(() => {
                        // 在页面上显示成功消息
                        this.$message.success('Book added to Borrowing List successfully');
                    })
                    .catch((res) => {
                        // 在页面上显示错误消息
                        this.$message.error(res.response.data.message);
                    });
            } else {
                // 在页面上显示提示消息
                this.$message.warning('Please log in to add books to Borrowing List');
                // 在这里实现跳转到登录页面的逻辑
            }
        },
        goToLogin() {
            this.$router.push({ name: 'Login' });
        },
        goToUserProfile() {
            this.$router.push({ name: 'UserProfile' });
        }
    },
    watch: {
        '$route.params.id': function () {
            this.fetchBookDetails(); // 当路由参数变化时重新获取书籍详细信息
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
    padding: 40px;
    background-color: #dbdbdb80;
    backdrop-filter: blur(10px);
    color: #fff;
    position: relative;
    z-index: 999;
    box-sizing: border-box;
    width: 100%;
    position: fixed;
    top: 0;
}

.header h1 {
    margin: 0;
    font-size: 24px;
    color: #333;
    cursor: pointer;
}

.user-info {
    color: black;
}

@keyframes bk-dtl-in {
    0% {
        opacity: 0;
        transform: translateY(-50px);
    }

    25% {
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

.book-details-container {
    animation: bk-dtl-in 1s;
    max-width: 900px;
    margin: auto;
    margin-top: 140px;
    padding: 20px;
}

.book-details {
    animation: bk-dtl-in 1s;
    max-width: 800px;
    margin: auto;
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
    display: flex;
    flex-direction: column;
    align-items: center;
}

.image img {
    max-width: 200px;
    height: auto;
}

.info {
    flex: 1;
}

.button-section {
    text-align: center;
}

.recommendations-container {
    display: flex;
    flex-wrap: wrap;
    align-items: center;
    justify-content: space-around;
}

.recommendations {
    margin-top: 40px;
    max-width: 1600px;
    margin: auto;
}

.recommendations h2 {
    text-align: center;
    font-size: 20px;
    color: #333;
}

.recommendations ul {
    list-style: none;
    padding: 0;
}

.recommendations .book-item {
    display: flex;
    align-items: center;
    border: 1px solid #ddd;
    border-radius: 5px;
    margin: 20px;
    padding: 20px;
    transition-duration: 0.2s;
    cursor: pointer;
    flex: 1;
    max-width: 28%;
}

.recommendations .book-item:hover {
    background-color: #66666619;
}

.recommendations .book-item:active {
    transition-duration: 0s;
    background-color: #66666631;
}

.recommendations .book-cover {
    animation: bk-dtl-in 1s;
    width: 80px;
    height: 120px;
    margin-right: 20px;
    border-radius: 5px;
    transition-duration: 0.4s;
}

.recommendations .book-cover:hover {
    filter: brightness(0.6);
}

.recommendations .book-details {
    pointer-events: none;
    flex: 1;
}

.recommendations .book-details h3 {
    margin-top: 0;
    margin-bottom: 10px;
    font-size: 18px;
    color: #333;
}

.recommendations .book-details p {
    margin: 0;
    margin-bottom: 5px;
    font-size: 14px;
    color: #666;
}
</style>
