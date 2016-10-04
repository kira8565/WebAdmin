package com.xstudio.dao.sys;

import com.xstudio.controllers.framework.IList;
import com.xstudio.models.sys.SysRole;
import org.apache.ibatis.annotations.Select;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public interface SysRoleMapperExtend extends IList {
    List<HashMap<String, Object>> loadRoleViaUser(Map<String, String> map);

    @Select("select a.* from sys_role as a " +
            "LEFT JOIN sys_role_user as b " +
            "on a.id=b.roleid where b.userid=#{id}")
    List<SysRole> findRoleByUserId(Integer id);
}