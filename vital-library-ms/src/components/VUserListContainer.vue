<script setup>
    import '@/assets/font-style.css'
    import VUserListContainerItem from './VUserListContainerItem.vue';
</script>

<template>
    <div class="ulist-box">
        <VUserListContainerItem></VUserListContainerItem>
        <VUserListContainerItem></VUserListContainerItem>
        <VUserListContainerItem></VUserListContainerItem>
        <VUserListContainerItem></VUserListContainerItem>
        <VUserListContainerItem></VUserListContainerItem>
        <VUserListContainerItem></VUserListContainerItem>
    </div>
</template>

<style>
    .ulist-box {
        padding: 20px;
        max-width: 800px;
        margin: auto;
        margin-bottom: 50px;
        display: flex;
        justify-content: center;
        align-items: center;
        flex-wrap: wrap;
        border-radius: 10px;
        background-color: rgba(255, 255, 255, 0.1);
    }
</style>