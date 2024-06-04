<template>
    <div class="dashboard-container">
        <!-- Header Section -->
        <header class="header">
            <h2>ViTAL <span style="font-weight: normal">LMS <span style="color: gray;">DASHBOARD</span></span></h2>
            <div class="user-container">
                <p v-if="currentAdminId" class="admin-top">Welcome, {{ currentAdminName }}</p>
                <p v-else class="admin-top">Please login first.</p>
                <el-button type="danger" class="admin-top logout-btn" v-if="currentAdminId" @click="logout">Logout</el-button>
            </div>
        </header>

        <!-- Main Content Section -->
        <div v-if="currentAdminId" class="main-content">
            <div class="flex-line">
                <!-- Server Status -->
                <div class="status-card">
                    <h3>Server Status</h3>
                    <p>Status: <span :class="serverStatus ? 'online' : 'offline'">{{ serverStatus ? 'Online' : 'Offline'
                            }}</span></p>
                    <h3>User Count</h3>
                    <p>Total Users: {{ userCount }}</p>
                </div>

                <!-- Basic Statistics -->
                <div class="status-card">
                    <h3>Basic Statistics</h3>
                    <ul>
                        <li>Total Books: {{ totalBooks }}</li>
                        <li>Total Borrowing Records: {{ totalBorrowingRecords }}</li>
                        <li>Total Reservations: {{ totalReservations }}</li>
                    </ul>
                </div>

                <!-- Buttons -->
                <div class="status-card">
                    <h3>Control Panel</h3>
                    <el-button type="primary" class="enterControl" @click="enterControl">Enter Control Panel</el-button>
                </div>

            </div>

            <div class="flex-line">
                <!-- Book Categories Count -->
                <div class="statistics">
                    <h3>Book Categories Count</h3>
                    <ul>
                        <li v-for="category in bookCategories" :key="category.name">
                            {{ category.name }}: {{ category.value }}
                        </li>
                    </ul>
                </div>

                <div class="statistics echarts-box">
                    <div class="echarts-container">
                        <div id="chartPie" class="pie-wrap"></div>
                    </div>
                </div>
            </div>
        </div>

        <p style="text-align: center;" v-else>Contant your server manager if you have any questions.</p>
    </div>
</template>

<script>
import axios from 'axios';
import * as echarts from 'echarts';
require('echarts/theme/macarons');//引入主题

export default {
    data() {
        return {
            serverStatus: false,
            userCount: 0,
            totalBooks: 0,
            totalBorrowingRecords: 0,
            totalReservations: 0,
            bookCategories: [],
            chartPie: null,
            currentAdminId: null,
            currentAdminName: null
        };
    },
    methods: {
        drawPieChart(bookGraphData) {
            let mytextStyle = {
                color: "#333",
                fontSize: 18,
            };
            let mylabel = {
                show: true,
                position: "right",
                offset: [30, 40],
                formatter: '{b} : {c} ({d}%)',
                textStyle: mytextStyle
            };
            this.chartPie = echarts.init(document.getElementById('chartPie'), 'macarons');
            this.chartPie.setOption({
                title: {
                    text: 'Book Categories Count Pie Chart',
                    x: 'center'
                },
                tooltip: {
                    trigger: 'item',
                    formatter: "{a} <br/>{b} : {c} ({d}%)",
                },
                series: [
                    {
                        name: 'Book Category',
                        type: 'pie',
                        radius: ['50%', '70%'],
                        center: ['50%', '50%'],
                        data: bookGraphData,
                        animationEasing: 'cubicInOut',
                        animationDuration: 2600,
                        label: {
                            emphasis: mylabel
                        }
                    }
                ]
            });
        },
        fetchData() {
            const adminUsername = localStorage.getItem('currentAdminUsername');
            const adminId = localStorage.getItem('currentAdminId');
            if (adminId && adminUsername) {
                this.currentAdminId = adminId;
                this.currentAdminName = adminUsername;
            }
            // Fetch server status
            axios.get('http://localhost:5000/api/server/status')
                .then(response => {
                    this.serverStatus = response.data.status;
                })
                .catch(error => {
                    console.error('Error fetching server status:', error);
                });

            // Fetch user count
            axios.get('http://localhost:5000/api/user/count')
                .then(response => {
                    this.userCount = response.data.user_count;
                })
                .catch(error => {
                    console.error('Error fetching user count:', error);
                });
            // Fetch basic statistics
            axios.get('http://localhost:5000/api/statistics')
                .then(response => {
                    this.totalBooks = response.data.total_books;
                    this.totalBorrowingRecords = response.data.total_borrowing_records;
                    this.totalReservations = response.data.total_reservations;
                })
                .catch(error => {
                    console.error('Error fetching basic statistics:', error);
                });
            // Fetch book categories count
            axios.get('http://localhost:5000/api/book-categories/count')
                .then(response => {
                    this.bookCategories = response.data;
                    this.drawPieChart(JSON.parse(JSON.stringify(response.data)));
                })
                .catch(error => {
                    console.error('Error fetching book categories count:', error);
                });
        },
        enterControl() {
            this.$router.push({ name: 'Admin' });
        },
        logout() {
            localStorage.removeItem('currentAdminUsername');
            localStorage.removeItem('currentAdminId');
            this.$router.push({ name: 'AdminLogin' });
            this.$message.info('Logged Out.');
        }
    },
    mounted() {
        this.fetchData();
    }
};
</script>

<style scoped>
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
    background-color: rgb(245, 245, 245);
    width: 100%;
    padding: 40px;
    box-sizing: border-box;
    margin-bottom: 40px;
}

.user-container {
    display: flex;
    align-items: center;
}

.main-content {
    max-width: 1200px;
    margin: auto;
    display: flex;
    justify-content: space-around;
    flex-wrap: wrap;
    flex-direction: column;
}

.status-card {
    background-color: #f5f5f5;
    padding: 20px;
    border-radius: 5px;
    margin: 10px;
    height: 200px;
    min-width: 20%;
    flex: 1;
    transition-duration: 0.2s;
}

.status-card h3 {
    margin-bottom: 10px;
}

.online {
    color: green;
}

.offline {
    color: red;
}

.statistics {
    background-color: #f5f5f5;
    padding: 20px;
    border-radius: 5px;
    flex: 1;
    margin: 10px;
    height: 500px;
    transition-duration: 0.2s;
}

.status-card:hover, .statistics:hover {
    background-color: #eaeaea;
}

.echarts-container {
    width: 700px;
    height: 500px;
}

.pie-wrap {
    width: 700px;
    height: 500px;
}

.statistics h3 {
    margin-bottom: 10px;
}

.statistics ul {
    list-style-type: none;
    padding: 0;
}

.statistics li {
    margin-bottom: 5px;
}

.echarts-box {
    display: flex;
    align-items: center;
    justify-content: center;
}

.flex-line {
    widows: 100%;
    display: flex;
    justify-content: space-between;
}

.enterControl {
    width: 100%;
}

.logout-btn {
    margin-left: 20px;
}
</style>