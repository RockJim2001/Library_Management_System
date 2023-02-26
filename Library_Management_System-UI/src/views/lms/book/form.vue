<template>
  <div class="app-container">
    <el-row>
      <el-col :span="20">
        <el-card shadow="hover" :body-style="{ padding: '0px' }">
          <br />
          <el-form
            ref="book"
            :model="book"
            :rules="validateRules"
            label-width="120px"
          >
            <el-form-item
              prop="id"
              label="编号"
              width="150"
              align="center"
              v-if="book.id"
              ><el-input v-model="book.id" disabled
            /></el-form-item>

            <el-form-item prop="name" label="书名" width="150" align="center">
              <el-input v-model="book.name" placeholder="书名不需要带书名号" />
            </el-form-item>
            <el-form-item prop="author" label="作者" width="150" align="center"
              ><el-input v-model="book.author"
            /></el-form-item>

            <el-form-item prop="publishingHouse" label="出版社">
              <el-input v-model="book.publishingHouse"></el-input>
            </el-form-item>

            <el-form-item
              prop="classificationId"
              label="分类"
              width="150"
              align="left"
            >
              <el-select
                v-model="book.classificationId"
                placeholder="请选择属于分类"
              >
                <el-option
                  v-for="item in classifications"
                  :key="item.value"
                  :label="item.label"
                  :value="item.value"
                >
                </el-option>
              </el-select>
            </el-form-item>

            <el-form-item
              prop="publishDate"
              label="出版日期"
              width="150"
              align="left"
            >
              <el-date-picker
                v-model="book.publishDate"
                type="date"
                placeholder="选择日期"
                value-format="yyyy-MM-dd HH:mm:ss"
              >
              </el-date-picker>
            </el-form-item>

            <el-form-item
              prop="number"
              label="借阅次数"
              width="150"
              align="center"
              v-if="book.number"
              ><el-input v-model="book.number" disabled
            /></el-form-item>

            <el-form-item prop="picture" label="图片" width="150" align="left">
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
                <img v-if="book.picture" :src="book.picture" class="avatar" />
                <i v-else class="el-icon-plus avatar-uploader-icon"></i>
              </el-upload>
            </el-form-item>

            <el-form-item
              prop="content"
              label="内容预览"
              width="150"
              align="left"
            >
              <el-tooltip
                class="item"
                effect="dark"
                content="点击链接在线预览电子书籍"
                placement="top"
              >
                <el-link
                  :href="preview(book.content)"
                  type="success"
                  target="_blank"
                  v-if="book.content"
                  >{{ book.name }}</el-link
                >
              </el-tooltip>

              <el-upload
                class="upload-demo"
                drag
                action=""
                :auto-upload="false"
                :file-list="contentList"
                :limit="1"
                :on-success="handleContentSuccess"
                :on-change="handleContentChange"
                v-if="!book.content || !book.id"
              >
                <i class="el-icon-upload"></i>
                <div class="el-upload__text">
                  将图书电子文档拖到此处，或<em>点击上传</em>
                </div>
              </el-upload>
              <!-- <el-input v-model="book.content" v-if="!book.content" /> -->
            </el-form-item>

            <el-form-item
              prop="libraryId"
              label="图书馆"
              width="150"
              align="left"
            >
              <el-select
                v-model="book.libraryId"
                placeholder="请选择哪个图书馆"
              >
                <el-option
                  v-for="item in librarys"
                  :key="item.value"
                  :label="item.label"
                  :value="item.value"
                >
                </el-option>
              </el-select>
            </el-form-item>

            <el-form-item
              prop="place"
              label="存放位置"
              width="150"
              align="center"
              ><el-input v-model="book.place"
            /></el-form-item>

            <el-form-item label="描述" prop="description">
              <el-input v-model="book.description" />
            </el-form-item>
            <el-form-item
              prop="state"
              label="状态"
              width="150"
              align="left"
              v-if="book.state"
            >
              <el-tag type="success" v-if="book.state === '0'">在馆</el-tag>
              <el-tag type="warning" v-if="!(book.state === '0')">借出</el-tag>
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
import bookApi from "@/api/lms/book";
import libraryApi from "@/api/lms/library";
import classificationApi from "@/api/lms/classification";
import fileApi from "@/api/file";
import kkFileView from "@/utils/kkFileView";

const validateDescription = (rule, value, callback) => {
  if (value.length < 5) {
    callback(new Error("描述不能少于5个字"));
  } else {
    callback();
  }
};
const defaultForm = {
  name: "",
  author: "",
  publishingHouse: "",
  classificationId: "",
  publishDate: "",
  number: "",
  picture: "",
  content: "",
  libraryId: "",
  place: "",
  description: "",
  state: "",
};
export default {
  data() {
    return {
      book: defaultForm,
      saveBtnDisabled: false, // 保存按钮是否禁用,
      refeshBtnDisabled: false,
      fileList: [],
      contentList: [],
      classifications: [],
      librarys: [],
      validateRules: {
        name: [
          {
            required: true,
            trigger: "blur",
            message: "请输入书名",
          },
        ],
        author: [
          {
            required: true,
            trigger: "blur",
            message: "请输入作者",
          },
        ],
        publishingHouse: [
          {
            required: true,
            trigger: "blur",
            message: "请输入出版社",
          },
        ],
        classificationId: [
          {
            required: true,
            trigger: "blur",
            message: "请输入分类",
          },
        ],
        publishDate: [
          {
            required: true,
            trigger: "blur",
            message: "请选择出版日期",
          },
        ],
        number: [
          {
            required: true,
            trigger: "blur",
            message: "不可修改",
          },
        ],
        picture: [
          {
            required: true,
            trigger: "blur",
            message: "请选择该书的照片",
          },
        ],
        content: [
          {
            required: true,
            trigger: "blur",
            message: "请上传该书的电子书籍",
          },
        ],
        libraryId: [
          {
            required: true,
            trigger: "blur",
            message: "请选择所属图书馆",
          },
        ],
        place: [
          {
            required: true,
            trigger: "blur",
            message: "请输入所在具体位置",
          },
        ],
        state: [
          {
            required: true,
            trigger: "blur",
            message: "不可修改",
          },
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
      libraryApi.getOptionList().then((res) => {
        var temp = res.data.items;
        var list = [];
        // debugger;
        for (let item of temp) {
          list.push({
            value: item.id,
            label: item.name,
          });
        }
        this.librarys = list;
      });
      classificationApi.getOptionList().then((res) => {
        var temp = res.data.items;
        var list = [];
        // debugger;
        for (let item of temp) {
          list.push({
            value: item.id,
            label: item.classification,
          });
        }
        this.classifications = list;
      });
      // debugger
      if (this.$route.params && this.$route.params.id) {
        const id = this.$route.params.id;
        this.fetchDataById(id);
      } else {
        // 对象拓展运算符：拷贝对象，而不是赋值对象的引用
        this.book = { ...defaultForm };
      }
    },
    // 文件预览
    preview(url) {
      return kkFileView.kkFileView(url);
    },
    saveOrUpdate() {
      this.$refs.book.validate((valid) => {
        if (valid) {
          this.saveBtnDisabled = true; // 防止表单重复提交
          var avatarUrl =
            "https://no-auth-resources.oss-cn-hangzhou.aliyuncs.com/avatar/c67dbd9bac5443e885a4870c00dc27fd.gif";

          var contentUrl = "";

          //先上传学生的照片
          var picture_data = new FormData();
          picture_data.append(
            "file",
            this.fileList[0].raw,
            this.fileList[0].name
          );

          var content_data = new FormData();
          content_data.append(
            "file",
            this.contentList[0].raw,
            this.contentList[0].name
          );
          Promise.all([
            fileApi.uploadBookPicture(picture_data),
            fileApi.uploadBookContent(content_data),
          ])
            .then((res) => {
              let [picture, content] = res;
              this.book.picture = picture.data.picture;
              this.book.content = content.data.content;
              // 时间格式转换

              if (!this.book.id) {
                this.saveData();
              } else {
                this.updateData();
              }
            })
            .catch((err) => {
              this.$message({
                type: "warn",
                message: err.message,
              });
              return null;
            });
          // this.book.picture = null;
          // this.book.content = null;
          // if (!this.book.id) {
          //   this.saveData();
          // } else {
          //   this.updateData();
          // }
        }
      });
    },

    // 新增用户
    saveData() {
      bookApi.save(this.book).then((response) => {
        // debugger
        if (response.success) {
          this.$message({
            type: "success",
            message: response.message,
          });
          this.$router.push({ path: "/lms/book/list" });
        }
      });
    },

    // 根据id更新记录
    updateData() {
      bookApi.updateById(this.book).then((response) => {
        if (response.success) {
          this.$message({
            type: "success",
            message: response.message,
          });
          this.$router.push({ path: "/lms/book/list" });
        }
      });
    },

    // 根据id查询记录
    fetchDataById(id) {
      bookApi.getById(id).then((response) => {
        // debugger
        this.book = response.data.item;
      });
    },

    //上传用户头像
    uploadAvatar() {
      var data = new FormData();
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
      this.$refs.book.clearValidate("picture"); //清除图片校验文字
      // this.$refs.book.clearValidate("content"); //清除图片校验文字
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
        this.book.picture = res.target.result;
      };
      this.fileList = fileList;
    },
    handleAvatarPreview(file) {
      console.log(file);
    },
    handleAvatarRemove() {},
    handleContentChange(file, contentList) {
      console.log("handleContentChange" + file);
      // this.user.avatar = URL.createObjectURL(file.raw);
      //读取图片为url
      var reader = new FileReader();
      reader.readAsDataURL(file.raw);

      // 读取成功调用方法
      reader.onload = (res) => {
        console.log("读取成功");

        // e.target.result 获取 读取成功后的  文件DataURL
        console.log("读取handleContentChange成功的回调：" + res);
        this.book.content = res.target.result;
      };
      this.contentList = contentList;
    },
    handleContentSuccess(res, file) {
      console.log("handleAvatarSuccess：" + file);
      // this.$refs.book.clearValidate("picture"); //清除图片校验文字
      this.$refs.book.clearValidate("content"); //清除图片校验文字
    },
  },
};
</script>
