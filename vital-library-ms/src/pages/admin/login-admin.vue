<script setup>
import VFonts from '@/components/VFonts.vue';
import { onMounted } from 'vue';

onMounted(() => {
    // 重载页面
    window.location.reload();
});
</script>

<template>
    <div class="titleContainer">
        <h1 class="loginTitle">Welcome to ViTAL Library</h1>
    </div>
    <div class="loginPart">
        <h2>Admin Login</h2>
        <div class="form">
            <div class="inputElement">
                <label>Username: </label><input v-model="username" placeholder="Input Username" type="text"></input>
            </div>
            <div class="inputElement">
                <label>Password: </label><input v-model="password" placeholder="Input Password" type="password"></input>
            </div>
            <div>
                <router-link to="/index-admin"><button class="login-button">Login</button></router-link>
            </div>
            <div style="display: inline;">
                <div style="text-align: left;color: white;">
                    <router-link to="/">Go back</router-link>
                </div>
                <div style="text-align: right;color: white;">
                    <router-link class="registerBtn" to="">Have no account?</router-link>
                </div>
            </div>
        </div>
    </div>

</template>

<style>
div {
    font-family: "MiSans";
}

.registerBtn {
    color: #fff;
    text-decoration: none;
}

.titleContainer {
    display: flex;
    justify-content: center;
    align-items: center;
    height: 10vh;
}

.loginTitle {
    display: flex;
    text-align: center;
}

.login-button {
    width: 100%;
    font-size: 16px;
    color: #fff;
    margin-bottom: 30px;
    border: none;
    background: transparent;
    display: flex;
    justify-content: right;
}

.loginPart {
    /*定位方式绝对定位absolute*/
    position: absolute;
    /*顶和高同时设置50%实现的是同时水平垂直居中效果*/
    top: 50%;
    left: 50%;
    /*实现块元素百分比下居中*/
    transform: translate(-50%, -50%);
    width: 450px;
    padding: 50px;
    background: rgba(0, 0, 0, .5);
    /*背景颜色为黑色，透明度为0.8*/
    box-sizing: border-box;
    /*box-sizing设置盒子模型的解析模式为怪异盒模型，
    将border和padding划归到width范围内*/
    box-shadow: 0px 15px 25px rgba(0, 0, 0, .5);
    /*边框阴影  水平阴影0 垂直阴影15px 模糊25px 颜色黑色透明度0.5*/
    border-radius: 15px;
    /*边框圆角，四个角均为15px*/
}

.loginPart h2 {
    margin: 0 0 30px;
    padding: 0;
    color: #fff;
    text-align: center;
}

.inputElement {
    display: flex;
    margin: auto;
    color: #fff;
    margin-bottom: 20px;
}

.inputElement input {
    flex: 3;
    width: 100%;
    font-size: 18px;
    color: #fff;
    /*字符间的间距1px*/
    letter-spacing: 1px;
    margin-bottom: 30px;
    border: none;
    border-bottom: 1px solid #fff;
    /*背景颜色为透明*/
    background: transparent;
    display: flex;
}

.inputElement input:focus {
    outline: none;
}

.inputElement label {
    font-size: 18px;
    display: flex;
    flex: 0 0 100px;
    margin-right: 10px;

}

a {
    text-decoration: none;
    color: #fff;
}

@font-face {
    font-family: "MiSans";
    src: url('@/assets/fonts/MiSans/MiSans-Normal.ttf');
    font-weight: normal;
    font-style: normal;
}
</style>