package whut.rockjim.lmsservice.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.springframework.stereotype.Repository;
import whut.rockjim.lmsservice.entity.Book;
import whut.rockjim.lmsservice.entity.vo.BookDetailVO;

import java.util.List;

/**
* @author RockJim
* @description 针对表【lms_book(图书信息)】的数据库操作Mapper
* @createDate 2022-11-27 22:33:36
* @Entity whut.rockjim.lmsservice.entity.Book
*/
@Repository
public interface BookDetailMapper extends BaseMapper<BookDetailVO> {
    BookDetailVO getBookDetailById(String id);

    List<BookDetailVO> getListOrderByNumber(Integer size);
}




