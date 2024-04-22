<script setup>
import VTopAdminBar from '@/components/VTopAdminBar.vue';
import VInput from '@/components/VInput.vue';
import VFonts from "@/components/VFonts.vue";

</script>

<template>
    <VTopAdminBar></VTopAdminBar>
    <div class="empty200px" style="height: 100px; width: 100%;"></div>
    <div class="list-title-modify">Modify USER Name <span class="list-title-red">$USERNAME$</span></div>
    <VInput>User Name</VInput>
    <VInput>User Password</VInput>
    <div class="mod-btns">
        <button class="summit-btn">Summit</button>
    </div>
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

.mod-btns {
    width: 100%;
    display: flex;
    justify-content: center;
    align-items: center;
    margin-bottom: 50px;
}

.summit-btn {
    width: 250px;
    height: 50px;
    font-size: 20px;
    font-family: apex;
    background-color: rgba(255, 255, 255, 0.3);
    color: white;
    outline: none;
    border: none;
    cursor: pointer;
    border-radius: 200px;
    transition-duration: 0.2s;
}

.summit-btn:hover {
    background-color: rgb(228, 68, 68);
}

.summit-btn:active {
    background-color: rgba(228, 68, 68, 0.5);
}

.list-title-modify {
    width: 100%;
    height: 50px;
    margin-top: 40px;
    margin-bottom: 40px;
    color: white;
    text-align: center;
    font-size: 30px;
    font-family: apex;
}

.list-title-red {
    color: rgb(228, 68, 68);
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