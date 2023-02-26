// kkFileView 用于在线预览文件

var host = "127.0.0.1" // kkFileView的ip
var port = 8012 // kkFileView的port

export default {
  kkFileView(url) {
    var result = 'http://' + host + ":" + port + "/onlinePreview?url=" + encodeURIComponent(window.btoa(url));
    return result;
  }
}
