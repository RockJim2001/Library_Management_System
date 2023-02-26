<template>
  <div class="app-container">
    <!-- 查询表单 -->
    <!--查询表单-->
    <br />
    <el-form :inline="true" class="demo-form-inline">
      <el-form-item>
        <el-input v-model="searchObj.username" placeholder="用户名/昵称" />
      </el-form-item>

      <el-button type="primary" icon="el-icon-search" @click="fetchData()"
        >查询</el-button
      >
      <el-button type="default" @click="resetData()">清空</el-button>
    </el-form>
    <br />
    <!-- 工具条 -->
    <div>
      <el-button
        type="danger"
        size="mini"
        @click="addUser()"
        v-if="hasPerm('user.add')"
        >添加</el-button
      >
      <el-button
        type="danger"
        size="mini"
        @click="removeRows()"
        v-if="hasPerm('user.remove')"
        >批量删除</el-button
      >
    </div>
    <br />
    <!-- 用户列表 -->
    <el-table
      v-loading="listLoading"
      :data="list"
      stripe
      style="width: 100%"
      @selection-change="handleSelectionChange"
      :highlight-current-row="true"
    >
      <el-table-column type="selection" width="45" />

      <el-table-column label="序号" width="50" align="center">
        <template slot-scope="scope">
          {{ (page - 1) * limit + scope.$index + 1 }}
        </template>
      </el-table-column>

      <el-table-column
        prop="username"
        label="用户名"
        width="100"
        align="center"
      />

      <el-table-column prop="nickName" label="用户昵称" align="center" />

      <el-table-column prop="avatar" label="头像" width="150" align="center">
        <template slot-scope="scope">
          <el-avatar
            size="large"
            :src="scope.row.avatar"
            fit
            shape="square"
          ></el-avatar>
        </template>
      </el-table-column>

      <el-table-column
        prop="lastLoginTime"
        label="上次登录时间"
        width="180"
        align="center"
      />

      <el-table-column
        prop="gmtCreate"
        label="创建时间"
        width="180"
        align="center"
      />

      <el-table-column label="是否禁用" width="65" align="center">
        <template slot-scope="scope">
          <el-switch
            v-model="scope.row.state"
            :active-value="1"
            :inactive-value="0"
            active-color="#13ce66"
            inactive-color="#ff4949"
            @change="refeshRowData(scope.row)"
          >
          </el-switch>
        </template>
      </el-table-column>

      <el-table-column label="操作" width="230" align="center">
        <template slot-scope="scope">
          <router-link :to="'/acl/user/role/' + scope.row.id">
            <el-tooltip
              class="item"
              effect="dark"
              content="角色分配"
              placement="top"
            >
              <el-button
                type="info"
                size="mini"
                icon="el-icon-info"
                v-if="hasPerm('user.assgin')"
              ></el-button>
            </el-tooltip>
          </router-link>
          <router-link :to="'/acl/user/update/' + scope.row.id">
            <el-tooltip
              class="item"
              effect="dark"
              content="修改用户"
              placement="top"
            >
              <el-button
                type="primary"
                size="mini"
                icon="el-icon-edit"
                v-if="hasPerm('user.update')"
              ></el-button>
            </el-tooltip>
          </router-link>
          <el-tooltip
            class="item"
            effect="dark"
            content="删除用户"
            placement="top"
          >
            <el-button
              type="danger"
              size="mini"
              icon="el-icon-delete"
              @click="removeDataById(scope.row.id)"
              v-if="hasPerm('user.remove')"
            ></el-button>
          </el-tooltip>
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
import user from "@/api/acl/user";

export default {
  data() {
    return {
      listLoading: true, // 数据是否正在加载
      list: null, // 用户列表
      total: 0, // 数据库中的总记录数
      page: 5, // 默认页码
      limit: 10, // 每页记录数
      searchObj: {}, // 查询表单对象
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

    addUser() {
      this.$router.push({ path: "/acl/user/add" });
    },

    // 加载用户列表数据
    fetchData(page = 1) {
      console.log("翻页。。。" + page);
      // 异步获取远程数据（ajax）
      this.page = page;

      user
        .getPageList(this.page, this.limit, this.searchObj)
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
      this.searchObj = {};
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
          return user.removeById(id);
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
          return user.removeRows(idList);
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

    // 更新行数据
    refeshRowData(row) {
      return user.updateById(row);
    },
  },
};
</script>


