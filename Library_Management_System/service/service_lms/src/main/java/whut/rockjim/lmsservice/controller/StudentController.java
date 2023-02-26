package whut.rockjim.lmsservice.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import whut.rockjim.aclservice.entity.UserAuth;
import whut.rockjim.aclservice.service.UserAuthService;
import whut.rockjim.lmsservice.entity.Student;
import whut.rockjim.lmsservice.service.StudentService;
import whut.rockjim.utils.utils.Result;
import whut.rockjim.utils.utils.excel.ExcelUtils;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * @Author : RockJim
 * @create 2022/11/28 14:09
 */
@RestController
@Api(value = "学生控制器")
@RequestMapping("/lms/student")
public class StudentController {
    @Autowired
    private StudentService studentService;

    @Autowired
    private UserAuthService userAuthService;

    @ApiOperation(value = "获取学生分页列表")
    @GetMapping("{page}/{limit}")
    public Result list(@ApiParam(name = "page", value = "当前页码", required = true)
                       @PathVariable Long page,
                       @ApiParam(name = "limit", value = "每页记录数", required = true)
                       @PathVariable Long limit,
                       @ApiParam(name = "keyword",value = "关键字")
                       Student student){
        Page<Student> pageParam = new Page<>(page, limit);

        QueryWrapper<Student> querryWrapper=new QueryWrapper<>();

        if(!StringUtils.isEmpty(student.getName())){
            querryWrapper.like("student_id",student.getName());
            querryWrapper.or();
            querryWrapper.like("name",student.getName());
            querryWrapper.or();
            querryWrapper.like("gender",student.getName());
            querryWrapper.or();
            querryWrapper.like("phone",student.getName());
            querryWrapper.or();
            querryWrapper.like("email",student.getName());
            querryWrapper.or();
            querryWrapper.like("department",student.getName());
            querryWrapper.or();
            querryWrapper.like("description",student.getName());
        }
        studentService.page(pageParam,querryWrapper);
        return Result.ok().data("items", pageParam.getRecords()).data("total", pageParam.getTotal());
    }

    @ApiOperation(value="通过id获取学生")
    @GetMapping("get/{id}")
    public Result get(@ApiParam(name = "id",value = "student实体的id",required = true)
                       @PathVariable String id){
        Student student = studentService.getById(id);
        return Result.ok().data("item",student);
    }

    @ApiOperation(value="通过用户id获取学生信息")
    @GetMapping("getByUserid/{id}")
    public Result getByUserid(@ApiParam(name = "id",value = "userAuth实体的id",required = true)
                       @PathVariable String id){
        // 先查询改用户的student_id
        String user_info_id=userAuthService.getById(id).getUserInfoId();
        if(user_info_id!=null){
            Student student = studentService.getById(user_info_id);
            return Result.ok().data("item",student);
        }else{
            Result result=Result.ok();
            result.setSuccess(false);
            return result;
        }
    }

    @ApiOperation(value="根据图书状态获取图书分页列表")
    @GetMapping("selectAll")
    public Result selectAll(Student student){

        List<Student> list = studentService.list();
        return Result.ok().data("items",list);
    }

    @ApiOperation(value="新增")
    @PostMapping("save")
    public Result save(@ApiParam(name = "student",value = "student实体",required = true)
                       @RequestBody Student student){
        studentService.save(student);
        return Result.ok();
    }

    @ApiOperation(value="绑定用户信息")
    @PostMapping("bind")
    public Result bind(@ApiParam(name = "student",value = "student实体",required = true)
                       @RequestBody Student student){
        String id=student.getId();
        student.setId(null);
        // 先生成一条学生信息记录
        studentService.save(student);
        // 更新用户的信息
        Student student1 = studentService.getOne(new QueryWrapper<Student>()
                .eq("student_id", student.getStudentId()).eq("name", student.getName()).eq("phone", student.getPhone())
                .eq("picture",student.getPicture()));
        userAuthService.update(new UpdateWrapper<UserAuth>().set("user_info_id",student1.getId()).eq("id",id));
        return Result.ok();
    }

    @ApiOperation(value = "修改图书")
    @PutMapping("update")
    public Result update(@ApiParam(name = "student",value = "student实体",required = true)
                         @RequestBody Student student){
        studentService.updateById(student);
        return Result.ok();
    }

    @ApiOperation(value = "删除图书")
    @DeleteMapping("remove/{id}")
    public Result remove(@ApiParam(name = "id",value = "student实体的id",required = true)
                         @PathVariable String id){
        studentService.removeById(id);
        return Result.ok();
    }

    @ApiOperation(value = "Excel批量导入")
    @PostMapping("import")
    public Result importStudent(@RequestPart("file")MultipartFile file) {
        List<Student> students=new ArrayList<>();
        try {
            students = ExcelUtils.readMultipartFile(file,Student.class);

        } catch (Exception e) {
            throw new RuntimeException(e);
        }

        List<String> messages=new ArrayList<>();
        for (Student student : students) {
            System.out.println(student.getPhone());
            if(!("".equals(student.getRowTips()))){
                messages.add("第"+student.getRowNum()+"条数据格式错误，错误信息："+student.getRowTips());
            }
        }
        if(messages.isEmpty()){
            studentService.saveBatch(students);
            return Result.ok();
        }else{
            return Result.ok().data("error",messages).success(false).message("部分数据格式有错！");
        }
    }

    @ApiOperation(value="Excel模板导出")
    @GetMapping("template")
    public void template(HttpServletResponse response){
        ExcelUtils.exportTemplate(response,"学生表",Student.class,true);
    }

    @ApiOperation(value = "批量删除")
    @DeleteMapping("batchRemove")
    public Result removeBatch(@ApiParam(name = "student",value = "批量删除student实体",required = true)
                              @RequestBody List<String> studentIds){
        studentService.removeBatchByIds(studentIds);
        return Result.ok();
    }
}
