<script setup>
import '@/assets/font-style.css'
import VBookListContainerItem from './VBookListContainerItem.vue';
import { ref, defineProps } from 'vue';

const props = defineProps({
    searchResults: {
        type: Array,
        default: () => []
    }
});

</script>

<template>
    <div class="ulist-box">
        <VBookListContainerItem v-for="result in searchResults" :key="result.id" :bookId="result.id">
            <template v-slot:bookName>{{ result.title }}</template>
        </VBookListContainerItem>
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