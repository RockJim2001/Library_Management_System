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
              <el-input v-model="student.name"></el-input>
            </el-form-item>

            <el-form-item prop="name" label="姓名" width="150" align="center">
              <el-input v-model="student.name"></el-input>
            </el-form-item>
            <el-form-item prop="author" label="作者" width="150" align="center"
              ><el-input v-model="book.author"
            /></el-form-item>

            <el-form-item prop="publishingHouse" label="出版社">
              <el-input v-model="book.publishingHouse"></el-input>
            </el-form-item>

            <el-form-item prop="picture" label="图片" width="150" align="center"
              ><el-input v-model="book.picture"
            /></el-form-item>
            <el-form-item
              prop="content"
              label="电子路径"
              width="150"
              align="center"
              ><el-input v-model="book.content"
            /></el-form-item>
            <el-form-item label="描述" prop="description">
              <el-input v-model="book.description" />
            </el-form-item>
            <el-form-item prop="state" label="状态" width="150" align="center"
              ><el-input v-model="book.state" />
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

const defaultForm = {
  name: "",
  description: "",
};

const validatename = (rule, value, callback) => {
  if (value.length > 20) {
    callback(new Error("分类名称不能超过20个字"));
  } else {
    callback();
  }
};
const validateDescription = (rule, value, callback) => {
  if (value.length < 5) {
    callback(new Error("描述不能少于5个字"));
  } else {
    callback();
  }
};
export default {
  data() {
    return {
      book: defaultForm,
      saveBtnDisabled: false, // 保存按钮是否禁用,
      refeshBtnDisabled: false,
      validateRules: {
        name: [
          {
            required: true,
            trigger: "blur",
            validator: validatename,
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
      // debugger
      if (this.$route.params && this.$route.params.id) {
        const id = this.$route.params.id;
        this.fetchDataById(id);
      } else {
        // 对象拓展运算符：拷贝对象，而不是赋值对象的引用
        this.book = { ...defaultForm };
      }
    },

    saveOrUpdate() {
      this.$refs.book.validate((valid) => {
        if (valid) {
          this.saveBtnDisabled = true; // 防止表单重复提交
          if (!this.book.id) {
            this.saveData();
          } else {
            this.updateData();
          }
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
  },
};
</script>
