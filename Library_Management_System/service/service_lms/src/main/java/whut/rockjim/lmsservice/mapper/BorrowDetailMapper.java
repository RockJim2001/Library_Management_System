package whut.rockjim.lmsservice.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.springframework.stereotype.Repository;
import whut.rockjim.lmsservice.entity.Borrow;
import whut.rockjim.lmsservice.entity.vo.BorrowDetailVO;

import java.util.List;

/**
* @author RockJim
* @description 针对表【lms_borrow(借阅信息)】的数据库操作Mapper
* @createDate 2022-11-28 15:20:44
* @Entity whut.rockjim.lmsservice.entity.Borrow
*/
@Repository
public interface BorrowDetailMapper extends BaseMapper<BorrowDetailVO> {
    IPage<BorrowDetailVO> getBorrowByStudent(Page page, String id);

    IPage<BorrowDetailVO> getBorrowDetialList(Page<BorrowDetailVO> pageParam);
}




