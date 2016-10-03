package com.xstudio.dao;

import com.xstudio.models.${entity};
import com.xstudio.models.${entity}Example;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.RowBounds;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public interface ${entity}MapperExtend {
List<HashMap<String, Object>> all(RowBounds pagination,
Map<String, String> map);
}