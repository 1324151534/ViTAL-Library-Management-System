<script setup>
import '@/assets/font-style.css'
import { ref, defineProps } from "vue";

const props = defineProps({
    bookId: {
        type: Number,
        required: true
    }
});
</script>

<template>
    <router-link :to="{ name: 'bookDetail', params: { id: bookId } }">
    <div class="rec-itm">
            <div class="itm-name">
                <slot name="bookName"></slot>
            </div>
            <div class="itm-author">
                <slot name="authorName"></slot>
            </div>
            <div>
                <slot>{{ bookId }}</slot>
            </div>
        </div>
    </router-link>
</template>

<style>
.rec-itm {
    width: 150px;
    height: 250px;
    border-radius: 5px;
    margin: 10px;
    padding: 10px;
    cursor: pointer;
    display: flex;
    flex-direction: column;
    justify-content: flex-end;
    align-items: center;
    overflow: hidden;
    color: white;
}

.rec-itm::before {
    content: "";
    background-image: url("@/assets/imgs/wp6599717.jpg");
    background-size: cover;
    border-radius: 5px;
    position: absolute;
    width: 170px;
    height: 270px;
    z-index: -1;
    transform: translateY(10px);
}

.rec-itm:hover {
    background: linear-gradient(to top, rgb(0, 0, 0) 0%, rgba(0, 0, 0, 0) 80%);
}

.itm-name {
    font-size: 20px;
}

.itm-author {
    font-size: 15px;
}
</style>