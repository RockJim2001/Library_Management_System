package whut.rockjim.aclservice.service.impl;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import whut.rockjim.aclservice.mapper.PermissionMapper;
import whut.rockjim.aclservice.service.PermissionService;

import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

/**
 * Created by IntelliJ IDEA.
 *
 * @Author : RockJim
 * @create 2022/11/21 22:01
 */
class PermissionServiceImplTest {

    @Autowired
    private PermissionService permissionMapper;

    @Test
    void selectPermissionValueByUserId() {
        List<String> strings = permissionMapper.selectPermissionValueByUserId("1");
        for (String string : strings) {
            System.out.println(string);
        }
    }
}