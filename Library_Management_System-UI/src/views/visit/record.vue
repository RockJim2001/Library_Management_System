<template>
  <div class="app-container">
    <!-- 查询表单 -->
    <!--查询表单-->
    <el-form :inline="true" class="demo-form-inline">
      <el-form-item>
        <el-input v-model="keyword" placeholder="关键字" />
      </el-form-item>

      <el-button
        type="primary"
        icon="el-icon-search"
        @click="handleSearch(keyword)"
        >查询</el-button
      >
      <el-button type="default" @click="resetData()">清空</el-button>
    </el-form>

    <!-- 分类列表 -->
    <el-table
      v-loading="listLoading"
      :data="filterMsg"
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

      <el-table-column prop="id" label="流水号" width="200" align="center" />
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
        width="150"
        align="center"
      />
      <el-table-column label="操作" width="250" align="center">
        <template slot-scope="scope">
          <!-- <router-link :to="'/lms/borrow/' + scope.row.id"> -->
          <el-tooltip
            class="item"
            effect="dark"
            :content="computedReturnDate(scope.row)"
            placement="top"
          >
            <el-button
              type="info"
              size="mini"
              icon="el-icon-info"
              @click="Warn(scope.row)"
              v-if="hasPerm('record.list')"
            ></el-button>
          </el-tooltip>
          <!-- </router-link> -->

          <!-- <router-link :to="'/lms/borrow/update/' + scope.row.id"> -->
          <el-tooltip class="item" effect="dark" content="续借" placement="top">
            <el-button
              type="primary"
              size="mini"
              icon="el-icon-edit"
              :disabled="scope.row.returnDate !== null ? true : false"
              @click="Renew(scope.row)"
              v-if="hasPerm('book.renew')"
              >续借</el-button
            ></el-tooltip
          >
          <!-- </router-link> -->
          <el-tooltip class="item" effect="dark" content="归还" placement="top">
            <el-button
              type="danger"
              size="mini"
              icon="el-icon-delete"
              :disabled="scope.row.returnDate !== null ? true : false"
              @click="returnBook(scope.row)"
              v-if="hasPerm('book.return')"
              >还书</el-button
            ></el-tooltip
          >
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
import borrowApi from "@/api/lms/borrow";
import dateApi from "@/utils/date";
export default {
  data() {
    return {
      listLoading: true, // 数据是否正在加载
      list: [], // 讲师列表
      filterMsg: [],
      total: 0, // 数据库中的总记录数
      page: 1, // 默认页码
      limit: 10, // 每页记录数
      keyword: "", // 查询表单对象
      multipleSelection: [], // 批量选择中选择的记录列表
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

    // 续借
    Renew(row) {
      if (row.limit > 30) {
        this.$message({
          type: "error",
          message: "一本书最多只能续借一次（30天)！",
        });
      } else {
        var temp = row;
        //向后端发送请求
        this.$confirm(
          "是否要续借流水号为:" +
            temp.id +
            "\t" +
            "书名为：" +
            temp.bookName +
            "\t" +
            "的这本书？",
          "提示",
          {
            confirmButtonText: "确定",
            cancelButtonText: "取消",
            type: "warning",
          }
        )
          .then(() => {
            setTimeout(() => {
              temp.limit += 30;
              borrowApi.updateById(temp).then((res) => {
                if (res.success) {
                  this.$message({
                    type: "success",
                    message: "续借成功!",
                  });
                  this.fetchData();
                }
              });
            }, 100);
          })
          .catch(() => {
            this.$message({
              type: "info",
              message: "已取消续借",
            });
            // this.fetchData();
          });
      }
    },
    // 提醒
    Warn(row) {
      var temp = this.computedReturnDate(row);
      this.$confirm(temp, "提示", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        type: "warning",
      });
    },
    // 计算归还日期
    computedReturnDate(row) {
      console.log("还书");
      let temp = new Date(row.borrowDate);
      let time1 = temp.valueOf();
      time1 = time1 + 24 * 60 * 60 * 1000 * row.limit;
      let returnDate = new Date(time1);
      return (
        "请在截止日期：" + dateApi.DateToStr(returnDate) + "之前归还该书！"
      );
    },
    // 加载分类列表数据
    fetchData(page = 1) {
      console.log("翻页。。。" + page);
      // 异步获取远程数据（ajax）
      this.page = page;
      var id = this.$store.getters.id;
      borrowApi
        .getBorrowByStudent(this.page, this.limit, id)
        .then((response) => {
          this.list = response.data.items;
          this.filterMsg = this.list;
          this.total = response.data.total;

          // 数据加载并绑定成功
          this.listLoading = false;
        });
    },

    // 重置查询表单
    resetData() {
      console.log("重置查询表单");
      this.keyword = "";
      this.fetchData();
    },
    // 还书请求
    returnBook(row) {
      var temp = row;
      //向后端发送请求
      this.$confirm(
        "是否要归还流水号为:" +
          temp.id +
          "\t" +
          "书名为：" +
          temp.bookName +
          "\t" +
          "的这本书？",
        "提示",
        {
          confirmButtonText: "确定",
          cancelButtonText: "取消",
          type: "warning",
        }
      )
        .then(() => {
          setTimeout(() => {
            var nowDate = dateApi.getTime();
            temp.returnDate = nowDate;
            // debugger;
            borrowApi.returnById(temp).then((res) => {
              if (res.success) {
                this.$message({
                  type: "success",
                  message: "还书成功!",
                });
                this.fetchData();
              }
            });
          }, 100);
          this.fetchData();
        })
        .catch(() => {
          this.$message({
            type: "info",
            message: "已取消还书",
          });
          // this.fetchData();
        });
    },

    // 当表格复选框选项发生变化的时候触发
    handleSelectionChange(selection) {
      console.log("handleSelectionChange......");
      console.log(selection);
      this.multipleSelection = selection;
    },

    handleSearch(keyword) {
      this.filterMsg = [];
      this.list.map((item) => {
        if (item.bookName.indeoOf(keyword) !== -1) {
          this.filterMsg.push(item);
        }
      });
      debugger;
    },
  },
};
</script>
  
  