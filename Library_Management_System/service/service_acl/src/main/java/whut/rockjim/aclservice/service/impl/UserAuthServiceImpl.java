package whut.rockjim.aclservice.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import whut.rockjim.aclservice.entity.UserAuth;
import whut.rockjim.aclservice.service.UserAuthService;
import whut.rockjim.aclservice.mapper.UserAuthMapper;
import org.springframework.stereotype.Service;

/**
* @author 25760
* @description 针对表【lms_user_auth(用户登录信息)】的数据库操作Service实现
* @createDate 2022-11-21 17:10:29
*/
@Service
public class UserAuthServiceImpl extends ServiceImpl<UserAuthMapper, UserAuth>
    implements UserAuthService{

    @Override
    public UserAuth selectByUsername(String username) {
        return baseMapper.selectOne(new QueryWrapper<UserAuth>()
                .eq("username",username));
    }
}




