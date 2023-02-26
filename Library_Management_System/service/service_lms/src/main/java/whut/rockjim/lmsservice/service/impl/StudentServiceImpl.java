package whut.rockjim.lmsservice.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import whut.rockjim.lmsservice.entity.Student;
import whut.rockjim.lmsservice.service.StudentService;
import whut.rockjim.lmsservice.mapper.StudentMapper;
import org.springframework.stereotype.Service;

/**
* @author RockJim
* @description 针对表【lms_user_info(用户基本信息)】的数据库操作Service实现
* @createDate 2022-11-28 14:06:39
*/
@Service
public class StudentServiceImpl extends ServiceImpl<StudentMapper, Student>
    implements StudentService{

}




