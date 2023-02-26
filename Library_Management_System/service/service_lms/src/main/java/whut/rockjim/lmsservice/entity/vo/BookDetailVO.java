package whut.rockjim.lmsservice.entity.vo;/**
 * Created by IntelliJ IDEA.
 *
 * @Author : RockJim
 * @create 2022/12/1 8:50
 */

import com.baomidou.mybatisplus.annotation.TableField;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.util.Date;

/**
 * Created by IntelliJ IDEA.
 * @Author : RockJim
 * @create 2022/12/1 8:50
 */
@Data
public class BookDetailVO {

    /**
     * 图书发行号
     */
    @ApiModelProperty("图书发行号")
//    @TableId(value = "id",type = IdType.ASSIGN_ID)
    private String id;


    /**
     * 书名
     */
    @ApiModelProperty("书名")
//    @TableField(value = "name")
    private String name;

    /**
     * 作者
     */
    @ApiModelProperty("作者")
//    @TableField(value = "author")
    private String author;

    /**
     * 出版社
     */
    @ApiModelProperty("出版社")
//    @TableField(value = "publishing_house")
    private String publishingHouse;

    /**
     * 分类编号
     */
    @ApiModelProperty("分类")
//    @TableField(value = "classification_id")
    private String classification;

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
//    @TableField(value = "library_id")
    private String library;

    /**
     * 存放位置
     */
    @ApiModelProperty("存放位置")
//    @TableField(value = "place")
    private String place;

    /**
     * 描述
     */
    @ApiModelProperty("描述")
//    @TableField(value = "description")
    private String description;

    /**
     * 是否被借（在馆未null，不在则为借阅者id）
     */
    @ApiModelProperty("是否被借（在馆未null，不在则为借阅者id）")
    @TableField(value = "state")
    private String state;


}
