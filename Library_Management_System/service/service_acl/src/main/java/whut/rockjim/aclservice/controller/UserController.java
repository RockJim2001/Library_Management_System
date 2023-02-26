package whut.rockjim.aclservice.controller;


import whut.rockjim.aclservice.entity.User;
import whut.rockjim.aclservice.entity.UserAuth;
import whut.rockjim.aclservice.service.RoleService;
import whut.rockjim.aclservice.service.UserAuthService;
import whut.rockjim.aclservice.service.UserService;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;
import whut.rockjim.utils.utils.MD5;
import whut.rockjim.utils.utils.Result;

import java.util.List;
import java.util.Map;

/**
 * <p>
 * 用户表 前端控制器
 * </p>
 *
 * @author testjava
 * @since 2020-01-12
 */
@RestController
@RequestMapping("/admin/acl/user")
//@CrossOrigin
public class UserController {

    @Autowired
    private UserAuthService userAuthService;

    @Autowired
    private RoleService roleService;

    @ApiOperation(value = "获取管理用户分页列表")
    @GetMapping("{page}/{limit}")
    public Result index(
            @ApiParam(name = "page", value = "当前页码", required = true)
            @PathVariable Long page,

            @ApiParam(name = "limit", value = "每页记录数", required = true)
            @PathVariable Long limit,

            @ApiParam(name = "courseQuery", value = "查询关键字", required = false)
            UserAuth userQueryVo) {
        Page<UserAuth> pageParam = new Page<>(page, limit);
        QueryWrapper<UserAuth> wrapper = new QueryWrapper<>();
        if(!StringUtils.isEmpty(userQueryVo.getUsername())) {
            wrapper
                    .like("username",userQueryVo.getUsername())
                    .or()
                    .like("nick_name",userQueryVo.getUsername())
                    .eq("login_type",0);
        }else {
            wrapper.eq("login_type",0);
        }

        IPage<UserAuth> pageModel = userAuthService.page(pageParam, wrapper);
        return Result.ok().data("items", pageModel.getRecords()).data("total", pageModel.getTotal());
    }

    @ApiOperation(value = "新增管理用户")
    @PostMapping("save")
    public Result save(@RequestBody UserAuth userAuth) {
        userAuth.setPassword(MD5.encrypt(userAuth.getPassword()));
        userAuthService.save(userAuth);
        return Result.ok();
    }

    @ApiOperation(value = "通过id获取用户")
    @GetMapping("get/{id}")
    public Result getUser(@ApiParam(name = "id",value = "用户id",required = true) @PathVariable String id){
        UserAuth userAuthServiceById = userAuthService.getById(id);
        return Result.ok().data("user",userAuthServiceById);
    }

    @ApiOperation(value = "更新用户信息")
    @PutMapping("update")
    public Result updateById(@RequestBody UserAuth userAuth) {
        userAuth.setPassword(MD5.encrypt(userAuth.getPassword()));
        userAuthService.updateById(userAuth);
        return Result.ok();
    }

    @ApiOperation(value = "删除指定用户")
    @DeleteMapping("remove/{id}")
    public Result remove(
            @ApiParam(name = "id", value = "删除指定用户", required = true)
            @PathVariable String id){
        userAuthService.removeById(id);
        return Result.ok();
    }

    @ApiOperation(value = "批量删除系统用户")
    @DeleteMapping("/batchRemove")
    public Result removeBatch(@RequestBody List<String> idLists){
        userAuthService.removeBatchByIds(idLists);
        return Result.ok();
    }


    @ApiOperation(value = "根据用户获取角色数据")
    @GetMapping("/toAssign/{userId}")
    public Result toAssign(@PathVariable String userId) {
        Map<String, Object> roleMap = roleService.findRoleByUserId(userId);
        return Result.ok().data(roleMap);
    }

    @ApiOperation(value = "根据用户分配角色")
    @PostMapping("/doAssign")
    public Result doAssign(@RequestParam String userId, @RequestParam String[] roleId) {
        roleService.saveUserRoleRealtionShip(userId,roleId);
        return Result.ok();
    }
}

