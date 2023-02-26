<template>
  <div class="app-container">
    <!-- 查询表单 -->
    <!--查询表单-->
    <el-form :inline="true" class="demo-form-inline">
      <el-form-item>
        <el-input v-model="keyword.name" placeholder="关键字" />
      </el-form-item>

      <el-button type="primary" icon="el-icon-search" @click="fetchData()"
        >查询</el-button
      >
      <el-button type="default" @click="resetData()">清空</el-button>
    </el-form>

    <!-- 工具条 -->
    <div style="display: flex">
      <el-button
        type="warning"
        size="mini"
        @click="addUser()"
        v-if="hasPerm('student.add')"
        >添加</el-button
      >
      <el-button
        type="danger"
        size="mini"
        @click="removeRows()"
        v-if="hasPerm('student.remove')"
        >批量删除</el-button
      >
      <el-button
        type="success"
        size="mini"
        v-if="hasPerm('student.download')"
        @click="saveRows()"
        >模板下载</el-button
      >

      <el-upload
        ref="uploadButton"
        action=""
        :on-preview="previewFile"
        :on-remove="handleRemove"
        :before-upload="beforeUpload"
        :limit="1"
        :on-exceed="handleExceed"
        :http-request="uploadFile"
        :on-change="submitFile"
        :on-success="uploadSuccess"
        :auto-upload="false"
        :file-list="fileList"
        :show-file-list="false"
        style="margin-left: 10px"
      >
        <el-button size="small" type="info"> 批量添加 </el-button>
      </el-upload>
    </div>

    <!-- 分类列表 -->
    <el-table
      v-loading="listLoading"
      :data="list"
      stripe
      style="width: 100%"
      @selection-change="handleSelectionChange"
    >
      <el-table-column type="selection" width="45" />

      <el-table-column label="序号" width="50" align="center">
        <template slot-scope="scope">
          {{ (page - 1) * limit + scope.$index + 1 }}
        </template>
      </el-table-column>

      <el-table-column
        prop="studentId"
        label="学号"
        width="150"
        align="center"
      />
      <el-table-column prop="name" label="姓名" width="80" align="center" />
      <el-table-column prop="gender" label="性别" width="50" align="center">
        <template slot-scope="scope">
          <i
            class="el-icon-male"
            style="color: blue"
            v-if="scope.row.gender === 0"
          ></i>
          <i
            class="el-icon-female"
            style="color: red"
            v-if="scope.row.gender === 1"
          ></i>
        </template>
      </el-table-column>
      <el-table-column prop="picture" label="照片" width="100" align="center">
        <template slot-scope="scope">
          <el-avatar
            size="large"
            :src="scope.row.picture"
            fit
            shape="square"
          ></el-avatar>
        </template>
      </el-table-column>
      <el-table-column prop="phone" label="电话" width="150" align="center" />
      <el-table-column prop="email" label="邮箱" width="170" align="center" />
      <el-table-column
        prop="department"
        label="院系"
        width="150"
        align="center"
      />
      <el-table-column prop="description" label="描述" align="center" />

      <el-table-column label="操作" width="200" align="center">
        <template slot-scope="scope">
          <router-link :to="'/lms/student/update/' + scope.row.id">
            <el-button
              type="primary"
              size="mini"
              icon="el-icon-edit"
              v-if="hasPerm('student.update')"
            ></el-button>
          </router-link>
          <el-button
            type="danger"
            size="mini"
            icon="el-icon-delete"
            @click="removeDataById(scope.row.id)"
            v-if="hasPerm('student.remove')"
          ></el-button>
        </template>
      </el-table-column>
    </el-table>

    <!-- 分页组件 -->
    <el-pagination
      :current-page="page"
      :total="total"
      :page-size="limit"
      :page-sizes="[5, 10, 20, 30, 40, 50, 100]"
      style="padding: 30px 0; text-align: center"
      layout="sizes, prev, pager, next, jumper, ->, total, slot"
      @current-change="fetchData"
      @size-change="changeSize"
    />
  </div>
</template>

<script>
import studentApi from "@/api/lms/student";
import { fileLimit } from "@/utils/file";

export default {
  data() {
    return {
      listLoading: true, // 数据是否正在加载
      list: null, // 讲师列表
      total: 0, // 数据库中的总记录数
      page: 1, // 默认页码
      limit: 10, // 每页记录数
      keyword: {}, // 查询表单对象
      multipleSelection: [], // 批量选择中选择的记录列表
      fileList: [],
      file: undefined,
    };
  },

  // 生命周期函数：内存准备完毕，页面尚未渲染
  created() {
    console.log("list created......");
    this.fetchData();
  },

  // 生命周期函数：内存准备完毕，页面渲染成功
  mounted() {
    console.log("list mounted......");
  },

  methods: {
    // 当页码发生改变的时候
    changeSize(size) {
      console.log(size);
      this.limit = size;
      this.fetchData(1);
    },

    addUser() {
      this.$router.push({ path: "/lms/student/add" });
    },
    saveRows() {
      // this.$router.push({ path: "/lms/student/import" });
      studentApi.getTemplate().then((res) => {
        const blob = new Blob([res], {
          type: "application/vnd.ms-excel",
        });
        const link = document.createElement("a");
        link.href = window.URL.createObjectURL(blob);
        // 这里也可以自己从headers中获取文件名.
        link.download = "模板.xlsx";
        link.click();
        console.log("哈哈哈哈");
      });
    },
    // 加载分类列表数据
    fetchData(page = 1) {
      console.log("翻页。。。" + page);
      // 异步获取远程数据（ajax）
      this.page = page;

      studentApi
        .getPageList(this.page, this.limit, this.keyword)
        .then((response) => {
          this.list = response.data.items;
          this.total = response.data.total;

          // 数据加载并绑定成功
          this.listLoading = false;
        });
    },

    // 重置查询表单
    resetData() {
      console.log("重置查询表单");
      this.keyword = {};
      this.fetchData();
    },

    // 根据id删除数据
    removeDataById(id) {
      // debugger
      this.$confirm("此操作将永久删除该记录, 是否继续?", "提示", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        type: "warning",
      })
        .then(() => {
          // promise
          // 点击确定，远程调用ajax
          return studentApi.removeById(id);
        })
        .then((response) => {
          this.fetchData(this.page);
          if (response.success) {
            this.$message({
              type: "success",
              message: "删除成功!",
            });
          }
        })
        .catch(() => {
          this.$message({
            type: "info",
            message: "已取消删除",
          });
        });
    },

    // 当表格复选框选项发生变化的时候触发
    handleSelectionChange(selection) {
      console.log("handleSelectionChange......");
      console.log(selection);
      this.multipleSelection = selection;
    },

    // 批量删除
    removeRows() {
      console.log("removeRows......");

      if (this.multipleSelection.length === 0) {
        this.$message({
          type: "warning",
          message: "请选择要删除的记录!",
        });
        return;
      }

      this.$confirm("此操作将永久删除该记录, 是否继续?", "提示", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        type: "warning",
      })
        .then(() => {
          // promise
          // 点击确定，远程调用ajax
          // 遍历selection，将id取出放入id列表
          var idList = [];
          this.multipleSelection.forEach((item) => {
            idList.push(item.id);
            // console.log(idList)
          });
          // 调用api
          return studentApi.removeRows(idList);
        })
        .then((response) => {
          this.fetchData(this.page);
          if (response.success) {
            this.$message({
              type: "success",
              message: "删除成功!",
            });
          }
        })
        .catch(() => {
          this.$message({
            type: "info",
            message: "已取消删除",
          });
        });
    },

    // 执行搜索
    // queryString：文本框中输入的值
    // cb：一个函数
    querySearch(queryString, cb) {
      console.log(queryString);
      console.log(cb);

      // teacher.selectNameByKey(queryString).then(response => {
      //   // 调用 callback 返回建议列表的数据
      //   cb(response.data.items)
      // })
    },

    beforeUpload(file) {
      const body = fileLimit(file, this.fileType);
      if (body.limit) {
        this.$message.error(body.error);
      }
      return !body.limit;
    },
    previewFile(file) {
      if (file.url) {
        window.location.href = file.url;
      }
    },
    submitFile(file, fileList) {
      // 获取上传的文件
      this.file = file.raw;
      // 通过submit调用uploadFile
      this.$refs.uploadButton.submit();
    },
    uploadFile(params) {
      const form = new FormData();
      form.append("file", this.file, this.file.name);
      studentApi
        .saveBatch(form)
        .then((response) => {
          if (response.success) {
            this.$message({
              type: "success",
              message: "批量导入成功！",
            });
            this.fetchData();
          } else {
            var message = response.message + " \n\r ";
            for (var m of response.data.error) {
              message = message + " \t " + m;
            }
            this.$message({
              type: "warning",
              message: message,
              duration: 0,
              showClose: true,
            });
            this.fileList = [];
          }
        })
        .catch((res) => {
          console.log("出现错误");
        });
    },
    uploadSuccess(reponse, file, fileList) {
      this.$emit("on-success", this.fileList);
    },
    handleRemove(file, fileList) {
      this.$emit("on-remove", fileList);
      this.fileList = fileList;
    },
    handleExceed(files, fileList) {
      this.$message.warning(`仅可上传1个附件`);
    },
  },
};
</script>

