package com.xstudio.dao.sys;

import com.xstudio.controllers.framework.IList;
import org.apache.ibatis.annotations.Select;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;

@Repository
public interface SysMenuMapperExtend extends IList {
    @Select("select a.* from sys_menu as a where a.isshow=1")
    List<HashMap<String, Object>> findUserMenus();
}