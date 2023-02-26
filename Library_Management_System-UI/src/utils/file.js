export const fileLimit = (file, fileType = ['xlsx']) => {
  const filePost = file.name.substring(file.name.lastIndexOf('.') + 1)
  // 限定文件后缀
  const extension = fileType.findIndex(item => item.toLowerCase().indexOf(filePost.toLowerCase()) > -1)
  // 限定上传文件大小为50MB
  const limit = 50
  const isLimit = file.size / 1024 / 1024 < limit
  if (extension === -1) {
    const fileTypeStr = fileType.join(',')
    return {
      limit: true,
      error: `仅支持上传${fileTypeStr}文件`
    }
  }
  return {
    limit: !isLimit,
    error: `文件大小不超过${limit}MB`
  }
}
