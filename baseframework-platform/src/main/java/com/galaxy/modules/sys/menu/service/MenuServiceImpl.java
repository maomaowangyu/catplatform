package com.galaxy.modules.sys.menu.service;

import com.galaxy.common.service.CrudService;
import com.galaxy.modules.sys.menu.domain.Menu;
import com.galaxy.modules.sys.menu.persistence.MenuDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by cat on 2016/7/9.
 */
@Service
public class MenuServiceImpl extends CrudService<MenuDao,Menu> implements MenuService {
    @Autowired
    private MenuDao menuDao;

    @Override
    public List<Menu> findMenuLeaveByUserId(Menu menu) {
        return menuDao.findMenuLeaveByUserId(menu);
    }

    @Override
    public List<Menu> findLeftMenuLeaveByUserId(Menu menu) {
        return menuDao.findLeftMenuLeaveByUserId(menu);
    }
}
