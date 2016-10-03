package com.xstudio.tools;

import com.xstudio.utilities.CommonUtility;
import freemarker.template.TemplateException;
import org.apache.commons.codec.binary.StringUtils;
import org.apache.commons.io.FileUtils;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;

/**
 * Created by kira on 16/8/9.
 */
public class TemplateGenerator {
    public static void main(String[] args) throws IOException, TemplateException {
        String path = "/Users/kira/Documents/product/WebAdmin/src/main/java/com/xstudio/";
        String mapperPath = "/Users/kira/Documents/product/WebAdmin/src/main/resources/mappers/";
        String jspPath = "/Users/kira/Documents/product/WebAdmin/src/main/webapp/jsp/";

        String entity = "WxPublicservice";
        String controllerDesc = "公众号";
        String prefix = "/admin/wx/publicmanager";
        String authPrefix = "ROLE_WX_Public_";

        HashMap<String, Object> map = new HashMap<>();
        map.put("controllerDesc", controllerDesc);
        map.put("prefix", prefix);
        map.put("authPrefix", authPrefix);
        map.put("entity", entity);
        map.put("entityVal", org.apache.commons.lang3.StringUtils.uncapitalize(entity));
//
//        String content = CommonUtility.generateDynamicTemplate(FileUtils.readFileToString(new File(path + "tools/simpleCrud/ControllerTemplate.ftl")), map);
//        System.out.println(content);

        // 生成MapperExtend
        String content = CommonUtility.generateDynamicTemplate(FileUtils.readFileToString(new File(path + "tools/simpleCrud/ExtendMapper.ftl")), map);
        FileUtils.writeStringToFile(new File(path + "dao/" + entity + "MapperExtend.java"), content);

        //生成对应的MapperExtend
        content = CommonUtility.generateDynamicTemplate(FileUtils.readFileToString(new File(path + "tools/simpleCrud/MapperExtend.ftl")), map);
        FileUtils.writeStringToFile(new File(mapperPath + entity + "MapperExtend.xml"), content);

        content = CommonUtility.generateDynamicTemplate(FileUtils.readFileToString(new File(path + "tools/simpleCrud/Validator.ftl")), map);
        FileUtils.writeStringToFile(new File(path + "validator/"  + entity + "Validator.java"), content);

        content = CommonUtility.generateDynamicTemplate(FileUtils.readFileToString(new File(path + "tools/simpleCrud/ControllerTemplate.ftl")), map);
        FileUtils.writeStringToFile(new File(path + "controllers/"  + entity + "Controller.java"), content);

        content = CommonUtility.generateDynamicTemplate(FileUtils.readFileToString(new File(path + "tools/simpleCrud/index.ftl")), map);
        FileUtils.writeStringToFile(new File(jspPath+"/"+prefix+"/index.jsp"), content);

        content = CommonUtility.generateDynamicTemplate(FileUtils.readFileToString(new File(path + "tools/simpleCrud/add.ftl")), map);
        FileUtils.writeStringToFile(new File(jspPath+"/"+prefix+"/add.jsp"), content);

        content = CommonUtility.generateDynamicTemplate(FileUtils.readFileToString(new File(path + "tools/simpleCrud/edit.ftl")), map);
        FileUtils.writeStringToFile(new File(jspPath+"/"+prefix+"/edit.jsp"), content);

        content = CommonUtility.generateDynamicTemplate(FileUtils.readFileToString(new File(path + "tools/simpleCrud/_form.ftl")), map);
        FileUtils.writeStringToFile(new File(jspPath+"/"+prefix+"/_form.jsp"), content);
    }
}
