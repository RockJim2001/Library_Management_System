package whut.rockjim.aclservice.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import whut.rockjim.aclservice.entity.UserInfo;
import whut.rockjim.aclservice.service.UserInfoService;
import whut.rockjim.aclservice.mapper.UserInfoMapper;
import org.springframework.stereotype.Service;

/**
* @author RockJim
* @description 针对表【lms_user_info(用户基本信息)】的数据库操作Service实现
* @createDate 2022-11-21 23:25:10
*/
@Service
public class UserInfoServiceImpl extends ServiceImpl<UserInfoMapper, UserInfo>
    implements UserInfoService{

}




