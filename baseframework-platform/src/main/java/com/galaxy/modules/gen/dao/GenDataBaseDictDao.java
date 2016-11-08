/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/cat/baseplatform">baseplatform</a> All rights reserved.
 */
package com.galaxy.modules.gen.dao;

import java.util.List;

import com.galaxy.modules.gen.entity.GenTable;
import com.galaxy.modules.gen.entity.GenTableColumn;
import com.galaxy.common.persistence.CrudDao;
import com.galaxy.common.persistence.annotation.MyBatisDao;

/**
 * 业务表字段DAO接口
 * @author cat
 * @version 2013-10-15
 */
@MyBatisDao
public interface GenDataBaseDictDao extends CrudDao<GenTableColumn> {

	/**
	 * 查询表列表
	 * @param genTable
	 * @return
	 */
	List<GenTable> findTableList(GenTable genTable);

	/**
	 * 获取数据表字段
	 * @param genTable
	 * @return
	 */
	List<GenTableColumn> findTableColumnList(GenTable genTable);
	
	/**
	 * 获取数据表主键
	 * @param genTable
	 * @return
	 */
	List<String> findTablePK(GenTable genTable);
	
}
