/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/cat/baseplatform">baseplatform</a> All rights reserved.
 */
package com.galaxy.modules.gen.web;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.galaxy.common.persistence.Page;
import com.galaxy.common.utils.StringUtils;
import com.galaxy.common.web.BaseController;
import com.galaxy.modules.gen.entity.GenTable;
import com.galaxy.modules.gen.entity.GenTableColumn;
import com.galaxy.modules.gen.service.GenTableService;
import com.galaxy.modules.gen.util.GenUtils;
import com.galaxy.modules.sys.user.domain.User;
import com.galaxy.modules.sys.utils.UserUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

/**
 * 业务表Controller
 * @author cat
 * @version 2013-10-15
 */
@Controller
@RequestMapping(value = "${adminPath}/gen/genTable")
public class GenTableController extends BaseController {

	@Autowired
	private GenTableService genTableService;
	
	@ModelAttribute
	public GenTable get(@RequestParam(required=false) String id) {
		if (StringUtils.isNotBlank(id)){
			return genTableService.get(id);
		}else{
			return new GenTable();
		}
	}
	
	@RequiresPermissions("gen:genTable:view")
	@RequestMapping(value = {"list.do", ""})
	public String list(GenTable genTable, HttpServletRequest request, HttpServletResponse response, Model model) {
		User user = UserUtils.getUser();
		if (!user.isAdmin()){
			genTable.setCreateBy(user);
		}
        Page<GenTable> page = genTableService.find(new Page<GenTable>(request, response), genTable);
        model.addAttribute("page", page);
		return "modules/generation/gentablelist";
	}

	@RequiresPermissions("gen:genTable:view")
	@RequestMapping(value = "form.do")
	public String form(GenTable genTable, Model model) {
		// 获取物理表列表
		List<GenTable> tableList = genTableService.findTableListFormDb(new GenTable());
		model.addAttribute("tableList", tableList);
		// 验证表是否存在
		if (StringUtils.isBlank(genTable.getId()) && !genTableService.checkTableName(genTable.getName())){
			addMessage(model, "下一步失败！" + genTable.getName() + " 表已经添加！");
			genTable.setName("");
		} else {
			genTable = genTableService.getTableFormDb(genTable);
		}
		model.addAttribute("genTable", genTable);
		model.addAttribute("config", GenUtils.getConfig());
		return "modules/generation/gentableadd";
	}

	@RequiresPermissions("gen:genTable:view")
	@RequestMapping(value = "toModiPage.do")
	public String toModiPage(GenTable genTable, Model model) {
		// 获取物理表列表
		List<GenTable> tableList = genTableService.findTableListFormDb(new GenTable());
		model.addAttribute("tableList", tableList);
        genTable = genTableService.getTableFormDb(genTable);
		model.addAttribute("genTable", genTable);
		model.addAttribute("config", GenUtils.getConfig());
		return "modules/generation/gentablemodi";
	}

	@RequiresPermissions("gen:genTable:edit")
	@RequestMapping(value = "save")
	public String save(GenTable genTables, Model model, RedirectAttributes redirectAttributes, HttpServletRequest request, HttpServletResponse response) {
		if (!beanValidator(model, genTables)){
			return form(genTables, model);
		}
		// 验证表是否已经存在
		if (StringUtils.isBlank(genTables.getId()) && !genTableService.checkTableName(genTables.getName())){
			model.addAttribute("message", "保存失败'" + genTables.getName() + "'表已经存在");
			//成功 success 失败 danger
			model.addAttribute("flag", "danger");
			genTables.setName("");
			return form(genTables, model);
		}
		genTableService.save(genTables);
		model.addAttribute("message", "保存业务表'" + genTables.getName() + "'成功");
		//成功 success 失败 danger
		model.addAttribute("flag", "success");
		return	list( genTables,  request,  response,  model) ;
	}
	
	@RequiresPermissions("gen:genTable:edit")
	@RequestMapping(value = "delete.do")
	public String delete(GenTable genTable, Model model, RedirectAttributes redirectAttributes, HttpServletRequest request, HttpServletResponse response) {
		genTableService.delete(genTable);
		model.addAttribute("message", "删除业务表成功");
		//成功 success 失败 danger
		model.addAttribute("flag", "success");
		return	list(genTable,  request,  response,  model) ;
	}

}
