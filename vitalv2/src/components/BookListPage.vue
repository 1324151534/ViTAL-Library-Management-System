<template>
    <div class="book-list">
        <header class="header">
            <h1 style="display: flex;">ViTAL LMS <span style="margin-left: 10px; color: gray; font-weight: lighter;">BOOKLIST</span></h1>
            <!-- Search Bar -->
            <div class="search-container">
                <el-input v-model="searchKeyword" placeholder="Enter keywords..." class="search-bar"></el-input>
                <el-button type="primary" @click="searchBooks">Search</el-button>
            </div>
            <div class="user-container">
                <span style="margin-right: 20px;" v-if="currentUser" class="user-info">Welcome, {{ currentUser }}</span>
                <el-tooltip v-if="currentUser" content="Notification Box" placement="top">
                    <el-button v-if="currentUser" @click="openNotificationBox" icon="el-icon-message-solid" circle></el-button>
                </el-tooltip>
                <el-button v-if="currentUser" type="primary" @click="goToUserProfile">My Profile</el-button>
                <el-button v-else type="warning" @click="goToLogin">Login or Signup</el-button>
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

        <!-- User Notification Dialog -->
        <el-dialog title="User Notifications" :visible.sync="notificationDialogVisible" width="75%">
            <el-table :data="userNotifications" style="width: 100%" empty-text="No Notifications Available">
                <el-table-column min-width="40%" prop="user_username" label="User"></el-table-column>
                <el-table-column min-width="30%" prop="admin_username" label="Librarian"></el-table-column>
                <el-table-column min-width="20%" prop="notification_state" label="State"></el-table-column>
                <el-table-column min-width="30%" prop="notification_level" label="Level"></el-table-column>
                <el-table-column min-width="60%" prop="notification_date" label="Date"></el-table-column>
                <el-table-column min-width="50%">
                    <template slot-scope="scope">
                        <el-button @click="viewText(scope.row.id)">View Text</el-button>
                        <el-button type="success" @click="receiveNotification(scope.row.id)">Receive</el-button>
                    </template>
                </el-table-column>
            </el-table>
            <div slot="footer" class="dialog-footer">
                <el-button @click="notificationDialogVisible = false">Close</el-button>
            </div>
        </el-dialog>

        <!-- User Notification Text Dialog -->
        <el-dialog title="User Notification Text" :visible.sync="notificationTextDialogVisible">
            <div class="text-area">{{ notificationText }}</div>
            <div slot="footer" class="dialog-footer">
                <el-button @click="notificationTextDialogVisible = false; notificationText = 'No Text';">Close</el-button>
            </div>
        </el-dialog>
    </div>
</template>

<script>
import axios from 'axios';

export default {
    data() {
        return {
            currentUser: null,
            currentUserId: null,
            books: [],
            searchKeyword: '', // 搜索关键词
            searchInfo: 'All Books',
            notificationText: 'No Text',
            notificationDialogVisible: false,
            notificationTextDialogVisible: false,
            userNotifications: []
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
        async fetchNotifications() {
            try {
                let userId = this.currentUserId
                const response = await axios.get('http://localhost:5000/api/notifications', {
                    params: {
                        user_id: userId
                    }
                });                
                if (response.data.length > 0) {
                    this.userNotifications = response.data;
                }
            } catch (error) {
                this.$message.error('Error fetching user notifications.');
                console.error('Error fetching user notifications:', error);
            }
        },
        async viewText(noti_id) {
            this.notificationTextDialogVisible = true;
            let i;
            let noti_json = JSON.parse(JSON.stringify(this.userNotifications));
            console.log(noti_json);
            for (i = 0; i <  noti_json.length; ++i) {
                if (noti_json[i].id == noti_id) {
                    this.notificationText = noti_json[i].notification_text;
                    break;
                }
            }
        },
        async receiveNotification(noti_id) {
            try {
                const response = await axios.get(`http://localhost:5000/api/notifications/${noti_id}`);                
                this.$message.info(response.data.message);
            } catch (error) {
                this.$message.error(error.response.data.error);
            }
        },
        openNotificationBox() {
            this.notificationDialogVisible = true;
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
            const currentUserId = localStorage.getItem('currentUserId');
            if (currentUser && currentUserId) {
                this.currentUser = currentUser;
                this.currentUserId = currentUserId;
                this.fetchNotifications();
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
    padding: 40px;
    background-color: #dbdbdb80;
    color: #fff;
    position: fixed;
    top: 0;
    width: 100%;
    backdrop-filter: blur(10px);
    box-sizing: border-box;
}

.header h1 {
    margin: 0;
    font-size: 24px;
    color: #333;
}

.user-info {
    color: black;
}

.book-container {
    padding-top: 150px;
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
}
</style>
