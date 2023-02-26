package whut.rockjim.lmsservice.entity;

import com.baomidou.mybatisplus.annotation.*;

import java.io.Serializable;
import java.util.Date;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

/**
 * 图书分类信息
 * @TableName lms_classification
 */
@ApiModel(description = "图书分类信息")
@TableName(value ="lms_classification")
@Data
public class Classification implements Serializable {
    /**
     * 分类id
     */
    @ApiModelProperty("分类id")
    @TableId(value = "id",type = IdType.ASSIGN_ID)
    private String id;

    /**
     * 分类名称
     */
    @ApiModelProperty("分类名称")
    @TableField(value = "classification")
    private String classification;

    /**
     * 分类描述
     */
    @ApiModelProperty("分类描述")
    @TableField(value = "description")
    private String description;

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
    @TableField(value = "gmt_create",fill=FieldFill.INSERT)
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