<template>
  <div>
    <el-card class="main-card">
      <h1 style="text-align: center">热门推荐图书</h1>
      <el-carousel :interval="4000" type="card" height="307px" :autoplay="true">
        <el-carousel-item v-for="carouse in books" :key="carouse.id">
          <el-card :body-style="{ padding: '0px' }">
            <img :src="carouse.picture" class="image" />
            <div style="padding: 14px">
              <div
                style="
                  display: flex,
                  flex-direction: row;
                  justify-content: space-around;
                "
              >
                <span style="color: brown">{{ carouse.name }}</span>
                <span>借阅数：{{ carouse.number }}</span>
              </div>

              <div class="bottom clearfix">
                <time class="time">{{ carouse.publishingHouse }}</time>
                <router-link :to="'/lms/book/detail/' + carouse.id">
                  <el-button type="text" class="button" @click="operator"
                    >查看详情</el-button
                  >
                </router-link>
              </div>
            </div>
          </el-card>
        </el-carousel-item>
      </el-carousel>
    </el-card>
  </div>
</template>

<script>
import bookApi from "@/api/lms/book";
export default {
  data() {
    return {
      currentDate: new Date(),
      books: [],
    };
  },
  created() {
    console.log("form created ......");
    this.init();
  },
  methods: {
    init() {
      this.fetchData();
    },
    fetchData() {
      // 发送请求，并初始化books数组
      bookApi.getListOrderByNumber().then((res) => {
        // var temp = res.data.item;
        // var list = [];
        // for (let i = 0; i < temp.length; i += 3) {
        //   var carouse = [];
        //   carouse.push(temp[i]);
        //   carouse.push(temp[i + 1]);
        //   carouse.push(temp[i + 2]);
        //   list.push(carouse);
        // }
        // this.books = list;
        this.books = res.data.item;
      });
    },
    operator() {
      console.log("啊哈哈哈哈");
    },
  },
};
</script>

<style>
.el-carousel__item h3 {
  color: #475669;
  font-size: 14px;
  opacity: 0.75;
  line-height: 200px;
  margin: 0;
}

.el-carousel__item--card {
  width: 15%;
}
.el-carousel__item:nth-child(2n) {
  background-color: #99a9bf;
}

.el-carousel__item:nth-child(2n + 1) {
  background-color: #d3dce6;
}
.time {
  font-size: 13px;
  color: #999;
}

.bottom {
  margin-top: 13px;
  line-height: 12px;
}

.button {
  padding: 0;
  float: right;
}

.image {
  width: 100%;
  display: block;
}

.clearfix:before,
.clearfix:after {
  display: table;
  content: "";
}

.clearfix:after {
  clear: both;
}
.main-card {
  margin: 20px 100px 0px 100px;
}
</style>