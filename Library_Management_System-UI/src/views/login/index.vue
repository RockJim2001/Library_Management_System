<template>
  <div class="login-container">
    <star-background />

    <div class="limiter">
      <div class="container-login100">
        <div class="wrap-login100 p-l-55 p-r-55 p-t-65 p-b-54">
          <el-form
            class="login100-form validate-form"
            id="LoginForm"
            ref="loginForm"
            :model="loginForm"
            :rules="loginRules"
            auto-complete="on"
            label-position="left"
          >
            <span class="login100-form-title p-b-49">登录</span>
            <div
              class="wrap-input100 validate-input m-b-23"
              data-validate="请输入用户名"
              prop="username"
            >
              <span class="label-input100">用户名</span>
              <input
                class="input100"
                type="text"
                id="username"
                name="username"
                placeholder="请输入用户名"
                autocomplete="off"
                required
              />
              <span class="focus-input100" data-symbol="&#xf206;"></span>
            </div>

            <div
              class="wrap-input100 validate-input"
              data-validate="请输入密码"
              prop="password"
            >
              <span class="label-input100">密码</span>
              <input
                class="input100"
                type="password"
                id="password"
                name="password"
                placeholder="请输入密码"
              />
              <span class="focus-input100-copy" data-symbol="&#xf190;"></span>
            </div>

            <div class="text-right p-t-8 p-b-31">
              <router-link to="/ForgetPassword">忘记密码？</router-link>
            </div>

            <div class="container-login100-form-btn">
              <div class="wrap-login100-form-btn">
                <div class="login100-form-bgbtn"></div>
                <button
                  type="button"
                  class="login100-form-btn"
                  @click="handleLogin"
                >
                  登 录
                </button>
              </div>
            </div>

            <div class="txt1 text-center p-t-54 p-b-20 line">
              <span>第三方登录</span>
            </div>

            <div class="flex-c-m">
              <a href="#" class="login100-social-item bg1">
                <i class="fa fa-wechat"></i>
              </a>

              <a href="#" class="login100-social-item bg2">
                <i class="fa fa-qq"></i>
              </a>

              <a href="#" class="login100-social-item bg3">
                <i class="fa fa-weibo"></i>
              </a>
            </div>

            <div class="flex-col-c p-t-25">
              <router-link to="/Register">立即注册</router-link>
            </div>
          </el-form>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { isvalidUsername } from "@/utils/validate";
import StarBackground from "../../components/Background/StarBackground.vue";
import "../../styles/css/bootstrap.min.css";
import "../../styles/css/font-awesome.min.css";
import "../../styles/css/main.css";
import "../../styles/css/material-design-iconic-font.min.css";
import "../../styles/css/util.css";

export default {
  components: { StarBackground },
  name: "Login",
  data() {
    const validateUsername = (rule, value, callback) => {
      if (!isvalidUsername(value)) {
        callback(new Error("请输入正确的用户名"));
      } else {
        callback();
      }
    };
    const validatePass = (rule, value, callback) => {
      if (value.length < 6) {
        callback(new Error("密码不能小于6位"));
      } else {
        callback();
      }
    };
    return {
      loginForm: {
        username: "",
        password: "",
      },
      loginRules: {
        username: [
          { required: true, trigger: "blur", validator: validateUsername },
        ],
        password: [
          { required: true, trigger: "blur", validator: validatePass },
        ],
      },
      loading: false,
      pwdType: "password",
      redirect: undefined,
    };
  },
  watch: {
    $route: {
      handler: function (route) {
        this.redirect = route.query && route.query.redirect;
      },
      immediate: true,
    },
  },
  methods: {
    showPwd() {
      if (this.pwdType === "password") {
        this.pwdType = "";
      } else {
        this.pwdType = "password";
      }
    },
    handleLogin() {
      this.$refs.loginForm.validate((valid) => {
        if (valid) {
          // debugger
          var username = document.getElementById("username").value;
          var password = document.getElementById("password").value;
          this.loginForm.username = username;
          this.loginForm.password = password;
          this.loading = true;
          this.$store
            .dispatch("Login", this.loginForm)
            .then(() => {
              this.loading = false;
              this.$router.push({ path: this.redirect || "/" });
            })
            .catch(() => {
              this.loading = false;
            });
        } else {
          console.log("error submit!!");
          return false;
        }
      });
    },
  },
};
</script>

<style rel="stylesheet/scss" lang="scss">
$bg: #2d3a4b;
$light_gray: #eee;

/* reset element-ui css */
.login-container {
  .el-input {
    display: inline-block;
    height: 47px;
    width: 85%;
    input {
      background: transparent;
      border: 0px;
      -webkit-appearance: none;
      border-radius: 0px;
      padding: 12px 5px 12px 15px;
      color: $light_gray;
      height: 47px;
      &:-webkit-autofill {
        -webkit-box-shadow: 0 0 0px 1000px $bg inset !important;
        -webkit-text-fill-color: #fff !important;
      }
    }
  }
  .el-form-item {
    border: 1px solid rgba(255, 255, 255, 0.1);
    background: rgba(0, 0, 0, 0.1);
    border-radius: 5px;
    color: #454545;
  }
}
</style>

<style rel="stylesheet/scss" lang="scss">
$bg: #2d3a4b;
$dark_gray: #889aa4;
$light_gray: #eee;
.login-container {
  position: fixed;
  height: 100%;
  width: 100%;
  background-color: $bg;
  background-image: url("../../../src/assets/images/background.jpg");
  background-size: 100%, 100%;
  .login-form {
    position: absolute;
    left: 0;
    right: 0;
    width: 520px;
    max-width: 100%;
    padding: 35px 35px 15px 35px;
    margin: 120px auto;
  }
  .tips {
    font-size: 14px;
    color: #fff;
    margin-bottom: 10px;
    span {
      &:first-of-type {
        margin-right: 16px;
      }
    }
  }
  .svg-container {
    padding: 6px 5px 6px 15px;
    color: $dark_gray;
    vertical-align: middle;
    width: 30px;
    display: inline-block;
  }
  .title {
    font-size: 26px;
    font-weight: 400;
    color: $light_gray;
    margin: 0px auto 40px auto;
    text-align: center;
    font-weight: bold;
  }
  .show-pwd {
    position: absolute;
    right: 10px;
    top: 7px;
    font-size: 16px;
    color: $dark_gray;
    cursor: pointer;
    user-select: none;
  }
}
.line {
  padding: 0 10px 0;
  margin: 20px 0;
  line-height: 1px;
  border-left: 100px solid #ddd;
  border-right: 100px solid #ddd;
  text-align: center;
}
.login100-form-title {
  letter-spacing: 20px;
  font-style: inherit;
}
.container-login100 {
  justify-content: left;
  margin-left: 10%;
}
</style>
