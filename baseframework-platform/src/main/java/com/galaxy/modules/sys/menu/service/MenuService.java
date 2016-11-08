package com.galaxy.modules.sys.menu.service;

import com.galaxy.common.service.BaseInterface;
import com.galaxy.modules.sys.menu.domain.Menu;

import java.util.List;

/**
 * Created by cat on 2016/7/9.
 */
public interface MenuService extends BaseInterface<Menu> {
    public List<Menu> findMenuLeaveByUserId(Menu menu);

    public List<Menu> findLeftMenuLeaveByUserId(Menu menu);
}
