import request from '@/utils/request'

const api_name = '/lms/classification'

export default {
  getPageList(page, limit, searchObj) {
    return request({
      url: `${api_name}/${page}/${limit}`,
      method: 'get',
      params: searchObj // url查询字符串或表单键值对
    })
  },
  save(classification) {
    return request({
      url: `${api_name}/save`,
      method: 'post',
      data: classification
    })
  },
  getById(id) {
    return request({
      url: `${api_name}/get/${id}`,
      method: 'get'
    })
  },

  removeById(id) {
    return request({
      url: `${api_name}/remove/${id}`,
      method: "delete"
    })
  },
  removeRows(idList) {
    return request({
      url: `${api_name}/batchRemove`,
      method: 'delete',
      data: idList
    })
  },
  updateById(classification) {
    return request({
      url: `${api_name}/update`,
      method: 'put',
      data: classification
    })
  },
  getOptionList() {
    return request({
      url: `${api_name}/getAll`,
      method: 'get'
    })
  }
}
