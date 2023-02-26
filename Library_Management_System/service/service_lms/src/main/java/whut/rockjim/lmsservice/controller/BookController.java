package whut.rockjim.lmsservice.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import whut.rockjim.lmsservice.entity.Book;
import whut.rockjim.lmsservice.entity.request.BookRequest;
import whut.rockjim.lmsservice.entity.vo.BookDetailVO;
import whut.rockjim.lmsservice.service.BookService;
import whut.rockjim.utils.utils.Result;

import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * @Author : RockJim
 * @create 2022/11/27 22:35
 */
@Api(value = "图书控制器")
@RestController
@RequestMapping("/lms/book")
public class BookController {
    @Autowired
    private BookService bookService;


    @ApiOperation(value = "获取图书分页列表")
    @GetMapping("{page}/{limit}")
    public Result list(@ApiParam(name = "page", value = "当前页码", required = true)
                       @PathVariable Long page,
                       @ApiParam(name = "limit", value = "每页记录数", required = true)
                       @PathVariable Long limit,
                       @ApiParam(name = "keyword",value = "关键字")
                       Book book){
        Page<Book> pageParam = new Page<>(page, limit);

        QueryWrapper<Book> querryWrapper=new QueryWrapper<>();

        if(!StringUtils.isEmpty(book.getName())){
            querryWrapper.like("name",book.getName());
            querryWrapper.or();
            querryWrapper.like("author",book.getName());
            querryWrapper.or();
            querryWrapper.like("publishing_house",book.getName());
            querryWrapper.or();
            querryWrapper.like("publish_date",book.getName());
            querryWrapper.or();
            querryWrapper.like("place",book.getName());
            querryWrapper.or();
            querryWrapper.like("description",book.getName());
        }
        bookService.page(pageParam,querryWrapper);
        return Result.ok().data("items", pageParam.getRecords()).data("total", pageParam.getTotal());
    }

    @ApiOperation(value="通过id获取图书详细信息")
    @GetMapping("getDetail/{id}")
    public Result getDetail(@ApiParam(name = "id",value = "book实体的id",required = true)
                       @PathVariable String id){
        BookDetailVO bookDetail = bookService.getBookDetailById(id);
        return Result.ok().data("item",bookDetail);
    }


    @ApiOperation(value="通过id获取图书信息")
    @GetMapping("get/{id}")
    public Result get(@ApiParam(name = "id",value = "book实体的id",required = true)
                       @PathVariable String id){
        Book book = bookService.getById(id);
        return Result.ok().data("item",book);
    }

    @ApiOperation(value="根据图书状态获取图书分页列表")
    @GetMapping("selectAll")
    public Result selectAll(Book book){

        List<Book> list = bookService.list();
        return Result.ok().data("items",list);
    }

    @ApiOperation(value="根据检索条件获取图书列表")
    @GetMapping("selectList")
    public Result selectList(BookRequest book){
        QueryWrapper<Book> queryWrapper=new QueryWrapper<>();
        queryWrapper.eq("state","0");

        if(book.getFlag()){
            if(book.getPublishDate()!=null){
                queryWrapper.ge("publish_date",book.getPublishDate().get(0));
                queryWrapper.le("publish_date",book.getPublishDate().get(1));
            }
            queryWrapper.and(i->i.like("name",book.getName()).or().like("author",book.getAuthor())
                    .or().like("publishing_house",book.getPublishingHouse()));
        }

        List<Book> list = bookService.list(queryWrapper);
        return Result.ok().data("items",list);
    }


    @ApiOperation(value = "获取number字段前几的记录")
    @GetMapping("getListOrderByNumber")
    public Result getListOrderByNumber(){
        Integer size=16;
        List<BookDetailVO> list=bookService.getListOrderByNumber(size);
        return Result.ok().data("item",list);
    }

    @ApiOperation(value="新增图书")
    @PostMapping("save")
    public Result save(@ApiParam(name = "book",value = "book实体",required = true)
                       @RequestBody Book book){
        bookService.save(book);
        return Result.ok();
    }

    @ApiOperation(value = "修改图书")
    @PutMapping("update")
    public Result update(@ApiParam(name = "book",value = "book实体",required = true)
                         @RequestBody Book book){
        bookService.updateById(book);
        return Result.ok();
    }

    @ApiOperation(value = "删除图书")
    @DeleteMapping("remove/{id}")
    public Result remove(@ApiParam(name = "id",value = "book实体的id",required = true)
                         @PathVariable String id){
        bookService.removeById(id);
        return Result.ok();
    }

    @ApiOperation(value = "批量导入")
    @PostMapping("saveBatch")
    public Result saveBatch(@ApiParam(name = "book",value = "book实体",required = true)
                            @RequestBody List<Book> books){
//        classificationService.update(classifications,null);
        return Result.ok();
    }

    @ApiOperation(value = "批量删除")
    @DeleteMapping("batchRemove")
    public Result removeBatch(@ApiParam(name = "book",value = "批量删除book实体",required = true)
                              @RequestBody List<String> bookIds){
        bookService.removeBatchByIds(bookIds);
        return Result.ok();
    }
}
