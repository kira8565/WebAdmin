package com.xstudio.dao.sys;

import com.xstudio.controllers.framework.IList;
import com.xstudio.models.sys.SysDict;
import org.apache.ibatis.annotations.Select;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface SysDictMapperExtend extends IList {
    @Select("select * from sys_dict where dictgroup=#{group}")
    List<SysDict> findDictByGroup(String group);
}