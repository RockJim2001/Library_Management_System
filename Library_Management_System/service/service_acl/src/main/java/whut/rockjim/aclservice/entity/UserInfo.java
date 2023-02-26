package whut.rockjim.aclservice.entity;

import com.baomidou.mybatisplus.annotation.*;

import java.io.Serializable;
import java.util.Date;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

/**
 * 用户基本信息
 * @TableName lms_user_info
 */
@ApiModel(description = "用户基本信息")
@TableName(value ="lms_user_info")
@Data
public class UserInfo implements Serializable {
    /**
     * 主键
     */
    @ApiModelProperty("主键")
    @TableId(value = "id")
    private String id;

    /**
     * 学号
     */
    @ApiModelProperty("学号")
    @TableField(value = "student_id")
    private String studentId;

    /**
     * 姓名
     */
    @ApiModelProperty("姓名")
    @TableField(value = "name")
    private String name;

    /**
     * 性别：0-男、1-女
     */
    @ApiModelProperty("性别：0-男、1-女")
    @TableField(value = "gender")
    private Integer gender;


    /**
     * 照片
     */
    @ApiModelProperty("照片")
    @TableField(value = "picture")
    private String picture;

    /**
     * 电话
     */
    @ApiModelProperty("电话")
    @TableField(value = "phone")
    private String phone;

    /**
     * 邮箱
     */
    @ApiModelProperty("邮箱")
    @TableField(value = "email")
    private String email;

    /**
     * 院系
     */
    @ApiModelProperty("院系")
    @TableField(value = "department")
    private String department;

    /**
     * 简介
     */
    @ApiModelProperty("简介")
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