package com.xstudio.dao.sys;

import com.xstudio.controllers.framework.IList;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;

@Repository
public interface SysUserMapperExtend extends IList{
    List<HashMap<String,Object>> loadUserAuth(Integer id);
}