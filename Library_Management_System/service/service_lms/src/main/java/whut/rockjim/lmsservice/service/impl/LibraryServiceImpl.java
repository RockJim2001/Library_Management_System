package whut.rockjim.lmsservice.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import whut.rockjim.lmsservice.entity.Library;
import whut.rockjim.lmsservice.service.LibraryService;
import whut.rockjim.lmsservice.mapper.LibraryMapper;
import org.springframework.stereotype.Service;

/**
* @author RockJim
* @description 针对表【lms_library(图书馆信息)】的数据库操作Service实现
* @createDate 2022-11-27 21:52:07
*/
@Service
public class LibraryServiceImpl extends ServiceImpl<LibraryMapper, Library>
    implements LibraryService{

}




