package whut.rockjim.lmsservice.entity;

import com.baomidou.mybatisplus.annotation.*;

import java.io.Serializable;
import java.util.Date;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

/**
 * 图书信息
 * @TableName lms_book
 */
@ApiModel(description = "图书信息")
@TableName(value ="lms_book")
@Data
public class Book implements Serializable {
    /**
     * 图书发行号
     */
    @ApiModelProperty("图书发行号")
    @TableId(value = "id",type = IdType.ASSIGN_ID)
    private String id;

    /**
     * 书名
     */
    @ApiModelProperty("书名")
    @TableField(value = "name")
    private String name;

    /**
     * 作者
     */
    @ApiModelProperty("作者")
    @TableField(value = "author")
    private String author;

    /**
     * 出版社
     */
    @ApiModelProperty("出版社")
    @TableField(value = "publishing_house")
    private String publishingHouse;

    /**
     * 分类编号
     */
    @ApiModelProperty("分类编号")
    @TableField(value = "classification_id")
    private String classificationId;

    /**
     * 出版日期
     */
    @ApiModelProperty("出版日期")
    @TableField(value = "publish_date")
    private Date publishDate;

    /**
     * 图书被借次数
     */
    @ApiModelProperty("图书被借次数")
    @TableField(value = "number")
    private Integer number;

    /**
     * 图书照片
     */
    @ApiModelProperty("图书照片")
    @TableField(value = "picture")
    private String picture;

    /**
     * 图书内容
     */
    @ApiModelProperty("图书内容")
    @TableField(value = "content")
    private String content;

    /**
     * 存放的图书馆
     */
    @ApiModelProperty("存放的图书馆")
    @TableField(value = "library_id")
    private String libraryId;

    /**
     * 存放位置
     */
    @ApiModelProperty("存放位置")
    @TableField(value = "place")
    private String place;

    /**
     * 描述
     */
    @ApiModelProperty("描述")
    @TableField(value = "description")
    private String description;

    /**
     * 是否被借（在馆未null，不在则为借阅者id）
     */
    @ApiModelProperty("是否被借（在馆未null，不在则为借阅者id）")
    @TableField(value = "state")
    private String state;

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