/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/cat/baseplatform">baseplatform</a> All rights reserved.
 */
package com.galaxy.modules.sys.log.persistence;

import com.galaxy.common.persistence.CrudDao;
import com.galaxy.common.persistence.annotation.MyBatisDao;
import com.galaxy.modules.sys.log.domain.Log;

/**
 * 日志DAO接口
 * @author cat
 * @version 2014-05-16
 */
@MyBatisDao
public interface LogDao extends CrudDao<Log> {

}
