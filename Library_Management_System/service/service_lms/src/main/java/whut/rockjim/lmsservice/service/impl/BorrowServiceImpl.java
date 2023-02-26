package whut.rockjim.lmsservice.service.impl;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import whut.rockjim.lmsservice.entity.Borrow;
import whut.rockjim.lmsservice.entity.vo.BorrowDetailVO;
import whut.rockjim.lmsservice.mapper.BorrowDetailMapper;
import whut.rockjim.lmsservice.service.BorrowService;
import whut.rockjim.lmsservice.mapper.BorrowMapper;
import org.springframework.stereotype.Service;

import java.util.List;

/**
* @author RockJim
* @description 针对表【lms_borrow(借阅信息)】的数据库操作Service实现
* @createDate 2022-11-28 15:20:44
*/
@Service
public class BorrowServiceImpl extends ServiceImpl<BorrowMapper, Borrow>
    implements BorrowService{

    @Autowired
    private BorrowDetailMapper borrowDetailMapper;

    @Override
    public IPage<BorrowDetailVO> getBorrowByStudent(Page<BorrowDetailVO> page, String id) {
        return borrowDetailMapper.getBorrowByStudent(page,id);
    }

    @Override
    public IPage<BorrowDetailVO> getBorrowDetail(Page<BorrowDetailVO> pageParam) {
        return borrowDetailMapper.getBorrowDetialList(pageParam);
    }
}




