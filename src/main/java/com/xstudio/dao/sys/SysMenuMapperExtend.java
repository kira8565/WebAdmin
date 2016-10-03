package com.xstudio.dao.sys;

import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public interface SysMenuMapperExtend {
    List<HashMap<String, Object>> all(
                                      Map<String, String> map);
}