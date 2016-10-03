package com.xstudio.validator;

import com.xstudio.models.sys.SysMenu;
import com.xstudio.utilities.ValidationUtility;
import org.springframework.stereotype.Repository;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

/**
 * Created by kira on 2016/5/10.
 */
@Repository

public class MenuValidator implements Validator {
    @Override
    public boolean supports(Class<?> aClass) {
        return true;
    }

    @Override
    public void validate(Object object, Errors errors) {
        SysMenu sysMenu = (SysMenu) object;
        ValidationUtility.rejectBlank(sysMenu.getName(), errors, "name", "sysmenu.name.required", "菜单名称不可为空");
        ValidationUtility.rejectBlank(sysMenu.getUrls(), errors, "urls", "sysmenu.urls.required", "菜单地址不可为空");
    }
}
