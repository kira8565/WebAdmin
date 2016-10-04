package com.xstudio.controllers.sys;

import com.codahale.metrics.MetricRegistry;
import com.xstudio.controllers.framework.BaseController;
import com.xstudio.dao.sys.*;
import com.xstudio.models.sys.*;
import com.xstudio.utilities.ConstantUtility;
import com.xstudio.validator.RoleValidator;
import org.apache.commons.lang.StringUtils;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import java.util.List;

/**
 * Created by kira on 16/2/28.
 * 角色管理
 */
@Controller
@RequestMapping(value = "/admin/sys/roles")
public class RoleManageController extends BaseController {

    String prefix = "admin/sys/roles/";

    @Resource
    RoleValidator roleValidator;

    @Resource
    SysRoleMapper sysRoleMapper;

    @InitBinder
    public void initBinder(WebDataBinder binder) {
        binder.setValidator(roleValidator);
    }

    @Resource
    SysRoleMapperExtend sysRoleMapperExtend;

    @PreAuthorize("hasAuthority('ROLE_SYS_ROLE_LIST')")
    @RequestMapping(value = "/index")
    public String index(HttpServletRequest request, Model model) {
        simpleList(request, model, sysRoleMapperExtend, true, null);
        return prefix + "index";
    }

    @PreAuthorize("hasAuthority('ROLE_SYS_ROLE_ADD')")
    @RequestMapping(value = "/add")
    public String add(HttpServletRequest request, Model model, @ModelAttribute("sysRole") SysRole sysRole) {
        return prefix + "add";
    }

    @PreAuthorize("hasAuthority('ROLE_SYS_ROLE_ADD')")
    @RequestMapping(value = "/addEntity")
    public ModelAndView addEntity(HttpServletRequest request, Model model, @Valid @ModelAttribute("sysRole") SysRole sysRole,
                                  BindingResult bindingResult, RedirectAttributes redirectAttributes) {
        return simpleAdd(bindingResult.hasErrors(), prefix, sysRole, "新增角色", sysRoleMapper, redirectAttributes);
    }

    @PreAuthorize("hasAuthority('ROLE_SYS_ROLE_EDIT')")
    @RequestMapping(value = "/edit")
    public String edit(HttpServletRequest request, Model model, Integer id) {
        model.addAttribute("sysRole", sysRoleMapper.selectByPrimaryKey(id));
        return prefix + "edit";
    }

    @PreAuthorize("hasAuthority('ROLE_SYS_ROLE_EDIT')")
    @RequestMapping(value = "/editEntity")
    public ModelAndView editEntity(HttpServletRequest request, Model model, @Valid @ModelAttribute("sysRole") SysRole sysRole,
                                   BindingResult bindingResult, RedirectAttributes redirectAttributes) {
        return simpleEdit(bindingResult.hasErrors(), prefix, sysRole, "编辑角色", sysRoleMapper, redirectAttributes);
    }

    @PreAuthorize("hasAuthority('ROLE_SYS_ROLE_DELETE')")
    @RequestMapping(value = "/deleteEntity")
    public ModelAndView deleteEntity(HttpServletRequest request, Model model, Integer id,
                                     RedirectAttributes redirectAttributes, String limit, String offset) {
        return simpleDelete(prefix, "删除角色", sysRoleMapper, id, redirectAttributes, limit, offset);
    }


    @Resource
    SysRoleUserMapper sysRoleUserMapper;

    @Resource
    SysUserMapper sysUserMapper;

    @Resource
    SysUserMapperExtend sysUserMapperExtend;

    @PreAuthorize("hasAuthority('ROLE_SYS_ROLE_CONFIGUSER')")
    @RequestMapping(value = "/configUser")
    public String configUser(HttpServletRequest request, Model model, Integer id,
                             RedirectAttributes redirectAttributes) {

        model.addAttribute("list", sysUserMapper.selectByExample(null));
        List<SysUser> userList = sysUserMapperExtend.findUserByRoleId(id);

        String useridStr = "";
        for (SysUser sysUser : userList) {
            useridStr += sysUser.getId() + ",";
        }
        if (StringUtils.isNotEmpty(useridStr)) {
            useridStr = useridStr.substring(0, useridStr.length() - 1);
        }

        model.addAttribute("userids", useridStr);
        model.addAttribute("entity", sysRoleMapper.selectByPrimaryKey(id));

        return prefix + "configUser";
    }

    @PreAuthorize("hasAuthority('ROLE_SYS_ROLE_CONFIGUSER')")
    @RequestMapping(value = "/configUserAction")
    public ModelAndView configUserAction(HttpServletRequest request, Model model,
                                         Integer id, String userids, RedirectAttributes redirectAttributes) {
        try {
            SysRoleUserExample example = new SysRoleUserExample();
            example.createCriteria().andRoleidEqualTo(id);
            sysRoleUserMapper.deleteByExample(example);

            if (StringUtils.isNotBlank(userids)) {
                String[] users = userids.split(",");
                for (String user : users) {
                    SysRoleUser sysRoleUser = new SysRoleUser();
                    sysRoleUser.setRoleid(id);
                    sysRoleUser.setUserid(Integer.parseInt(user));
                    sysRoleUserMapper.insertSelective(sysRoleUser);
                }
            }
            redirectAttributes.addFlashAttribute(ConstantUtility.FLASH_SUCCESS_MESSAEG, "配置成功");
        } catch (Exception ex) {
            redirectAttributes.addFlashAttribute(ConstantUtility.FLASH_ERROR_MESSAEG, "配置失败");
            logger.error(ex.getMessage());
        }
        return new ModelAndView("redirect:/" + prefix + "index");
    }

    @Resource
    SysRoleMenuMapper sysRoleMenuMapper;

    @Resource
    SysMenuMapper sysMenuMapper;

    @Resource
    SysMenuMapperExtend sysMenuMapperExtend;

    @PreAuthorize("hasAuthority('ROLE_SYS_ROLE_CONFIGMENU')")
    @RequestMapping(value = "/configMenu")
    public String configMenu(HttpServletRequest request, Model model, Integer id) {
        SysMenuExample menuExample = new SysMenuExample();
        menuExample.createCriteria().andIsshowEqualTo(1);
        model.addAttribute("list", sysMenuMapper.selectByExample(menuExample));

        List<SysMenu> menus = sysMenuMapperExtend.findMenuByRoleID(id);
        String menusidStr = "";
        for (SysMenu sysMenu : menus) {
            menusidStr += sysMenu.getId() + ",";
        }
        if (StringUtils.isNotEmpty(menusidStr)) {
            menusidStr = menusidStr.substring(0, menusidStr.length() - 1);
        }
        model.addAttribute("menuids", menusidStr);
        model.addAttribute("entity", sysRoleMapper.selectByPrimaryKey(id));

        return prefix + "configMenu";
    }

    @Resource
    SysRoleAuthMapper sysRoleAuthMapper;

    @PreAuthorize("hasAuthority('ROLE_SYS_ROLE_CONFIGMENU')")
    @RequestMapping(value = "/configMenuAction")
    public ModelAndView configMenuAction(HttpServletRequest request, Model model,
                                         Integer id, String menuids, RedirectAttributes redirectAttributes) {
        try {
            SysRoleMenuExample example = new SysRoleMenuExample();
            example.createCriteria().andRoleidEqualTo(id);
            sysRoleMenuMapper.deleteByExample(example);

            SysRoleAuthExample roleAuthExample = new SysRoleAuthExample();
            roleAuthExample.createCriteria().andRoleidEqualTo(id);
            sysRoleAuthMapper.deleteByExample(roleAuthExample);

            List<SysMenu> menuList = sysMenuMapper.selectByExample(null);

            if (StringUtils.isNotBlank(menuids)) {
                String[] menuidStr = menuids.split(",");
                for (String s : menuidStr) {
                    SysRoleMenu sysRoleMenu = new SysRoleMenu();
                    sysRoleMenu.setMenuid(Integer.parseInt(s));
                    sysRoleMenu.setRoleid(id);
                    sysRoleMenuMapper.insertSelective(sysRoleMenu);

                    SysRoleAuth sysRoleAuth = new SysRoleAuth();
                    sysRoleAuth.setAuthname(
                            menuList.stream().filter((p) -> p.getId() == Integer.parseInt(s)).findFirst().get().getAuthname());
                    sysRoleAuth.setRoleid(id);
                    sysRoleAuthMapper.insertSelective(sysRoleAuth);
                }

                SysRoleAuth sysRoleAuth = new SysRoleAuth();
                sysRoleAuth.setAuthname(ConstantUtility.ROLE_USER);
                sysRoleAuth.setRoleid(id);
                sysRoleAuthMapper.insertSelective(sysRoleAuth);
            }
            redirectAttributes.addFlashAttribute(ConstantUtility.FLASH_SUCCESS_MESSAEG, "配置成功");
        } catch (Exception ex) {
            redirectAttributes.addFlashAttribute(ConstantUtility.FLASH_ERROR_MESSAEG, "配置失败");
            logger.error(ex.getMessage());
        }

        return new ModelAndView("redirect:/" + prefix + "index");
    }
}
