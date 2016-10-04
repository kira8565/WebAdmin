package com.xstudio.controllers.framework;

import com.xstudio.mybatis.Pagination;
import com.xstudio.utilities.CommonUtility;
import com.xstudio.utilities.ConstantUtility;
import org.apache.log4j.Logger;
import org.springframework.ui.Model;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;

/**
 * Created by kira on 2016/10/3.
 */
public class BaseController {
    protected Logger logger = Logger.getLogger(this.getClass());

    protected void simpleList(HttpServletRequest request, Model model, IList list, Boolean needPage, HashMap<String, String> extendParam) {
        Pagination pagination = new Pagination();
        if (needPage) {
            pagination = CommonUtility.getPagination(request, model);
        }
        HashMap<String, String> map = CommonUtility.getParameterMap(request);
        if (extendParam != null) {
            map.putAll(extendParam);
        }
        CommonUtility.renderGridData(request, model,
                list.all(pagination, map),
                pagination);
    }

    protected ModelAndView simpleAdd(Boolean hasError,
                                     String prefix,
                                     Object object,
                                     String logTitle,
                                     Object mapper,
                                     RedirectAttributes redirectAttributes) {
        if (hasError) {
            return new ModelAndView(prefix + "add");
        } else {
            ModelAndView modelAndView = new ModelAndView();
            try {
                mapper.getClass().getDeclaredMethod("insertSelective", object.getClass()).invoke(mapper, object);
                redirectAttributes.addFlashAttribute(ConstantUtility.FLASH_SUCCESS_MESSAEG, ConstantUtility.CREATE_SUCCESS);
            } catch (Exception ex) {
                redirectAttributes.addFlashAttribute(ConstantUtility.FLASH_ERROR_MESSAEG, ConstantUtility.CREATE_FAIL);
                logger.error(ex.getMessage());
            }
            modelAndView.setViewName("redirect:/" + prefix + "index");
            return modelAndView;
        }
    }

    protected ModelAndView simpleDelete(String prefix, String logTitle, Object mapper,
                                        Integer id, RedirectAttributes redirectAttributes,
                                        String limit, String offset) {
        ModelAndView modelAndView = new ModelAndView();
        try {
            mapper.getClass().getDeclaredMethod("deleteByPrimaryKey", Integer.class).invoke(mapper, id);
            redirectAttributes.addFlashAttribute(ConstantUtility.FLASH_SUCCESS_MESSAEG, ConstantUtility.DELETE_SUCCESS);
        } catch (Exception ex) {
            redirectAttributes.addFlashAttribute(ConstantUtility.FLASH_ERROR_MESSAEG, ConstantUtility.DELETE_FAIL);
            logger.error(ex.getMessage());
        }
        if (limit.equals("0") && offset.equals("0")) {
            modelAndView.setViewName("redirect:/" + prefix + "index");
        } else {
            modelAndView.setViewName("redirect:/" + prefix + "index?limit=" + limit + "&offset=" + offset);
        }

        return modelAndView;
    }

    protected ModelAndView simpleEdit(Boolean hasError,
                                      String prefix,
                                      Object object,
                                      String logTitle,
                                      Object mapper,
                                      RedirectAttributes redirectAttributes) {
        if (hasError) {
            return new ModelAndView(prefix + "edit");
        } else {
            ModelAndView modelAndView = new ModelAndView();
            try {
                mapper.getClass().getDeclaredMethod("updateByPrimaryKeySelective", object.getClass()).invoke(mapper, object);
                redirectAttributes.addFlashAttribute(ConstantUtility.FLASH_SUCCESS_MESSAEG, ConstantUtility.UPDATE_SUCCESS);
            } catch (Exception ex) {
                redirectAttributes.addFlashAttribute(ConstantUtility.FLASH_ERROR_MESSAEG, ConstantUtility.UPDATE_FAIL);
                logger.error(ex.getMessage());
            }
            modelAndView.setViewName("redirect:/" + prefix + "index");

            return modelAndView;
        }
    }
}
