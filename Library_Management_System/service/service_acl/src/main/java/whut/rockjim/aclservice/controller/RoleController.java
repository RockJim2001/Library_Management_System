package whut.rockjim.aclservice.controller;


import io.swagger.annotations.Api;
import whut.rockjim.aclservice.entity.Role;
import whut.rockjim.aclservice.entity.UserAuth;
import whut.rockjim.aclservice.service.RoleService;
import whut.rockjim.utils.utils.Result;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author testjava
 * @since 2020-01-12
 */
@RestController
@RequestMapping("/admin/acl/role")
//@CrossOrigin
public class RoleController {

    @Autowired
    private RoleService roleService;

    @ApiOperation(value = "获取角色分页列表")
    @GetMapping("{page}/{limit}")
    public Result index(
            @ApiParam(name = "page", value = "当前页码", required = true)
            @PathVariable Long page,

            @ApiParam(name = "limit", value = "每页记录数", required = true)
            @PathVariable Long limit,
            Role role) {
        Page<Role> pageParam = new Page<>(page, limit);
        QueryWrapper<Role> wrapper = new QueryWrapper<>();
        if(!StringUtils.isEmpty(role.getRoleName())) {
            wrapper.like("role_name",role.getRoleName());
        }
        roleService.page(pageParam,wrapper);
        return Result.ok().data("items", pageParam.getRecords()).data("total", pageParam.getTotal());
    }

    @ApiOperation(value = "新增角色")
    @PostMapping("save")
    public Result save(@RequestBody Role role) {
        roleService.save(role);
        return Result.ok();
    }

    @ApiOperation(value = "删除角色")
    @DeleteMapping("remove/{id}")
    public Result remove(
            @ApiParam(name = "id",value = "角色id",required = true)
            @PathVariable Long id){
        roleService.removeById(id);
        return Result.ok();
    }

    @ApiOperation(value = "批量删除角色")
    @DeleteMapping("batchRemove")
    public Result batchRemove(@RequestBody List<Long> idList){
        roleService.removeBatchByIds(idList);
        return Result.ok();
    }

    @ApiOperation(value = "修改角色")
    @PutMapping("update")
    public Result update(@RequestBody Role role){
        roleService.updateById(role);
        return Result.ok();
    }

    @ApiOperation(value = "通过id获取角色")
    @GetMapping("get/{id}")
    public Result getRoleById(@ApiParam(name = "id",value = "角色id",required = true) @PathVariable Long id){
        Role role = roleService.getById(id);
        return Result.ok().data("role",role);
    }
}

