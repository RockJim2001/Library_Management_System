package whut.rockjim.lmsservice.entity;

import com.baomidou.mybatisplus.annotation.*;

import java.io.Serializable;
import java.util.Date;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

/**
 * 借阅信息
 * @TableName lms_borrow
 */
@ApiModel(description = "借阅信息")
@TableName(value ="lms_borrow")
@Data
public class Borrow implements Serializable {
    /**
     * 借阅编号
     */
    @ApiModelProperty("借阅编号")
    @TableId(value = "id",type = IdType.ASSIGN_ID)
    private String id;

    /**
     * 外键
     */
    @ApiModelProperty("外键")
    @TableField(value = "user_id")
    private String userId;

    /**
     * 外键
     */
    @ApiModelProperty("外键")
    @TableField(value = "book_id")
    private String bookId;

    /**
     * 借阅日期
     */
    @ApiModelProperty("借阅日期")
    @TableField(value = "borrow_date",fill = FieldFill.INSERT)
    private Date borrowDate;

    /**
     * 可借时长
     */
    @ApiModelProperty("可借时长")
    @TableField(value = "`limit`")
    private Integer limit;

    /**
     * 归还日期
     */
    @ApiModelProperty("归还日期")
    @TableField(value = "return_date")
    private Date returnDate;

    /**
     * 违规描述
     */
    @ApiModelProperty("违规描述")
    @TableField(value = "violation_description")
    private String violationDescription;

    /**
     * 处理人
     */
    @ApiModelProperty("处理人")
    @TableField(value = "handler")
    private String handler;

    /**
     * 逻辑删除 1（true）已删除， 0（false）未删除
     */
    @ApiModelProperty("逻辑删除 1（true）已删除， 0（false）未删除")
    @TableField(value = "is_deleted")
    @TableLogic
    private Integer isDeleted;

    /**
     * 创建时间
     */
    @ApiModelProperty("创建时间")
    @TableField(value = "gmt_create",fill = FieldFill.INSERT)
    private Date gmtCreate;

    /**
     * 更新时间
     */
    @ApiModelProperty("更新时间")
    @TableField(value = "gmt_modified",fill = FieldFill.INSERT_UPDATE)
    private Date gmtModified;

    @ApiModelProperty(hidden = true)
    @TableField(exist = false)
    private static final long serialVersionUID = 1L;
}