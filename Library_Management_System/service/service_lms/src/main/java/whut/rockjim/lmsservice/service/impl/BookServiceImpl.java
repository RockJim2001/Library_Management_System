package whut.rockjim.lmsservice.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import whut.rockjim.lmsservice.entity.Book;
import whut.rockjim.lmsservice.entity.vo.BookDetailVO;
import whut.rockjim.lmsservice.mapper.BookDetailMapper;
import whut.rockjim.lmsservice.service.BookService;
import whut.rockjim.lmsservice.mapper.BookMapper;
import org.springframework.stereotype.Service;

import java.util.List;

/**
* @author RockJim
* @description 针对表【lms_book(图书信息)】的数据库操作Service实现
* @createDate 2022-11-27 22:33:36
*/
@Service
public class BookServiceImpl extends ServiceImpl<BookMapper, Book>
    implements BookService{
    @Autowired
    private BookDetailMapper bookDetailMapper;
    @Override
    public BookDetailVO getBookDetailById(String id) {
        return bookDetailMapper.getBookDetailById(id);
    }

    @Override
    public List<BookDetailVO> getListOrderByNumber(Integer size) {
        return bookDetailMapper.getListOrderByNumber(size);
    }
}




