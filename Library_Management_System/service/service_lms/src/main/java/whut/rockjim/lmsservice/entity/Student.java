package whut.rockjim.lmsservice.entity;

import com.baomidou.mybatisplus.annotation.*;

import java.io.Serializable;
import java.util.Date;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import whut.rockjim.utils.utils.excel.ExcelExport;
import whut.rockjim.utils.utils.excel.ExcelImport;

/**
 * 用户基本信息
 * @TableName lms_user_info
 */
@ApiModel(description = "用户基本信息")
@TableName(value ="lms_user_info")
@Data
public class Student implements Serializable {

    /**
     * 行号
     */
    @ApiModelProperty(hidden = true)
    @TableField(exist = false)
    private int rowNum;

    /**
     * 主键
     */
    @ApiModelProperty("主键")
    @TableId(value = "id",type = IdType.ASSIGN_ID)
    private String id;

    /**
     * 学号
     */
    @ApiModelProperty("学号")
    @TableField(value = "student_id")
    @ExcelImport(value = "学号",maxLength = 13,required = true,unique = true)
    @ExcelExport(value = "学号",example = "0121810870123")
    private String studentId;

    /**
     * 姓名
     */
    @ApiModelProperty("姓名")
    @TableField(value = "name")
    @ExcelImport(value = "姓名",required = true)
    @ExcelExport(value = "姓名",example = "张三")
    private String name;

    /**
     * 性别：0-男、1-女
     */
    @ApiModelProperty("性别：0-男、1-女")
    @TableField(value = "gender")
    @ExcelImport(value = "性别",kv = "0-男;1-女",required = true)
    @ExcelExport(value="性别",example = "男/女",kv = "0-男;1-女")
    private Integer gender;

    /**
     * 照片
     */
    @ApiModelProperty("照片")
    @TableField(value = "picture")
    @ExcelImport(value = "照片",required = true)
    @ExcelExport(value = "照片",example = "https://no-auth-resources.oss-cn-hangzhou.aliyuncs.com/avatar/c67dbd9bac5443e885a4870c00dc27fd.gif")
    private String picture;

    /**
     * 电话
     */
    @ApiModelProperty("电话")
    @TableField(value = "phone")
    @ExcelImport(value = "电话",maxLength = 11,required = true,unique = true)
    @ExcelExport(value = "电话",example = "15129630498")
    private String phone;

    /**
     * 邮箱
     */
    @ApiModelProperty("邮箱")
    @TableField(value = "email")
    @ExcelImport(value = "邮箱",unique = true)
    @ExcelExport(value = "邮箱",example = "284027@whut.edu.cn")
    private String email;

    /**
     * 院系
     */
    @ApiModelProperty("院系")
    @TableField(value = "department")
    @ExcelImport(value = "院系",required = true)
    @ExcelExport(value = "院系",example = "计算机学院电子信息")
    private String department;

    /**
     * 简介
     */
    @ApiModelProperty("简介")
    @TableField(value = "description")
    @ExcelImport("简介")
    @ExcelExport(value = "简介",example = "计算机学院电子信息专业大一新生")
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
    @TableField(value = "gmt_modified",fill=FieldFill.INSERT_UPDATE)
    private Date gmtModified;

    @ApiModelProperty(hidden = true)
    @TableField(exist = false)
    private static final long serialVersionUID = 1L;

    /**
     * 错误提示
     */
    @ApiModelProperty(hidden = true)
    @TableField(exist = false)
    private String rowTips;

    /**
     * 原始数据
     */
    @ApiModelProperty(hidden = true)
    @TableField(exist = false)
    private String rowData;

}