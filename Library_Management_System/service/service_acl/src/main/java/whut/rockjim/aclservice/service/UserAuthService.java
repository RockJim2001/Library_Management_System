package whut.rockjim.aclservice.service;

import whut.rockjim.aclservice.entity.UserAuth;
import com.baomidou.mybatisplus.extension.service.IService;

/**
* @author 25760
* @description 针对表【lms_user_auth(用户登录信息)】的数据库操作Service
* @createDate 2022-11-21 17:10:29
*/
public interface UserAuthService extends IService<UserAuth> {


    /**
     * @param username
     * @return
     * @description
     */
    UserAuth selectByUsername(String username);
}
