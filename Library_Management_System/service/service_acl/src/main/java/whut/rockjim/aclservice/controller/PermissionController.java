package whut.rockjim.aclservice.controller;


import io.swagger.annotations.Api;
import io.swagger.annotations.ApiParam;
import whut.rockjim.aclservice.entity.Permission;
import whut.rockjim.aclservice.service.PermissionService;
import whut.rockjim.utils.utils.Result;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * <p>
 * 权限 菜单管理
 * </p>
 *
 * @author testjava
 * @since 2020-01-12
 */
@RestController
@RequestMapping("/admin/acl/permission")
//@CrossOrigin
public class PermissionController {

    @Autowired
    private PermissionService permissionService;

    //获取全部菜单
    @ApiOperation(value = "查询所有菜单")
    @GetMapping
    public Result indexAllPermission() {
        List<Permission> list =  permissionService.queryAllMenu();
        return Result.ok().data("children",list);
    }

    @ApiOperation(value = "给角色分配权限")
    @PostMapping("/doAssign")
    public Result doAssign(String roleId, String[] permissionId) {
        permissionService.saveRolePermissionRealtionShipGuli(roleId,permissionId);
        return Result.ok();
    }

    @ApiOperation(value = "根据角色获取菜单")
    @GetMapping("toAssign/{roleId}")
    public Result toAssign(@PathVariable String roleId) {
        List<Permission> list = permissionService.selectAllMenu(roleId);
        return Result.ok().data("children", list);
    }

    @ApiOperation(value = "新增一个权限")
    @PostMapping("save")
    public Result save(@RequestBody Permission permission){
        permissionService.save(permission);
        return Result.ok();
    }

    @ApiOperation(value = "删除一个权限")
    @DeleteMapping("remove/{id}")
    public Result remove(@ApiParam(value="id",name = "id")
                         @PathVariable String id){
        permissionService.removeById(id);
        return Result.ok();
    }

    @ApiOperation(value="更新一个权限")
    @PutMapping("update")
    public Result update(@RequestBody Permission permission){
        permissionService.updateById(permission);
        return Result.ok();
    }
}

