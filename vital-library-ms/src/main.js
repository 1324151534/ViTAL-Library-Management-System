import { createApp } from 'vue'
import App from './App.vue'
import router from './router'

const app = createApp(App)
app.use(router)

// 全局前置守卫
router.beforeEach((to, from, next) => {
    console.log('to:', to)
    console.log("from:", from)

    // next()
    if(to.name=="member"){
        next(false)// 拦截
        console.log("拦截")
    }
    else{
        next()
    }

})

app.mount('#app')
