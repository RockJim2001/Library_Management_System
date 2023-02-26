package whut.rockjim.lmsservice.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import whut.rockjim.lmsservice.entity.Classification;
import whut.rockjim.lmsservice.service.ClassificationService;
import whut.rockjim.utils.utils.Result;
import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * @Author : RockJim
 * @create 2022/11/27 14:26
 */
@RestController
@Api(value = "图书分类控制器")
@RequestMapping("/lms/classification")
public class ClassificationController {

    @Autowired
    private ClassificationService classificationService;

    @ApiOperation(value = "分类分页列表")
    @GetMapping("{page}/{limit}")
    public Result list(
            @ApiParam(name = "page", value = "当前页码", required = true)
            @PathVariable Long page,
            @ApiParam(name = "limit", value = "每页记录数", required = true)
            @PathVariable Long limit,
            @ApiParam(name = "keyword",value = "关键字")
            Classification keyword){

        Page<Classification> pageParam = new Page<>(page, limit);

        QueryWrapper<Classification> querryWrapper=new QueryWrapper<>();
        if(!StringUtils.isEmpty(keyword.getClassification())){
            querryWrapper.like("classification",keyword.getClassification());
            querryWrapper.or();
            querryWrapper.like("description",keyword.getClassification());
        }
        classificationService.page(pageParam,querryWrapper);
        return Result.ok().data("items", pageParam.getRecords()).data("total", pageParam.getTotal());
    }

    @ApiOperation(value="通过id获取分类")
    @GetMapping("get/{id}")
    public Result save(@ApiParam(name = "id",value = "classification实体的id",required = true)
                           @PathVariable String id){
        Classification classification = classificationService.getById(id);
        return Result.ok().data("item",classification);
    }

    @ApiOperation(value="获取所有分类")
    @GetMapping("getAll")
    public Result getAll(){
        List<Classification> list = classificationService.list();
        return Result.ok().data("items",list);
    }

    @ApiOperation(value="新增分类")
    @PostMapping("save")
    public Result save(@ApiParam(name = "classification",value = "classification实体",required = true)
                       @RequestBody Classification classification){
        classificationService.save(classification);
        return Result.ok();
    }

    @ApiOperation(value = "修改分类")
    @PutMapping("update")
    public Result update(@ApiParam(name = "classification",value = "classification实体",required = true)
                         @RequestBody Classification classification){
        classificationService.updateById(classification);
        return Result.ok();
    }

    @ApiOperation(value = "删除分类")
    @DeleteMapping("remove/{id}")
    public Result remove(@ApiParam(name = "id",value = "classification实体的id",required = true)
                         @PathVariable String id){
        classificationService.removeById(id);
        return Result.ok();
    }

    @ApiOperation(value = "批量导入")
    @PostMapping("saveBatch")
    public Result saveBatch(@ApiParam(name = "classification",value = "classification实体",required = true)
                         @RequestBody List<Classification> classifications){
//        classificationService.update(classifications,null);
        return Result.ok();
    }

    @ApiOperation(value = "批量删除")
    @DeleteMapping("batchRemove")
    public Result removeBatch(@ApiParam(name = "classification",value = "批量删除classification实体",required = true)
                            @RequestBody List<String> classificationIds){
            classificationService.removeBatchByIds(classificationIds);
        return Result.ok();
    }

}
