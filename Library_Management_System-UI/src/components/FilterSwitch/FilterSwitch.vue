<template>
  <div class="filter-box">
    <div class="filter-switch">
      <h3>筛选条件</h3>
      <el-switch v-model="show"></el-switch>
    </div>
    <div class="filter-child" v-show="show">
      <slot></slot>
    </div>
  </div>
</template>
  
  <script>
export default {
  props: {
    initShop: {
      type: Boolean,
      default: false,
    },
  },
  data() {
    return {
      show: false,
    };
  },
  created() {
    this.init();
  },
  methods: {
    init() {
      this.show = this.props.initShop;
    },
  },
};
</script>
  
  <style lang="scss" scoped>
.filter-switch {
  padding: 0 12px;
  span {
    margin-right: 12px;
    font-size: 13px;
    color: #444;
  }
}

.filter-child {
  margin-top: 20px;
}
</style>