package whut.rockjim.lmsservice.entity.request;/**
 * Created by IntelliJ IDEA.
 *
 * @Author : RockJim
 * @create 2022/12/3 13:51
 */

import lombok.Data;

import java.util.Date;
import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * @Author : RockJim
 * @create 2022/12/3 13:51
 */
@Data
public class BookRequest {
    /**
     * 书名
     */
    private String name;
    /**
     * 作者
     */
    private String author;
    /**
     * 出版社
     */
    private String publishingHouse;
    /**
     * 发布日期
     */
    private List<Date> publishDate;
    /**
     * 图书管id
     */
    private String library_id;
    /**
     * 是否启用筛选
     */
    private Boolean flag;
}
