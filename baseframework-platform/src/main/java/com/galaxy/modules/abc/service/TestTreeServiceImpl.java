/**
 * Copyright &copy; 2012-2016 <a href="#">BasePlatform</a> All rights reserved.
 */
package com.galaxy.modules.abc.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import  com.galaxy.modules.abc.service.TestTreeService;

import com.galaxy.common.service.TreeService;
import com.galaxy.common.utils.StringUtils;
import com.galaxy.modules.abc.domain.TestTree;
import com.galaxy.modules.abc.dao.TestTreeDao;

/**
 * weeService
 * @author we
 * @version 2016-11-05
 */
@Service
@Transactional(readOnly = true)
public class TestTreeServiceImpl extends TreeService<TestTreeDao, TestTree> implements TestTreeService {

	public TestTree get(String id) {
		return super.get(id);
	}

	public List<TestTree> findList(TestTree testTree) {
		if (StringUtils.isNotBlank(testTree.getParentIds())){
			testTree.setParentIds(","+testTree.getParentIds()+",");
		}
		return super.findList(testTree);
	}

	@Transactional(readOnly = false)
	public void save(TestTree testTree) {
		super.save(testTree);
	}

	@Transactional(readOnly = false)
	public void delete(TestTree testTree) {
		super.delete(testTree);
	}

}