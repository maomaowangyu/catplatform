/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/cat/baseplatform">baseplatform</a> All rights reserved.
 */
package com.galaxy.modules.sys.dict.webtier;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.galaxy.common.config.Global;
import com.galaxy.common.persistence.Page;
import com.galaxy.common.utils.StringUtils;
import com.galaxy.common.web.BaseController;
import com.galaxy.modules.sys.dict.domain.Dict;
import com.galaxy.modules.sys.dict.domain.DictType;
import com.galaxy.modules.sys.dict.service.DictService;
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

/**
 * 字典Controller
 * @author cat
 * @version 2014-05-16
 */
@Controller
@RequestMapping(value = "${adminPath}/dict")
public class DictController extends BaseController {

	@Autowired
	private DictService dictService;
	
	@ModelAttribute
	public Dict get(@RequestParam(required=false) String id) {
		if (StringUtils.isNotBlank(id)){
			return dictService.get(id);
		}else{
			return new Dict();
		}
	}
	
	@RequiresPermissions("sys:dict:view")
	@RequestMapping(value = {"list.do", ""})
	public String list(Dict dict, HttpServletRequest request, HttpServletResponse response, Model model) {
		List<String> typeList = dictService.findTypeList();
		model.addAttribute("typeList", typeList);
        Page<Dict> page = dictService.findPage(new Page<Dict>(request, response), dict);
        model.addAttribute("page", page);
		return "modules/dict/list";
	}

	@RequestMapping(value = "toAddPage")
	public String toAddPage(Dict dict, Model model) {
		model.addAttribute("dict", dict);
		return "modules/dict/add";
	}

	@RequestMapping(value = "toModiPage.do")
	public String toModiPage(Dict dict, Model model) {
		Dict r = dictService.getDict(dict.getId());
		model.addAttribute("dict", r);
		return "modules/dict/modi";
	}

	@RequiresPermissions("sys:dict:view")
	@RequestMapping(value = "form")
	public String form(Dict dict, Model model) {
		model.addAttribute("dict", dict);
		return "modules/sys/dictForm";
	}

	@RequiresPermissions("sys:dict:edit")
	@RequestMapping(value = "save")
	public String save(Dict dict, Model model, RedirectAttributes redirectAttributes, HttpServletRequest request, HttpServletResponse response) {
		if (!beanValidator(model, dict)){
			return form(dict, model);
		}
		dictService.save(dict);
		model.addAttribute("message", "保存字典'" + dict.getLabel() + "'成功");
		//成功 success 失败 danger
		model.addAttribute("flag", "success");
		return list(dict,request,response,model);
	}
	
	@RequiresPermissions("sys:dict:edit")
	@RequestMapping(value = "delete")
	public String delete(Dict dict, Model model, RedirectAttributes redirectAttributes,
						 HttpServletRequest request, HttpServletResponse response) {
		dictService.delete(dict);
		model.addAttribute("message", "删除字典成功");
		//成功 success 失败 danger
		model.addAttribute("flag", "success");
		return list(dict,request,response,model);
	}

	@RequiresPermissions("sys:dict:edit")
	@RequestMapping(value = "alldelete.do")
	public String alldelete(String[] ids,Dict dict, Model model, RedirectAttributes redirectAttributes,
						 HttpServletRequest request, HttpServletResponse response) {
		dictService.alldelete(ids);
		model.addAttribute("message", "删除字典成功");
		//成功 success 失败 danger
		model.addAttribute("flag", "success");
		return list(dict,request,response,model);
	}

	@RequiresPermissions("user")
	@ResponseBody
	@RequestMapping(value = "treeData")
	public List<Map<String, Object>> treeData(@RequestParam(required=false) String type, HttpServletResponse response) {
		List<Map<String, Object>> mapList = Lists.newArrayList();
		Dict dict = new Dict();
		dict.setType(type);
		List<Dict> list = dictService.findList(dict);
		for (int i=0; i<list.size(); i++){
			Dict e = list.get(i);
			Map<String, Object> map = Maps.newHashMap();
			map.put("id", e.getId());
			map.put("pId", e.getParentId());
			map.put("name", StringUtils.replace(e.getLabel(), " ", ""));
			mapList.add(map);
		}
		return mapList;
	}

	@ResponseBody
	@RequestMapping(value = "type1.do")
	public Map type1(String q, HttpServletRequest request, HttpServletResponse response,DictType dictType) {
		Map map = new HashMap();
		dictType.setVname(q);
		Page<DictType> page = dictService.getType(new Page<DictType>(request, response), dictType);
		map.put("total_count",page.getCount());
		map.put("items",page.getList());
		return map;
	}

	
	@ResponseBody
	@RequestMapping(value = "listData")
	public List<Dict> listData(@RequestParam(required=false) String type) {
		Dict dict = new Dict();
		dict.setType(type);
		return dictService.findList(dict);
	}

}
