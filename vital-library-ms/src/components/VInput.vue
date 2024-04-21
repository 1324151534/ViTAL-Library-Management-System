<script setup>
    import '@/assets/font-style.css'
</script>

<template>
    <div class="input-box">
        <div class="input-text"><slot>$INPUT TEXT$</slot></div>
        <input type="text" class="vinput">
    </div>
</template>

<style>
    .input-box {
        width: 80%;
        margin: auto;
        max-width: 600px;
        height: 125px;
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: flex-start;
        color: white;
    }

    .input-text {
        width: 100%;
        text-align: left;
        font-size: 20px;
        margin-bottom: 10px;
    }

    .vinput {
        width: 100%;
        height: 50px;
        background-color: rgba(255, 255, 255, 0.1);
        border: 2px solid rgba(255, 255, 255, 0.4);
        outline: none;
        box-sizing: border-box;
        border-radius: 200px;
        padding: 10px;
        color: white;
    }

    .vinput:hover {
        background-color: rgba(255, 255, 255, 0.2);
    }

    .vinput:focus {
        background-color: rgba(255, 255, 255, 0.05);
        border: 2px solid rgb(228, 68, 68);
    }
</style>