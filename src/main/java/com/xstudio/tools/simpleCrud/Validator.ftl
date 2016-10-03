package com.xstudio.validator;

import com.xstudio.models.${entity};
import com.xstudio.utilities.ValidationUtility;
import org.springframework.stereotype.Repository;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

/**
* Created by kira on 2016/5/10.
*/
@Repository

public class ${entity}Validator implements Validator {
@Override
public boolean supports(Class<?> aClass) {
return true;
}

@Override
public void validate(Object object, Errors errors) {
${entity} ${entityVal} = (${entity}) object;
//ValidationUtility.rejectBlank(sysUser.getName(), errors, "name", "sysUser.name.required", "用户名称不可为空");
}
}
