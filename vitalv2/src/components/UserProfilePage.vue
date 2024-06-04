<template>
  <div class="profile-page">
    <!-- Header Section -->
    <header class="header">
      <h1 @click="goToBookList">ViTAL LMS <span style="color: gray;" class="lightTitle">MY PROFILE</span></h1>
      <div class="user-container">
        <span v-if="currentUser" class="user-info">Welcome, {{ currentUser }}</span>
        <el-tooltip v-if="currentUser" content="Notification Box" placement="top">
          <el-button v-if="currentUser" @click="openNotificationBox" icon="el-icon-message-solid" circle></el-button>
        </el-tooltip>
        <el-button v-if="currentUser" type="danger" @click="logout">Logout</el-button>
        <el-button v-else type="primary" @click="goToLogin">Login or Signup</el-button>
      </div>
    </header>


    <div class="profile-container">
      <el-button icon="el-icon-arrow-left" type="text" class="returnBooklist" @click="goToBookList">Return
        Booklist</el-button>

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
            <div class="button-container-list">
              <el-tooltip content="Reserve Book" placement="top">
                <el-button v-if="record.quantity == 0" style="width: 55px; height: 55px;" type="warning"
                  icon="el-icon-time" @click="reserveBook(record.book_id)" circle></el-button>
              </el-tooltip>
              <el-tooltip content="Delete Book" placement="top">
                <el-button style="width: 55px; height: 55px;" type="danger" icon="el-icon-delete"
                  @click="deleteBook(record.book_id)" circle></el-button>
              </el-tooltip>
            </div>
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
              <el-tooltip content="If you have any question, please contant ViTAL librarian." placement="top-start">
                <p class="rec-title-location"><span style="font-weight: normal; color: black;">Please fetch the book at
                  </span>{{ record.location }}</p>
              </el-tooltip>
              <div class="book-info-container-record">
                <div class="book-info"><strong>Author:</strong> {{ record.author }}</div>
                <div class="book-info"><strong>Borrowed from:</strong> {{ record.borrow_date }}</div>
                <div class="book-info"><strong>Due to:</strong> {{ record.return_date }}</div>
                <div class="book-info"><strong>Renewed:</strong> {{ record.extension_count }}</div>
              </div>
            </div>
            <div class="button-container">
              <el-tooltip content="You can renew 3 times, 30 days each time, for each book." placement="top">
                <el-button style="width: 180px; height: 45px; border-radius: 100px;" type="primary"
                  icon="el-icon-refresh" @click="renewBook(record.record_id)" plain>Renew</el-button>
              </el-tooltip>
              <el-button v-if="record.is_returning == true"
                style="width: 180px; height: 45px; margin-left: 0px; margin-top: 10px; border-radius: 100px;"
                type="warning" icon="el-icon-refresh-left" @click="cancelReturnBook(record.record_id)">Cancel
                Return</el-button>
              <el-button v-else
                style="width: 180px; height: 45px; margin-left: 0px; margin-top: 10px; border-radius: 100px;"
                type="primary" icon="el-icon-refresh-left" @click="check_out(record.record_id)">Return</el-button>
            </div>
          </li>
        </ul>
      </div>

      <!-- Reservation Table -->
      <div class="borrowing-records">
        <h2>{{ reservationInfo }}</h2>
        <ul v-if="currentUser && reservations.length > 0">
          <li v-for="record in reservations" :key="record.reservation_id" class="record-item">
            <div class="book-container">
              <p class="rec-title">{{ record.title }}</p>
              <div class="book-info-container-record">
                <div class="book-info"><strong>Author:</strong> {{ record.author }}</div>
                <div class="book-info"><strong>Quantity:</strong> {{ record.quantity }}</div>
                <div class="book-info"><strong>Reserve time:</strong> {{ record.reservation_date }}</div>
              </div>
            </div>
            <div class="button-container">
              <el-button style="width: 125px; height: 45px; margin-left: 0px; margin-top: 10px; border-radius: 100px;"
                type="danger" icon="el-icon-close" @click="cancelResv(record.reservation_id)">Cancel</el-button>
            </div>
          </li>
        </ul>
      </div>

      <!-- Change Password Section -->
      <h2 v-if="currentUser" style="font-size: 20px;">Change Password</h2>
      <div v-if="currentUser" class="change-password">
        <div class="password-input">
          <el-input v-model="newPassword" type="password" placeholder="Enter new password"></el-input>
        </div>
        <div class="password-button">
          <el-button type="primary" @click="changePassword">Change Password</el-button>
        </div>
      </div>

      <!-- Failed Borrowing Records Dialog -->
      <el-dialog title="User Reserve Lists" :visible.sync="reserveBookDialogVisible">
        <el-table :data="failedRecords" style="width: 100%">
          <el-table-column min-width="50%" prop="title" label="Title"></el-table-column>
          <el-table-column min-width="20%" prop="author" label="Author"></el-table-column>
          <el-table-column min-width="20%" prop="quantity" label="Quantity"></el-table-column>
          <el-table-column min-width="10%" label="">
            <template slot-scope="scope">
              <el-tooltip content="Reserve Book" placement="top">
                <el-button style="width: 50px; height: 50px;" type="warning" icon="el-icon-time"
                  @click="reserveBook(scope.row.book_id)" circle>
                </el-button>
              </el-tooltip>
            </template>
          </el-table-column>
        </el-table>
        <div slot="footer" class="dialog-footer">
          <el-button @click="reserveBookDialogVisible = false">Close</el-button>
        </div>
      </el-dialog>

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

      <!-- Checkout Dialog -->
      <el-dialog title="Check-out" :visible.sync="checkoutDialogVisible">
        <div class="check-container">
          <div class="check-container-left">
            <div class="check-bookname">{{ now_checking_book }}</div>
            <div class="check-info">Warning: You have to return the book in 7 days, or your payment will refund.<br>(if your
              book
              isn't overdue)</div>
            <div class="check-title">Borrowed From</div>
            <div class="check-date">{{ now_checking_date }}</div>
            <div class="check-title">You have borrowed</div>
            <div class="check-date-count">{{ diff_days }} Days</div>
            <div class="check-title">Remaining Time</div>
            <div class="check-date-count">{{ remain_days }} Days</div>
            <div class="check-title">Total Fee is</div>
            <div class="check-fee-count">{{ fee }} $</div>
          </div>
          <div class="check-container-right">
            <img ref="payment_img" src="http://localhost:5000/covers/AlipayPayment.png" alt="Payment QR Code">
            <el-button @click="switch_payment">{{ payment_text }}</el-button>
          </div>
        </div>
        <div slot="footer" class="dialog-footer">
          <el-button @click="checkoutDialogVisible = false">Close</el-button>
          <el-button type="primary" @click="returnBook(now_checking_id)">Pay</el-button>
        </div>
      </el-dialog>

    </div>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  data() {
    return {
      currentUser: null,
      currentUserId: null,
      borrowingLists: [],
      BorrowingListInfo: 'Borrowing List',
      borrowingRecords: [],
      borrowingRecordInfo: 'Borrowing Record',
      reservationInfo: 'Reservations',
      reservations: [],
      failedRecords: [],
      reserveBookDialogVisible: false,
      checkoutDialogVisible: false,
      newPassword: '',
      notificationText: 'No Text',
      notificationDialogVisible: false,
      notificationTextDialogVisible: false,
      userNotifications: [],
      now_checking_id: null,
      now_checking_book: 'BOOK TITLE',
      now_checking_date: 'NO DATE',
      payment_text: 'Use Wechat Pay',
      diff_days: 0,
      remain_days: 0,
      fee: 0.5
    };
  },
  methods: {
    check_out(record_id) {
      this.now_checking_id = record_id;
      let record_json = JSON.parse(JSON.stringify(this.borrowingRecords));
      let i = 0;
      let now_record = {};
      for (i; i < record_json.length; ++i) {
        if (record_json[i].record_id == record_id) {
          now_record = record_json[i];
          break;
        }
      }
      this.now_checking_book = now_record.title;
      let utc_time = (now_record.borrow_date.split('.')[0]).split('T');
      let utc_return_time = (now_record.return_date.split('.')[0]).split('T');

      this.now_checking_date = utc_time[0] + ' ' + utc_time[1];

      let date = Date.parse(this.now_checking_date);
      let ret_date = Date.parse(utc_return_time[0] + ' ' + utc_return_time[1])

      let diffDate = Date.now() - date;
      let diffRetDate = ret_date - Date.now();

      this.diff_days = Math.floor(diffDate / (1000 * 3600 * 24));
      this.remain_days = Math.floor(diffRetDate / (1000 * 3600 * 24));

      this.checkoutDialogVisible = true;
      this.fee = Math.max(0.3, 0.2 * (this.diff_days / 7));
    },
    switch_payment() {
      if (this.payment_text == 'Use Wechat Pay') {
        let img = this.$refs.payment_img;
        img.src = 'http://localhost:5000/covers/WechatPayment.png'
        this.payment_text = 'Use Alipay';
      }
      else {
        let img = this.$refs.payment_img;
        img.src = 'http://localhost:5000/covers/AlipayPayment.png'
        this.payment_text = 'Use Wechat Pay';
      }
    },
    async fetchBorrowingRecords() {
      try {
        const userId = localStorage.getItem('currentUserId');
        if (!userId) {
          this.borrowingRecordInfo = 'Not logged in yet, please Login first.';
        }
        const response = await axios.get(`http://localhost:5000/api/user_borrowing_records/${userId}`);
        this.borrowingRecords = response.data;
        console.log(this.borrowingRecords)
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
          this.$message.info('You received a notification.');
        }
        else {
          this.$message.success('You have no new notification now.');
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
      for (i = 0; i < noti_json.length; ++i) {
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
        this.fetchBorrowingLists();
      } catch (error) {
        console.error('Error removing book from borrowing list:', error);
        this.$message.error('Failed to remove book. Please try again.');
      }
    },
    async cancelReturnBook(record_id) {
      try {
        const data = { record_id: record_id };
        await axios.post(`http://localhost:5000/api/borrowing_records/cancel_user_return`, data);
        this.fetchBorrowingRecords();
        this.$message.success('Book return request canceled successfully!');
      } catch (error) {
        this.$message.error('Failed to cancel book return.');
      }
    },
    async returnBook(record_id) {
      try {
        const data = { record_id: record_id };
        await axios.post(`http://localhost:5000/api/borrowing_records/user_return`, data);
        this.fetchBorrowingRecords();
        this.$message.success('Book return request created successfully!');
        this.checkoutDialogVisible = false;
      } catch (error) {
        this.$message.error('Failed to return book.');
      }
    },
    async deleteRecord(record_id) {
      try {
        await axios.delete(`http://localhost:5000/api/borrowing_records/${record_id}`);
        this.fetchBorrowingRecords();
        this.$message.success('Book returned successfully!');
      } catch (error) {
        this.$message.error('Failed to return book.');
      }
    },
    async renewBook(record_id) {
      try {
        const res = await axios.put(`http://localhost:5000/api/borrowing_records/extend/${record_id}`);
        this.fetchBorrowingRecords();
        this.$message.success(res.data.message);
      } catch (error) {
        this.$message.error(error.response.data.message);
      }
    },
    async borrowAllBooks() {
      try {
        const userId = localStorage.getItem('currentUserId');
        const failedRecords = [];

        // Iterate over borrowingLists and try to add each book to BorrowingRecord
        for (const record of this.borrowingLists) {
          const data = { user_id: userId, book_id: record.book_id };
          console.log(data)
          const response = await axios.post('http://localhost:5000/api/borrowing_records', data);

          // If adding book to BorrowingRecord is successful, remove it from borrowingLists
          if (response.status === 201) {
            try {
              await axios.delete(`http://localhost:5000/api/shopping_cart/${userId}/${record.book_id}`);
              this.fetchBorrowingRecords();
              this.fetchBorrowingLists();
            } catch (deleteError) {
              console.error('Error deleting book from borrowing list:', deleteError);
              failedRecords.push(record);
            }
          } else {
            failedRecords.push(record);
          }
        }
        this.failedRecords = failedRecords;

        // Display message about failed records, if any
        if (failedRecords.length > 0) {
          const failedTitles = failedRecords.map(record => record.title).join(', ');
          this.$message.error(`Failed to borrow books: ${failedTitles}`);
          this.reserveBookDialogVisible = true;
        } else {
          this.$message.success('All books borrowed successfully!');
        }
      } catch (error) {
        // console.error('Error borrowing all books:', error);
        this.$message.error(error.response.data.error);
      }
    },
    async reserveBook(book_id) {
      try {
        const userId = localStorage.getItem('currentUserId');
        await axios.post('http://localhost:5000/api/reservations', { user_id: userId, book_id: book_id });
        this.$message.success('Book reserved successfully!');
        this.deleteBook(book_id);
        this.fetchResv();
      } catch (error) {
        this.$message.error(error.response.data.message);
      }
    },
    async fetchResv() {
      try {
        const userId = localStorage.getItem('currentUserId');
        if (!userId) {
          this.reservationInfo = 'Not logged in yet, please Login first.';
        }
        const response = await axios.get(`http://localhost:5000/api/reservations/user/${userId}`);
        this.reservations = response.data;
      } catch (error) {
        console.error('Error fetching reservation lists:', error);
      }
    },
    async cancelResv(resv_id) {
      try {
        await axios.delete(`http://localhost:5000/api/reservations/${resv_id}`);
        this.$message.success('Reservation canceled successfully!');
        this.fetchResv();
      } catch (error) {
        this.$message.error('Failed to cancel reservation. Please try again.');
      }
    },
    logout() {
      localStorage.removeItem('currentUser');
      localStorage.removeItem('currentUserId');
      this.$router.push({ name: 'Login' });
      this.$message.info('Logged Out.');
      // Perform logout logic, e.g., clear localStorage, redirect to login page, etc.
    }
  },
  mounted() {
    this.fetchBorrowingLists();
    this.fetchBorrowingRecords();
    this.fetchResv();
    const currentUser = localStorage.getItem('currentUser');
    const currentUserId = localStorage.getItem('currentUserId');
    if (currentUser && currentUserId) {
      this.currentUser = currentUser;
      this.currentUserId = currentUserId;
      this.fetchNotifications();
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
  margin: auto;
  padding-top: 170px;
}

.header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 20px;
  width: 100%;
  height: 150px;
  background-color: #dbdbdb80;
  padding: 40px;
  box-sizing: border-box;
  position: fixed;
  top: 0;
  backdrop-filter: blur(10px);
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
  margin-top: 0;
  font-size: larger;
}

.rec-title-location {
  font-weight: bold;
  color: #881010;
  width: auto;
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

.button-container-list {
  width: auto;
  margin: auto;
  margin-right: 0px;
  display: flex;
  justify-content: center;
  align-items: center;
}

.lightTitle {
  font-weight: lighter;
}

.returnBooklist {
  font-size: large;
}

.check-container {
  display: flex;
  justify-content: space-around;
  align-items: center;
}

.check-bookname {
  font-size: 40px;
  font-weight: bolder;
}

.check-info {
  font-weight: lighter;
}

.check-title {
  font-size: 30px;
  margin-top: 10px;
}

.check-date, .check-date-count {
  font-size: 20px;
}

.check-fee-count {
  font-size: 35px;
  color: #881010;
  flex: 1;
}

.check-container-left {
  display: flex;
  flex-direction: column;
  justify-content: space-around;
}

.check-container-right {
  display: flex;
  flex-direction: column;
  justify-content: space-around;
  align-items: center;
}
</style>
