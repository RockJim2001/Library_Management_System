import request from '@/utils/request'

const api_name = '/file'


// 系统文件处理操作
export default {
  // 用户头像上传
  uploadAvatar(avatar) {
    return request({
      url: `${api_name}/avatar`,
      method: 'post',
      data: avatar
    })
  },
  // 学生照片上传
  uploadUserPicture(picture) {
    return request({
      url: `${api_name}/user/picture`,
      method: 'post',
      data: picture
    })
  },
  // 图书照片上传
  uploadBookPicture(picture) {
    return request({
      url: `${api_name}/book/picture`,
      method: 'post',
      data: picture
    })
  },
  // 图书电子文档上传
  uploadBookContent(content) {
    return request({
      url: `${api_name}/book/content`,
      method: 'post',
      data: content
    })
  },
}
