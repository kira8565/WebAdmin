package com.xstudio.controllers.sys;

import com.xstudio.dao.sys.*;
import com.xstudio.models.sys.*;
import com.xstudio.mybatis.Pagination;
import com.xstudio.utilities.CommonUtility;
import com.xstudio.utilities.ConstantUtility;
import com.xstudio.validator.RoleValidator;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
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
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

/**
 * Created by kira on 16/2/28.
 * 角色管理
 */
@Controller
@RequestMapping(value = "/admin/sys/roles")
public class RoleManageController {

    private Logger logger = Logger.getLogger(RoleManageController.class);

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
        Pagination pagination = CommonUtility.getPagination(request, model);
        HashMap<String, String> map = CommonUtility.getParameterMap(request);
        CommonUtility.renderGridData(request, model,
                sysRoleMapperExtend.all(pagination, map),
                pagination);

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
        return CommonUtility.commonAdd(false, prefix, sysRole, "新增角色", sysRoleMapper, redirectAttributes, logger, "");
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
        return CommonUtility.commonEdit(false, prefix, sysRole, "编辑角色", sysRoleMapper, redirectAttributes, logger, "");
    }

    @PreAuthorize("hasAuthority('ROLE_SYS_ROLE_DELETE')")
    @RequestMapping(value = "/deleteEntity")
    public ModelAndView deleteEntity(HttpServletRequest request, Model model, Integer id,
                                     RedirectAttributes redirectAttributes, String limit, String offset) {
        return CommonUtility.commonDelete(prefix, "删除角色", sysRoleMapper, id, redirectAttributes, limit, offset, logger, "");
    }


    @Resource
    SysRoleUserMapper sysRoleUserMapper;

    @Resource
    SysUserMapper sysUserMapper;

    @PreAuthorize("hasAuthority('ROLE_SYS_ROLE_CONFIGUSER')")
    @RequestMapping(value = "/configUser")
    public String configUser(HttpServletRequest request, Model model, Integer id,
                             RedirectAttributes redirectAttributes) {
        model.addAttribute("list", sysUserMapper.selectByExample(null));

        SysRoleUserExample example = new SysRoleUserExample();
        example.createCriteria().andRoleidEqualTo(id);
        List<SysRoleUser> list = sysRoleUserMapper.selectByExample(example);

        List<Integer> userids = new ArrayList<>();
        list.forEach(e -> {
            userids.add(e.getUserid());
        });

        //当前角色用户ID不为空才去获取已选用户信息
        List<SysUser> userList = new ArrayList<>();
        if (!userids.isEmpty()) {
            SysUserExample userExample = new SysUserExample();
            userExample.createCriteria().andIdIn(userids);
            userList = sysUserMapper.selectByExample(userExample);
        }

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

    @PreAuthorize("hasAuthority('ROLE_SYS_ROLE_CONFIGMENU')")
    @RequestMapping(value = "/configMenu")
    public String configMenu(HttpServletRequest request, Model model, Integer id) {
        SysMenuExample menuExample = new SysMenuExample();
        menuExample.createCriteria().andIsshowEqualTo(1);
        model.addAttribute("list", sysMenuMapper.selectByExample(menuExample));

        SysRoleMenuExample example = new SysRoleMenuExample();
        example.createCriteria().andRoleidEqualTo(id);
        List<SysRoleMenu> list = sysRoleMenuMapper.selectByExample(example);

        List<Integer> menuids = new ArrayList<>();
        list.forEach(e -> {
            menuids.add(e.getMenuid());
        });

        List<SysMenu> menus = new ArrayList<>();
        if (menuids.size() > 0) {
            SysMenuExample sysMenuExample = new SysMenuExample();
            sysMenuExample.createCriteria().andIdIn(menuids);
            menus = sysMenuMapper.selectByExample(sysMenuExample);
        }

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
