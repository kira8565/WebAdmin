package com.xstudio.controllers.sys;

import com.xstudio.controllers.framework.BaseController;
import com.xstudio.dao.sys.SysDictMapper;
import com.xstudio.dao.sys.SysDictMapperExtend;
import com.xstudio.models.sys.SysDict;
import com.xstudio.validator.SysDictValidator;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

/**
 * Created by kira on 16/2/28.
 * 字典管理
 */
@Controller
@RequestMapping(value = "/admin/sys/dict")
public class DictManageController extends BaseController {

    String prefix = "admin/sys/dict/";

    @Resource
    SysDictValidator sysDictValidator;

    @Resource
    SysDictMapper sysDictMapper;

    @Resource
    SysDictMapperExtend sysDictMapperExtend;

    @InitBinder
    public void initBinder(WebDataBinder binder) {
        binder.setValidator(sysDictValidator);
    }

    @PreAuthorize("hasAuthority('ROLE_SYS_DICT_LIST')")
    @RequestMapping(value = "/index")
    public String index(HttpServletRequest request, Model model) {
        simpleList(request, model, sysDictMapperExtend, false, null);
        return prefix + "index";
    }


    @PreAuthorize("hasAuthority('ROLE_SYS_DICT_ADD')")
    @RequestMapping(value = "/add")
    public String add(HttpServletRequest request, Model model,
                      @ModelAttribute("sysDict") SysDict sysDict, BindingResult result) {
        return prefix + "add";
    }


    @PreAuthorize("hasAuthority('ROLE_SYS_DICT_ADD')")
    @RequestMapping(value = "/addEntity")
    public ModelAndView addEntity(HttpServletRequest request, Model model,
                                  @Valid @ModelAttribute("sysDict") SysDict sysDict,
                                  BindingResult bindingResult,
                                  RedirectAttributes redirectAttributes) {
        return simpleAdd(bindingResult.hasErrors(), prefix,
                sysDict, "新增字段", sysDictMapper,
                redirectAttributes);
    }


    @PreAuthorize("hasAuthority('ROLE_SYS_DICT_EDIT')")
    @RequestMapping(value = "/edit")
    public String edit(HttpServletRequest request, Model model, Integer id) {
        model.addAttribute("sysDict", sysDictMapper.selectByPrimaryKey(id));
        return prefix + "edit";
    }


    @PreAuthorize("hasAuthority('ROLE_SYS_DICT_EDIT')")
    @RequestMapping(value = "/editEntity")
    public ModelAndView editEntity(HttpServletRequest request, Model model,
                                   @Valid @ModelAttribute("sysDict") SysDict sysDict,
                                   BindingResult bindingResult,
                                   RedirectAttributes redirectAttributes) {
        return simpleEdit(bindingResult.hasErrors(), prefix, sysDict, "编辑字段", sysDictMapper, redirectAttributes);
    }


    @PreAuthorize("hasAuthority('ROLE_SYS_DICT_DELETE')")
    @RequestMapping(value = "/deleteEntity")
    @ResponseBody
    public ModelAndView deleteEntity(HttpServletRequest request, Model model,
                                     Integer id, String limit, String offset,
                                     RedirectAttributes redirectAttributes) {
        return simpleDelete(prefix, "删除字段", sysDictMapper, id, redirectAttributes, limit, offset);
    }
}
