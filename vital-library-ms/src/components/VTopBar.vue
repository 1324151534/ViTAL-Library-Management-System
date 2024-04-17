<script setup>
</script>

<template>
    <div class="topbar">
        <div class="topbar-home"><router-link to="/index">Home</router-link></div>
        <div class="topbar-search"><router-link to="/search">Search</router-link></div>
        <div class="topbar-Notification"><router-link to="/notification">Notification</router-link></div>
        <div class="topbar-borrow"><router-link to="borrow">Borrow</router-link></div>
        <div class="topbar-return"><router-link to="return">Return</router-link></div>
    </div>
    <div class="empty200"></div>
</template>

<style>
@keyframes topbar-in {
    from {
        transform: translateY(-100%)
    }

    to {
        transform: translateY(0%)
    }
}

.topbar {
    animation: topbar-in 0.2s;
    display: flex;
    align-items: center;
    justify-content: space-around;
    width: 100%;
    position: fixed;
    height: 100px;
    background-color: #4CAF50;
    color: white;
    font-family: "MiSans";
}

.empty200 {
    width: 100%;
    height: 100px;
}

a {
    text-decoration: none;
    color: inherit;
    font-family: "MiSans";
}
</style>