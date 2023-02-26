package whut.rockjim.oss.service.impl;/**
 * Created by IntelliJ IDEA.
 *
 * @Author : RockJim
 * @create 2022/12/6 22:09
 */

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import whut.rockjim.oss.service.OssService;
import whut.rockjim.oss.utils.AliyunOSSUtil;

/**
 * Created by IntelliJ IDEA.
 * @Author : RockJim
 * @create 2022/12/6 22:09
 */
@Service
public class OssServiceImpl implements OssService {
    /**
     * @param filepath 文件存储的目录
     * @param file
     * @return
     */
    @Override
    public String uploadFile(String filepath, MultipartFile file) {
        return AliyunOSSUtil.upload(filepath,file);
    }
}
