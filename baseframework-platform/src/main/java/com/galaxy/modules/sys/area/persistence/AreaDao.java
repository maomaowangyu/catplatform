/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/cat/baseplatform">baseplatform</a> All rights reserved.
 */
package com.galaxy.modules.sys.area.persistence;

import com.galaxy.common.persistence.TreeDao;
import com.galaxy.common.persistence.annotation.MyBatisDao;
import com.galaxy.modules.sys.area.domain.Area;

/**
 * 区域DAO接口
 * @author cat
 * @version 2014-05-16
 */
@MyBatisDao
public interface AreaDao extends TreeDao<Area> {
	
}
