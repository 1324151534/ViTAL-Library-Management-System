<script setup>
import VTopAdminBar from '@/components/VTopAdminBar.vue';
import VUserListContainer from '@/components/VUserListContainer.vue';
import VFonts from "@/components/VFonts.vue";

</script>

<template>
    <VTopAdminBar></VTopAdminBar>
    <div class="empty200px" style="height: 100px; width: 100%;"></div>
    <div class="title-box">
        <h1>USER <span class="title-usrnme">MANAGEMENT</span> User Interface</h1>
    </div>
    <div class="list-title">User List</div>
    <VUserListContainer></VUserListContainer>
</template>

<style>
a {
    text-decoration: none;
}

body {
    padding: 0;
    margin: 0;
    background-color: rgb(50, 50, 50);
}

.list-title {
    width: 100%;
    height: 50px;
    color: white;
    text-align: center;
    font-size: 30px;
    font-family: apex;
}

.admin-rec-container {
    width: 100%;
    margin: auto;
    display: flex;
    justify-content: center;
    align-items: center;
}

.title-box {
    color: white;
}

.title-usrnme {
    color: rgb(228, 68, 68);
    transition-duration: 0.4s;
}

.title-usrnme:hover {
    color: rgba(228, 68, 68, 0.8);
}

.title-box {
    display: flex;
    align-items: center;
    justify-content: center;
    width: 100%;
    height: 200px;
    font-family: apex;
}

.result-box{
    display: flex;
    align-items: center;
    justify-content: center;
    width: 100%;
    height: 200px;
    font-family: "MiSans"
}

@font-face {
    font-family: "MiSans";
    src: url('@/assets/fonts/MiSans/MiSans-Normal.ttf');
    font-weight: normal;
    font-style: normal;
}
</style>