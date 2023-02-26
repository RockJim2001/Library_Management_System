package whut.rockjim.oss.service;

import org.springframework.web.multipart.MultipartFile;

/**
 * Created by IntelliJ IDEA.
 *
 * @Author : RockJim
 * @create 2022/12/6 22:09
 */
public interface OssService {
    String uploadFile(String filename, MultipartFile file);
}
