package whut.rockjim.utils.utils.excel;

import lombok.Data;

import java.util.LinkedHashMap;

/**
 * Created by IntelliJ IDEA.
 * @Author : RockJim
 * @create 2022/11/28 15:49
 */
@Data
public class ExcelClassField {
    /** 字段名称 */
    private String fieldName;

    /** 表头名称 */
    private String name;

    /** 映射关系 */
    private LinkedHashMap<String, String> kvMap;

    /** 示例值 */
    private Object example;

    /** 排序 */
    private int sort;

    /** 是否为注解字段：0-否，1-是 */
    private int hasAnnotation;

}
