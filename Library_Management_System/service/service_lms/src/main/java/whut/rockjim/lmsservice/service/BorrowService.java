package whut.rockjim.lmsservice.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import whut.rockjim.lmsservice.entity.Borrow;
import com.baomidou.mybatisplus.extension.service.IService;
import whut.rockjim.lmsservice.entity.vo.BorrowDetailVO;

import java.util.List;

/**
* @author RockJim
* @description 针对表【lms_borrow(借阅信息)】的数据库操作Service
* @createDate 2022-11-28 15:20:44
*/
public interface BorrowService extends IService<Borrow> {
    IPage<BorrowDetailVO> getBorrowByStudent(Page<BorrowDetailVO> page, String id);

    IPage<BorrowDetailVO> getBorrowDetail(Page<BorrowDetailVO> pageParam);
}
