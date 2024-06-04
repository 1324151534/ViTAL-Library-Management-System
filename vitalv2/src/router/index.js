import Vue from 'vue';
import VueRouter from 'vue-router';
import Login from '@/components/LoginPage.vue';
import Register from '@/components/RegisterPage.vue';
import BookListPage from '@/components/BookListPage.vue';
import BookDetailsPage from '@/components/BookDetailsPage.vue';
import UserProfilePage from '@/components/UserProfilePage.vue';
import AdminPage from '@/components/AdminPage.vue';
import AdminLoginPage from '@/components/AdminLoginPage.vue';
import AdminDashboard from '@/components/AdminDashboard.vue';

Vue.use(VueRouter);

const routes = [
  {
    path: '/',
    name: 'Login',
    component: Login
  },
  {
    path: '/register',
    name: 'Register',
    component: Register
  },
  {
    path: '/book-list',
    name: 'BookList',
    component: BookListPage // Associate the route with the BookListPage component
  },
  {
    path: '/book/:id', // 定义书籍详细信息页面的路由，其中 ":id" 是动态路由参数，用于传递书籍ID
    name: 'BookDetails',
    component: BookDetailsPage
  },
  {
    path: '/user-profile',
    name: 'UserProfile',
    component: UserProfilePage
  },
  {
    path: '/admin',
    name: 'Admin',
    component: AdminPage
  },
  {
    path: '/admin/login',
    name: 'AdminLogin',
    component: AdminLoginPage
  },
  {
    path: '/admin/dashboard',
    name: 'AdminDashboard',
    component: AdminDashboard
  }
];

const router = new VueRouter({
  mode: 'history',
  routes
});

export default router;
