package whut.rockjim.lmsservice.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import whut.rockjim.aclservice.entity.UserAuth;
import whut.rockjim.aclservice.service.UserAuthService;
import whut.rockjim.lmsservice.entity.Book;
import whut.rockjim.lmsservice.entity.Borrow;
import whut.rockjim.lmsservice.entity.Student;
import whut.rockjim.lmsservice.entity.request.BorrowBookRequest;
import whut.rockjim.lmsservice.entity.vo.BorrowDetailVO;
import whut.rockjim.lmsservice.service.BookService;
import whut.rockjim.lmsservice.service.BorrowService;
import whut.rockjim.utils.utils.Result;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * @Author : RockJim
 * @create 2022/11/28 14:59
 */
@RestController
@Api(value = "借书记录控制器")
@RequestMapping("/lms/borrow")
public class BorrowController {
    @Autowired
    private BorrowService borrowService;

    @Autowired
    private UserAuthService userAuthService;

    @Autowired
    private BookService bookService;

    @ApiOperation(value = "获取记录分页列表")
    @GetMapping("{page}/{limit}")
    public Result list(@ApiParam(name = "page", value = "当前页码", required = true)
                       @PathVariable Long page,
                       @ApiParam(name = "limit", value = "每页记录数", required = true)
                       @PathVariable Long limit){
        Page<BorrowDetailVO> pageParam = new Page<>(page, limit);


        IPage<BorrowDetailVO> list = borrowService.getBorrowDetail(pageParam);

        return Result.ok().data("items",list.getRecords()).data("total",list.getTotal());
    }

    @ApiOperation(value="通过id获取记录")
    @GetMapping("get/{id}")
    public Result save(@ApiParam(name = "id",value = "borrow实体的id",required = true)
                       @PathVariable String id){
        Borrow borrow = borrowService.getById(id);
        return Result.ok().data("item",borrow);
    }


    @ApiOperation(value="通过用户id获取记录分页列表")
    @GetMapping("student/{page}/{limit}")
    public Result getBorrowByStudent(@ApiParam(name = "page", value = "当前页码", required = true)
                                         @PathVariable Long page,
                                     @ApiParam(name = "limit", value = "每页记录数", required = true)
                                         @PathVariable Long limit,
                                     @ApiParam(name = "keyword",value = "关键字")
                                         String id){
        Page<BorrowDetailVO> pageParam = new Page<>(page, limit);

        String userInfoId = userAuthService.getById(id).getUserInfoId();

        IPage<BorrowDetailVO> list = borrowService.getBorrowByStudent(pageParam,userInfoId);

        return Result.ok().data("items",list.getRecords()).data("total",list.getTotal());
    }

    @ApiOperation(value="根据分页列表")
    @GetMapping("selectAll")
    public Result selectAll(Student student){

        List<Borrow> list = borrowService.list();
        return Result.ok().data("items",list);
    }

    @ApiOperation(value="新增")
    @PostMapping("save")
    public Result save(@ApiParam(name = "borrow",value = "borrow实体",required = true)
                       @RequestBody Borrow borrow){
        borrowService.save(borrow);
        return Result.ok();
    }

    @ApiOperation(value = "修改记录")
    @PutMapping("update")
    public Result update(@ApiParam(name = "borrow",value = "borrow实体",required = true)
                         @RequestBody Borrow borrow){
        borrowService.updateById(borrow);
        return Result.ok();
    }

    @ApiOperation(value = "还书")
    @PutMapping("return")
    public Result returnBook(@ApiParam(name = "borrow",value = "borrow实体",required = true)
                         @RequestBody Borrow borrow){
        borrowService.updateById(borrow);
        String bookId = borrowService.getById(borrow.getId()).getBookId();
        bookService.update(new UpdateWrapper<Book>().set("state","0").eq("id",bookId));
        return Result.ok();
    }

    @ApiOperation(value = "批量借阅")
    @PutMapping("borrowBook")
    public Result borrowBook(@RequestBody BorrowBookRequest borrowBookRequest){
        // 先获取student的id
        String student_id=userAuthService.getById(borrowBookRequest.getId()).getUserInfoId();
        //修改book中的state字段
        List<Book> books=new ArrayList<>();
        List<Borrow> borrows=new ArrayList<>();
        borrowBookRequest.getIdList().forEach(index->{
            Book book=new Book();
            book.setId(index);
            book.setState(student_id);

            Borrow borrow=new Borrow();
            borrow.setUserId(student_id);
            borrow.setBookId(index);
            books.add(book);
            borrows.add(borrow);
        });
        bookService.updateBatchById(books);
        // 生成借阅记录
        borrowService.saveBatch(borrows);
        return Result.ok();
    }
    @ApiOperation(value = "删除还书记录")
    @DeleteMapping("remove/{id}")
    public Result remove(@ApiParam(name = "id",value = "borrow实体的id",required = true)
                         @PathVariable String id){
        borrowService.removeById(id);
        return Result.ok();
    }
}
