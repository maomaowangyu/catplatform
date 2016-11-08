/**
 * Copyright &copy; 2012-2016 <a href="#">BasePlatform</a> All rights reserved.
 */
package com.galaxy.modules.abc.web;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.galaxy.common.persistence.Page;
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
import com.galaxy.common.utils.StringUtils;
import com.galaxy.modules.abc.domain.TestTree;
import com.galaxy.modules.abc.service.TestTreeService;

/**
 * weeController
 * @author we
 * @version 2016-11-05
 */
@Controller
@RequestMapping(value = "${adminPath}/abc/testTree")
public class TestTreeController extends BaseController {

	@Autowired
	private TestTreeService testTreeService;

	@ModelAttribute
	public TestTree get(@RequestParam(required=false) String id) {
		TestTree entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = testTreeService.get(id);
		}
		if (entity == null){
			entity = new TestTree();
		}
		return entity;
	}

	@RequiresPermissions("abc:testTree:view")
	@RequestMapping(value = {"list.do", ""})
	public String list(TestTree testTree, HttpServletRequest request, HttpServletResponse response, Model model) {
		List<TestTree> list = testTreeService.findList(testTree);
		model.addAttribute("list", list);
		Page<TestTree> page = testTreeService.findPage(new Page<TestTree>(request, response), testTree);
		model.addAttribute("page", page);
		return "modules/abc/list";
	}

	@RequiresPermissions("abc:testTree:view")
	@RequestMapping(value = "toAddPage.do")
	public String toAddPage(TestTree testTree, Model model) {
		if (testTree.getParent()!=null && StringUtils.isNotBlank(testTree.getParent().getId())){
			testTree.setParent(testTreeService.get(testTree.getParent().getId()));
			// 获取排序号，最末节点排序号+30
			if (StringUtils.isBlank(testTree.getId())){
				TestTree testTreeChild = new TestTree();
				testTreeChild.setParent(new TestTree(testTree.getParent().getId()));
				List<TestTree> list = testTreeService.findList(testTree);
				if (list.size() > 0){
					testTree.setSort(list.get(list.size()-1).getSort());
					if (testTree.getSort() != null){
						testTree.setSort(testTree.getSort() + 30);
					}
				}
			}
		}
		if (testTree.getSort() == null){
			testTree.setSort(30);
		}
		model.addAttribute("testTree", testTree);
		return "modules/abc/add";
	}

	@RequiresPermissions("abc:testTree:view")
	@RequestMapping(value = "toModiPage.do")
	public String toModiPage(TestTree testTree, Model model) {
		testTree = testTreeService.get(testTree);

		if (testTree.getParent()!=null && StringUtils.isNotBlank(testTree.getParent().getId())){
			testTree.setParent(testTreeService.get(testTree.getParent().getId()));
			// 获取排序号，最末节点排序号+30
			if (StringUtils.isBlank(testTree.getId())){
				TestTree testTreeChild = new TestTree();
				testTreeChild.setParent(new TestTree(testTree.getParent().getId()));
				List<TestTree> list = testTreeService.findList(testTree);
				if (list.size() > 0){
					testTree.setSort(list.get(list.size()-1).getSort());
					if (testTree.getSort() != null){
						testTree.setSort(testTree.getSort() + 30);
					}
				}
			}
		}
		if (testTree.getSort() == null){
			testTree.setSort(30);
		}
		model.addAttribute("testTree", testTree);
		return "modules/abc/modi";
	}

	@RequiresPermissions("abc:testTree:edit")
	@RequestMapping(value = "save")
	public String save(TestTree testTree, Model model, RedirectAttributes redirectAttributes, HttpServletRequest request, HttpServletResponse response) {
		if (!beanValidator(model, testTree)){
			model.addAttribute("message", "保存失败");
			//成功 success 失败 danger
			model.addAttribute("flag", "danger");
			return	list(  testTree,  request,  response,  model) ;
		}
		testTreeService.save(testTree);

		model.addAttribute("message", "保存成功");
		//成功 success 失败 danger
		model.addAttribute("flag", "success");
		return	list(  testTree,  request,  response,  model) ;
	}

	@RequiresPermissions("abc:testTree:edit")
	@RequestMapping(value = "delete")
	public String delete(TestTree testTree, RedirectAttributes redirectAttributes, Model model, HttpServletRequest request, HttpServletResponse response) {
		testTreeService.delete(testTree);
		model.addAttribute("message", "删除成功");
		//成功 success 失败 danger
		model.addAttribute("flag", "success");
		return list( testTree,request,response,model);
	}

	@RequiresPermissions("user")
	@ResponseBody
	@RequestMapping(value = "treeData")
	public List<Map<String, Object>> treeData(@RequestParam(required=false) String extId, HttpServletResponse response) {
		List<Map<String, Object>> mapList = Lists.newArrayList();
		List<TestTree> list = testTreeService.findList(new TestTree());
		for (int i=0; i<list.size(); i++){
			TestTree e = list.get(i);
			if (StringUtils.isBlank(extId) || (extId!=null && !extId.equals(e.getId()) && e.getParentIds().indexOf(","+extId+",")==-1)){
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