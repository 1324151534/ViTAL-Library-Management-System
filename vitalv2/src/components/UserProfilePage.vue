<template>
    <div class="profile-container">
      <!-- Header Section -->
      <header class="header">
        <h1>My Profile</h1>
        <div class="user-container">
          <span v-if="currentUser" class="user-info">Welcome, {{ currentUser }}</span>
          <el-button v-if="currentUser" type="text" @click="logout">Logout</el-button>
          <el-button v-else type="text" @click="goToLogin">Login or Signup</el-button>
        </div>
      </header>
  
      <!-- Borrowing Records Section -->
      <div class="borrowing-records">
        <h2>{{ BorrowingListInfo }}</h2>
        <ul v-if="currentUser">
          <li v-for="record in borrowingRecords" :key="record.book_id" class="record-item">
            <div class="book-container">
                <p class="rec-title">{{ record.title }}</p>
                <div class="book-info-container">
                    <div class="book-info"><strong>Author:</strong> {{ record.author }}</div>
                    <div class="book-info"><strong>Quantity:</strong> {{ record.quantity }}</div>
                </div>
            </div>
            <el-button style="width: 55px; height: 55px;" type="danger" icon="el-icon-delete" @click="deleteBook" circle></el-button>
          </li>
        </ul>
        <div v-if="currentUser" class="rec-ctrl-container">
            <el-button type="primary" @click="borrowAllBooks">Borrow All</el-button>
        </div>
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
        borrowingRecords: [],
        BorrowingListInfo: 'Borrowing List',
        newPassword: ''
      };
    },
    methods: {
      async fetchBorrowingRecords() {
        try {
          // Fetch borrowing records from the backend
          const userId = localStorage.getItem('currentUserId');
          if (!userId) {
            this.BorrowingListInfo = 'Not logged in yet, please Login first.';
          }
          const response = await axios.get('http://localhost:5000/api/shopping_cart/' + userId);
          this.borrowingRecords = response.data;
        } catch (error) {
          console.error('Error fetching borrowing records:', error);
        }
      },
      async changePassword() {
        try {
          // Send a request to the backend to change the password
          await axios.post('http://localhost:5000/api/change_password', { newPassword: this.newPassword });
          // Reset the newPassword field
          this.newPassword = '';
          // Show a success message to the user
          this.$message.success('Password changed successfully!');
        } catch (error) {
          console.error('Error changing password:', error);
          // Show an error message to the user
          this.$message.error('Failed to change password. Please try again.');
        }
      },
      goToLogin() {
          this.$router.push({ name: 'Login' });
      },
      borrowAllBooks() {
        
      },
      deleteBook() {
        
      },
      logout() {
        // Perform logout logic, e.g., clear localStorage, redirect to login page, etc.
      }
    },
    mounted() {
      // Fetch the current user's borrowing records when the component is mounted
      this.fetchBorrowingRecords();
      // Get the current user from localStorage
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
  
  .borrowing-records, .change-password {
    margin-bottom: 30px;
    padding: 0;
  }
  
  .borrowing-records h2, .change-password h2 {
    margin-bottom: 10px;
    font-size: 20px;
    color: #333;
  }
  
  .record-item {
    margin-bottom: 15px;
    border: 1px solid #333;
    list-style-type: none;
    padding: 20px;
    border-radius: 10px;
    display: flex;
    justify-content: space-between;
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

  .book-info {
    margin-right: 10px;
  }
  </style>
  