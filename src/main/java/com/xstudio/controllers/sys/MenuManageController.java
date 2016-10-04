package com.xstudio.controllers.sys;

import com.xstudio.controllers.framework.BaseController;
import com.xstudio.dao.sys.SysMenuMapper;
import com.xstudio.dao.sys.SysMenuMapperExtend;
import com.xstudio.models.sys.SysMenu;
import com.xstudio.models.sys.SysMenuExample;
import com.xstudio.utilities.CommonUtility;
import com.xstudio.validator.MenuValidator;
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
import java.util.HashMap;
import java.util.List;

/**
 * Created by kira on 16/2/28.
 * 菜单管理
 */
@Controller
@RequestMapping(value = "/admin/sys/menus")
public class MenuManageController extends BaseController {

    @Resource
    MenuValidator menuValidator;

    @InitBinder
    public void initBinder(WebDataBinder binder) {
        binder.setValidator(menuValidator);
    }

    String prefix = "admin/sys/menus/";

    @Resource
    SysMenuMapperExtend sysMenuMapperExtend;

    @Resource
    SysMenuMapper sysMenuMapper;

    //菜单不分页
    @PreAuthorize("hasAuthority('ROLE_SYS_MENU_LIST')")
    @RequestMapping(value = "/index")
    public String index(HttpServletRequest request, Model model) {
        HashMap<String, String> map = new HashMap<>();
        map.put("n_isshow", "2");
        simpleList(request, model, sysMenuMapperExtend, false, map);
        return prefix + "index";
    }

    @PreAuthorize("hasAuthority('ROLE_SYS_MENU_ADD')")
    @RequestMapping(value = "/add")
    public String add(HttpServletRequest request, Model model,
                      @ModelAttribute("sysMenu") SysMenu sysMenu) {
        formInit(model);
        return prefix + "add";
    }


    private void formInit(Model model) {
        SysMenuExample example = new SysMenuExample();
        example.createCriteria().andParentidIsNull().andIsshowEqualTo(1);
        List<SysMenu> list = sysMenuMapper.selectByExample(example);
        model.addAttribute("parents", list);
        model.addAttribute("combo", CommonUtility.buildTrueOrFalseMap());
    }


    @PreAuthorize("hasAuthority('ROLE_SYS_MENU_ADD')")
    @RequestMapping(value = "/addEntity")
    @ResponseBody
    public ModelAndView addEntity(HttpServletRequest request, Model model,
                                  @Valid @ModelAttribute("sysMenu") SysMenu sysMenu,
                                  BindingResult bindingResult,
                                  RedirectAttributes redirectAttributes) {
        return simpleAdd(bindingResult.hasErrors(), prefix, sysMenu, "新增菜单", sysMenuMapper,
                redirectAttributes);
    }

    @PreAuthorize("hasAuthority('ROLE_SYS_MENU_EDIT')")
    @RequestMapping(value = "/edit")
    public String edit(HttpServletRequest request, Model model, Integer id) {
        formInit(model);
        model.addAttribute("sysMenu", sysMenuMapper.selectByPrimaryKey(id));
        return prefix + "edit";
    }


    @PreAuthorize("hasAuthority('ROLE_SYS_MENU_EDIT')")
    @RequestMapping(value = "/editEntity")
    public ModelAndView editEntity(HttpServletRequest request, Model model, SysMenu sysMenu,
                                   BindingResult bindingResult,
                                   RedirectAttributes redirectAttributes) {
        return simpleEdit(bindingResult.hasErrors(), prefix, sysMenu, "编辑菜单", sysMenuMapper,
                redirectAttributes);
    }


    @PreAuthorize("hasAuthority('ROLE_SYS_MENU_DELETE')")
    @RequestMapping(value = "/deleteEntity")
    public ModelAndView deleteEntity(HttpServletRequest request, Model model,
                                     Integer id, RedirectAttributes redirectAttributes,
                                     String limit, String offset) {
        return simpleDelete(prefix, "删除菜单", sysMenuMapper, id, redirectAttributes, limit,
                offset);
    }

}
