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
    <div>
      <el-button type="warning" size="mini" v-if="hasPerm('borrow.add')"
        >添加</el-button
      >
      <el-button
        type="danger"
        size="mini"
        @click="removeRows()"
        v-if="hasPerm('borrow.remove')"
        >批量删除</el-button
      >
      <el-button
        type="success"
        size="mini"
        @click="saveRows()"
        v-if="hasPerm('borrow.download')"
        >导出</el-button
      >
    </div>

    <!-- 分类列表 -->
    <el-table
      v-loading="listLoading"
      :data="list"
      stripe
      style="width: 100%"
      @selection-change="handleSelectionChange"
    >
      <el-table-column type="selection" width="55" />

      <el-table-column label="序号" width="70" align="center">
        <template slot-scope="scope">
          {{ (page - 1) * limit + scope.$index + 1 }}
        </template>
      </el-table-column>

      <el-table-column prop="id" label="流水号" width="170" align="center" />
      <el-table-column prop="student" label="姓名" width="150" align="center" />

      <el-table-column
        prop="bookName"
        label="书名"
        width="150"
        align="center"
      />
      <el-table-column
        prop="publishingHouse"
        label="出版社"
        width="150"
        align="center"
      />
      <el-table-column
        prop="borrowDate"
        label="借阅日期"
        width="150"
        align="center"
      />

      <el-table-column
        prop="limit"
        label="可借时长"
        width="150"
        align="center"
      />
      <el-table-column
        prop="returnDate"
        label="归还日期"
        width="150"
        align="center"
      />
      <el-table-column
        prop="violationDescription"
        label="违规说明"
        width="400"
        align="center"
      />
      <!-- <el-table-column
        prop="handler"
        label="处理人"
        width="150"
        align="center"
      /> -->

      <el-table-column label="操作" width="100" align="center">
        <template slot-scope="scope">
          <!-- <router-link :to="'/lms/borrow/' + scope.row.id">
            <el-button
              type="info"
              size="mini"
              icon="el-icon-info"
              v-if="hasPerm('borrow.detail')"
            ></el-button>
          </router-link> -->
          <el-button
            type="primary"
            size="mini"
            icon="el-icon-edit"
            @click="borrowEdit(scope)"
            v-if="hasPerm('borrow.update')"
          ></el-button>

          <!-- <el-button
            type="danger"
            size="mini"
            icon="el-icon-delete"
            @click="removeDataById(scope.row.id)"
            v-if="hasPerm('borrow.remove')"
          ></el-button> -->
        </template>
      </el-table-column>
    </el-table>

    <!-- 编辑对话框 -->
    <el-dialog title="借阅记录" :visible.sync="dialogFormVisible">
      <el-form :model="borrow">
        <el-form-item label="流水号" :label-width="formLabelWidth">
          <el-input v-model="borrow.id" autocomplete="off" disabled></el-input>
        </el-form-item>
        <el-form-item label="借阅者" :label-width="formLabelWidth">
          <el-input
            v-model="borrow.student"
            autocomplete="off"
            disabled
          ></el-input>
        </el-form-item>
        <el-form-item label="出版社" :label-width="formLabelWidth">
          <el-input
            v-model="borrow.publishingHouse"
            autocomplete="off"
            disabled
          ></el-input>
        </el-form-item>
        <el-form-item label="借阅日期" :label-width="formLabelWidth">
          <el-date-picker
            v-model="borrow.borrowDate"
            type="datetime"
            placeholder="选择日期时间"
            disabled
          >
          </el-date-picker>
        </el-form-item>

        <el-form-item label="可借时长" :label-width="formLabelWidth">
          <el-input
            v-model="borrow.limit"
            autocomplete="off"
            disabled
          ></el-input>
        </el-form-item>

        <el-form-item label="归还日期" :label-width="formLabelWidth">
          <el-date-picker
            v-model="borrow.returnDate"
            type="datetime"
            placeholder="选择日期时间"
          >
          </el-date-picker>
        </el-form-item>
        <el-form-item label="违规说明" :label-width="formLabelWidth">
          <el-input
            v-model="borrow.violationDescription"
            autocomplete="off"
          ></el-input>
        </el-form-item>
      </el-form>

      <div slot="footer" class="dialog-footer">
        <el-button @click="dialogFormVisible = false">取 消</el-button>
        <el-button type="primary" @click="handleEdit">确 定</el-button>
      </div>
    </el-dialog>

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
import borrowApi from "@/api/lms/borrow";
const defaultForm = {
  id: "",
  student: "",
  bookName: "",
  publishingHouse: "",
  borrowDate: "",
  limit: "",
  returnDate: "",
  violationDescription: "",
};
export default {
  data() {
    return {
      dialogFormVisible: false,
      listLoading: true, // 数据是否正在加载
      list: null, // 讲师列表
      total: 0, // 数据库中的总记录数
      page: 1, // 默认页码
      limit: 10, // 每页记录数
      keyword: {}, // 查询表单对象
      multipleSelection: [], // 批量选择中选择的记录列表
      borrow: defaultForm,
      formLabelWidth: "120px",
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

    borrowEdit(scope) {
      this.borrow = scope.row;
      this.dialogFormVisible = true;
    },
    handleEdit() {
      // 执行修改请求
      borrowApi.updateById(this.borrow).then((res) => {
        if (res.success) {
          this.$message({
            type: "success",
            message: "修改成功!",
          });
          this.borrow = defaultForm;
          this.dialogFormVisible = false;
        }
      });
    },

    addUser() {
      this.$router.push({ path: "/lms/borrow/add" });
    },
    saveRows() {
      this.$router.push({ path: "/lms/borrow/import" });
    },
    // 加载分类列表数据
    fetchData(page = 1) {
      console.log("翻页。。。" + page);
      // 异步获取远程数据（ajax）
      this.page = page;

      borrowApi.getPageList(this.page, this.limit).then((response) => {
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
          return borrowApi.removeById(id);
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
          return borrowApi.removeRows(idList);
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
  },
};
</script>

