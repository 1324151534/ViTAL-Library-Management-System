<script setup>
import '@/assets/font-style.css'
</script>

<template>
    <div class="vue-body">
        <div class="ln-bkg-darker">
            <img class="ln-bkg-img" src="@/assets/imgs/img19.jpg" alt="">
        </div>
        <div class="ln-box-sys">
            <div class="ln-box-float">
                <div class="ln-title-sys">V<span class="ln-red-sys">i</span>TAL <span class="ln-regu-sys">SYSTEM</span></div>
                <div class="ln-title-sys-ver">MANAGEMENT ACCOUNT ONLY</div>
                <div class="ln-box-ipt">
                    <div class="ln-noti-sys"><i class="icon-person i-sys"></i> Librarian Username</div>
                    <input type="text" class="ln-ipt-sys ln-id" placeholder="username/email etc.">
                    <div class="ln-noti-sys"><i class="icon-vpn_key i-sys"></i> Password</div>
                    <input type="password" class="ln-ipt-sys ln-psw" placeholder="password">
                </div>
                <div class="ln-box-btns">
                    <router-link to="/index-admin"><a class="ln-btns-sys ln-log-sys"><i class="icon-keyboard_arrow_right i-sys"></i></a></router-link>
                </div>
            </div>
        </div>
    </div>

</template>

<style>
    body {
        overflow: hidden;
    }
</style>

<style scoped src="@/assets/sys-general-style.css"></style>
<style scoped>
*, .i-sys {
    color: white;
}

a {
    color: black;
    cursor: pointer;
    width: 100%;
    height: 30px;
    margin-top: 10px;
    background: none;
    border: none;
    outline: none;
    transition-duration: 0.4s;
    font-size: 2vh;
    font-family: apex;
    display: flex;
    justify-content: flex-start;
    align-items: center;
}

body {
    padding: 0;
    margin: 0;
    display: flex;
    flex-direction: row-reverse;
    background-color: black;
    overflow: hidden;
    color: white;
}

.ln-bkg-darker {
    width: 100vw;
    height: 100vh;
    position: absolute;
    z-index: -1;
    object-fit: cover;
    transition-duration: 0.2s;
}

.ln-bkg-darker::before {
    position: absolute;
    font-size: 1.5vw;
    font-weight: lighter;
    z-index: 999;
    content: "Powered by Microsoft Bing";
    color: white;
    padding: 20px;
    border-radius: 10px;
    background-color: rgba(255, 255, 255, 0.2);
    opacity: 0;
    transition-duration: 0.2s;
    margin-left: 5vh;
    bottom: 5vh;
}

.ln-bkg-img {
    width: 100vw;
    height: 100vh;
    object-fit: cover;
    transition-duration: 0.2s;
}

.ln-box-sys {
    width: 100vw;
    height: 100vh;
    background-color: rgba(0, 0, 0, 0.5);
    backdrop-filter: blur(10px);
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    z-index: 999;
}

.ln-box-float {
    width: 100%;
    max-width: 600px;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
}

.ln-box-ipt {
    display: flex;
    flex-direction: column;
    width: 100%;
    justify-content: center;
    align-items: center;
}

.ln-title-sys {
    color: white;
    font-size: 5vh;
    text-wrap: nowrap;
    font-family: apex-bold;
}

.ln-title-sys-ver {
    color: white;
    font-size: 2vh;
    text-wrap: nowrap;
    margin-bottom: 10px;
    font-family: apex-light;
    opacity: 0.6;
}

.ln-ipt-sys {
    width: 80%;
    color: white;
    margin-top: 5px;
    margin-bottom: 10px;
    height: 40px;
    border-radius: 200px;
    padding-left: 10px;
    padding-right: 10px;
    box-sizing: border-box;
    transition-duration: 0.2s;
    outline: none;
    border: 1px solid rgb(195, 195, 195);
    background-color: rgba(255, 255, 255, 0.205);
}

.ln-ipt-sys::placeholder {
    font-family: apex;
    color: rgb(195, 195, 195);
}

.ln-ipt-sys:hover {
    background-color: rgba(215, 215, 215, 0.5);
}

.ln-ipt-sys:focus {
    background-color: rgb(230, 230, 230, 0.1);
    border: 1px solid rgb(255, 255, 255);
}

.ln-box-btns {
    width: 80%;
    display: flex;
    flex-direction: column;
    justify-content: space-between;
    align-items: center;
}

.ln-red-sys {
    color: rgb(228, 68, 68);
}

.ln-regu-sys {
    color: white;
    font-family: apex;
}

.ln-btns-sys {
    color: white;
    cursor: pointer;
    width: 100%;
    height: 30px;
    margin-top: 10px;
    background: none;
    border: none;
    outline: none;
    transition-duration: 0.4s;
    font-size: 2vh;
    font-family: apex;
    display: flex;
    justify-content: flex-start;
    align-items: center;
}
.ln-reg::before {
    content: "SIGNUP";
    transition: margin-left 0.4s;
}

.ln-log-sys::before {
    content: "LOGIN";
    transition: margin-left 0.4s;
}

.ln-btns-sys:hover:before {
    margin-left: calc(100% - 80px);
}

.ln-btns-sys:hover {
    background-color: rgb(228, 68, 68);
    color: white;
}

.ln-btns-sys:active {
    transition-duration: 0s;
    background-color: rgb(164, 48, 48);
}

.ln-noti-sys {
    color: white;
    font-family: apex-light;
}
</style>