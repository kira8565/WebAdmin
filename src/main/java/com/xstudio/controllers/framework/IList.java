package com.xstudio.controllers.framework;

import org.apache.ibatis.session.RowBounds;

import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by kira on 16/8/21.
 */
public interface IList {
    List<LinkedHashMap<String, Object>> all(RowBounds pagination,
                                            Map<String, String> map);
}
