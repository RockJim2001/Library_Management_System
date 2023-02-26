package whut.rockjim.utils.utils;

import lombok.Data;
import java.util.HashMap;
import java.util.Map;

//统一返回结果的类
@Data
public class Result {

    private Boolean success;

    private Integer code;

    private String message;

    private Map<String, Object> data = new HashMap<String, Object>();

    //把构造方法私有
    private Result() {}

    //成功静态方法
    public static Result ok() {
        Result result = new Result();
        result.setSuccess(true);
        result.setCode(20000);
        result.setMessage("成功");
        return result;
    }

    //失败静态方法
    public static Result error() {
        Result result = new Result();
        result.setSuccess(false);
        result.setCode(20001);
        result.setMessage("失败");
        return result;
    }

    public Result success(Boolean success){
        this.setSuccess(success);
        return this;
    }

    public Result message(String message){
        this.setMessage(message);
        return this;
    }

    public Result code(Integer code){
        this.setCode(code);
        return this;
    }

    public Result data(String key, Object value){
        this.data.put(key, value);
        return this;
    }

    public Result data(Map<String, Object> map){
        this.setData(map);
        return this;
    }
}
