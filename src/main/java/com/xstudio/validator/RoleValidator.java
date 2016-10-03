package com.xstudio.validator;

import com.xstudio.models.sys.SysRole;
import com.xstudio.utilities.ValidationUtility;
import org.springframework.stereotype.Repository;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

/**
 * Created by kira on 2016/5/10.
 */
@Repository

public class RoleValidator implements Validator {
    @Override
    public boolean supports(Class<?> aClass) {
        return true;
    }

    @Override
    public void validate(Object object, Errors errors) {
        SysRole sysRole = (SysRole) object;
        ValidationUtility.rejectBlank(sysRole.getName(), errors, "name", "sysRole.name.required", "角色名称不可为空");
    }
}
