package com.xstudio.interceptor;

import com.xstudio.dao.sys.SysMenuMapper;
import com.xstudio.dao.sys.SysMenuMapperExtend;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Created by wuwenhao on 16/4/29.
 */
public class MenuInitHandler implements AuthenticationSuccessHandler {
    @Resource
    SysMenuMapper sysMenuMapper;

    @Resource
    SysMenuMapperExtend sysMenuMapperExtend;


    @Override
    public void onAuthenticationSuccess(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Authentication authentication) throws IOException, ServletException {
        httpServletRequest.getSession().setAttribute("_menus", sysMenuMapperExtend.findUserMenus());

        httpServletResponse.sendRedirect(httpServletRequest.getContextPath() + "/admin/index");
    }
}
