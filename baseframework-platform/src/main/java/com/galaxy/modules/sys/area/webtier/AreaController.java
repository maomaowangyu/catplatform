/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/cat/baseplatform">baseplatform</a> All rights reserved.
 */
package com.galaxy.modules.sys.area.webtier;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import com.galaxy.common.utils.StringUtils;
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
import com.galaxy.common.web.BaseController;
import com.galaxy.modules.sys.area.domain.Area;
import com.galaxy.modules.sys.area.service.AreaService;

/**
 * 区域Controller
 *
 * @author cat
 * @version 2013-5-15
 */
@Controller
@RequestMapping(value = "${adminPath}/area")
public class AreaController extends BaseController {

    @Autowired
    private AreaService areaService;

    @ModelAttribute("area")
    public Area get(@RequestParam(required = false) String id) {
        if (StringUtils.isNotBlank(id)) {
            return areaService.get(id);
        } else {
            return new Area();
        }
    }

    @RequiresPermissions("sys:area:view")
    @RequestMapping(value = {"list.do", ""})
    public String list(Area area, Model model) {
        model.addAttribute("list", areaService.findAll());
        return "modules/area/list";
    }

    @RequiresPermissions("sys:area:view")
    @RequestMapping(value = "form")
    public String form(Area area, Model model) {
        if (area.getParent() == null || area.getParent().getId() == null) {
            area.setParent(UserUtils.getUser().getOffice().getArea());
        }
        area.setParent(areaService.get(area.getParent().getId()));
        model.addAttribute("area", area);
        return "modules/area/add";
    }

    @RequiresPermissions("sys:area:view")
    @RequestMapping(value = "toAddPage.do")
    public String toAddPage(Area area, Model model) {
        if (area.getParent() == null || area.getParent().getId() == null) {
            area.setParent(UserUtils.getUser().getOffice().getArea());
        }
        area.setParent(areaService.get(area.getParent().getId()));
        model.addAttribute("area", area);
        return "modules/area/add";
    }

    @RequiresPermissions("sys:area:view")
    @RequestMapping(value = "toModiPage.do")
    public String toModiPage(Area area, Model model) {
        if (area.getParent() == null || area.getParent().getId() == null) {
            area.setParent(UserUtils.getUser().getOffice().getArea());
        }
        area.setParent(areaService.get(area.getParent().getId()));
        model.addAttribute("area", area);
        return "modules/area/modi";
    }


    @RequiresPermissions("sys:area:edit")
    @RequestMapping(value = "save.do")
    public String save(Area area, Model model, RedirectAttributes redirectAttributes) {
        if (!beanValidator(model, area)) {
            return form(area, model);
        }
        areaService.save(area);
        model.addAttribute("message", "保存区域'" + area.getName() + "'成功");
        //成功 success 失败 danger
        model.addAttribute("flag", "success");
        return list(area, model);
    }

    @RequiresPermissions("sys:area:edit")
    @RequestMapping(value = "delete.do")
    public String delete(Area area, Model model, RedirectAttributes redirectAttributes) {

        areaService.delete(area);
        model.addAttribute("message", "删除区域成功");
        //成功 success 失败 danger
        model.addAttribute("flag", "success");
        return list(area, model);
    }

    @RequiresPermissions("user")
    @ResponseBody
    @RequestMapping(value = "treeData.do")
    public List<Map<String, Object>> treeData(@RequestParam(required = false) String extId, HttpServletResponse response) {
        List<Map<String, Object>> mapList = Lists.newArrayList();
        List<Area> list = areaService.findAll();
        for (int i = 0; i < list.size(); i++) {
            Area e = list.get(i);
            if (StringUtils.isBlank(extId) || (extId != null && !extId.equals(e.getId()) && e.getParentIds().indexOf("," + extId + ",") == -1)) {
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
