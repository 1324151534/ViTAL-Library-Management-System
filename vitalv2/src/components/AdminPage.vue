<template>
    <div class="admin-container">
        <!-- Header Section -->
        <header class="header">
            <h2>ViTAL <span style="font-weight: normal">LMS <span style="color: gray;">CONTROL PANEL</span></span></h2>
            <div class="user-container">
                <p v-if="currentAdminId" class="admin-top">Welcome, {{ currentAdminName }}</p>
                <p v-else class="admin-top">Please login first.</p>
                <el-button type="danger" class="admin-top logout-btn" v-if="currentAdminId"
                    @click="logout">Logout</el-button>
            </div>
        </header>


        <!-- Manage Books Section -->
        <div v-if="currentAdminId" class="manage-section first-section">
            <el-button icon="el-icon-arrow-left" type="text" class="enterDashboard" @click="enterDashboard">Return
                Dashboard</el-button>
            <h2>Manage Books</h2>
            <div class="search-add-container">
                <el-input v-model="searchBook" placeholder="Search Books" @input="fetchBooks"></el-input>
                <el-button style="margin-left: 10px;" type="primary" @click="openAddBookDialog">Add Book</el-button>
            </div>
            <el-table :data="books" style="width: 100%" empty-text="No Book Available">
                <el-table-column min-width="20%" prop="book_id" label="ID"></el-table-column>
                <el-table-column min-width="150%" prop="title" label="Title"></el-table-column>
                <el-table-column min-width="80%" prop="author" label="Author"></el-table-column>
                <el-table-column min-width="40%" prop="quantity" label="Quantity"></el-table-column>
                <el-table-column min-width="75%">
                    <template slot-scope="scope">
                        <el-button @click="editBook(scope.row)">Edit</el-button>
                        <el-button type="danger" @click="delBook(scope.row)">Delete</el-button>
                    </template>
                </el-table-column>
            </el-table>
        </div>

        <div v-else class="manage-section">
            <h2>Librarian Account Needed.</h2>
            <h3>Please contant server admin if you have questions.</h3>
        </div>

        <!-- Manage Return Book Request Section -->
        <div v-if="currentAdminId" class="manage-section">
            <h2>Manage Return Book Requests</h2>
            <el-table :data="requests" style="width: 100%" empty-text="No Request Available">
                <el-table-column min-width="30%" prop="record_id" label="Record ID"></el-table-column>
                <el-table-column min-width="40%" prop="title" label="Book Title"></el-table-column>
                <el-table-column min-width="30%" prop="username" label="Username"></el-table-column>
                <el-table-column min-width="30%">
                    <template slot-scope="scope">
                        <el-button type="success" @click="confirmReturn(scope.row.record_id)">Confirm</el-button>
                        <el-button type="danger" @click="refuseReturn(scope.row.record_id)">Refuse</el-button>
                    </template>
                </el-table-column>
            </el-table>
        </div>

        <div v-else class="manage-section">
            <h2>Librarian Account Needed.</h2>
            <h3>Please contant server admin if you have questions.</h3>
        </div>

        <!-- Manage Users Section -->
        <div v-if="currentAdminId" class="manage-section">
            <h2>Manage Users</h2>
            <div class="search-add-container">
                <el-input v-model="searchUser" placeholder="Search Users" @input="fetchUsers"></el-input>
                <el-button type="primary" style="margin-left: 10px;" @click="openSendNotification()">Send
                    Notification</el-button>
            </div>
            <el-table :data="users" style="width: 100%" empty-text="No User Available">
                <el-table-column min-width="20%" prop="username" label="Username"></el-table-column>
                <el-table-column min-width="80%">
                    <template slot-scope="scope">
                        <el-button @click="viewBorrowingRecords(scope.row.id)">View Borrowing Records</el-button>
                        <el-button @click="viewShoppingCart(scope.row.id)">View Borrowing List</el-button>
                        <el-button @click="viewReservations(scope.row.id)">View Reservations</el-button>
                        <el-button @click="viewNotifications(scope.row.id)">View Notifications</el-button>
                    </template>
                </el-table-column>
            </el-table>
        </div>

        <!-- Edit Book Dialog -->
        <el-dialog title="Edit Book" :visible.sync="editBookDialogVisible">
            <el-form :model="editBookForm">
                <el-form-item label="Title">
                    <el-input v-model="editBookForm.title"></el-input>
                </el-form-item>
                <el-form-item label="Author">
                    <el-input v-model="editBookForm.author"></el-input>
                </el-form-item>
                <el-form-item label="Quantity">
                    <el-input v-model="editBookForm.quantity" type="number"></el-input>
                </el-form-item>
                <el-form-item label="ISBN">
                    <el-input v-model="editBookForm.isbn"></el-input>
                </el-form-item>
                <el-form-item label="Type">
                    <el-input v-model="editBookForm.type"></el-input>
                </el-form-item>
                <el-form-item label="Cover Image">
                    <el-input v-model="editBookForm.cover_image"></el-input>
                </el-form-item>
                <el-form-item label="Location">
                    <el-input v-model="editBookForm.location"></el-input>
                </el-form-item>
                <el-form-item label="Description">
                    <el-input type="textarea" v-model="editBookForm.description"></el-input>
                </el-form-item>
                <el-form-item label="Published Date">
                    <el-date-picker v-model="editBookForm.published_date" type="date"
                        placeholder="Select date"></el-date-picker>
                </el-form-item>
            </el-form>
            <div slot="footer" class="dialog-footer">
                <el-button @click="editBookDialogVisible = false">Cancel</el-button>
                <el-button type="primary" @click="updateBook">Save</el-button>
            </div>
        </el-dialog>

        <!-- Add Book Dialog -->
        <el-dialog title="Add Book" :visible.sync="addBookDialogVisible">
            <el-form :model="newBookForm">
                <el-form-item label="Title">
                    <el-input v-model="newBookForm.title"></el-input>
                </el-form-item>
                <el-form-item label="Author">
                    <el-input v-model="newBookForm.author"></el-input>
                </el-form-item>
                <el-form-item label="Quantity">
                    <el-input v-model="newBookForm.quantity" type="number"></el-input>
                </el-form-item>
                <el-form-item label="ISBN">
                    <el-input v-model="newBookForm.isbn"></el-input>
                </el-form-item>
                <el-form-item label="Type">
                    <el-input v-model="newBookForm.type"></el-input>
                </el-form-item>
                <el-form-item label="Cover Image">
                    <el-input v-model="newBookForm.cover_image"></el-input>
                </el-form-item>
                <el-form-item label="Location">
                    <el-input v-model="newBookForm.location"></el-input>
                </el-form-item>
                <el-form-item label="Description">
                    <el-input type="textarea" v-model="newBookForm.description"></el-input>
                </el-form-item>
                <el-form-item label="Published Date">
                    <el-date-picker v-model="newBookForm.published_date" type="date"
                        placeholder="Select date"></el-date-picker>
                </el-form-item>
            </el-form>
            <div slot="footer" class="dialog-footer">
                <el-button @click="addBookDialogVisible = false">Cancel</el-button>
                <el-button type="primary" @click="addBook">Add</el-button>
            </div>
        </el-dialog>

        <!-- User Borrowing Lists Dialog -->
        <el-dialog title="User Borrowing List" :visible.sync="shoppingCartDialogVisible">
            <el-table :data="userShoppingCart" style="width: 100%">
                <el-table-column min-width="60%" prop="title" label="Title"></el-table-column>
                <el-table-column min-width="30%" prop="author" label="Author"></el-table-column>
                <el-table-column min-width="30%" prop="quantity" label="Quantity"></el-table-column>
            </el-table>
            <div slot="footer" class="dialog-footer">
                <el-button @click="shoppingCartDialogVisible = false">Close</el-button>
            </div>
        </el-dialog>

        <!-- User Borrowing Records Dialog -->
        <el-dialog title="User Borrowing Records" :visible.sync="borrowingRecordsDialogVisible" width="75%">
            <el-table :data="userBorrowingList" style="width: 100%">
                <el-table-column min-width="55%" prop="title" label="Title"></el-table-column>
                <el-table-column min-width="40%" prop="author" label="Author"></el-table-column>
                <el-table-column min-width="60%" prop="borrow_date" label="Borrow from"></el-table-column>
                <el-table-column min-width="60%" prop="return_date" label="Due to"></el-table-column>
                <el-table-column min-width="30%" prop="extension_count" label="Renewed"></el-table-column>
            </el-table>
            <div slot="footer" class="dialog-footer">
                <el-button @click="borrowingRecordsDialogVisible = false">Close</el-button>
            </div>
        </el-dialog>

        <!-- User Reservations Dialog -->
        <el-dialog title="User Reservations" :visible.sync="reservationsDialogVisible">
            <el-table :data="userReservations" style="width: 100%">
                <el-table-column min-width="70%" prop="title" label="Title"></el-table-column>
                <el-table-column min-width="30%" prop="author" label="Author"></el-table-column>
                <el-table-column min-width="20%" prop="quantity" label="Quantity"></el-table-column>
                <el-table-column min-width="60%" prop="reservation_date" label="Resv Date"></el-table-column>
            </el-table>
            <div slot="footer" class="dialog-footer">
                <el-button @click="reservationsDialogVisible = false">Close</el-button>
            </div>
        </el-dialog>

        <!-- User Notification Dialog -->
        <el-dialog title="User Notifications" :visible.sync="notificationDialogVisible" width="75%">
            <el-table :data="userNotifications" style="width: 100%">
                <el-table-column min-width="40%" prop="user_username" label="User"></el-table-column>
                <el-table-column min-width="30%" prop="admin_username" label="Librarian"></el-table-column>
                <el-table-column min-width="20%" prop="notification_state" label="State"></el-table-column>
                <el-table-column min-width="30%" prop="notification_level" label="Level"></el-table-column>
                <el-table-column min-width="60%" prop="notification_date" label="Date"></el-table-column>
                <el-table-column min-width="50%">
                    <template slot-scope="scope">
                        <el-button @click="viewText(scope.row.id)">View Text</el-button>
                        <el-button type="danger" @click="deleteNotification(scope.row.id)">Delete</el-button>
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

        <!-- Send Notification Dialog -->
        <el-dialog title="Send Notification" :visible.sync="sendNotificationDialogVisible">
            <el-form :model="sendNotificationForm">
                <el-form-item label="">
                    <el-table :data="users" style="width: 100%" empty-text="No User Available"
                        @row-click="handleRowClick">
                        <el-table-column min-width="25%" label="User ID">
                            <template slot-scope="scope">
                                <el-radio :label="scope.row.id" v-model="sendNotificationForm.user_id"
                                    @change.native="getCurrentRow(scope.row)"></el-radio>
                            </template>
                        </el-table-column>
                        <el-table-column min-width="75%" prop="username" label="Username"></el-table-column>
                    </el-table>
                </el-form-item>
                <el-form-item label="Notification Text">
                    <el-input type="textarea" v-model="sendNotificationForm.notification_text"></el-input>
                </el-form-item>
                <el-form-item label="Notification Level">
                    <el-radio v-model="sendNotificationForm.notification_level" label="warning">Warning</el-radio>
                    <el-radio v-model="sendNotificationForm.notification_level" label="danger">Danger</el-radio>
                </el-form-item>
            </el-form>
            <div slot="footer" class="dialog-footer">
                <el-button @click="sendNotificationDialogVisible = false">Cancel</el-button>
                <el-button type="primary" @click="sendNotification">Send</el-button>
            </div>
        </el-dialog>
    </div>
</template>

<script>
import axios from 'axios';

export default {
    data() {
        return {
            books: [],
            requests: [],
            users: [],
            searchBook: '',
            searchUser: '',
            editBookDialogVisible: false,
            addBookDialogVisible: false,
            shoppingCartDialogVisible: false,
            borrowingRecordsDialogVisible: false,
            reservationsDialogVisible: false,
            sendNotificationDialogVisible: false,
            notificationDialogVisible: false,
            notificationTextDialogVisible: false,
            userShoppingCart: [],
            userBorrowingList: [],
            userReservations: [],
            userNotifications: [],
            currentAdminId: null,
            currentAdminName: null,
            notificationText: 'No Text',
            sendNotificationForm: {
                user_id: '',
                notification_text: '',
                notification_level: 'warning'
            },
            editBookForm: {
                title: '',
                author: '',
                quantity: 0,
                isbn: '',
                type: '',
                cover_image: '',
                location: '',
                description: '',
                published_date: null,
                book_id: null
            },
            newBookForm: {
                title: '',
                author: '',
                quantity: 0,
                isbn: '',
                type: '',
                cover_image: '',
                location: '',
                description: '',
                published_date: null
            }
        };
    },
    methods: {
        handleRowClick(row) {
            this.sendNotificationForm.user_id = row.id;
        },
        async fetchBooks() {
            const adminUsername = localStorage.getItem('currentAdminUsername');
            const adminId = localStorage.getItem('currentAdminId');
            if (adminId && adminUsername) {
                this.currentAdminId = adminId;
                this.currentAdminName = adminUsername;
            }
            try {
                const response = await axios.get(`http://localhost:5000/api/books?search=${this.searchBook}`);
                this.books = response.data;
            } catch (error) {
                console.error('Error fetching books:', error);
            }
        },
        async fetchRequests() {
            try {
                const response = await axios.get(`http://localhost:5000/api/user_borrowing_records/requests`);
                this.requests = response.data;
            } catch (error) {
                console.error('Error fetching users:', error);
            }
        },
        async fetchUsers() {
            try {
                const response = await axios.get(`http://localhost:5000/api/users?search=${this.searchUser}`);
                this.users = response.data;
            } catch (error) {
                console.error('Error fetching users:', error);
            }
        },
        async confirmReturn(record_id) {
            try {
                await axios.delete(`http://localhost:5000/api/borrowing_records/${record_id}`);
                this.fetchRequests();
                this.$message.success('Book returned successfully!');
            } catch (error) {
                this.$message.error('Failed to return book.');
            }
        },
        async refuseReturn(record_id) {
            try {
                const data = { record_id: record_id };
                await axios.post(`http://localhost:5000/api/borrowing_records/cancel_user_return`, data);
                this.fetchRequests();
                this.$message.success('Book return request canceled successfully!');
            } catch (error) {
                this.$message.error('Failed to cancel book return.');
            }
        },
        editBook(book) {
            this.editBookForm = { ...book, published_date: book.published_date ? new Date(book.published_date) : null };
            this.editBookDialogVisible = true;
        },
        async delBook(book) {
            try {
                await axios.delete(`http://localhost:5000/api/books/${book.book_id}`);
                this.fetchBooks();
                this.$message.success('Book deleted successfully!');
            } catch (error) {
                console.error('Error deleting book:', error);
                this.$message.error('Failed to delete book.');
            }
        },
        async deleteNotification(noti_id) {
            try {
                await axios.delete(`http://localhost:5000/api/notifications/${noti_id}`);
                this.notificationDialogVisible = false;
                this.$message.success('Notification deleted successfully!');
            } catch (error) {
                console.error('Error deleting notification:', error);
                this.$message.error('Failed to delete notification.');
            }
        },
        async updateBook() {
            try {
                await axios.put(`http://localhost:5000/api/books/${this.editBookForm.book_id}`, {
                    title: this.editBookForm.title,
                    author: this.editBookForm.author,
                    quantity: this.editBookForm.quantity,
                    isbn: this.editBookForm.isbn,
                    type: this.editBookForm.type,
                    cover_image: this.editBookForm.cover_image,
                    location: this.editBookForm.location,
                    description: this.editBookForm.description,
                    published_date: this.editBookForm.published_date ? this.editBookForm.published_date.toISOString().split('T')[0] : null
                });
                this.editBookDialogVisible = false;
                this.fetchBooks();
                this.$message.success('Book updated successfully!');
            } catch (error) {
                console.error('Error updating book:', error);
                this.$message.error('Failed to update book.');
            }
        },
        openAddBookDialog() {
            this.addBookDialogVisible = true;
        },
        enterDashboard() {
            this.$router.push({ name: 'AdminDashboard' });
        },
        async addBook() {
            try {
                await axios.post(`http://localhost:5000/api/books`, {
                    title: this.newBookForm.title,
                    author: this.newBookForm.author,
                    quantity: this.newBookForm.quantity,
                    isbn: this.newBookForm.isbn,
                    type: this.newBookForm.type,
                    cover_image: this.newBookForm.cover_image,
                    location: this.newBookForm.location,
                    description: this.newBookForm.description,
                    published_date: this.newBookForm.published_date ? this.newBookForm.published_date.toISOString().split('T')[0] : null
                });
                this.addBookDialogVisible = false;
                this.fetchBooks();
                this.$message.success('Book added successfully!');
            } catch (error) {
                console.error('Error adding book:', error);
                this.$message.error('Failed to add book.');
            }
        },
        async sendNotification() {
            try {
                await axios.post(`http://localhost:5000/api/notifications`, {
                    user_id: this.sendNotificationForm.user_id,
                    admin_id: this.currentAdminId,
                    notification_text: this.sendNotificationForm.notification_text,
                    notification_level: this.sendNotificationForm.notification_level
                });
                this.sendNotificationDialogVisible = false;
                this.$message.success('Notification sent successfully!');
            } catch (error) {
                console.error('Error sending notification:', error);
                this.$message.error('Failed to send notification.');
            }
        },
        async viewBorrowingRecords(userId) {
            try {
                const response = await axios.get(`http://localhost:5000/api/user_borrowing_records/${userId}`);
                if (response.data.length > 0) {
                    this.userBorrowingList = response.data;
                    this.borrowingRecordsDialogVisible = true;
                }
                else {
                    this.$message.error('User Borrowing Record is Empty.');
                }
            } catch (error) {
                this.$message.error('Error fetching user Borrowing Record.');
                console.error('Error fetching user Borrowing Record:', error);
            }
        },
        async viewReservations(userId) {
            try {
                const response = await axios.get(`http://localhost:5000/api/reservations/user/${userId}`);
                if (response.data.length > 0) {
                    this.userReservations = response.data;
                    this.reservationsDialogVisible = true;
                }
                else {
                    this.$message.error('User Reservation is Empty.');
                }
            } catch (error) {
                this.$message.error('Error fetching user Reservations.');
                console.error('Error fetching user Reservations:', error);
            }
        },
        async viewShoppingCart(userId) {
            try {
                const response = await axios.get(`http://localhost:5000/api/shopping_cart/${userId}`);
                if (response.data.length > 0) {
                    this.userShoppingCart = response.data;
                    this.shoppingCartDialogVisible = true;
                }
                else {
                    this.$message.error('User Borrowing List is Empty.');
                }
            } catch (error) {
                this.$message.error('Error fetching user Borrowing List.');
                console.error('Error fetching user Borrowing List:', error);
            }
        },
        async viewNotifications(userId) {
            try {
                const response = await axios.get('http://localhost:5000/api/notifications', {
                    params: {
                        user_id: userId
                    }
                });                
                if (response.data.length > 0) {
                    this.userNotifications = response.data;
                    this.notificationDialogVisible = true;
                }
                else {
                    this.$message.error('User Notifications List is Empty.');
                }
            } catch (error) {
                this.$message.error('Error fetching user Notifications.');
                console.error('Error fetching user Notifications:', error);
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
        openSendNotification() {
            this.sendNotificationDialogVisible = true;
        },
        logout() {
            localStorage.removeItem('currentAdminUsername');
            localStorage.removeItem('currentAdminId');
            this.$router.push({ name: 'AdminLogin' });
            this.$message.info('Logged Out.');
        }
    },
    mounted() {
        this.fetchBooks();
        this.fetchUsers();
        this.fetchRequests();
    }
};
</script>

<style scoped>
.first-section {
    padding-top: 170px;
}

.admin-top {
    font-size: larger;
    font-weight: lighter;
    margin-left: 5px;
}

.header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 20px;
    background-color: #dbdbdb80;
    width: 100%;
    padding: 40px;
    box-sizing: border-box;
    margin-bottom: 40px;
    position: fixed;
    backdrop-filter: blur(10px);
    box-sizing: border-box;
    z-index: 999;
}

.user-container {
    display: flex;
    align-items: center;
}

.manage-section {
    width: 80%;
    min-width: 400px;
    max-width: 900px;
    margin: auto;
    margin-bottom: 40px;
}

.search-add-container {
    display: flex;
    justify-content: space-between;
    margin-bottom: 20px;
}

.search-container {
    margin-bottom: 20px;
}

.el-table {
    margin-bottom: 20px;
}

.pie-wrap {
    width: 100%;
    height: 400px;
}

.logout-btn {
    margin-left: 20px;
}

.enterDashboard {
    font-size: large;
}
</style>