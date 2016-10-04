package com.xstudio.dao.sys;

import com.xstudio.controllers.framework.IList;
import com.xstudio.models.sys.SysMenu;
import org.apache.ibatis.annotations.Select;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;

@Repository
public interface SysMenuMapperExtend extends IList {
    @Select("select a.* from sys_menu as a where a.isshow=1")
    List<HashMap<String, Object>> findUserMenus();

    @Select("select a.* from sys_menu as a " +
            "LEFT JOIN sys_role_menu as b " +
            "on a.id=b.menuid where b.roleid=#{id}")
    List<SysMenu> findMenuByRoleID(Integer id);
}