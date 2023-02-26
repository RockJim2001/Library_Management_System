<template>
  <div>
    <div class="container-header">
      <div>
        <FilterSwitch>
          <el-form ref="form" :model="filterForm" label-width="80px">
            <el-form-item prop="name" label="书名">
              <el-input
                v-model="filterForm.name"
                placeholder="请输入书名"
                class="w300"
              ></el-input>
            </el-form-item>
            <el-form-item prop="author" label="作者">
              <el-input
                v-model="filterForm.author"
                placeholder="请输入书名"
                class="w300"
              ></el-input>
            </el-form-item>
            <el-form-item prop="publishingHouse" label="出版社">
              <el-input
                v-model="filterForm.publishingHouse"
                placeholder="请输入出版社"
                class="w300"
              ></el-input>
            </el-form-item>

            <el-form-item prop="publishDate" label="发布时间">
              <el-date-picker
                v-model="filterForm.publishDate"
                type="monthrange"
                range-separator="至"
                start-placeholder="开始日期"
                end-placeholder="结束日期"
                value-format="yyyy-MM"
              >
              </el-date-picker>
            </el-form-item>

            <el-form-item prop="libraryId" label="馆藏地">
              <el-select
                v-model="filterForm.libraryId"
                value=""
                placeholder="请选择哪个图书馆"
              >
                <el-option value="" label="全部">全部</el-option>
                <el-option
                  v-for="item in librarys"
                  :key="item.id"
                  :value="item.name"
                >
                </el-option>
              </el-select>
            </el-form-item>
            <el-form-item>
              <el-button type="primary" size="small" @click="submitForm"
                >筛选</el-button
              >
              <el-button size="small" @click="resetForm">清空</el-button>
            </el-form-item>
          </el-form>
        </FilterSwitch>
      </div>
    </div>
    <el-divider></el-divider>
    <div style="text-align: center; margin: 20px 20px 0px 20px">
      <el-transfer
        style="text-align: left; display: block"
        v-model="value4"
        filterable
        :filter-method="filterMethod"
        :left-default-checked="leftvalue"
        :right-default-checked="rightvalue"
        :titles="['馆内图书', '预借图书']"
        :button-texts="['取消', '借书']"
        :format="{
          noChecked: '${total}',
          hasChecked: '${checked}/${total}',
        }"
        @change="handleChange"
        :data="transferData"
        v-loading="loading"
        element-loading-text="拼命加载中"
        element-loading-spinner="el-icon-loading"
        element-loading-background="rgba(0, 0, 0, 0.8)"
      >
        <span slot-scope="{ option }">
          <el-row :gutter="4">
            <el-col :span="1"
              ><div class="grid-content bg-purple">
                {{ option.key }}
              </div></el-col
            >
            <el-col :span="6"
              ><div class="grid-content bg-purple">
                {{ option.label }}
              </div></el-col
            >
            <el-col :span="6"
              ><div class="grid-content bg-purple">
                {{ option.author }}
              </div></el-col
            >
            <el-col :span="6"
              ><div class="grid-content bg-purple">
                {{ option.publishingHouse }}
              </div></el-col
            >
          </el-row>
        </span>
        <el-button
          class="transfer-footer"
          slot="left-footer"
          icon="el-icon-refresh"
          size="small"
          type="info"
          circle
          @click="refreshData"
        ></el-button>
        <el-button
          class="transfer-footer"
          slot="right-footer"
          size="small"
          icon="el-icon-finished"
          type="success"
          @click="submitData"
          >借 阅</el-button
        >
      </el-transfer>
    </div>
  </div>
</template>


<script>
import FilterSwitch from "../../components/FilterSwitch/FilterSwitch.vue";
import libraryApi from "@/api/lms/library";
import bookApi from "@/api/lms/book";
import borrowApi from "@/api/lms/borrow";
const defaultForm = {
  name: "",
  author: "",
  publishingHouse: "",
  publishDate: "",
  libraryId: "",
  flag: false,
};
export default {
  components: { FilterSwitch },
  data() {
    return {
      sourceData: [], //筛选出来的数据
      transferData: [],
      filterForm: defaultForm,
      pickdata: {
        startTime: "",
        endTime: "",
      },
      query: "",
      leftvalue: [], // 左侧选择的值
      rightvalue: [], // 右侧选中的值
      value4: [],
      librarys: [],
      loading: true,
    };
  },
  created() {
    this.init();
  },
  methods: {
    handleChange(value, direction, movedKeys) {
      console.log(value, direction, movedKeys);
      if (direction === "right") {
        movedKeys.forEach((key) => {
          let index = this.leftvalue.findIndex((item) => item === key);
          this.leftvalue.splice(index, 1);
        });
        movedKeys.forEach((key) => {
          this.rightvalue.push(key);
        });
      } else {
        movedKeys.forEach((key) => {
          let index = this.rightvalue.findIndex((item) => item === key);
          this.rightvalue.splice(index, 1);
        });
        movedKeys.forEach((key) => {
          this.leftvalue.push(key);
        });
      }
    },
    init() {
      // console.log("触发了一次初始化操作");
      libraryApi.getOptionList().then((res) => {
        this.librarys = res.data.items;
      });

      bookApi.selectList(this.filterForm).then((res) => {
        this.sourceData = res.data.items;
        this.transferData = this.transfer(this.sourceData);
        this.loading = false;
      });
    },

    // 将temp数组转为el-transfer需要的形式
    transfer(temp) {
      const data = [];
      temp.forEach((item, index) => {
        data.push({
          label: item.name,
          key: ++index,
          id: item.id,
          author: item.author,
          publishingHouse: item.publishingHouse,
        });
      });
      return data;
    },
    refreshData() {
      console.log("哈哈哈哈");
      this.init();
    },
    submitData() {
      // 提交借阅列表
      var checklist = this.rightvalue;
      console.log(this.rightvalue);
      if (checklist.length === 0) {
        this.$message({
          type: "warning",
          message: "请勾选需要借阅的书籍！",
        });
        return;
      }
      this.$confirm("一键借阅所选书籍, 是否继续?", "提示", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        type: "warning",
      })
        .then(() => {
          setTimeout(() => {
            this.borrowCheck(checklist);
          }, 100);
        })
        .catch(() => {
          this.$message({
            type: "info",
            message: "已取消借阅",
          });
        });
    },
    // 借书
    borrowCheck(checklist) {
      // 从transferData绑定的数据中获取id列表
      var idList = [];

      checklist.forEach((item) => {
        idList.push(this.transferData[item].id);
      });

      let object = {
        id: this.$store.getters.id,
        idList: idList,
      };

      // 提交请求
      borrowApi.borrowBook(object).then((res) => {
        if (res.success) {
          this.$message({
            type: "success",
            message: "借阅成功!",
          });
          // debugger;
          // this.init();
          this.$router.push({ path: "/record/list" });
        }
      });
    },
    filterMethod(query, item) {
      return (
        item.label.indexOf(query) > -1 ||
        item.author.indexOf(query) > -1 ||
        item.publishingHouse.indexOf(query) > -1
      );
    },
    submitForm() {
      this.filterForm.flag = true;
      // const temp = this.filterForm.publishDate;
      // this.filterForm.publishDate = "";
      // this.filterForm.publishDate.push(temp[0]);
      // this.filterForm.publishDate.push(temp[1]);
      this.init();
      this.filterForm = {};
    },
    resetForm() {
      this.filterForm = {};
    },
  },
};
</script>

<style>
/* 穿梭框外框高宽度 */
.el-transfer-panel {
  width: 40%;
  height: 500px;
}
.el-transfer-panel__list.is-filterable {
  height: 360px;
  padding-top: 0;
}
.transfer-footer {
  margin-left: 20px;
}
</style>