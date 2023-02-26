export default {
  //日期转字符串格式
  DateToStr(date) {
    var year = date.getFullYear(); //年
    var month = date.getMonth(); //月
    var day = date.getDate(); //日
    var hours = date.getHours(); //时
    var min = date.getMinutes(); //分
    var second = date.getSeconds(); //秒
    return year + "-" +
      ((month + 1) > 9 ? (month + 1) : "0" + (month + 1)) + "-" +
      (day > 9 ? day : ("0" + day)) + " " +
      (hours > 9 ? hours : ("0" + hours)) + ":" +
      (min > 9 ? min : ("0" + min)) + ":" +
      (second > 9 ? second : ("0" + second));
  },


  // 字符串转日期
  StrToDate(datestr) {
    return new Date(datestr);
  },


  // 字符串转新字符串
  formatDate(dateStr) {
    var newdateStr = dateStr.replace(/\d+(?=-[^-]+$)/, (a) => (parseInt(a, 10) - 1)); //字符串处理(月份)
    var nums = newdateStr.match(/\d+/g); //取数
    var date = eval('new Date(' + nums + ')'); //转换
    //重组
    var datetime =
      date.getFullYear() + "-" + //年
      ((date.getMonth() + 1) > 9 ? (date.getMonth() + 1) : "0" + (date.getMonth() + 1)) + "-" + //月
      (date.getDate() > 9 ? date.getDate() : ("0" + date.getDate())); //日
    return datetime;
  },

  getTime() {
    var date = new Date();
    var seperator1 = "-";
    var seperator2 = ":";
    var month = date.getMonth() + 1;
    var strDate = date.getDate();
    if (month >= 1 && month <= 9) {
      month = "0" + month;
    }
    if (strDate >= 0 && strDate <= 9) {
      strDate = "0" + strDate;
    }
    var currentdate = date.getFullYear() + seperator1 + month + seperator1 + strDate + " " + date.getHours() + seperator2 + date.getMinutes() + seperator2 + date.getSeconds();
    return currentdate;
  }
}
