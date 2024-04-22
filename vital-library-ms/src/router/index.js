import { createRouter, createWebHistory, createWebHashHistory } from 'vue-router';

const routes = [
    {
        path: "/",
        component: () => import("@/pages/login.vue"),
    },
    // for Normal Users
    {
        path: "/login-user",
        component: () => import("@/pages/user/login-user.vue"),
    },
    {
        path: "/usr-login",
        component: () => import("@/pages/usr-login.vue"),
    },
    {
        path: "/index-user",
        component: () => import("@/pages/user/index-user.vue"),
    },
    {
        path: "/book/:id",
        name: "bookDetail",
        component: () => import("@/pages/user/bookDetailed.vue"),
        props: true,
    },
    {
        path: "/user/:id/name/:name?",
        name: "member",
        component: () => import("@/pages/user.vue")
    },
    // for admin/Librarian
    {
        path: "/login-admin",
        component: () => import("@/pages/admin/login-admin.vue")
    },
    {
        path: "/sys-login",
        component: () => import("@/pages/sys-login.vue"),
    },
    {
        path: "/index-admin",
        component: () => import("@/pages/admin/index-admin.vue"),
    },
    {
        path: "/book-manage",
        component: () => import("@/pages/admin/book-manage.vue"),
    },
    {
        path: "/book-manage-modify/:id",
        name: "bookManageModify",
        props: true,
        component: () => import("@/pages/admin/book-manage-modify.vue"),
    },
    {
        path: "/book-manage-add",
        component: () => import("@/pages/admin/book-manage-add.vue"),
    },
    {
        path: "/user-manage",
        component: () => import("@/pages/admin/user-manage.vue"),
    },
    {
        path: "/user-manage-modify",
        component: () => import("@/pages/admin/user-manage-modify.vue"),
    },
    // ... 其他路由配置
];

const router = createRouter({
    history: createWebHashHistory(),
    routes, // 简写，相当于 routes: routes
});

export default router;