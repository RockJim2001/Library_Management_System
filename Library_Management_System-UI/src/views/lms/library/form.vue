<template>
  <div class="app-container">
    <el-row>
      <el-col :span="20">
        <el-card shadow="hover" :body-style="{ padding: '0px' }">
          <br />
          <el-form
            ref="library"
            :model="library"
            :rules="validateRules"
            label-width="120px"
          >
            <el-form-item label="名称" prop="name">
              <el-input v-model="library.name" />
            </el-form-item>
            <el-form-item label="负责人" prop="principal">
              <el-input v-model="library.principal" />
            </el-form-item>
            <el-form-item label="联系方式" prop="contact">
              <el-input v-model="library.contact" />
            </el-form-item>
            <el-form-item label="官网" prop="network">
              <el-input v-model="library.network" />
            </el-form-item>

            <el-form-item label="描述" prop="description">
              <el-input v-model="library.description" />
            </el-form-item>

            <el-form-item label="地址" prop="address">
              <el-input v-model="library.address" />
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
import libraryApi from "@/api/lms/library";

const defaultForm = {
  name: "",
  principal: "",
  contact: "",
  network: "",
  description: "",
  address: "",
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
const validateDescription = (rule, value, callback) => {
  if (value.length < 5) {
    callback(new Error("描述不能少于5个字"));
  } else {
    callback();
  }
};
const checkUrl = (rule, value, callback) => {
  if (/^http:\/\/([\w-]+\.)+[\w-]+(\/[\w-./?%&=]*)?$/.test(value) == false) {
    callback(new Error("请输入正确的Url"));
  } else {
    callback();
  }
};

export default {
  data() {
    return {
      library: defaultForm,
      saveBtnDisabled: false, // 保存按钮是否禁用,
      refeshBtnDisabled: false,
      validateRules: {
        name: [
          {
            required: true,
            trigger: "blur",
            message: "请输入图书馆名称",
          },
        ],
        principal: [
          {
            required: true,
            trigger: "blur",
            validator: validatename,
          },
        ],
        contact: [
          {
            required: true,
            trigger: "blur",
            validator: checkPhone,
          },
        ],
        network: [
          {
            required: true,
            trigger: "blur",
            validator: checkUrl,
          },
        ],
        description: [
          {
            required: true,
            trigger: "blur",
            validator: validateDescription,
          },
        ],
        address: [
          {
            required: true,
            trigger: "blur",
            message: "请输入图书馆地址",
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
        this.library = { ...defaultForm };
      }
    },

    saveOrUpdate() {
      this.$refs.library.validate((valid) => {
        if (valid) {
          this.saveBtnDisabled = true; // 防止表单重复提交
          if (!this.library.id) {
            this.saveData();
          } else {
            this.updateData();
          }
        }
      });
    },

    // 新增用户
    saveData() {
      libraryApi.save(this.library).then((response) => {
        // debugger
        if (response.success) {
          this.$message({
            type: "success",
            message: response.message,
          });
          this.$router.push({ path: "/lms/library/list" });
        }
      });
    },

    // 根据id更新记录
    updateData() {
      libraryApi.updateById(this.library).then((response) => {
        if (response.success) {
          this.$message({
            type: "success",
            message: response.message,
          });
          this.$router.push({ path: "/lms/library/list" });
        }
      });
    },

    // 根据id查询记录
    fetchDataById(id) {
      libraryApi.getById(id).then((response) => {
        // debugger
        this.library = response.data.item;
      });
    },
  },
};
</script>
