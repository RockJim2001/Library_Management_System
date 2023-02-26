package whut.rockjim.lmsservice.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;
import whut.rockjim.lmsservice.entity.Classification;
import whut.rockjim.lmsservice.mapper.ClassificationMapper;
import whut.rockjim.lmsservice.service.ClassificationService;

/**
* @author RockJim
* @description 针对表【lms_classification(图书分类信息)】的数据库操作Service实现
* @createDate 2022-11-27 14:21:58
*/
@Service
public class ClassificationServiceImpl extends ServiceImpl<ClassificationMapper, Classification>
    implements ClassificationService {

}




