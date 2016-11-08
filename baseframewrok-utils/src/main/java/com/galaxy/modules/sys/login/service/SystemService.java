/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/cat/baseplatform">baseplatform</a> All rights reserved.
 */
package com.galaxy.modules.sys.login.service;

import java.util.Collection;
import java.util.Date;
import java.util.Iterator;
import java.util.List;


import org.springframework.beans.factory.InitializingBean;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.galaxy.common.service.BaseService;
import com.galaxy.modules.sys.role.domain.Role;
import com.galaxy.modules.sys.user.domain.User;
import com.galaxy.modules.sys.utils.UserUtils;

/**
 * 系统管理，安全相关实体的管理类,包括用户、角色、菜单.
 * @author cat
 * @version 2013-12-05
 */
@Service
@Transactional(readOnly = true)
public class SystemService extends BaseService implements InitializingBean {
	
	public static final String HASH_ALGORITHM = "SHA-1";
	public static final int HASH_INTERATIONS = 1024;
	public static final int SALT_SIZE = 8;


	@Override
	public void afterPropertiesSet() throws Exception {

	}

	public void deleteUser(User user) {

	}

	public List<Role> findRole(Role role){
		return null;
	}

	/**
	 * 根据登录名获取用户
	 * @param loginName
	 * @return
	 */
	public User getUserByLoginName(String loginName) {
		return UserUtils.getByLoginName(loginName);
	}
}
