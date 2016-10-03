package com.xstudio.utilities;

import org.apache.commons.lang3.StringUtils;
import org.springframework.validation.Errors;

/**
 * Created by kira on 2016/5/8.
 */
public class ValidationUtility {
    public static void rejectBlank(String property, Errors errors, String key, String desc, String comment) {
        if (StringUtils.isBlank(property)) {
            errors.rejectValue(key, desc, comment);
        }
    }
}
