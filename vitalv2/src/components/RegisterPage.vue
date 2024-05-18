<template>
    <div class="register-container">
      <h2>ViTAL LMS</h2>
      <el-form :model="registerForm" ref="registerForm" :rules="rules" label-width="100px">
        <el-form-item label="Username" prop="username">
          <el-input v-model="registerForm.username" auto-complete="off"></el-input>
        </el-form-item>
        <el-form-item label="Password" prop="password">
          <el-input type="password" v-model="registerForm.password" auto-complete="off"></el-input>
        </el-form-item>
        <el-form-item label="Confirm" prop="confirmPassword">
          <el-input type="password" v-model="registerForm.confirmPassword" auto-complete="off"></el-input>
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="handleRegister" class="register-button">Register</el-button>
          <el-button @click="goToLogin" class="back-button">Back to Login</el-button>
        </el-form-item>
      </el-form>
    </div>
  </template>
  
  <script>
  import axios from 'axios';
  
  export default {
    data() {
      return {
        registerForm: {
          username: '',
          password: '',
          confirmPassword: ''
        },
        rules: {
          username: [
            { required: true, message: 'Please input username', trigger: 'blur' },
          ],
          password: [
            { required: true, message: 'Please input password', trigger: 'blur' },
          ],
          confirmPassword: [
            { required: true, message: 'Please confirm your password', trigger: 'blur' },
            { validator: (rule, value, callback) => {
              if (value !== this.registerForm.password) {
                callback(new Error('Passwords do not match'));
              } else {
                callback();
              }
            }, trigger: 'blur' }
          ]
        }
      };
    },
    methods: {
      async handleRegister() {
        this.$refs.registerForm.validate(async (valid) => {
          if (valid) {
            try {
              await axios.post('http://localhost:5000/register', this.registerForm);
              this.$notify({
                title: 'Success',
                message: 'Registration successful',
                type: 'success',
              });
              // 在注册成功后进行页面跳转等操作
            } catch (error) {
              this.$notify.error({
                title: 'Error',
                message: error.response ? error.response.data.error : 'Registration failed',
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
      goToLogin() {
        this.$router.push({ name: 'Login' });
      }
    }
  };
  </script>
  
  <style scoped>
  .register-container {
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
  .register-button {
    width: 100%;
    margin-bottom: 10px;
  }
  .back-button {
    width: 100%;
    background-color: #909399;
    color: #fff;
    border-color: #909399;
  }
  .back-button:hover {
    background-color: #80868b;
    border-color: #80868b;
  }
  .el-button {
    width: 45%;
  }
  </style>
  