package com.xstudio.controllers.sys;

import com.sun.javafx.scene.control.skin.VirtualFlow;
import com.xstudio.controllers.framework.BaseController;
import com.xstudio.dao.sys.*;
import com.xstudio.models.sys.*;
import com.xstudio.utilities.CommonUtility;
import com.xstudio.utilities.ConstantUtility;
import com.xstudio.validator.UserValidator;
import org.apache.commons.lang.StringUtils;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.authentication.encoding.Md5PasswordEncoder;
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
import java.util.List;

/**
 * Created by kira on 16/2/28.
 */
@Controller
@RequestMapping(value = "/admin/sys/users")
public class UserManageController extends BaseController {

    String prefix = "admin/sys/users/";

    @Resource
    UserValidator userValidator;

    @Resource
    SysUserMapper sysUserMapper;

    @InitBinder
    public void initBinder(WebDataBinder binder) {
        binder.setValidator(userValidator);
    }

    @Resource
    SysUserMapperExtend sysUserMapperExtend;

    @PreAuthorize("hasAuthority('ROLE_SYS_USER_LIST')")
    @RequestMapping(value = "/index")
    public String index(HttpServletRequest request, Model model) {
        initSimpleList(request, model, sysUserMapperExtend, true);
        return prefix + "index";
    }

    //TODO下次继续
    @PreAuthorize("hasAuthority('ROLE_SYS_USER_ADD')")
    @RequestMapping(value = "/add")
    public String add(HttpServletRequest request, Model model, @ModelAttribute("sysUser") SysUser sysUser) {
        SysDictExample dictExample = new SysDictExample();
        dictExample.createCriteria().andDictgroupEqualTo("sys_user:sex");
        model.addAttribute("sex", sysDictMapper.selectByExample(dictExample));
        return prefix + "add";
    }

    @Resource
    SysDictMapper sysDictMapper;

    @PreAuthorize("hasAuthority('ROLE_SYS_USER_ADD')")
    @RequestMapping(value = "/addEntity")
    public ModelAndView addEntity(HttpServletRequest request, Model model, @Valid @ModelAttribute("sysUser") SysUser sysUser,
                                  BindingResult bindingResult,
                                  RedirectAttributes redirectAttributes) {


        sysUser.setPassword(new Md5PasswordEncoder().encodePassword(sysUser.getPassword(), null));
        return CommonUtility.commonAdd(false, prefix, sysUser, "新增用户", sysUserMapper,
                redirectAttributes, logger, "");
    }

    @PreAuthorize("hasAuthority('ROLE_SYS_USER_EDIT')")
    @RequestMapping(value = "/edit")
    public String edit(HttpServletRequest request, Model model, Integer id) {
        model.addAttribute("sysUser", sysUserMapper.selectByPrimaryKey(id));
        SysDictExample dictExample = new SysDictExample();
        dictExample.createCriteria().andDictgroupEqualTo("sys_user:sex");
        model.addAttribute("sex", sysDictMapper.selectByExample(dictExample));
        return prefix + "edit";
    }

    @PreAuthorize("hasAuthority('ROLE_SYS_USER_EDIT')")
    @RequestMapping(value = "/editEntity")
    public ModelAndView editEntity(HttpServletRequest request, Model model, @Valid @ModelAttribute("sysUser") SysUser sysUser,
                                   BindingResult bindingResult, RedirectAttributes redirectAttributes) {
        if (sysUserMapper.selectByPrimaryKey(sysUser.getId()).getPassword().equals(sysUser.getPassword()) == false) {
            sysUser.setPassword(new Md5PasswordEncoder().encodePassword(sysUser.getPassword(), null));
        }
        return CommonUtility.commonEdit(false, prefix, sysUser, "编辑用户", sysUserMapper, redirectAttributes, logger, "");
    }

    @PreAuthorize("hasAuthority('ROLE_SYS_USER_DELETE')")
    @RequestMapping(value = "/deleteEntity")
    public ModelAndView deleteEntity(HttpServletRequest request, Model model, Integer id,
                                     RedirectAttributes redirectAttributes, String limit, String offset) {
        return CommonUtility.commonDelete(prefix, "删除用户", sysUserMapper, id, redirectAttributes, limit, offset, logger, "");
    }

    @Resource
    SysRoleMapper sysRoleMapper;

    @Resource
    SysRoleUserMapper sysRoleUserMapper;

    @PreAuthorize("hasAuthority('ROLE_SYS_USER_CONFIGROLE')")
    @RequestMapping(value = "/configRole")
    public String configRole(HttpServletRequest request, Model model, Integer id) {
        model.addAttribute("list", sysRoleMapper.selectByExample(null));

        SysRoleUserExample example = new SysRoleUserExample();
        example.createCriteria().andUseridEqualTo(id);
        List<SysRoleUser> list = sysRoleUserMapper.selectByExample(example);

        List<Integer> roleids = new ArrayList<>();
        list.forEach(e -> {
            roleids.add(e.getRoleid());
        });

        List<SysRole> roleList = new VirtualFlow.ArrayLinkedList<>();
        if (roleids.size() > 0) {
            SysRoleExample sysRoleExample = new SysRoleExample();
            sysRoleExample.createCriteria().andIdIn(roleids);
            roleList = sysRoleMapper.selectByExample(sysRoleExample);
        }


        String roleidStr = "";
        for (SysRole sysRole : roleList) {
            roleidStr += sysRole.getId() + ",";
        }
        if (StringUtils.isNotEmpty(roleidStr)) {
            roleidStr = roleidStr.substring(0, roleidStr.length() - 1);
        }
        model.addAttribute("roleids", roleidStr);
        model.addAttribute("entity", sysUserMapper.selectByPrimaryKey(id));


        return prefix + "configRole";
    }

    @PreAuthorize("hasAuthority('ROLE_SYS_USER_CONFIGROLE')")
    @RequestMapping(value = "/configRoleAction")
    public ModelAndView configRoleAction(HttpServletRequest request, Model model,
                                         Integer id, String roleids, RedirectAttributes redirectAttributes) {
        try {
            SysRoleUserExample example = new SysRoleUserExample();
            example.createCriteria().andUseridEqualTo(id);
            sysRoleUserMapper.deleteByExample(example);

            if (StringUtils.isNotEmpty(roleids)) {
                String[] roles = roleids.split(",");
                for (String role : roles) {
                    SysRoleUser sysRoleUser = new SysRoleUser();
                    sysRoleUser.setRoleid(Integer.parseInt(role));
                    sysRoleUser.setUserid(id);
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
}
