package whut.rockjim.lmsservice.service;

import whut.rockjim.lmsservice.entity.Book;
import com.baomidou.mybatisplus.extension.service.IService;
import whut.rockjim.lmsservice.entity.vo.BookDetailVO;

import java.util.List;

/**
* @author RockJim
* @description 针对表【lms_book(图书信息)】的数据库操作Service
* @createDate 2022-11-27 22:33:36
*/
public interface BookService extends IService<Book> {

    BookDetailVO getBookDetailById(String id);

    List<BookDetailVO> getListOrderByNumber(Integer size);
}
