<script setup>
import '@/assets/font-style.css'
import { ref, defineProps } from "vue";

const props = defineProps({
    bookId: {
        type: Number,
        required: true
    }
});

const deleteBook = async () => {
    try {
        const response = await fetch(`http://localhost:5000/books/${props.bookId}`, {
            method: 'DELETE',
            headers: {
                'Content-Type': 'application/json',
            },
        });

        if (!response.ok) {
            throw new Error('Network response was not ok');
        }

        // 提示删除成功
        alert('Book deleted successfully');
        // 刷新页面
        window.location.reload();
    } catch (error) {
        console.error('Error deleting book:', error);
    }
};

</script>

<template>
    <div class="rec-itm">
        <div class="usr-name">
            <slot name="bookName"></slot>
        </div>
        <div class="usr-ctrl">
            <router-link :to="{ name: 'bookManageModify', params: { id: bookId } }">
                <div class="usr-ctrl-btn"><i class="icon-edit_off"></i> Modify</div>
            </router-link>
            <div class="usr-ctrl-btn" @click="deleteBook"><i class="icon-delete_forever"></i> Delete</div>
        </div>
    </div>
</template>

<style>
a {
    color: white;
    text-decoration: none;
}

.rec-itm {
    width: 100%;
    height: 50px;
    margin: 10px;
    padding: 10px;
    cursor: pointer;
    display: flex;
    flex-direction: row;
    justify-content: space-around;
    align-items: center;
    overflow: hidden;
    color: white;
    transition-duration: 0.2s;
    border-radius: 10px;
}

.rec-itm:hover {
    background-color: rgba(255, 255, 255, 0.10);
}

.usr-name {
    font-size: 20px;
    flex: 1;
}

.usr-ctrl {
    display: flex;
    align-content: center;
    justify-content: center;
}

.usr-ctrl-btn {
    font-size: 15px;
    padding: 15px;
    border-radius: 10px;
    margin-left: 10px;
}

.usr-ctrl-btn:hover {
    background-color: rgba(255, 255, 255, 0.2);
}

.usr-ctrl-btn:active {
    background-color: rgba(255, 255, 255, 0.115);
}
</style>