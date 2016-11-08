/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/cat/baseplatform">baseplatform</a> All rights reserved.
 */
package com.galaxy.modules.sys.dict.service;

import java.util.List;

import com.galaxy.common.persistence.Page;
import com.galaxy.common.service.CrudService;
import com.galaxy.common.utils.CacheUtils;
import com.galaxy.modules.sys.dict.domain.Dict;
import com.galaxy.modules.sys.dict.domain.DictType;
import com.galaxy.modules.sys.utils.DictUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.galaxy.modules.sys.dict.persistence.DictDao;

/**
 * 字典Service
 * @author cat
 * @version 2014-05-16
 */
@Service
@Transactional(readOnly = true)
public class DictService extends CrudService<DictDao, Dict> {
	@Autowired
	private DictDao dictDao;
	/**
	 * 查询字段类型列表
	 * @return
	 */
	public List<String> findTypeList(){
		return dao.findTypeList(new Dict());
	}

	@Transactional(readOnly = false)
	public void save(Dict dict) {
		super.save(dict);
		CacheUtils.remove(DictUtils.CACHE_DICT_MAP);
	}

	@Transactional(readOnly = false)
	public void delete(Dict dict) {
		super.delete(dict);
		CacheUtils.remove(DictUtils.CACHE_DICT_MAP);
	}

	@Transactional(readOnly = false)
	public void alldelete(String[] ids) {
		dictDao.alldelete(ids);
		CacheUtils.remove(DictUtils.CACHE_DICT_MAP);
	}

	public Dict getDict(String id) {
		return dictDao.get(id);
	}

	public Page<DictType> getType(Page<DictType> page, DictType dictType) {
		// 生成数据权限过滤条件（dsf为dataScopeFilter的简写，在xml中使用 ${sqlMap.dsf}调用权限SQL）
		dictType.getSqlMap().put("dsf", dataScopeFilter(dictType.getCurrentUser(), "o", "a"));
		// 设置分页参数
		dictType.setPage(page);
		// 执行分页查询
		page.setList(dictDao.getType(dictType));
		return page;
	}


}
