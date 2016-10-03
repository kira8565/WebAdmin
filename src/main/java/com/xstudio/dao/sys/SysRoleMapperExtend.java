package com.xstudio.dao.sys;

import org.apache.ibatis.session.RowBounds;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@Repository
public interface SysRoleMapperExtend {
    List<LinkedHashMap<String, Object>> all(RowBounds pagination,
                                      Map<String, String> map);

    List<HashMap<String, Object>> loadRoleViaUser(Map<String, String> map);
}