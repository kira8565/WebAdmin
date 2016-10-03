package com.xstudio.controllers.framework;

import com.alibaba.fastjson.JSON;
import com.xstudio.models.sys.SysDict;
import com.xstudio.mybatis.Pagination;
import com.xstudio.utilities.CommonUtility;
import com.xstudio.utilities.SpringContainerUtility;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import java.lang.reflect.InvocationTargetException;
import java.util.HashMap;
import java.util.List;

/**
 * Created by kira on 16/8/21.
 */
@Controller
@RequestMapping(value = "/admin/framework/simplecrud")
public class SimpleCrudController {
    private Logger logger = Logger.getLogger(SimpleCrudController.class);

    String prefix = "admin/framework/simplecrud/";

    @RequestMapping(value = "/index")
    public String index(HttpServletRequest request, Model model,
                        String key) throws ClassNotFoundException {
        MetaModel metaModel = CommonUtility.loadFrameWorkMetaResource(key);
        Pagination pagination;
        if (metaModel.getNeedPage()) {
            pagination = CommonUtility.getPagination(request, model);
        } else {
            pagination = new Pagination();
        }

        HashMap<String, String> map = CommonUtility.getParameterMap(request);

        Object mapperExtend =
                Class.forName("com.xstudio.dao." + metaModel.getEntityPrefix()
                        + "."
                        + metaModel.getEntityName() + "MapperExtend");
        IList listPlugin =
                (IList) SpringContainerUtility.context.getBean(
                        ((Class) mapperExtend));

        CommonUtility.renderGridData(request, model,
                listPlugin.all(pagination, map),
                pagination);

        model.addAttribute("metaModel", metaModel);
        return prefix + "index";
    }


    @RequestMapping(value = "/add")
    public String add(HttpServletRequest request, Model model, String key,
                      @ModelAttribute("entity") HashMap<String, Object> entity) throws ClassNotFoundException, IllegalAccessException, InstantiationException {
        MetaModel metaModel = CommonUtility.loadFrameWorkMetaResource(key);
        model.addAttribute("metaModel", metaModel);
        Object mapperExtend =
                Class.forName("com.xstudio.models." + metaModel.getEntityPrefix()
                        + "."
                        + metaModel.getEntityName()).newInstance();

        model.addAttribute("entity", mapperExtend);
        return prefix + "add";
    }

    @RequestMapping(value = "/addEntity")
    public ModelAndView addEntity(HttpServletRequest request, Model model,
                                  RedirectAttributes redirectAttributes) throws ClassNotFoundException, IllegalAccessException, InstantiationException {
        HashMap<String, String> map = CommonUtility.getParameterMap(request);
        String json = JSON.toJSON(map).toString();

        MetaModel metaModel = CommonUtility.loadFrameWorkMetaResource(map.get("key"));
        Object entity = JSON.parseObject(json, Class.forName("com.xstudio.models." + metaModel.getEntityPrefix()
                + "."
                + metaModel.getEntityName()));

        Object mapper =
                Class.forName("com.xstudio.dao." + metaModel.getEntityPrefix()
                        + "."
                        + metaModel.getEntityName() + "Mapper");
        return CommonUtility.commonAdd(false, prefix,
                entity, "新增字段", SpringContainerUtility.context.getBean((Class) mapper),
                redirectAttributes, logger, map.get("key"));
    }

    @RequestMapping(value = "/deleteEntity")
    @ResponseBody
    public ModelAndView deleteEntity(HttpServletRequest request, Model model,
                                     Integer id, String limit, String offset, String key,
                                     RedirectAttributes redirectAttributes) throws ClassNotFoundException {
        MetaModel metaModel = CommonUtility.loadFrameWorkMetaResource(key);
        Object mapper =
                Class.forName("com.xstudio.dao." + metaModel.getEntityPrefix()
                        + "."
                        + metaModel.getEntityName() + "Mapper");

        return CommonUtility.commonDelete(prefix, "删除字段",
                SpringContainerUtility.context.getBean((Class) mapper), id,
                redirectAttributes, limit, offset, logger, key);
    }

    @RequestMapping(value = "/edit")
    public String edit(HttpServletRequest request, Model model, Integer id
            , String key) throws ClassNotFoundException, NoSuchMethodException, InvocationTargetException, IllegalAccessException {

        MetaModel metaModel = CommonUtility.loadFrameWorkMetaResource(key);
        Object mapper =
                Class.forName("com.xstudio.dao." + metaModel.getEntityPrefix()
                        + "."
                        + metaModel.getEntityName() + "Mapper");
        Object obj = SpringContainerUtility.context.getBean((Class) mapper);
        model.addAttribute("entity",
                obj.getClass().getMethod("selectByPrimaryKey", Integer.class).invoke(obj, id)
        );
        model.addAttribute("metaModel", metaModel);
        return prefix + "edit";
    }

    @RequestMapping(value = "/editEntity")
    public ModelAndView editEntity(HttpServletRequest request, Model model,
                                   RedirectAttributes redirectAttributes) throws Exception {

        HashMap<String, String> map = CommonUtility.getParameterMap(request);
        String json = JSON.toJSON(map).toString();

        MetaModel metaModel = CommonUtility.loadFrameWorkMetaResource(map.get("key"));
        Object entity = JSON.parseObject(json, Class.forName("com.xstudio.models." + metaModel.getEntityPrefix()
                + "."
                + metaModel.getEntityName()));

        Object mapper =
                Class.forName("com.xstudio.dao." + metaModel.getEntityPrefix()
                        + "."
                        + metaModel.getEntityName() + "Mapper");

        return CommonUtility.commonEdit(false, prefix, entity,
                metaModel.getEditTitle(), SpringContainerUtility.context.getBean((Class)mapper), redirectAttributes, logger, map.get("key"));
    }
}
