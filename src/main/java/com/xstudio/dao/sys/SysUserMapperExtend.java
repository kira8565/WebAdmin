package com.xstudio.dao.sys;

import com.xstudio.controllers.framework.IList;
import com.xstudio.models.sys.SysUser;
import org.apache.ibatis.annotations.Select;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;

@Repository
public interface SysUserMapperExtend extends IList{
    List<HashMap<String,Object>> loadUserAuth(Integer id);

    @Select("select a.* from sys_user as a " +
            "LEFT JOIN sys_role_user as b " +
            "on a.id=b.userid where b.roleid=#{id}")
    List<SysUser> findUserByRoleId(Integer id);
}