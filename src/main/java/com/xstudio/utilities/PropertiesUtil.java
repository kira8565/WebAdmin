package com.xstudio.utilities;

import java.util.Properties;

/**
 * Created by wuwenhao on 16/4/28.
 */
public class PropertiesUtil {
    private static String filename = "/druid.properties";
    private static Properties pro = new Properties();

    static {
        try {
            pro.load(PropertiesUtil.class.getResourceAsStream(filename));
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("Load druid.properties “" + filename + "” file error.");
        }
    }

    public static int getInt(String key) {
        int i = 0;
        try {
            i = Integer.parseInt(getString(key));
        } catch (Exception e) {
        }
        return i;
    }

    public static String getString(String key) {
        return pro == null ? null : pro.getProperty(key);
    }
}
