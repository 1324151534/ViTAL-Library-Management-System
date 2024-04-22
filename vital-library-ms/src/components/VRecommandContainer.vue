<script setup>
import '@/assets/font-style.css'
import VRecommandContainerItem from './VRecommandContainerItem.vue';
import { ref, defineProps } from "vue";

const props = defineProps({
    searchResults: {
        type: Array,
        default: () => []
    }
});

</script>

<template>
    <div class="rec-box">
        <VRecommandContainerItem v-for="result in searchResults" :key="result.id" :bookId="result.id">
            <!-- 将结果中的书籍名称和作者名称分别传递给 Item组件 -->
            <template v-slot:bookName>{{ result.title }}</template>
            <template v-slot:authorName>{{ result.author }}</template>
        </VRecommandContainerItem>
    </div>
</template>

<style>
.rec-box {
    padding-top: 20px;
    width: 80%;
    max-width: 800px;
    margin: auto;
    display: flex;
    justify-content: center;
    align-items: center;
    flex-wrap: wrap;
}
</style>