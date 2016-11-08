/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/cat/baseplatform">baseplatform</a> All rights reserved.
 */
package com.galaxy.modules.gen.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.galaxy.common.persistence.Page;
import com.galaxy.common.utils.StringUtils;
import com.galaxy.common.web.BaseController;
import com.galaxy.modules.gen.entity.GenScheme;
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

import com.galaxy.modules.gen.service.GenSchemeService;

/**
 * 生成方案Controller
 * @author cat
 * @version 2013-10-15
 */
@Controller
@RequestMapping(value = "${adminPath}/gen/genScheme")
public class GenSchemeController extends BaseController {

	@Autowired
	private GenSchemeService genSchemeService;
	
	@Autowired
	private GenTableService genTableService;
	
	@ModelAttribute
	public GenScheme get(@RequestParam(required=false) String id) {
		if (StringUtils.isNotBlank(id)){
			return genSchemeService.get(id);
		}else{
			return new GenScheme();
		}
	}
	
	@RequiresPermissions("gen:genScheme:view")
	@RequestMapping(value = {"list.do", ""})
	public String list(GenScheme genScheme, HttpServletRequest request, HttpServletResponse response, Model model) {
		User user = UserUtils.getUser();
		if (!user.isAdmin()){
			genScheme.setCreateBy(user);
		}
        Page<GenScheme> page = genSchemeService.find(new Page<GenScheme>(request, response), genScheme);
        model.addAttribute("page", page);
		
		return "modules/generation/schemelist";
	}

	@RequiresPermissions("gen:genScheme:view")
	@RequestMapping(value = "toAddPage")
	public String toAddPage(GenScheme genScheme, Model model) {
		if (StringUtils.isBlank(genScheme.getPackageName())){
			genScheme.setPackageName("com.galaxy.modules");
		}

		model.addAttribute("genScheme", genScheme);
		model.addAttribute("config", GenUtils.getConfig());
		model.addAttribute("tableList", genTableService.findAll());
		return "modules/generation/schemeadd";
	}

	@RequiresPermissions("gen:genScheme:view")
	@RequestMapping(value = "toModiPage")
	public String toModiPage(GenScheme genScheme, Model model) {
		if (StringUtils.isBlank(genScheme.getPackageName())){
			genScheme.setPackageName("com.galaxy.modules");
		}

		model.addAttribute("genScheme", genSchemeService.get(genScheme.getId()));
		model.addAttribute("config", GenUtils.getConfig());
		model.addAttribute("tableList", genTableService.findAll());
		return "modules/generation/schememodi";
	}

	@RequiresPermissions("gen:genScheme:view")
	@RequestMapping(value = "form")
	public String form(GenScheme genScheme, Model model) {
		if (StringUtils.isBlank(genScheme.getPackageName())){
			genScheme.setPackageName("com.galaxy.modules");
		}
//		if (StringUtils.isBlank(genScheme.getFunctionAuthor())){
//			genScheme.setFunctionAuthor(UserUtils.getUser().getName());
//		}
		model.addAttribute("genScheme", genScheme);
		model.addAttribute("config", GenUtils.getConfig());
		model.addAttribute("tableList", genTableService.findAll());
		return "modules/gen/genSchemeForm";
	}

	@RequiresPermissions("gen:genScheme:edit")
	@RequestMapping(value = "save")
	public String save(GenScheme genScheme, HttpServletRequest request, HttpServletResponse response, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, genScheme)){
			return form(genScheme, model);
		}
		
		String result = genSchemeService.save(genScheme);
		model.addAttribute("message", "操作生成方案'" + genScheme.getName() + "'成功<br/>"+result);
		//成功 success 失败 danger
		model.addAttribute("flag", "success");
		return list( genScheme,  request,  response,  model);
	}
	
	@RequiresPermissions("gen:genScheme:edit")
	@RequestMapping(value = "delete.do")
	public String delete(GenScheme genScheme, HttpServletRequest request, HttpServletResponse response, Model model, RedirectAttributes redirectAttributes) {
		genSchemeService.delete(genScheme);
		model.addAttribute("message", "删除生成方案成功");
		//成功 success 失败 danger
		model.addAttribute("flag", "success");
		return list( genScheme,  request,  response,  model);
	}

}
