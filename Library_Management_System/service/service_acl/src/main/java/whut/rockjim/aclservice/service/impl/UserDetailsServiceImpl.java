package whut.rockjim.aclservice.service.impl;

import whut.rockjim.aclservice.entity.User;
import whut.rockjim.aclservice.entity.UserAuth;
import whut.rockjim.aclservice.entity.UserInfo;
import whut.rockjim.aclservice.service.PermissionService;
import whut.rockjim.aclservice.service.UserAuthService;
import whut.rockjim.aclservice.service.UserInfoService;
import whut.rockjim.aclservice.service.UserService;
import whut.rockjim.security.entity.SecurityUser;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * @Author : RockJim
 * @create 2022/11/21  18:03
 */
@Service("userDetailsService")
public class UserDetailsServiceImpl implements UserDetailsService {

    @Autowired
    private UserAuthService userAuthService;

    @Autowired
    private PermissionService permissionService;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        //根据用户名从userAuth表中查询数据
        UserAuth userAuth=userAuthService.selectByUsername(username); //username实际上是用户id
        //判断
        if(userAuth == null) {
            throw new UsernameNotFoundException("用户不存在");
        }
        whut.rockjim.security.entity.User curUser = new whut.rockjim.security.entity.User();

        BeanUtils.copyProperties(userAuth,curUser);

        //根据用户查询用户权限列表
        List<String> permissionValueList = permissionService.selectPermissionValueByUserId(userAuth.getId());
        SecurityUser securityUser = new SecurityUser();
        securityUser.setCurrentUserInfo(curUser);
        securityUser.setPermissionValueList(permissionValueList);
        return securityUser;
    }
}
