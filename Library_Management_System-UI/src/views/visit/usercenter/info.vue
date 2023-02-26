<template>
  <div>
    <el-card class="container">
      <el-tabs
        tab-position="right"
        style="margin: 10px 0px 100px 50px; height: 600px"
        stretch
        @tab-click="getInfo"
      >
        <el-tab-pane label="登录信息">
          <div class="description-table">
            <el-divider content-position="center"><h1>学生信息</h1></el-divider>
            <el-form
              ref="user"
              :model="user"
              :rules="validateRules"
              label-width="120px"
            >
              <el-form-item label="用户头像" prop="avatar">
                <el-upload
                  class="avatar-uploader"
                  action=""
                  :show-file-list="false"
                  :auto-upload="false"
                  :file-list="fileList"
                  :limit="1"
                  :on-preview="handleAvatarPreview"
                  :on-remove="handleAvatarRemove"
                  :before-upload="beforeAvatarUpload"
                  :on-success="handleAvatarSuccess"
                  :on-change="handleAvatarChange"
                >
                  <img v-if="user.avatar" :src="user.avatar" class="avatar" />
                  <i v-else class="el-icon-plus avatar-uploader-icon"></i>
                </el-upload>
              </el-form-item>
              <el-form-item label="用户名" prop="username">
                <el-input v-model="user.username" disabled />
              </el-form-item>
              <el-form-item label="用户昵称" prop="nickName">
                <el-input v-model="user.nickName" />
              </el-form-item>

              <el-form-item label="用户密码" prop="password">
                <el-input v-model="user.password" />
              </el-form-item>

              <el-form-item>
                <el-button
                  :disabled="saveBtnDisabled"
                  type="primary"
                  @click="saveOrUpdate"
                  >保存</el-button
                >
              </el-form-item>
            </el-form>
          </div>
        </el-tab-pane>
        <el-tab-pane label="学生信息">
          <div class="description-table">
            <el-divider content-position="center"><h1>学生信息</h1></el-divider>

            <el-descriptions
              class="margin-top"
              title="学生个人身份信息"
              :column="3"
              border
            >
              <template slot="extra">
                <el-button type="primary" size="small" @click="userInfoOperator"
                  >操作</el-button
                >
              </template>
              <el-descriptions-item>
                <template slot="label">
                  <i class="el-icon-user"></i>
                  姓名
                </template>
                {{ this.student.name }}
              </el-descriptions-item>
              <el-descriptions-item>
                <template slot="label"> 学号 </template>
                {{ this.student.studentId }}
              </el-descriptions-item>
              <el-descriptions-item>
                <template slot="label"> 性别 </template>
                <i
                  class="el-icon-male"
                  style="color: blue"
                  v-if="this.student.gender === 0"
                ></i>
                <i
                  class="el-icon-female"
                  style="color: red"
                  v-if="!(this.student.gender === 0)"
                ></i>
              </el-descriptions-item>

              <el-descriptions-item>
                <template slot="label">
                  <i class="el-icon-camera-solid"></i>
                  照片
                </template>
                <el-image
                  style="width: 100px; height: 100px"
                  :src="this.student.picture"
                  fit="fit"
                ></el-image>
              </el-descriptions-item>

              <el-descriptions-item>
                <template slot="label">
                  <i class="el-icon-mobile"></i>
                  电话
                </template>
                {{ this.student.phone }}
              </el-descriptions-item>

              <el-descriptions-item>
                <template slot="label">
                  <i class="el-icon-tickets"></i>
                  邮箱
                </template>
                {{ this.student.email }}
              </el-descriptions-item>

              <el-descriptions-item>
                <template slot="label">
                  <i class="el-icon-school"></i>
                  院系
                </template>
                {{ this.student.department }}
              </el-descriptions-item>
              <el-descriptions-item>
                <template slot="label">
                  <i class="el-icon-tickets"></i>
                  简介
                </template>
                {{ this.student.description }}
              </el-descriptions-item>
            </el-descriptions>
          </div>
        </el-tab-pane>
      </el-tabs>
    </el-card>
  </div>
</template>

<script>
import userApi from "@/api/acl/user";
import studentApi from "@/api/lms/student";

const defaultForm = {
  avatar: "",
  username: "",
  nickName: "",
  password: "",
};
const defaultInfoForm = {
  studentId: "",
  name: "",
  gender: "",
  picture: "",
  phone: "",
  email: "",
  department: "",
  description: "",
};
const validatePass = (rule, value, callback) => {
  if (value.length < 6) {
    callback(new Error("密码不能小于6位"));
  } else {
    callback();
  }
};
export default {
  data() {
    return {
      user: defaultForm,
      student: defaultInfoForm,
      saveBtnDisabled: false, // 保存按钮是否禁用,
      refeshBtnDisabled: false,
      validateRules: {
        avatar: [
          {
            required: true,
            trigger: "change",
            message: "给用户选一个头像吧！",
          },
        ],
        username: [
          { required: true, trigger: "blur", message: "用户名必须输入" },
        ],
        password: [
          { required: true, trigger: "blur", validator: validatePass },
        ],
        nickName: [
          {
            required: true,
            trigger: "blur",
            message: "给这个用户取个名吧！",
          },
        ],
      },
      fileList: [],
    };
  },

  // 监听器
  watch: {
    $route(to, from) {
      console.log("路由变化......");
      console.log(to);
      console.log(from);
      this.init();
    },
  },

  // 生命周期方法（在路由切换，组件不变的情况下不会被调用）
  created() {
    console.log("form created ......");
    this.init();
  },

  methods: {
    // 表单初始化
    init() {
      // debugger
      this.fetchDataById(this.$store.getters.id);
    },

    userInfoOperator() {
      console.log(this.student);
      if (!this.student.id) {
        this.$router.push({ path: "/usercenter/add" });
      } else {
        this.$router.push({ path: "/usercenter/update/" + this.student.id });
      }
    },
    getInfo(tab, event) {
      if (tab.index === 0) {
        this.init();
      } else {
        studentApi.getByUserId(this.$store.getters.id).then((res) => {
          // debugger;
          if (!res.success) {
            this.$message({
              type: "warning",
              message: "您还未绑定个人身份信息，请尽快绑定！",
            });
          } else {
            // debugger;
            this.student = res.data.item;
          }
        });
      }
      console.log("哈哈哈哈");
    },
    saveOrUpdate() {
      this.$refs.user.validate((valid) => {
        if (valid) {
          this.saveBtnDisabled = true; // 防止表单重复提交
          //先上传用户的头像
          // var avatarUrl = this.uploadAvatar();
          // // debugger;
          // if (avatarUrl === NaN) {
          //   //上传失败，所有数据清空
          //   this.saveBtnDisabled = false;
          //   return;
          // }
          // this.user.avatar = avatarUrl;
          // debugger;
          this.user.avatar = "";
          this.updateData();
        }
      });
    },

    //上传用户头像
    uploadAvatar() {
      var data = new FormData();
      data.append("file", this.fileList[0].raw, this.fileList[0].name);
      userApi.uploadAvatar(data).then((response) => {
        if (response.success) {
          this.$message({
            type: "success",
            message: response.message,
          });
        } else {
          this.$message({
            type: "warn",
            message: response.message,
          });
        }
        return response.data;
      });
    },
    // 根据id更新记录
    updateData() {
      // teacher数据的获取
      userApi.updateById(this.user).then((response) => {
        if (response.success) {
          this.$message({
            type: "success",
            message: response.message,
          });
          this.$router.push({ path: "/usercenter/usercenter" });
        }
      });
    },

    // 根据id查询记录
    fetchDataById(id) {
      userApi.getById(id).then((response) => {
        // debugger
        this.user = response.data.user;
      });
    },

    handleAvatarSuccess(res, file) {
      console.log("handleAvatarSuccess：" + file);
      this.$refs.user.clearValidate("avatar"); //清除图片校验文字
    },
    //头像上传之前进行校验
    beforeAvatarUpload(file) {
      console.log("上传前类型校验");
      const fileSuffix = file.name.substring(file.name.lastIndexOf(".") + 1);

      const whiteList = [
        "jpg",
        "jpeg",
        "png",
        "gif",
        "bmp",
        "JPG",
        "JPEG",
        "PBG",
        "GIF",
        "BMP",
      ];

      if (whiteList.indexOf(fileSuffix) === -1) {
        this.$message.error(
          "上传文件只能是 jpg,jpeg,png,gif,bmp,JPG,JPEG,PBG,GIF,BMP 格式"
        );
        return false;
      }

      const isLt2M = file.size / 1024 / 1024 < 2;

      if (!isLt2M) {
        this.$message.error("上传文件大小不能超过 2MB");
        return false;
      }
      return isJPG && isLt2M;
    },
    handleAvatarChange(file, fileList) {
      console.log("handleAvatarChange：" + file);
      // this.user.avatar = URL.createObjectURL(file.raw);
      //读取图片为url
      var reader = new FileReader();
      reader.readAsDataURL(file.raw);

      // 读取成功调用方法
      reader.onload = (res) => {
        console.log("读取成功");

        // e.target.result 获取 读取成功后的  文件DataURL
        console.log("读取成功的回调：" + res);
        this.user.avatar = res.target.result;
      };
      this.fileList = fileList;
    },
    handleAvatarPreview(file) {
      console.log(file);
    },
    handleAvatarRemove() {},
  },
};
</script>

<style>
.container {
  margin: 80px 100px 30px 100px;
}
.el-tabs__nav-scroll {
  overflow: hidden;
  display: grid;
  align-content: center;
}
.description-table {
  margin: 50px 30px;
}
.margin-top {
  margin-top: 100px;
}
</style>