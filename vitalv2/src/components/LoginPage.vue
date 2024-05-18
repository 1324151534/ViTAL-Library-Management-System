<template>
  <div class="login-container">
    <h2>ViTAL LMS</h2>
    <el-form :model="loginForm" ref="loginForm" :rules="rules" label-width="100px">
      <el-form-item label="Username" prop="username">
        <el-input v-model="loginForm.username" auto-complete="off"></el-input>
      </el-form-item>
      <el-form-item label="Password" prop="password">
        <el-input type="password" v-model="loginForm.password" auto-complete="off"></el-input>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" @click="handleLogin" class="login-button">Login</el-button>
        <el-button @click="goToRegister" class="register-button">Register</el-button>
      </el-form-item>
    </el-form>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  data() {
    return {
      loginForm: {
        username: '',
        password: ''
      },
      rules: {
        username: [
          { required: true, message: 'Please input username', trigger: 'blur' },
        ],
        password: [
          { required: true, message: 'Please input password', trigger: 'blur' },
        ]
      }
    };
  },
  methods: {
    async handleLogin() {
      this.$refs.loginForm.validate(async (valid) => {
        if (valid) {
          try {
            const response = await axios.post('http://localhost:5000/login', this.loginForm);
            localStorage.setItem('currentUser', JSON.stringify(response.data.user));
            localStorage.setItem('currentUserId', JSON.stringify(response.data.userId));
            this.$notify({
              title: 'Success',
              message: 'Login successful',
              type: 'success',
            });
            // Redirect to the book list page after successful login
            this.$router.push({ name: 'BookList' });
          } catch (error) {
            this.$notify.error({
              title: 'Error',
              message: error.response ? error.response.data.error : 'Login failed',
            });
          }
        } else {
          this.$notify.error({
            title: 'Error',
            message: 'Please complete the form',
          });
          return false;
        }
      });
    },
    goToRegister() {
      this.$router.push({ name: 'Register' });
    }
  }
};
</script>

<style scoped>
.login-container {
  width: 400px;
  margin: 100px auto;
  padding: 40px;
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
  background-color: #ffffff;
  border-radius: 8px;
}
h2 {
  text-align: center;
  margin-bottom: 30px;
  font-size: 24px;
  color: #333;
}
.el-form-item {
  margin-bottom: 20px;
}
.login-button {
  width: 100%;
  margin-bottom: 10px;
}
.register-button {
  width: 100%;
  background-color: #42b983;
  color: #fff;
  border-color: #42b983;
}
.register-button:hover {
  background-color: #3a9d72;
  border-color: #3a9d72;
}
.el-button {
  width: 45%;
}
</style>
