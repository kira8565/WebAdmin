package com.xstudio.controllers.sys;

import com.xstudio.utilities.ConstantUtility;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;

/**
 * 首页
 */
@Controller
@RequestMapping(value = "/admin")
public class MainformController {

    @PreAuthorize("hasAuthority('ROLE_SYS_MAINFORM')")
    @RequestMapping(value = "/index")
    public String index(Model model)  {
        Runtime runtime = Runtime.getRuntime();
        model.addAttribute("availableProcessors", runtime.availableProcessors());
        return "admin/index";
    }

    /**
     * 设置菜单选中状态
     * @param request
     * @param id
     * @param subid
     * @return
     */
    @RequestMapping(value = "/setMenuSession")
    @ResponseBody
    public String setMenuSession(HttpServletRequest request,
                                 String id, String subid) {
        request.getSession().setAttribute(ConstantUtility.MENU_SID, id);
        request.getSession().setAttribute(ConstantUtility.MENU_SUBSID, subid);
        return "";
    }
}
