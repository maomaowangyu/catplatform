/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/cat/baseplatform">baseplatform</a> All rights reserved.
 */
package com.galaxy.modules.gen.dao;

import com.galaxy.common.persistence.CrudDao;
import com.galaxy.common.persistence.annotation.MyBatisDao;
import com.galaxy.modules.gen.entity.GenScheme;

/**
 * 生成方案DAO接口
 * @author cat
 * @version 2013-10-15
 */
@MyBatisDao
public interface GenSchemeDao extends CrudDao<GenScheme> {
	
}
