import request from '@/utils/request'

const api_name = '/lms/borrow'

export default {
  getPageList(page, limit) {
    return request({
      url: `${api_name}/${page}/${limit}`,
      method: 'get',
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
  returnById(classification) {
    return request({
      url: `${api_name}/return`,
      method: 'put',
      data: classification
    })
  },
  getBorrowByStudent(page, limit, id) {
    return request({
      url: `${api_name}/student/${page}/${limit}`,
      method: 'get',
      params: {
        id
      }
    })
  },
  borrowBook(idList) {
    return request({
      url: `${api_name}/borrowBook`,
      method: 'put',
      data: idList
    })
  }
}
