package whut.rockjim.aclservice.entity;

import com.baomidou.mybatisplus.annotation.*;

import java.io.Serializable;
import java.util.Date;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

/**
 * 用户登录信息
 * @author RockJim
 * @TableName lms_user_auth
 */
@ApiModel(description = "用户登录信息")
@TableName(value ="lms_user_auth")
@Data
public class UserAuth implements Serializable {
    /**
     * 编号
     */
    @ApiModelProperty("编号")
    @TableId(value = "id",type = IdType.ASSIGN_ID)
    private String id;

    /**
     * 用户名
     */
    @ApiModelProperty("用户名")
    @TableField(value = "username")
    private String username;

    /**
     * 密码
     */
    @ApiModelProperty("密码")
    @TableField(value = "password")
    private String password;

    /**
     * 头像
     */
    @ApiModelProperty("头像")
    @TableField(value = "avatar")
    private String avatar;

    /**
     * 昵称
     */
    @ApiModelProperty("昵称")
    @TableField(value = "nick_name")
    private String nickName;

    /**
     * 登录类型：0-用户名、1-微信、2-微博
     */
    @ApiModelProperty("登录类型：0-用户名、1-微信、2-微博")
    @TableField(value = "login_type")
    private Integer loginType;

    /**
     * 用户签名
     */
    @ApiModelProperty("用户签名")
    @TableField(value = "token")
    private String token;

    /**
     * 用户登录ip
     */
    @ApiModelProperty("用户登录ip")
    @TableField(value = "ip_address")
    private String ipAddress;

    /**
     * ip来源
     */
    @ApiModelProperty("ip来源")
    @TableField(value = "ip_source")
    private String ipSource;

    /**
     * 上次登录时间
     */
    @ApiModelProperty("上次登录时间")
    @TableField(value = "last_login_time")
    private Date lastLoginTime;

    /**
     * 状态：0-正常、1-停用
     */
    @ApiModelProperty("状态：1-正常、0-停用")
    @TableField(value = "state")
    private Integer state;

    /**
     * 外键---用户信息
     */
    @ApiModelProperty("外键---用户信息")
    @TableField(value = "user_info_id")
    private String userInfoId;

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