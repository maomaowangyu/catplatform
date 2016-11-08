/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/cat/baseplatform">baseplatform</a> All rights reserved.
 */
package com.galaxy.modules.sys.dict.persistence;

import java.util.List;

import com.galaxy.modules.sys.dict.domain.Dict;
import com.galaxy.common.persistence.CrudDao;
import com.galaxy.common.persistence.annotation.MyBatisDao;
import com.galaxy.modules.sys.dict.domain.DictType;
import org.apache.ibatis.annotations.Param;

/**
 * 字典DAO接口
 * @author cat
 * @version 2014-05-16
 */
@MyBatisDao
public interface DictDao extends CrudDao<Dict> {

	public List<String> findTypeList(Dict dict);

	public List<DictType> getType(DictType dictType);

	public int alldelete(@Param("ids") String[] ids);

}
