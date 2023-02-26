package whut.rockjim.lmsservice.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import whut.rockjim.lmsservice.entity.Library;
import whut.rockjim.lmsservice.service.LibraryService;
import whut.rockjim.utils.utils.Result;

import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * @Author : RockJim
 * @create 2022/11/27 21:52
 */
@RestController
@Api(value = "图书馆控制器")
@RequestMapping("/lms/library")
public class LibraryController {

    @Autowired
    private LibraryService libraryService;

    @ApiOperation(value = "获取图书馆分页列表")
    @GetMapping("{page}/{limit}")
    public Result list(@ApiParam(name = "page", value = "当前页码", required = true)
                           @PathVariable Long page,
                       @ApiParam(name = "limit", value = "每页记录数", required = true)
                           @PathVariable Long limit,
                       @ApiParam(name = "keyword",value = "关键字")
                           Library library){
        Page<Library> pageParam = new Page<>(page, limit);

        QueryWrapper<Library> querryWrapper=new QueryWrapper<>();
        if(!StringUtils.isEmpty(library.getName())){
            querryWrapper.like("name",library.getName());
            querryWrapper.or();
            querryWrapper.like("principal",library.getName());
            querryWrapper.or();
            querryWrapper.like("contact",library.getName());
            querryWrapper.or();
            querryWrapper.like("network",library.getName());
            querryWrapper.or();
            querryWrapper.like("description",library.getName());
            querryWrapper.or();
            querryWrapper.like("address",library.getName());
        }
        libraryService.page(pageParam,querryWrapper);
        return Result.ok().data("items", pageParam.getRecords()).data("total", pageParam.getTotal());
    }

    @ApiOperation(value="通过id获取图书馆")
    @GetMapping("get/{id}")
    public Result save(@ApiParam(name = "id",value = "library实体的id",required = true)
                       @PathVariable String id){
        Library library = libraryService.getById(id);
        return Result.ok().data("item",library);
    }

    @ApiOperation(value="获取所有图书馆")
    @GetMapping("getAll")
    public Result getAll(){
        List<Library> list = libraryService.list();
        return Result.ok().data("items",list);
    }

    @ApiOperation(value="添加图书馆")
    @PostMapping("save")
    public Result save(@ApiParam(name = "library",value = "library实体",required = true)
                       @RequestBody Library library){
        libraryService.save(library);
        return Result.ok();
    }

    @ApiOperation(value = "修改图书馆信息")
    @PutMapping("update")
    public Result update(@ApiParam(name = "library",value = "library实体",required = true)
                         @RequestBody Library library){
        libraryService.updateById(library);
        return Result.ok();
    }

    @ApiOperation(value = "删除图书馆")
    @DeleteMapping("remove/{id}")
    public Result remove(@ApiParam(name = "id",value = "library实体的id",required = true)
                         @PathVariable String id){
        libraryService.removeById(id);
        return Result.ok();
    }

    @ApiOperation(value = "批量删除")
    @DeleteMapping("batchRemove")
    public Result removeBatch(@ApiParam(name = "library",value = "批量删除library实体",required = true)
                              @RequestBody List<String> libraryIds){
        libraryService.removeBatchByIds(libraryIds);
        return Result.ok();
    }
}
