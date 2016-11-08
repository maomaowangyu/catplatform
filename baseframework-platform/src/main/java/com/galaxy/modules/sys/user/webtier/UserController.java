/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/cat/baseplatform">baseplatform</a> All rights reserved.
 */
package com.galaxy.modules.sys.user.webtier;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.ConstraintViolationException;

import com.galaxy.common.beanvalidator.BeanValidators;
import com.galaxy.common.persistence.Page;
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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.galaxy.common.config.Global;
import com.galaxy.common.utils.DateUtils;
import com.galaxy.common.utils.excel.ExportExcel;
import com.galaxy.common.utils.excel.ImportExcel;
import com.galaxy.modules.sys.office.domain.Office;

/**
 * 用户Controller
 *
 * @author cat
 * @version 2013-8-29
 */
@Controller
@RequestMapping(value = "${adminPath}/user")
public class UserController extends BaseController {

    @Autowired
    private SystemService systemService;

    @ModelAttribute
    public User get(@RequestParam(required = false) String id) {
        if (StringUtils.isNotBlank(id)) {
            return systemService.getUser(id);
        } else {
            return new User();
        }
    }

    @RequiresPermissions("sys:user:view")
    @RequestMapping(value = {"index"})
    public String index(User user, Model model) {
        return "modules/sys/userIndex";
    }

    @RequiresPermissions("sys:user:view")
    @RequestMapping(value = {"list.do", ""})
    public String list(User user, HttpServletRequest request, HttpServletResponse response, Model model) {
        Page<User> page = systemService.findUser(new Page<User>(request, response), user);
        model.addAttribute("page", page);
        return "modules/user/list";
    }


    @RequiresPermissions("sys:user:view")
    @RequestMapping(value = "toAddPage")
    public String toAddPage(User user, Model model) {
        model.addAttribute("allRoles", systemService.findAllRole());
        return "modules/user/add";
    }

    @ResponseBody
    @RequiresPermissions("sys:user:view")
    @RequestMapping(value = {"listData"})
    public Page<User> listData(User user, HttpServletRequest request, HttpServletResponse response, Model model) {
        Page<User> page = systemService.findUser(new Page<User>(request, response), user);
        return page;
    }

    @RequiresPermissions("sys:user:view")
    @RequestMapping(value = "form")
    public String form(User user, Model model) {
        if (user.getCompany() == null || user.getCompany().getId() == null) {
            user.setCompany(UserUtils.getUser().getCompany());
        }
        if (user.getOffice() == null || user.getOffice().getId() == null) {
            user.setOffice(UserUtils.getUser().getOffice());
        }
        model.addAttribute("user", user);
        model.addAttribute("allRoles", systemService.findAllRole());
        return "modules/sys/userForm";
    }


    @RequiresPermissions("sys:user:edit")
    @RequestMapping(value = "save")
    public String save(User user, HttpServletRequest request, Model model, HttpServletResponse response, RedirectAttributes redirectAttributes) {
        user.setCompany(new Office(request.getParameter("company.id"), request.getParameter("company.name")));
        user.setOffice(new Office(request.getParameter("office.id"), request.getParameter("office.name")));
        // 如果新密码为空，则不更换密码
        if (StringUtils.isNotBlank(user.getNewPassword())) {
            user.setPassword(SystemService.entryptPassword(user.getNewPassword()));
        }
        if (!beanValidator(model, user)) {
            model.addAttribute("message", "保存角色'" + user.getLoginName() + "'失败");
            //成功 success 失败 danger
            model.addAttribute("flag", "danger");
            return list(user, request, response, model);
        }
        if (!"true".equals(checkLoginName(user.getOldLoginName(), user.getLoginName()))) {
            model.addAttribute("message", "保存角色'" + user.getLoginName() + "'失败，登录名已存在");
            //成功 success 失败 danger
            model.addAttribute("flag", "danger");
            return list(user, request, response, model);
        }
        // 角色数据有效性验证，过滤不在授权内的角色
        List<Role> roleList = Lists.newArrayList();
        List<String> roleIdList = user.getRoleIdList();
        for (Role r : systemService.findAllRole()) {
            if (roleIdList.contains(r.getId())) {
                roleList.add(r);
            }
        }
        user.setRoleList(roleList);
        // 保存用户信息
        systemService.saveUser(user);
        // 清除当前用户缓存
        if (user.getLoginName().equals(UserUtils.getUser().getLoginName())) {
            UserUtils.clearCache();
        }
        model.addAttribute("message", "保存角色'" + user.getLoginName() + "'成功");
        //成功 success 失败 danger
        model.addAttribute("flag", "success");
        return list(user, request, response, model);
    }

    @RequestMapping(value = "toModiPage.do")
    public String toModiPage(User user, Model model) {
        User u = systemService.getUser(user.getId());
        model.addAttribute("user", u);
        model.addAttribute("allRoles", systemService.findAllRole());
        return "modules/user/modi";
    }

    @RequiresPermissions("sys:user:edit")
    @RequestMapping(value = "delete")
    public String delete(User user, HttpServletRequest request, Model model, HttpServletResponse response) {
        if (UserUtils.getUser().getId().equals(user.getId())) {
            model.addAttribute("message", "删除用户失败, 不允许删除当前用户");
            //成功 success 失败 danger
            model.addAttribute("flag", "danger");
        } else if (User.isAdmin(user.getId())) {
            model.addAttribute("message", "删除用户失败, 不允许删除超级管理员用户");
            //成功 success 失败 danger
            model.addAttribute("flag", "danger");
        } else {
            systemService.deleteUser(user);
            model.addAttribute("message", "删除用户成功");
            //成功 success 失败 danger
            model.addAttribute("flag", "success");
        }

        return list(user, request, response, model);
    }

    /**
     * 导出用户数据
     *
     * @param user
     * @param request
     * @param response
     * @param redirectAttributes
     * @return
     */
    @RequiresPermissions("sys:user:view")
    @RequestMapping(value = "export.do")
    public String exportFile(User user, HttpServletRequest request, Model model, HttpServletResponse response, RedirectAttributes redirectAttributes) {
        try {
            String fileName = "用户数据" + DateUtils.getDate("yyyyMMddHHmmss") + ".xlsx";
            Page<User> page = systemService.findUser(new Page<User>(request, response, -1), user);
            List<User> list = new ArrayList<User>();
            for (int i = 0, j = page.getList().size(); i < j; i++) {
                User u = page.getList().get(i);
                List<Role> l = systemService.findRoleByUser(u.getId());
                u.setRoleList(l);
                list.add(u);
            }
            new ExportExcel("用户数据", User.class).setDataList(list).write(response, fileName).dispose();
            return null;
        } catch (Exception e) {
            try {
                throw new Exception(e.getMessage());
            } catch (Exception e1) {
                e1.printStackTrace();
            }
            model.addAttribute("message", "导出用户失败！失败信息：" + e.getMessage());
            //成功 success 失败 danger
            model.addAttribute("flag", "danger");
        }
        try {
            List<User> list1 = new ArrayList<User>();
            new ExportExcel("用户数据", User.class).setDataList(list1).write(response, "").dispose();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return null;

    }

    /**
     * 导入用户数据
     *
     * @param
     * @param redirectAttributes
     * @return
     */
    @RequestMapping(value = "import.do")
    public String importFile(@RequestParam(value = "file_fields") MultipartFile[] file_fields, RedirectAttributes redirectAttributes, User users, HttpServletRequest request, Model model, HttpServletResponse response) {
        try {
            int successNum = 0;
            int failureNum = 0;
            StringBuilder failureMsg = new StringBuilder();
            for (MultipartFile myfile : file_fields) {
                ImportExcel ei = new ImportExcel(myfile, 1, 0);
                List<User> list = ei.getDataList(User.class);
                for (User user : list) {
                    try {
                        if ("true".equals(checkLoginName("", user.getLoginName()))) {
                            user.setPassword(SystemService.entryptPassword("123456"));
                            BeanValidators.validateWithException(validator, user);
                            systemService.saveUser(user);
                            successNum++;
                        } else {
                            failureMsg.append("<br/>登录名 " + user.getLoginName() + " 已存在; ");
                            failureNum++;
                        }
                    } catch (ConstraintViolationException ex) {
                        failureMsg.append("<br/>登录名 " + user.getLoginName() + " 导入失败：");
                        List<String> messageList = BeanValidators.extractPropertyAndMessageAsList(ex, ": ");
                        for (String message : messageList) {
                            failureMsg.append(message + "; ");
                            failureNum++;
                        }
                    } catch (Exception ex) {
                        failureMsg.append("<br/>登录名 " + user.getLoginName() + " 导入失败：" + ex.getMessage());
                    }
                }
            }
            if (failureNum > 0) {
                failureMsg.insert(0, "，失败 " + failureNum + " 条用户，导入信息如下：");
            }
            model.addAttribute("message", "已成功导入" + successNum + " 条用户" + failureMsg);
            //成功 success 失败 danger
            model.addAttribute("flag", "success");
        } catch (Exception e) {
            model.addAttribute("message", "导入用户失败！失败信息：" + e.getMessage());
            //成功 success 失败 danger
            model.addAttribute("flag", "danger");
        }

        return list(users, request, response, model);
    }

    /**
     * 下载导入用户数据模板
     *
     * @param response
     * @param redirectAttributes
     * @return
     */
    @RequiresPermissions("sys:user:view")
    @RequestMapping(value = "import/template")
    public String importFileTemplate(HttpServletResponse response, RedirectAttributes redirectAttributes) {
        try {
            String fileName = "用户数据导入模板.xlsx";
            List<User> list = Lists.newArrayList();
            list.add(UserUtils.getUser());
            new ExportExcel("用户数据", User.class, 2).setDataList(list).write(response, fileName).dispose();
            return null;
        } catch (Exception e) {
            addMessage(redirectAttributes, "导入模板下载失败！失败信息：" + e.getMessage());
        }
        return "redirect:" + adminPath + "/sys/user/list?repage";
    }

    /**
     * 验证登录名是否有效
     *
     * @param oldLoginName
     * @param loginName
     * @return
     */
    @ResponseBody
    @RequiresPermissions("sys:user:edit")
    @RequestMapping(value = "checkLoginName")
    public String checkLoginName(String oldLoginName, String loginName) {
        if (loginName != null && loginName.equals(oldLoginName)) {
            return "true";
        } else if (loginName != null && systemService.getUserByLoginName(loginName) == null) {
            return "true";
        }
        return "false";
    }

    /**
     * 用户信息显示及保存
     *
     * @param user
     * @param model
     * @return
     */
    @RequiresPermissions("user")
    @RequestMapping(value = "info.do")
    public String info(User user, HttpServletResponse response, Model model) {
        User currentUser = UserUtils.getUser();
        if (StringUtils.isNotBlank(user.getName())) {
            currentUser.setEmail(user.getEmail());
            currentUser.setPhone(user.getPhone());
            currentUser.setMobile(user.getMobile());
            currentUser.setRemarks(user.getRemarks());
            currentUser.setPhoto(user.getPhoto());
            systemService.updateUserInfo(currentUser);
            model.addAttribute("message",  "保存用户信息成功");
            //成功 success 失败 danger
            model.addAttribute("flag", "success");
        }
        model.addAttribute("user", currentUser);
        model.addAttribute("Global", new Global());
        return "modules/user/info";
    }

    /**
     * 返回用户信息
     *
     * @return
     */
    @RequiresPermissions("user")
    @ResponseBody
    @RequestMapping(value = "infoData")
    public User infoData() {
        return UserUtils.getUser();
    }

    /**
     * 修改个人用户密码
     *
     * @param oldPassword
     * @param newPassword
     * @param model
     * @return
     */
    @RequiresPermissions("user")
    @RequestMapping(value = "modifyPwd.do")
    public String modifyPwd(String oldPassword, String newPassword, Model model) {
        User user = UserUtils.getUser();
        if (StringUtils.isNotBlank(oldPassword) && StringUtils.isNotBlank(newPassword)) {
            if (SystemService.validatePassword(oldPassword, user.getPassword())) {
                systemService.updatePasswordById(user.getId(), user.getLoginName(), newPassword);
                model.addAttribute("message", "修改密码成功");
                //成功 success 失败 danger
                model.addAttribute("flag", "success");
            } else {
                model.addAttribute("message", "修改密码失败，旧密码错误");
                //成功 success 失败 danger
                model.addAttribute("flag", "danger");
            }
        }
        model.addAttribute("user", user);
        return "modules/user/userPwd";
    }

    @RequiresPermissions("user")
    @ResponseBody
    @RequestMapping(value = "treeData")
    public List<Map<String, Object>> treeData(@RequestParam(required = false) String officeId, HttpServletResponse response) {
        List<Map<String, Object>> mapList = Lists.newArrayList();
        List<User> list = systemService.findUserByOfficeId(officeId);
        for (int i = 0; i < list.size(); i++) {
            User e = list.get(i);
            Map<String, Object> map = Maps.newHashMap();
            map.put("id", "u_" + e.getId());
            map.put("pId", officeId);
            map.put("name", StringUtils.replace(e.getName(), " ", ""));
            mapList.add(map);
        }
        return mapList;
    }

//	@InitBinder
//	public void initBinder(WebDataBinder b) {
//		b.registerCustomEditor(List.class, "roleList", new PropertyEditorSupport(){
//			@Autowired
//			private SystemService systemService;
//			@Override
//			public void setAsText(String text) throws IllegalArgumentException {
//				String[] ids = StringUtils.split(text, ",");
//				List<Role> roles = new ArrayList<Role>();
//				for (String id : ids) {
//					Role role = systemService.getRole(Long.valueOf(id));
//					roles.add(role);
//				}
//				setValue(roles);
//			}
//			@Override
//			public String getAsText() {
//				return Collections3.extractToString((List) getValue(), "id", ",");
//			}
//		});
//	}
}
