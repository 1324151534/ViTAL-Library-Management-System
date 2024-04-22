<script setup>
    import VFonts from "@/components/VFonts.vue";
    import '@/assets/font-style.css'
</script>

<template>
    <div class="status-box">
        <div class="status-name">STATUS</div>
        <div class="status-number">10,000</div>
        <div class="status-text">Users Count</div>
    </div>
</template>

<style>
    .status-box {
        width: 250px;
        margin: 10px;
        height: 400px;
        background-color: rgb(80, 80, 80);
        display: flex;
        flex-direction: column;
        justify-content: space-around;
        align-items: center;
        color: white;
        font-family: apex;
        transition-duration: 0.4s;
    }

    .status-box:hover {
        background-color: rgb(115, 115, 115);
        width: 300px;
    }

    .status-box:hover .status-number {
        font-size: 70px;
    }

    .status-name {
        font-size: 30px;
        font-family: apex;
    }

    .status-number {
        font-family: apex;
        font-size: 55px;
        transition-duration: 0.4s;
    }

    .status-text {
        font-family: apex;
    }
</style>