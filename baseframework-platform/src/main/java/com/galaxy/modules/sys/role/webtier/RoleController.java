
package com.galaxy.modules.sys.role.webtier;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.galaxy.common.utils.StringUtils;
import com.galaxy.common.web.BaseController;
import com.galaxy.modules.sys.role.domain.Role;
import com.galaxy.modules.sys.user.domain.User;
import com.galaxy.modules.sys.login.service.SystemService;
import com.galaxy.modules.sys.utils.UserUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.galaxy.common.config.Global;
import com.galaxy.common.persistence.Page;
import com.galaxy.common.utils.Collections3;
import com.galaxy.modules.sys.office.domain.Office;
import com.galaxy.modules.sys.office.service.OfficeService;

/**
 * 角色Controller
 *
 * @author cat
 * @version 2013-12-05
 */
@Controller
@RequestMapping(value = "${adminPath}/role")
public class RoleController extends BaseController {

    @Autowired
    private SystemService systemService;

    @Autowired
    private OfficeService officeService;

    @ModelAttribute("role")
    public Role get(@RequestParam(required = false) String id) {
        if (StringUtils.isNotBlank(id)) {
            return systemService.getRole(id);
        } else {
            return new Role();
        }
    }

    @RequiresPermissions("sys:role:view")
    @RequestMapping(value = {"list.do", ""})
    public String list(Role role, HttpServletRequest request, HttpServletResponse response , Model model) {
        Page<Role> page = systemService.findRoleByPage(new Page<Role>(request,response), role);
        model.addAttribute("page", page);
        model.addAttribute("role", role);
        return "modules/role/list";
    }

    @RequestMapping(value = "toAddPage")
    public String toAddPage(Role role, Model model) {
        model.addAttribute("role", role);
        model.addAttribute("menuList", systemService.findAllMenu());
        model.addAttribute("officeList", officeService.findAll());
        return "modules/role/add";
    }

    @RequestMapping(value = "toModiPage.do")
    public String toModiPage(Role role, Model model) {
        Role r = systemService.getRole(role.getId());
        model.addAttribute("role", r);
        model.addAttribute("menuList", systemService.findAllMenu());
        model.addAttribute("officeList", officeService.findAll());
        return "modules/role/modi";
    }

    @RequiresPermissions("sys:role:view")
    @RequestMapping(value = "form")
    public String form(Role role, Model model) {
        if (role.getOffice() == null) {
            role.setOffice(UserUtils.getUser().getOffice());
        }
        model.addAttribute("role", role);
        model.addAttribute("menuList", systemService.findAllMenu());
        model.addAttribute("officeList", officeService.findAll());
        return "modules/role/add";
    }

    @RequiresPermissions("sys:role:edit")
    @RequestMapping(value = "save.do")
    public String save(Role role, Model model, RedirectAttributes redirectAttributes, HttpServletRequest request, HttpServletResponse response) {
        if (!beanValidator(model, role)) {
            return form(role, model);
        }
        try {
            if (!"true".equals(checkName(role.getOldName(), role.getName(),request))) {
                model.addAttribute("message", "保存角色'" + role.getName() + "'失败, 角色名已存在");
                //成功 success 失败 danger
                model.addAttribute("flag", "danger");
                return list(role,request,response,model);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        if (!"true".equals(checkEnname(role.getOldEnname(), role.getEnname()))) {
            model.addAttribute("message", "保存角色'" + role.getName() + "'失败, 英文名已存在");
            //成功 success 失败 danger
            model.addAttribute("flag", "danger");
            return list(role,request,response,model);
        }
        systemService.saveRole(role);
        model.addAttribute("message", "保存角色'" + role.getName() + "'成功");
        //成功 success 失败 danger
        model.addAttribute("flag", "success");
        return list(role,request,response,model);
    }

    @RequiresPermissions("sys:role:edit")
    @RequestMapping(value = "delete.do")
    public String delete(Role role, Model model, RedirectAttributes redirectAttributes, HttpServletRequest request, HttpServletResponse response) {
        systemService.deleteRole(role);
        model.addAttribute("message", "删除角色成功");
        model.addAttribute("flag", "success");
        return list(role,request,response,model);
    }

    /**
     * 角色分配页面
     *
     * @param role
     * @param model
     * @return
     */
    @RequiresPermissions("sys:role:edit")
    @RequestMapping(value = "assign.do")
    public String assign(Role role, Model model) {
        List<User> userList = systemService.findUser(new User(new Role(role.getId())));
        model.addAttribute("userList", userList);
        return "modules/role/assign";
    }

    /**
     * 角色分配 -- 打开角色分配对话框
     *
     * @param role
     * @param model
     * @return
     */
    @RequiresPermissions("sys:role:view")
    @RequestMapping(value = "usertorole.do")
    public String selectUserToRole(Role role, Model model) {
        List<User> userList = systemService.findUser(new User(new Role(role.getId())));
        model.addAttribute("role", role);
        model.addAttribute("userList", userList);
        model.addAttribute("selectIds", Collections3.extractToString(userList, "name", ","));
        model.addAttribute("officeList", officeService.findAll());
        return "modules/role/selectutor";
    }

    /**
     * 角色分配 -- 根据部门编号获取用户列表
     *
     * @param officeId
     * @param response
     * @return
     */
    @RequiresPermissions("sys:role:view")
    @ResponseBody
    @RequestMapping(value = "users.do")
    public List<Map<String, Object>> users(String officeId, HttpServletResponse response) {
        List<Map<String, Object>> mapList = Lists.newArrayList();
        User user = new User();
        user.setOffice(new Office(officeId));
        Page<User> page = systemService.findUser(new Page<User>(1, -1), user);
        for (User e : page.getList()) {
            Map<String, Object> map = Maps.newHashMap();
            map.put("id", e.getId());
            map.put("pId", 0);
            map.put("name", e.getName());
            mapList.add(map);
        }
        return mapList;
    }

    /**
     * 角色分配 -- 从角色中移除用户
     *
     * @param userId
     * @param roleId
     * @param redirectAttributes
     * @return
     */
    @RequiresPermissions("sys:role:edit")
    @RequestMapping(value = "outrole.do")
    public String outrole(String userId, String roleId, Model model, RedirectAttributes redirectAttributes) {
        Role role = systemService.getRole(roleId);
        User user = systemService.getUser(userId);
        if (UserUtils.getUser().getId().equals(userId)) {
            addMessage(redirectAttributes, "无法从角色【" + role.getName() + "】中移除用户【" + user.getName() + "】自己！");
        } else {
            if (user.getRoleList().size() <= 1) {
                addMessage(redirectAttributes, "用户【" + user.getName() + "】从角色【" + role.getName() + "】中移除失败！这已经是该用户的唯一角色，不能移除。");
            } else {
                Boolean flag = systemService.outUserInRole(role, user);
                if (!flag) {
                    addMessage(redirectAttributes, "用户【" + user.getName() + "】从角色【" + role.getName() + "】中移除失败！");
                } else {
                    addMessage(redirectAttributes, "用户【" + user.getName() + "】从角色【" + role.getName() + "】中移除成功！");
                }
            }
        }
        return  assign(role,model) ;
    }

    /**
     * 角色分配
     *
     * @param role
     * @param idsArr
     * @param redirectAttributes
     * @return
     */
    @RequiresPermissions("sys:role:edit")
    @RequestMapping(value = "assignrole.do")
    public String assignRole(Role role, String[] idsArr, Model model, RedirectAttributes redirectAttributes) {
        StringBuilder msg = new StringBuilder();
        int newNum = 0;
        for (int i = 0; i < idsArr.length; i++) {
            User user = systemService.assignUserToRole(role, systemService.getUser(idsArr[i]));
            if (null != user) {
                msg.append("<br/>新增用户【" + user.getName() + "】到角色【" + role.getName() + "】！");
                newNum++;
            }
        }
        addMessage(redirectAttributes, "已成功分配 " + newNum + " 个用户" + msg);
        return  assign(role,model);
    }

    /**
     * 验证角色名是否有效
     *
     * @param oldName
     * @param name
     * @return
     */
    @RequiresPermissions("user")
    @ResponseBody
    @RequestMapping(value = "checkName.do")
    public String checkName(String oldName, String name,HttpServletRequest request)  throws Exception{
        name = new String(request.getParameter("name").getBytes("ISO8859-1"), "UTF-8");
        oldName = new String(request.getParameter("oldName").getBytes("ISO8859-1"), "UTF-8");
        if (name != null && name.equals(oldName)) {
            return "true";
        } else if (name != null && systemService.getRoleByName(name) == null) {
            return "true";
        }
        return "false";
    }

    /**
     * 验证角色英文名是否有效
     *
     * @param oldEnname
     * @param enname
     * @return
     */
    @RequiresPermissions("user")
    @ResponseBody
    @RequestMapping(value = "checkEnname.do")
    public String checkEnname(String oldEnname, String enname) {
        if (enname != null && enname.equals(oldEnname)) {
            return "true";
        } else if (enname != null && systemService.getRoleByEnname(enname) == null) {
            return "true";
        }
        return "false";
    }

}
