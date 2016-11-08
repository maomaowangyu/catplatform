/**
 * Copyright &copy; 2012-2016 <a href="#">BasePlatform</a> All rights reserved.
 */
package com.galaxy.modules.abc.dao;

import com.galaxy.common.persistence.TreeDao;
import com.galaxy.common.persistence.annotation.MyBatisDao;
import com.galaxy.modules.abc.domain.TestTree;

/**
 * weeDAO接口
 * @author we
 * @version 2016-11-05
 */
@MyBatisDao
public interface TestTreeDao extends TreeDao<TestTree> {
	
}