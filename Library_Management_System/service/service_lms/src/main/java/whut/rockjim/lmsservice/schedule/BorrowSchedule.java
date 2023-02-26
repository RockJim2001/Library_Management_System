package whut.rockjim.lmsservice.schedule;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import whut.rockjim.lmsservice.entity.Borrow;
import whut.rockjim.lmsservice.service.BorrowService;

import java.util.Date;
import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * @Author : RockJim
 * @create 2022/12/14 0:01
 */
@Component
public class BorrowSchedule {

    @Autowired
    private BorrowService borrowService;

    // 判断借阅的书籍是否超时(每10分钟执行一次)
    @Scheduled(fixedDelay = 1000*60*10)
    public void timeoutTask(){
        long timeMillis = System.currentTimeMillis();
        timeMillis-=365/2*24*3600*1000L;
        Date date=new Date(timeMillis);
        List<Borrow> list = borrowService.list(new QueryWrapper<Borrow>()
                .ge("borrow_date",date).isNull("return_date"));
        System.out.println("list的大小为："+list.size());
        for (int i = 0; i < list.size(); i++) {
            long borrowDate=list.get(i).getBorrowDate().getTime();
            long temp=borrowDate+24L*3600*1000*list.get(i).getLimit();
            long currentTime=System.currentTimeMillis();
            if(currentTime>temp){
                Borrow borrow=list.get(i);
                borrow.setViolationDescription("该书已经超时！");
                borrowService.updateById(borrow);
            }
        }
    }
}
