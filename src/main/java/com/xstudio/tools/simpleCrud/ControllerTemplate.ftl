package com.xstudio.controllers;

import com.xstudio.validator.*;
import com.xstudio.dao.*;
import com.xstudio.models.*;
import com.xstudio.mybatis.Pagination;
import com.xstudio.utilities.CommonUtility;
import com.xstudio.utilities.ConstantUtility;
import com.xstudio.validator.SysDictValidator;
import org.apache.log4j.Logger;
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
import java.util.Date;
import java.util.HashMap;

/**
* Created by kira on 16/2/28.
* ${controllerDesc}管理
*/
@Controller
@RequestMapping(value = "${prefix}")
public class ${entity}Controller {
private Logger logger = Logger.getLogger(${entity}Controller.class);

String prefix = "${prefix}";

@Resource
${entity}Validator ${entityVal}Validator;

@InitBinder
public void initBinder(WebDataBinder binder) {
binder.setValidator(${entityVal}Validator);
}

@Resource
${entity}Mapper ${entityVal}Mapper;

@Resource
${entity}MapperExtend ${entityVal}MapperExtend;


@PreAuthorize("hasAuthority('${authPrefix}_LIST')")
@RequestMapping(value = "/index")
public String index(HttpServletRequest request, Model model) {
Pagination pagination = new Pagination();
HashMap
<String, String> map = CommonUtility.getParameterMap(request);
CommonUtility.renderGridData(request, model,
${entityVal}MapperExtend.all(pagination, map),
pagination);

return prefix + "index";
}


@PreAuthorize("hasAuthority('${authPrefix}_ADD')")
@RequestMapping(value = "/add")
public String add(HttpServletRequest request, Model model,
@ModelAttribute("${entityVal}") ${entity} ${entityVal}, BindingResult result) {
return prefix + "add";
}


@PreAuthorize("hasAuthority('${authPrefix}_ADD')")
@RequestMapping(value = "/addEntity")
public ModelAndView addEntity(HttpServletRequest request, Model model,
@Valid @ModelAttribute("${entityVal}") ${entity} ${entityVal},
BindingResult bindingResult,
RedirectAttributes redirectAttributes) {
return CommonUtility.commonAdd(bindingResult, prefix, ${entityVal}, "新增${controllerDesc}", ${entityVal}Mapper, redirectAttributes, logger);
}


@PreAuthorize("hasAuthority('${authPrefix}_EDIT')")
@RequestMapping(value = "/edit")
public String edit(HttpServletRequest request, Model model, Integer id) {
model.addAttribute("${entityVal}", ${entityVal}Mapper.selectByPrimaryKey(id));
return prefix + "edit";
}


@PreAuthorize("hasAuthority('${authPrefix}_EDIT')")
@RequestMapping(value = "/editEntity")
public ModelAndView editEntity(HttpServletRequest request, Model model,
@Valid @ModelAttribute("${entityVal}") ${entity} ${entityVal},
BindingResult bindingResult,
RedirectAttributes redirectAttributes) {
return CommonUtility.commonEdit(bindingResult, prefix, ${entityVal}, "编辑${controllerDesc}", ${entityVal}Mapper, redirectAttributes, logger);
}


@PreAuthorize("hasAuthority('${authPrefix}_DELETE')")
@RequestMapping(value = "/deleteEntity")
@ResponseBody
public ModelAndView deleteEntity(HttpServletRequest request, Model model,
Integer id, String limit, String offset,
RedirectAttributes redirectAttributes) {
return CommonUtility.commonDelete(prefix, "删除${controllerDesc}", ${entityVal}Mapper, id, redirectAttributes, limit, offset, logger);
}
}
