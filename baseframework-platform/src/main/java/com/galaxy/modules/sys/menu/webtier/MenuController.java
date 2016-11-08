/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/cat/baseplatform">baseplatform</a> All rights reserved.
 */
package com.galaxy.modules.sys.menu.webtier;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import com.galaxy.common.config.Global;
import com.galaxy.common.utils.StringUtils;
import com.galaxy.common.web.BaseController;
import com.galaxy.modules.sys.menu.domain.Menu;
import com.galaxy.modules.sys.login.service.SystemService;
import com.galaxy.modules.sys.menu.service.MenuService;
import com.galaxy.modules.sys.user.domain.User;
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

import static com.galaxy.modules.sys.utils.UserUtils.getUser;

/**
 * 菜单Controller
 *
 * @author cat
 * @version 2013-3-23
 */
@Controller
@RequestMapping(value = "${adminPath}/menu")
public class MenuController extends BaseController {

    @Autowired
    private SystemService systemService;

    @Autowired
    private MenuService menuService;

    @ModelAttribute("menu")
    public Menu get(@RequestParam(required = false) String id) {
        if (StringUtils.isNotBlank(id)) {
            return systemService.getMenu(id);
        } else {
            return new Menu();
        }
    }

    @RequestMapping("leftmenu.do")
    public String leftmenu(Model model, String id) {
        User user = getUser();
        Menu m = new Menu();
        m.setUserId(user.getId());
        List<Menu> lmenuList = new ArrayList<Menu>();
        m.setLeave(2);
        m.setParentfId(id);
        lmenuList = menuService.findLeftMenuLeaveByUserId(m);
        m.setLeave(3);
        List<Menu> menuList = menuService.findMenuLeaveByUserId(m);

        model.addAttribute("lmenuList", lmenuList);
        model.addAttribute("menuList", menuList);
        return "modules/login/lefttree";
    }

    @RequiresPermissions("sys:menu:view")
    @RequestMapping(value = {"list.do", ""})
    public String list(Model model) {
        List<Menu> list = Lists.newArrayList();
        List<Menu> sourcelist = systemService.findAllMenu();
        Menu.sortList(list, sourcelist, Menu.getRootId(), true);
        model.addAttribute("list", list);
        return "modules/menu/list";
    }

    @RequiresPermissions("sys:menu:view")
    @RequestMapping(value = "toAddPage.do")
    public String toAddPage(Menu menu, Model model) {
        if (menu.getParent() == null || menu.getParent().getId() == null) {
            menu.setParent(new Menu(Menu.getRootId()));
        }
        menu.setParent(systemService.getMenu(menu.getParent().getId()));
        // 获取排序号，最末节点排序号+30
        if (StringUtils.isBlank(menu.getId())) {
            List<Menu> list = Lists.newArrayList();
            List<Menu> sourcelist = systemService.findAllMenu();
            Menu.sortList(list, sourcelist, menu.getParentId(), false);
            if (list.size() > 0) {
                menu.setSort(list.get(list.size() - 1).getSort() + 30);
            }
        }
        model.addAttribute("menu", menu);
        return "modules/menu/add";
    }

    @RequiresPermissions("sys:menu:view")
    @RequestMapping(value = "toModiPage.do")
    public String toModiPage(String id, Model model) {
        if (id == null) {
            id = "";
        }
        Menu menu = systemService.getMenu(id);

        if (menu.getParent() == null || menu.getParent().getId() == null) {
            menu.setParent(new Menu(Menu.getRootId()));
        }
        menu.setParent(systemService.getMenu(menu.getParent().getId()));
        // 获取排序号，最末节点排序号+30
        if (StringUtils.isBlank(menu.getId())) {
            List<Menu> list = Lists.newArrayList();
            List<Menu> sourcelist = systemService.findAllMenu();
            Menu.sortList(list, sourcelist, menu.getParentId(), false);
            if (list.size() > 0) {
                menu.setSort(list.get(list.size() - 1).getSort() + 30);
            }
        }
        model.addAttribute("menu", menu);
        return "modules/menu/modi";
    }

    @RequiresPermissions("sys:menu:view")
    @RequestMapping(value = "form.do")
    public String form(Menu menu, Model model) {
        if (menu.getParent() == null || menu.getParent().getId() == null) {
            menu.setParent(new Menu(Menu.getRootId()));
        }
        menu.setParent(systemService.getMenu(menu.getParent().getId()));
        // 获取排序号，最末节点排序号+30
        if (StringUtils.isBlank(menu.getId())) {
            List<Menu> list = Lists.newArrayList();
            List<Menu> sourcelist = systemService.findAllMenu();
            Menu.sortList(list, sourcelist, menu.getParentId(), false);
            if (list.size() > 0) {
                menu.setSort(list.get(list.size() - 1).getSort() + 30);
            }
        }
        model.addAttribute("menu", menu);
        return  "modules/menu/add";
    }

    @RequiresPermissions("sys:menu:edit")
    @RequestMapping(value = "save.do")
    public String save(Menu menu, Model model, RedirectAttributes redirectAttributes) {

        if (!beanValidator(model, menu)) {
            return form(menu, model);
        }
        systemService.saveMenu(menu);
        model.addAttribute("message", "保存菜单'" + menu.getName() + "'成功");
        //成功 success 失败 danger
        model.addAttribute("flag", "success");
        return list(model);
    }

    @RequiresPermissions("sys:menu:edit")
    @RequestMapping(value = "delete.do")
    public String delete(Menu menu,Model model, RedirectAttributes redirectAttributes) {
        systemService.deleteMenu(menu);
        model.addAttribute("message", "删除菜单成功");
        model.addAttribute("flag", "success");
        return list(model);
    }

    @RequiresPermissions("user")
    @RequestMapping(value = "tree")
    public String tree() {
        return "modules/sys/menuTree";
    }

    @RequiresPermissions("user")
    @RequestMapping(value = "treeselect")
    public String treeselect(String parentId, Model model) {
        model.addAttribute("parentId", parentId);
        return "modules/sys/menuTreeselect";
    }

    /**
     * 批量修改菜单排序
     */
    @RequiresPermissions("sys:menu:edit")
    @RequestMapping(value = "updateSort.do")
    public String updateSort(String[] ids, Integer[] sorts,Model model, RedirectAttributes redirectAttributes) {
        for (int i = 0; i < ids.length; i++) {
            Menu menu = new Menu(ids[i]);
            menu.setSort(sorts[i]);
            systemService.updateMenuSort(menu);
        }
        model.addAttribute("message", "保存菜单排序成功");
        //成功 success 失败 danger
        model.addAttribute("flag", "success");
        return list(model);
    }

    /**
     * isShowHide是否显示隐藏菜单
     *
     * @param extId    isShowHidden
     * @param response
     * @return
     */
    @RequiresPermissions("user")
    @ResponseBody
    @RequestMapping(value = "treeData.do")
    public List<Map<String, Object>> treeData(@RequestParam(required = false) String extId, @RequestParam(required = false) String isShowHide, HttpServletResponse response) {
        List<Map<String, Object>> mapList = Lists.newArrayList();
        List<Menu> list = systemService.findAllMenu();
        for (int i = 0; i < list.size(); i++) {
            Menu e = list.get(i);
            if (StringUtils.isBlank(extId) || (extId != null && !extId.equals(e.getId()) && e.getParentIds().indexOf("," + extId + ",") == -1)) {
                if (isShowHide != null && isShowHide.equals("0") && e.getIsShow().equals("0")) {
                    continue;
                }
                Map<String, Object> map = Maps.newHashMap();
                map.put("id", e.getId());
                map.put("pId", e.getParentId());
                map.put("name", e.getName());
                mapList.add(map);
            }
        }
        return mapList;
    }
}
