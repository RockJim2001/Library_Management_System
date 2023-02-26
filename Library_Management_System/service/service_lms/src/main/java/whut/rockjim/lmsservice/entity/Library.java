package whut.rockjim.lmsservice.entity;

import com.baomidou.mybatisplus.annotation.*;

import java.io.Serializable;
import java.util.Date;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

/**
 * 图书馆信息
 * @TableName lms_library
 */
@ApiModel(description = "图书馆信息")
@TableName(value ="lms_library")
@Data
public class Library implements Serializable {
    /**
     * 图书馆id
     */
    @ApiModelProperty("图书馆id")
    @TableId(value = "id",type = IdType.ASSIGN_ID)
    private String id;

    /**
     * 名称
     */
    @ApiModelProperty("名称")
    @TableField(value = "name")
    private String name;

    /**
     * 负责人
     */
    @ApiModelProperty("负责人")
    @TableField(value = "principal")
    private String principal;

    /**
     * 联系方式
     */
    @ApiModelProperty("联系方式")
    @TableField(value = "contact")
    private String contact;

    /**
     * 官网
     */
    @ApiModelProperty("官网")
    @TableField(value = "network")
    private String network;

    /**
     * 介绍
     */
    @ApiModelProperty("介绍")
    @TableField(value = "description")
    private String description;

    /**
     * 地址
     */
    @ApiModelProperty("地址")
    @TableField(value = "address")
    private String address;


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