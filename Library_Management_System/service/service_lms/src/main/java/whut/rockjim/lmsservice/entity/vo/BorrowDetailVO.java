package whut.rockjim.lmsservice.entity.vo;/**
 * Created by IntelliJ IDEA.
 *
 * @Author : RockJim
 * @create 2022/12/3 9:49
 */

import com.baomidou.mybatisplus.annotation.*;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.util.Date;

/**
 * Created by IntelliJ IDEA.
 * @Author : RockJim
 * @create 2022/12/3 9:49
 */
@Data
public class BorrowDetailVO {
    /**
     * 借阅编号
     */
    @ApiModelProperty("流水号")
//    @TableId(value = "id",type = IdType.ASSIGN_ID)
    private String id;

    /**
     * 外键---借阅者
     */
    @ApiModelProperty("外键")
//    @TableField(value = "user_id")
    private String student;

    /**
     * 外键---书编号
     */
    @ApiModelProperty("书名")
//    @TableField(value = "book_id")
    private String bookName;

    /**
     * 外键---出版社
     */
    @ApiModelProperty("出版社")
//    @TableField(value = "book_id")
    private String publishingHouse;

    /**
     * 借阅日期
     */
    @ApiModelProperty("借阅日期")
//    @TableField(value = "borrow_date")
    private Date borrowDate;

    /**
     * 可借时长
     */
    @ApiModelProperty("可借时长")
//    @TableField(value = "limit")
    private Integer limit;

    /**
     * 归还日期
     */
    @ApiModelProperty("归还日期")
//    @TableField(value = "return_date")
    private Date returnDate;

    /**
     * 违规描述
     */
    @ApiModelProperty("违规描述")
//    @TableField(value = "violation_description")
    private String violationDescription;

    /**
     * 外键----处理人
     */
    @ApiModelProperty("处理人")
//    @TableField(value = "handler")
    private String handler;

    @ApiModelProperty(hidden = true)
    @TableField(exist = false)
    private static final long serialVersionUID = 1L;
}
