<script setup>
    import '@/assets/font-style.css'
</script>

<template>
    <div class="topbar">
        <div class="vlogo-box">
            <div class="vlogo">V<span class="vlogo-red">i</span>TAL <span class="vlogo-light">Library Management System</span></div>
            <div class="vlogo-version">VERISON 0421</div>
        </div>
        <div class="vpsnl">
            <div class="psnl-ico">
                <div class="psnl-box">
                    <div class="psnl-box-itm">My Account</div>
                    <div class="psnl-box-itm">My BorrowList</div>
                    <div class="psnl-box-itm">Log Out</div>
                </div>
            </div>
        </div>
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

.vpsnl {
    width: 150px;
    display: flex;
    flex-direction: row-reverse;
}

.psnl-ico {
    width: 50px;
    height: 50px;
    background-color: white;
    border-radius: 100px;
    cursor: pointer;
    transition-duration: 0.4s;
}

.psnl-ico:hover {
    background-color: rgba(255, 255, 255, 0.75);
}

.psnl-ico:hover .psnl-box {
    display: block;
}

.psnl-box {
    border-radius: 10px;
    position: absolute;
    display: none;
    background-color: rgba(240, 248, 255, 0.5);
    border: 1px solid gray;
    top: 60px;
    padding: 10px;
    margin-top: 20px;
    transform: translateX(-60px);
    color: black;
    width: 150px;
    height: auto;
}

.psnl-box::before {
    content: "";
    position: absolute;
    width: 150px;
    height: 20px;
    top: -20px;
}

.ipt-srh {
    width: 350px;
    height: 30px;
    padding-left: 10px;
    padding-right: 10px;
    border: 2px solid rgba(0, 0, 0, 0.5);
    outline: none;
    border-radius: 200px;
}

.topbar {
    animation: topbar-in 0.2s;
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