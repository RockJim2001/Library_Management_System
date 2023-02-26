package whut.rockjim.lmsservice.entity.request;/**
 * Created by IntelliJ IDEA.
 *
 * @Author : RockJim
 * @create 2022/12/4 23:08
 */

import lombok.Data;

import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * @Author : RockJim
 * @create 2022/12/4 23:08
 */
@Data
public class BorrowBookRequest {
    /**
     * 用户id
     */
    private String id;
    /**
     * 借阅书籍idList
     */
    private List<String> idList;
}
