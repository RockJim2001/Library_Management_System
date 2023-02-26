<template>
  <div class="app-container">
    <el-row>
      <el-col :span="20">
        <el-card shadow="hover" :body-style="{ padding: '0px' }">
          <br />
          <el-form
            ref="student"
            :model="student"
            :rules="validateRules"
            label-width="120px"
          >
            <el-form-item
              prop="studentId"
              label="学号"
              width="150"
              align="center"
            >
              <el-input
                v-model="student.studentId"
                oninput="value=value.replace(/[^\d]/g,'')"
              ></el-input>
            </el-form-item>

            <el-form-item prop="name" label="姓名" width="150" align="center">
              <el-input v-model="student.name"></el-input>
            </el-form-item>
            <el-form-item prop="gender" label="性别" width="150" align="left">
              <el-select v-model="student.gender" placeholder="请选择">
                <el-option
                  v-for="item in options"
                  :key="item.value"
                  :label="item.label"
                  :value="item.value"
                >
                </el-option>
              </el-select>
            </el-form-item>

            <el-form-item prop="picture" label="照片">
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
                <img
                  v-if="student.picture"
                  :src="student.picture"
                  class="avatar"
                />
                <i v-else class="el-icon-plus avatar-uploader-icon"></i>
              </el-upload>
            </el-form-item>

            <el-form-item prop="phone" label="电话" width="150" align="center"
              ><el-input v-model="student.phone"
            /></el-form-item>

            <el-form-item prop="email" label="邮箱" width="150" align="center"
              ><el-input v-model="student.email"
            /></el-form-item>

            <el-form-item label="院系" prop="department">
              <el-input v-model="student.department" />
            </el-form-item>

            <el-form-item
              prop="description"
              label="简介"
              width="150"
              align="center"
              ><el-input v-model="student.description" />
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
import studentApi from "@/api/lms/student";
import fileApi from "@/api/file";

const defaultForm = {
  studentId: "",
  name: "",
  gender: "",
  picture: "",
  phone: "",
  email: "",
  department: "",
  description: "",
};
const validateStudentid = (rule, value, callback) => {
  // debugger;
  if (value.length != 13) {
    callback(new Error("学号必须是13位"));
  } else {
    callback();
  }
};
const validatename = (rule, value, callback) => {
  if (!value) {
    callback(new Error("请输入中文名"));
  } else {
    const reg = /^[\u4e00-\u9fa5]+$/;

    if (value.length < 100 && reg.test(value)) {
      callback();
    } else {
      return callback(new Error("请输入正确的中文名"));
    }
  }
};
const validateDescription = (rule, value, callback) => {
  if (value.length < 5) {
    callback(new Error("描述不能少于5个字"));
  } else {
    callback();
  }
};
const checkPhone = (rule, value, callback) => {
  if (!value) {
    callback(new Error("请输入联系方式"));
  } else {
    const reg = /^1[3|4|5|7|8][0-9]\d{8}$/;
    if (reg.test(value)) {
      callback();
    } else {
      return callback(new Error("请输入正确的电话"));
    }
  }
};
const validateEmail = (rule, value, callback) => {
  if (/^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/.test(value) || !value) {
    callback();
  } else {
    callback(new Error("请输入正确邮箱"));
  }
};
export default {
  data() {
    return {
      student: defaultForm,
      options: [
        {
          value: 0,
          label: "男",
        },
        {
          value: 1,
          label: "女",
        },
      ],
      fileList: [],
      saveBtnDisabled: false, // 保存按钮是否禁用,
      refeshBtnDisabled: false,
      validateRules: {
        studentId: [
          {
            required: true,
            trigger: "blur",
            validator: validateStudentid,
          },
        ],
        name: [
          {
            required: true,
            trigger: "blur",
            validator: validatename,
          },
        ],
        gender: [
          { required: true, trigger: "blur", message: "请选择一个性别" },
        ],
        picture: [
          { required: true, trigger: "blur", message: "请上传一张学生照片" },
        ],
        phone: [{ required: true, trigger: "blur", validator: checkPhone }],
        email: [{ required: true, trigger: "blur", validator: validateEmail }],
        department: [
          { required: true, trigger: "blur", message: "请输入院系信息" },
        ],
        description: [
          {
            required: true,
            trigger: "blur",
            validator: validateDescription,
          },
        ],
      },
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
        this.student = { ...defaultForm };
      }
    },

    saveOrUpdate() {
      this.$refs.student.validate((valid) => {
        if (valid) {
          this.saveBtnDisabled = true; // 防止表单重复提交
          var avatarUrl =
            "https://no-auth-resources.oss-cn-hangzhou.aliyuncs.com/avatar/c67dbd9bac5443e885a4870c00dc27fd.gif";

          //先上传学生的照片
          var data = new FormData();
          data.append("file", this.fileList[0].raw, this.fileList[0].name);
          fileApi.uploadUserPicture(data).then((response) => {
            if (response.success) {
              avatarUrl = response.data.avatar;
              console.log("后端传来的值为：" + response.data.avatar);
              this.student.picture = avatarUrl;
              if (!this.student.id) {
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
        }
      });
    },
    // 新增用户
    saveData() {
      studentApi.save(this.student).then((response) => {
        // debugger
        if (response.success) {
          this.$message({
            type: "success",
            message: response.message,
          });
          this.$router.push({ path: "/lms/student/list" });
        }
      });
    },

    // 根据id更新记录
    updateData() {
      studentApi.updateById(this.student).then((response) => {
        if (response.success) {
          this.$message({
            type: "success",
            message: response.message,
          });
          this.$router.push({ path: "/lms/student/list" });
        }
      });
    },

    // 根据id查询记录
    fetchDataById(id) {
      studentApi.getById(id).then((response) => {
        // debugger
        this.student = response.data.item;
      });
    },

    //上传用户头像
    uploadAvatar() {
      // var data = new FormData();
      // data.append("file", this.fileList[0].raw, this.fileList[0].name);
      // userApi.uploadAvatar(data).then((response) => {
      //   if (response.success) {
      //     this.$message({
      //       type: "success",
      //       message: response.message,
      //     });
      //   } else {
      //     this.$message({
      //       type: "warn",
      //       message: response.message,
      //     });
      //   }
      //   return response.data;
      // });
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
        this.student.picture = res.target.result;
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
