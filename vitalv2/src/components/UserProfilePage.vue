<template>
  <div class="profile-container">
    <!-- Header Section -->
    <header class="header">
      <h1 @click="goToBookList">My Profile</h1>
      <div class="user-container">
        <span v-if="currentUser" class="user-info">Welcome, {{ currentUser }}</span>
        <el-button v-if="currentUser" type="text" @click="logout">Logout</el-button>
        <el-button v-else type="text" @click="goToLogin">Login or Signup</el-button>
      </div>
    </header>

    <!-- Borrowing List Section -->
    <div class="borrowing-records">
      <h2>{{ BorrowingListInfo }}</h2>
      <ul v-if="currentUser">
        <li v-for="record in borrowingLists" :key="record.book_id" class="record-item">
          <div class="book-container">
            <p class="rec-title">{{ record.title }}</p>
            <div class="book-info-container">
              <div class="book-info"><strong>Author:</strong> {{ record.author }}</div>
              <div class="book-info"><strong>Quantity:</strong> {{ record.quantity }}</div>
            </div>
          </div>
          <el-button style="width: 55px; height: 55px;" type="danger" icon="el-icon-delete"
            @click="deleteBook(record.book_id)" circle></el-button>
        </li>
      </ul>
      <div v-if="currentUser" class="rec-ctrl-container">
        <el-button type="primary" @click="borrowAllBooks">Borrow All</el-button>
      </div>
    </div>

    <!-- Borrowing Record Table -->
    <div class="borrowing-records">
      <h2>{{ borrowingRecordInfo }}</h2>
      <ul v-if="currentUser">
        <li v-for="record in borrowingRecords" :key="record.record_id" class="record-item">
          <div class="book-container">
            <p class="rec-title">{{ record.title }}</p>
            <div class="book-info-container-record">
              <div class="book-info"><strong>Author:</strong> {{ record.author }}</div>
              <div class="book-info"><strong>Borrowed from:</strong> {{ record.borrow_date }}</div>
              <div class="book-info"><strong>Due to:</strong> {{ record.return_date }}</div>
              <div class="book-info"><strong>Renewed:</strong> {{ record.extension_count }}</div>
            </div>
          </div>
          <div class="button-container">
            <el-button style="width: 125px; height: 45px; border-radius: 100px;" type="primary" icon="el-icon-refresh"
              @click="renewBook()" plain>Renew</el-button>
            <el-button style="width: 125px; height: 45px; margin-left: 0px; margin-top: 10px; border-radius: 100px;" type="primary" icon="el-icon-refresh-left"
              @click="returnBook()">Return</el-button>
          </div>
        </li>
      </ul>
    </div>

    <!-- Change Password Section -->
    <h2 v-if="currentUser">Change Password</h2>
    <div v-if="currentUser" class="change-password">
      <div class="password-input">
        <el-input v-model="newPassword" type="password" placeholder="Enter new password"></el-input>
      </div>
      <div class="password-button">
        <el-button type="primary" @click="changePassword">Change Password</el-button>
      </div>
    </div>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  data() {
    return {
      currentUser: null,
      borrowingLists: [],
      BorrowingListInfo: 'Borrowing List',
      borrowingRecords: [],
      borrowingRecordInfo: 'Borrowing Record',
      newPassword: ''
    };
  },
  methods: {
    async fetchBorrowingRecords() {
      try {
        const userId = localStorage.getItem('currentUserId');
        if (!userId) {
          this.borrowingRecordInfo = 'Not logged in yet, please Login first.';
        }
        const response = await axios.get(`http://localhost:5000/api/user_borrowing_records/${userId}`);
        this.borrowingRecords = response.data;
      } catch (error) {
        console.error('Error fetching borrowing records:', error);
      }
    },
    async fetchBorrowingLists() {
      try {
        const userId = localStorage.getItem('currentUserId');
        if (!userId) {
          this.BorrowingListInfo = 'Not logged in yet, please Login first.';
        }
        const response = await axios.get(`http://localhost:5000/api/shopping_cart/${userId}`);
        this.borrowingLists = response.data;
      } catch (error) {
        console.error('Error fetching borrowing lists:', error);
      }
    },
    async changePassword() {
      try {
        const userId = localStorage.getItem('currentUserId');
        await axios.post('http://localhost:5000/api/change_password', { user_id: userId, newPassword: this.newPassword });
        this.newPassword = '';
        this.$message.success('Password changed successfully!');
      } catch (error) {
        console.error('Error changing password:', error);
        this.$message.error('Failed to change password. Please try again.');
      }
    },
    goToLogin() {
      this.$router.push({ name: 'Login' });
    },
    goToBookList() {
      this.$router.push({ name: 'BookList' });
    },
    async deleteBook(bookId) {
      try {
        const userId = localStorage.getItem('currentUserId');
        await axios.delete(`http://localhost:5000/api/shopping_cart/${userId}/${bookId}`);
        this.borrowingLists = this.borrowingLists.filter(record => record.book_id !== bookId);
        this.$message.success('Book removed from borrowing list successfully!');
      } catch (error) {
        console.error('Error removing book from borrowing list:', error);
        this.$message.error('Failed to remove book. Please try again.');
      }
    },
    async borrowAllBooks() {
      try {
        const userId = localStorage.getItem('currentUserId');
        const failedRecords = [];

        // Iterate over borrowingLists and try to add each book to BorrowingRecord
        for (const record of this.borrowingLists) {
          const data = { user_id: userId, book_id: record.book_id };
          const response = await axios.post('http://localhost:5000/api/borrowing_records', data);

          // If adding book to BorrowingRecord is successful, remove it from borrowingLists
          if (response.status === 201) {
            try {
              await axios.delete(`http://localhost:5000/api/shopping_cart/${userId}/${record.book_id}`);
            } catch (deleteError) {
              console.error('Error deleting book from borrowing list:', deleteError);
              failedRecords.push(record);
            }
          } else {
            failedRecords.push(record);
          }
        }

        // Display message about failed records, if any
        if (failedRecords.length > 0) {
          const failedTitles = failedRecords.map(record => record.title).join(', ');
          this.$message.error(`Failed to borrow books: ${failedTitles}`);
        } else {
          this.$message.success('All books borrowed successfully!');
        }
      } catch (error) {
        console.error('Error borrowing all books:', error);
        this.$message.error('Failed to borrow books. Please try again.');
      }
    },

    logout() {
      // Perform logout logic, e.g., clear localStorage, redirect to login page, etc.
    }
  },
  mounted() {
    this.fetchBorrowingLists();
    this.fetchBorrowingRecords();
    const currentUser = localStorage.getItem('currentUser');
    if (currentUser) {
      this.currentUser = currentUser;
    }
  }
};
</script>

<style scoped>
ul {
  padding-left: 0;
}

/* Styles for the profile page */
.profile-container {
  max-width: 800px;
  margin: 0 auto;
  padding: 20px;
}

.header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 20px;
}

.header h1 {
  margin: 0;
  font-size: 24px;
  color: #333;
}

.user-container {
  display: flex;
  align-items: center;
}

.user-info {
  margin-right: 10px;
}

.change-password {
  display: flex
}

.borrowing-records,
.change-password {
  margin-bottom: 30px;
  padding: 0;
}

.borrowing-records h2,
.change-password h2 {
  margin-bottom: 10px;
  font-size: 20px;
  color: #333;
}

.record-item {
  margin-bottom: 15px;
  border: 2px solid #e0e0e0;
  list-style-type: none;
  padding: 20px;
  border-radius: 10px;
  display: flex;
  justify-content: space-between;
  transition-duration: 0.2s;
}

.record-item:hover {
  background-color: #f3f3f3;
}

.password-input {
  width: calc(100% - 160px);
  margin-right: 10px;
  margin-bottom: 10px;
}

.password-button {
  width: 150px;
  text-align: right;
}

.rec-title {
  font-weight: bold;
  font-size: larger;
  margin-top: 0;
  margin-bottom: 10px;
}

.book-info-container {
  display: flex;
  margin-top: 0;
}

.book-info-container-record {
  display: flex;
  margin-top: 0;
  flex-direction: column;
}

.book-info {
  margin-right: 10px;
}

.button-container {
  width: auto;
  margin: auto;
  margin-right: 0px;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
}
</style>
