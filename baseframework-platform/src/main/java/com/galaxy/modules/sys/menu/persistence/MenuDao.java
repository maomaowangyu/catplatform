/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/cat/baseplatform">baseplatform</a> All rights reserved.
 */
package com.galaxy.modules.sys.menu.persistence;

import java.util.List;

import com.galaxy.common.persistence.CrudDao;
import com.galaxy.common.persistence.annotation.MyBatisDao;
import com.galaxy.modules.sys.menu.domain.Menu;

/**
 * 菜单DAO接口
 * @author cat
 * @version 2014-05-16
 */
@MyBatisDao
public interface MenuDao extends CrudDao<Menu> {

	public List<Menu> findByParentIdsLike(Menu menu);

	public List<Menu> findByUserId(Menu menu);

	public List<Menu> findMenuLeaveByUserId(Menu menu);

	public List<Menu> findLeftMenuLeaveByUserId(Menu menu);

	public int updateParentIds(Menu menu);
	
	public int updateSort(Menu menu);
	
}
