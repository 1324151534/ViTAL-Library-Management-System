<template>
    <div class="book-list">
        <header class="header">
            <h1>ViTAL LMS</h1>
            <!-- Search Bar -->
            <div class="search-container">
                <el-input v-model="searchKeyword" placeholder="Enter keywords..." class="search-bar"></el-input>
                <el-button type="primary" @click="searchBooks">Search</el-button>
            </div>
            <div class="user-container">
                <span v-if="currentUser" class="user-info">Welcome, </span>
                <el-button v-if="currentUser" type="text" @click="goToUserProfile">{{ currentUser }}</el-button>
                <el-button v-else type="text" @click="goToLogin">Login or Signup</el-button>
            </div>
        </header>
        <div class="book-container">
            <h2>{{ searchInfo }}</h2>
            <ul>
                <li v-for="book in books" :key="book.book_id" class="book-item" @click="viewBookDetails(book.book_id)">
                    <img :src="book.cover_image" alt="Book Cover" class="book-cover">
                    <div class="book-details">
                        <h3>{{ book.title }}</h3>
                        <p><strong>Author:</strong> {{ book.author }}</p>
                        <p><strong>Type:</strong> {{ book.type }}</p>
                        <p><strong>ISBN:</strong> {{ book.isbn }}</p>
                        <p><strong>Location:</strong> {{ book.location }}</p>
                        <p><strong>Quantity:</strong> {{ book.quantity }}</p>
                        <p><strong>Description:</strong> {{ book.description }}</p>
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
            books: [],
            searchKeyword: '', // 搜索关键词
            searchInfo: 'All Books'
        };
    },
    methods: {
        async fetchBooks() {
            try {
                const response = await axios.get('http://localhost:5000/api/books');
                this.books = response.data;
            } catch (error) {
                console.error('Error fetching books:', error);
            }
        },
        async searchBooks() {
            // 清空当前书籍列表
            this.books = [];

            try {
                const response = await axios.get('http://localhost:5000/api/books', {
                    params: {
                        search: this.searchKeyword
                    }
                });
                this.books = response.data;
                if (this.searchKeyword == '') {
                    this.searchInfo = 'All Books'
                }
                else {
                    this.searchInfo = 'Search results for ' + this.searchKeyword;
                }
            } catch (error) {
                console.error('Error searching books:', error);
            }
        },
        goToUserProfile() {
            this.$router.push({ name: 'UserProfile'});
        },
        goToLogin() {
            this.$router.push({ name: 'Login' });
        },
        viewBookDetails(bookId) {
            this.$router.push({ name: 'BookDetails', params: { id: bookId } });
        },
        fetchCurrentUser() {
            const currentUser = localStorage.getItem('currentUser');
            if (currentUser) {
                this.currentUser = currentUser;
                console.log(currentUser);
            }
        }
    },
    mounted() {
        this.fetchCurrentUser();
        this.fetchBooks();
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

.book-container {
    margin-top: 20px;
    max-width: 850px;
    margin: auto;
}

.book-container h2 {
    margin-bottom: 10px;
    font-size: 20px;
    color: #333;
}

.book-container ul {
    list-style: none;
    padding: 0;
}

.book-item {
    display: flex;
    align-items: center;
    border: 1px solid #ddd;
    border-radius: 5px;
    margin-bottom: 20px;
    padding: 20px;
    transition-duration: 0.2s;
    cursor: pointer;
}

.book-item:hover {
    background-color: #66666619;
}

.book-item:active {
    transition-duration: 0s;
    background-color: #66666631;
}

.book-cover {
    width: 120px;
    height: 180px;
    margin-right: 20px;
    border-radius: 5px;
    transition-duration: 0.4s;
}

.book-cover:hover {
    filter: brightness(0.6);
}

.book-details {
    pointer-events: none;
    flex: 1;
}

.book-details h3 {
    margin-top: 0;
    margin-bottom: 10px;
    font-size: 18px;
    color: #333;
}

.book-details p {
    margin: 0;
    margin-bottom: 5px;
    font-size: 14px;
    color: #666;
}
.search-container {
    width: 75%;
    max-width: 800px;
    min-width: 200px;
    display: flex;
    justify-content: center;
}
.search-bar {
    width: 70%;
    max-width: 500px;
    min-width: 200px;
    margin-right: 10px;
}
.user-container {
    display: flex;
    justify-content: center;
    align-items: center;
    height: 30px;
    width: 150px;
}
</style>
