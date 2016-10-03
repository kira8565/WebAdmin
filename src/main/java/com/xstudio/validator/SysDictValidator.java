package com.xstudio.validator;

import com.xstudio.models.sys.SysDict;
import com.xstudio.utilities.ValidationUtility;
import org.springframework.stereotype.Repository;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

/**
 * Created by kira on 2016/5/8.
 */
@Repository
public class SysDictValidator implements Validator {
    @Override
    public boolean supports(Class<?> aClass) {
        return true;
    }

    @Override
    public void validate(Object object, Errors errors) {
        SysDict sysDict = (SysDict) object;
        ValidationUtility.rejectBlank(sysDict.getDictgroup(), errors, "dictgroup", "sysdict.dictgroup.required", "字典分组不可为空");
        ValidationUtility.rejectBlank(sysDict.getDictkey(), errors, "dictkey", "sysdict.dictkey.required", "字典名称不可为空");
        ValidationUtility.rejectBlank(sysDict.getDictvalues(), errors, "dictvalues", "sysdict.dictvalues.required", "字典值不可为空");
    }
}
