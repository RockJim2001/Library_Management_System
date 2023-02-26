package whut.rockjim.oss.controller;


import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import whut.rockjim.oss.service.OssService;
import whut.rockjim.oss.utils.AliyunOSSUtil;
import whut.rockjim.utils.utils.Result;

/**
 * Created by IntelliJ IDEA.
 * @Author : RockJim
 * @create 2022/11/23 18:46
 * @description 文件上传下载
 */
@RestController
@RequestMapping("/file")
public class OssController {

    @Autowired
    private OssService ossService;

    @ApiOperation(value = "用户头像上传")
    @PostMapping("/avatar")
    public Result uploadAvatar(@RequestPart(value = "file") MultipartFile file){
        //调用服务
        String fileUrl = ossService.uploadFile("avatar",file);
//        String fileUrl= AliyunOSSUtil.upload(filename,file);
        return  Result.ok().data("avatar",fileUrl);
    }

    @ApiOperation(value = "学生照片上传")
    @PostMapping("/user/picture")
    public Result userPicture(@RequestPart(value = "file") MultipartFile file){
        //调用服务
        String fileUrl = ossService.uploadFile("student",file);
//        String fileUrl= AliyunOSSUtil.upload(filename,file);
        return  Result.ok().data("avatar",fileUrl);
    }
    @ApiOperation(value = "图书照片上传")
    @PostMapping("/book/picture")
    public Result bookPicture(@RequestPart(value = "file") MultipartFile file){
        //调用服务
        String fileUrl = ossService.uploadFile("book/picture",file);
//        String fileUrl= AliyunOSSUtil.upload(filename,file);
        return  Result.ok().data("picture",fileUrl);
    }

    @ApiOperation(value = "图书电子文档上传")
    @PostMapping("/book/content")
    public Result bookContent(@RequestPart(value = "file") MultipartFile file){
        //调用服务
        String fileUrl = ossService.uploadFile("book/content",file);
//        String fileUrl= AliyunOSSUtil.upload(filename,file);
        return  Result.ok().data("content",fileUrl);
    }
}