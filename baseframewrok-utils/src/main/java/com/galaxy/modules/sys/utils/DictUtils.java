/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/cat/baseplatform">baseplatform</a> All rights reserved.
 */
package com.galaxy.modules.sys.utils;

import java.util.List;
import java.util.Map;

import com.galaxy.common.utils.CacheUtils;
import org.apache.commons.lang3.StringUtils;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.galaxy.common.mapper.JsonMapper;
import com.galaxy.common.utils.SpringContextHolder;

/**
 * 字典工具类
 * @author cat
 * @version 2013-5-29
 */
public class DictUtils {
	

	public static final String CACHE_DICT_MAP = "dictMap";
	
	public static String getDictLabel(String value, String type, String defaultValue){

		return defaultValue;
	}

}
