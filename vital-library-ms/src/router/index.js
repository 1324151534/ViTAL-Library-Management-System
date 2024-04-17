import { createRouter, createWebHistory, createWebHashHistory } from 'vue-router';

const routes = [
    {
        path: "/",
        component: () => import("@/pages/login.vue"),
    },
    {
        path: "/index",
        alias: [ '/home'],
        component: () => import("@/pages/index.vue"),
    },
    {
        path: "/search",
        component: () => import("@/pages/search.vue"),
    },
    {
        path: "/notification",
        component: () => import("@/pages/notification.vue"),
    },
    {
        path: "/borrow",
        component: () => import("@/pages/borrow.vue"),
    },
    {
        path: "/return",
        component: () => import("@/pages/return.vue"),
    },
    {
        path: "/user/:id/name/:name?",
        name: "member",
        component: () => import("@/pages/user.vue")
    }
    // ... 其他路由配置
];

const router = createRouter({
    history: createWebHashHistory(),
    routes, // 简写，相当于 routes: routes
});

export default router;