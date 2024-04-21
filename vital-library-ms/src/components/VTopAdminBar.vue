<script setup>
    import '@/assets/font-style.css'
</script>

<template>
    <div class="topbar">
        <div class="vlogo-box">
            <div class="vlogo">V<span class="vlogo-red">i</span>TAL <span class="vlogo-light">Library Management System</span></div>
            <div class="vlogo-version">VERISON 0421</div>
        </div>
        <div class="vctrl">
            <router-link to="/book-manage"><div class="vctrl-itm">BOOK<span class="vctrl-itm-light">MANAGEMENT</span></div></router-link>
            <router-link to="/user-manage"><div class="vctrl-itm">USER<span class="vctrl-itm-light">MANAGEMENT</span></div></router-link>
            <router-link to=""><div class="vctrl-itm">NOTIFY<span class="vctrl-itm-light">MANAGEMENT</span></div></router-link>
            <i class="icon-logout vctrl-ico"></i>
        </div>
    </div>
    <div class="empty200"></div>
</template>

<style>

.vctrl {
    height: 50px;
    display: flex;
    align-items: center;
    justify-content: space-around;
    font-family: apex-bold;
    font-size: 25px;
}

.vctrl-ico {
    width: 30px;
    height: 30px;
    border-radius: 100px;
    padding: 10px;
    display: flex;
    justify-content: center;
    align-items: center;
    cursor: pointer;
    font-size: 25px;
    transition: font-size 0.2s;
}

.vctrl-ico:hover {
    background-color: rgba(255, 255, 255, 0.188);
    font-size: 30px;
}

.vctrl-ico:active {
    background-color: rgba(255, 255, 255, 0.1);
}

.vctrl-itm {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    padding: 20px;
    cursor: pointer;
    border-radius: 5px;
    text-decoration: none;
    color: white;
}

.vctrl-itm:hover {
    background-color: rgba(255, 255, 255, 0.188);
}

.vctrl-itm:active {
    background-color: rgba(255, 255, 255, 0.1);
    text-decoration: underline;
    text-decoration-color: rgb(228, 68, 68);
    text-decoration-thickness: 2px;

}

.vctrl-itm-light {
    font-size: 15px;
    font-family: apex-light;
    color: rgb(180, 180, 180);
}

@keyframes topbar-in {
    from {
        transform: translateY(-100%)
    }

    to {
        transform: translateY(0%)
    }
}

@media screen and (max-width: 480px) {
    .vlogo-light {
        display: none;
    }
}

.vlogo-box {
    display: flex;
    flex-direction: column;
}

.vlogo {
    font-family: apex;
    font-size: 25px;
}

.vlogo-red {
    color: rgb(228, 68, 68);
}

.vlogo-light {
    font-family: apex-light;
    color: rgb(180, 180, 180);
}

.vlogo-version {
    font-size: 10px;
    font-weight: lighter;
    text-align: start;
}

.topbar {
    display: flex;
    align-items: center;
    justify-content: space-around;
    width: 100%;
    position: fixed;
    height: 100px;
    background-color: #000000;
    transition-duration: 0.4s;
    color: white;
    font-family: "MiSans";
}

.topbar:hover {
    background-color: #212121;
}

</style>