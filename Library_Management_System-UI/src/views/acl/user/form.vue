<template>
  <div class="app-container">
    <el-row>
      <el-col :span="20">
        <el-card shadow="hover" :body-style="{ padding: '0px' }">
          <br />
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
              <el-input v-model="user.username" />
            </el-form-item>
            <el-form-item label="用户昵称" prop="nickName">
              <el-input v-model="user.nickName" />
            </el-form-item>

            <el-form-item v-if="!user.id" label="用户密码" prop="password">
              <el-input v-model="user.password" />
            </el-form-item>
            <el-form-item v-if="user.id" label="密码管理" prop="password">
              <el-button
                type="text"
                @click="PasswordRefesh"
                :disabled="refeshBtnDisabled"
                >密码重置</el-button
              >
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
        </el-card>
      </el-col>
    </el-row>
  </div>
</template>

<script>
import userApi from "@/api/acl/user";
import fileApi from "@/api/file";

const defaultForm = {
  avatar: "",
  username: "",
  nickName: "",
  password: "",
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
      if (this.$route.params && this.$route.params.id) {
        const id = this.$route.params.id;
        this.fetchDataById(id);
      } else {
        // 对象拓展运算符：拷贝对象，而不是赋值对象的引用
        this.user = { ...defaultForm };
      }
    },
    //上传用户头像
    uploadAvatar() {},
    saveOrUpdate() {
      this.$refs.user.validate((valid) => {
        if (valid) {
          this.saveBtnDisabled = true; // 防止表单重复提交
          var avatarUrl =
            "https://no-auth-resources.oss-cn-hangzhou.aliyuncs.com/avatar/c67dbd9bac5443e885a4870c00dc27fd.gif";

          //先上传用户的头像
          var data = new FormData();
          data.append("file", this.fileList[0].raw, this.fileList[0].name);
          fileApi.uploadAvatar(data).then((response) => {
            if (response.success) {
              avatarUrl = response.data.avatar;
              console.log("后端传来的值为：" + response.data.avatar);
              this.user.avatar = avatarUrl;
              if (!this.user.id) {
                this.saveData();
              } else {
                this.updateData();
              }
            } else {
              this.$message({
                type: "warn",
                message: response.message,
              });
              return null;
            }
          });
          // var avatarUrl = this.uploadAvatar();
          // if (avatarUrl === null) {
          //   //上传失败，所有数据清空
          //   this.saveBtnDisabled = false;
          //   this.$message({
          //     type: "error",
          //     message: "上传失败！",
          //   });
          //   return;
          // }
        }
      });
    },

    // 新增用户
    saveData() {
      userApi.save(this.user).then((response) => {
        // debugger
        if (response.success) {
          this.$message({
            type: "success",
            message: response.message,
          });
          this.$router.push({ path: "/acl/user/list" });
        }
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
          this.$router.push({ path: "/acl/user/list" });
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
    //重置用户密码
    PasswordRefesh() {
      this.$prompt("确认将该用户密码重置为默认密码么？", "消息提醒", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        inputPattern: this.validatePass,
        inputValue: "111111",
        inputErrorMessage: "密码格式不正确",
      })
        .then(({ value }) => {
          //向后台发送请求
          this.user.password = value;
          debugger;
          this.refeshBtnDisabled = true;
          this.$message({
            type: "success",
            message: "你设置的默认密码是: " + value,
          });
        })
        .catch(() => {
          debugger;
          this.$message({
            type: "info",
            message: "取消重置",
          });
        });
    },
  },
};
</script>
