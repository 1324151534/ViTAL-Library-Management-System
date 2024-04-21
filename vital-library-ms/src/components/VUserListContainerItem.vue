<script setup>
    import '@/assets/font-style.css'
</script>

<template>
    <div class="rec-itm">
        <div class="usr-name">$USERNAME$</div>
        <div class="usr-ctrl">
            <router-link to="/user-manage-modify"><div class="usr-ctrl-btn"><i class="icon-edit_off"></i> Modify</div></router-link>
            <div class="usr-ctrl-btn"><i class="icon-delete_forever"></i> Delete</div>
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