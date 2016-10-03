package com.xstudio.utilities;

import com.xstudio.dao.sys.SysDictMapper;
import com.xstudio.dao.sys.SysLogMapper;
import com.xstudio.models.sys.SysDictExample;
import com.xstudio.models.sys.SysLog;
import com.xstudio.mybatis.Pagination;
import freemarker.cache.StringTemplateLoader;
import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;
import org.activiti.engine.TaskService;
import org.activiti.engine.task.Task;
import org.apache.commons.io.IOUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.BeanUtils;
import org.springframework.core.convert.support.DefaultConversionService;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.ui.Model;
import org.springframework.util.ReflectionUtils;
import org.springframework.util.StringUtils;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import java.io.BufferedInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.StringWriter;
import java.lang.reflect.Field;
import java.sql.Blob;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.Map.Entry;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class CommonUtility {

    public static void logEvent(String event) {
        Thread thread = new Thread(() -> {
            SysLogMapper sysLogMapper = SpringContainerUtility.context.getBean(SysLogMapper.class);
            SysLog sysLog = new SysLog();
            sysLog.setLog(event);
            sysLog.setOperateTime(new Date());
            sysLog.setOperator(getUserInfo());
            sysLogMapper.insertSelective(sysLog);
        });
        thread.run();
    }

    public static String getUserInfo() {
        UserDetails userDetails = (UserDetails) SecurityContextHolder.getContext()
                .getAuthentication()
                .getPrincipal();
        return userDetails.getUsername();
    }

    public static long getMonthBetween(String startDate, String endDate) {
        SimpleDateFormat f = new SimpleDateFormat("yyyy-MM");
        long monthday;
        try {
            Date startDate1 = f.parse(startDate);
            //开始时间与今天相比较
            Date endDate1 = f.parse(endDate);

            Calendar starCal = Calendar.getInstance();
            starCal.setTime(startDate1);

            int sYear = starCal.get(Calendar.YEAR);
            int sMonth = starCal.get(Calendar.MONTH);
            int sDay = starCal.get(Calendar.DATE);

            Calendar endCal = Calendar.getInstance();
            endCal.setTime(endDate1);
            int eYear = endCal.get(Calendar.YEAR);
            int eMonth = endCal.get(Calendar.MONTH);
            int eDay = endCal.get(Calendar.DATE);

            monthday = ((eYear - sYear) * 12 + (eMonth - sMonth));

            if (sDay < eDay) {
                monthday = monthday + 1;
            }
            return monthday;
        } catch (ParseException e) {
            monthday = 0;
        }
        return monthday;
    }


    public static Pagination getPagination(HttpServletRequest request,
                                           Model model) {
        String offset = request.getParameter("offset");
        String limit = request.getParameter("limit");
        int off = StringUtils.isEmpty(offset) ? 0 : Integer.parseInt(offset);
        int lim = StringUtils.isEmpty(limit) ? 50 : Integer.parseInt(limit);

        return new Pagination(off, lim);
    }


    public static Pagination getFrontPagination(HttpServletRequest request,
                                                Model model) {
        String offset = request.getParameter("offset");
        String limit = request.getParameter("limit");
        int off = StringUtils.isEmpty(offset) ? 0 : Integer.parseInt(offset);
        int lim = StringUtils.isEmpty(limit) ? 10 : Integer.parseInt(limit);

        return new Pagination(off, lim);
    }

    public static String getLogPath(HttpServletRequest request) {
        return request.getSession().getServletContext().getRealPath("/static/upload/");
    }

    public static void renderGridData(HttpServletRequest request, Model model,
                                      List<LinkedHashMap<String, Object>> list, Pagination pagination) {
        model.addAttribute("result", list);

        String offset = request.getParameter("offset");
        String limit = request.getParameter("limit");
        int off = StringUtils.isEmpty(offset) ? 0 : Integer.parseInt(offset);
        int lim = StringUtils.isEmpty(limit) ? 10 : Integer.parseInt(limit);
        model.addAttribute("limit", lim);
        model.addAttribute("currentpage", (off / lim) + 1);

        if (pagination.getTotal() <= lim) {
            model.addAttribute("total", 1);
        }
        if (pagination.getTotal() > lim) {
            int num = pagination.getTotal() / lim;
            if (num == 1) {
                model.addAttribute("total", "2");
            } else {
                model.addAttribute("total", pagination.getTotal() / lim);
            }
        }
        model.addAttribute("all", pagination.getTotal());
    }

    public static HashMap<String, String> getParameterMap(
            HttpServletRequest request) {
        // 参数Map
        Map properties = request.getParameterMap();
        // 返回值Map
        Map returnMap = new HashMap();
        Iterator entries = properties.entrySet().iterator();
        Entry entry;
        String name = "";
        String value = "";
        while (entries.hasNext()) {
            entry = (Entry) entries.next();
            name = (String) entry.getKey();
            Object valueObj = entry.getValue();
            if (null == valueObj) {
                value = "";
            } else if (valueObj instanceof String[]) {
                String[] values = (String[]) valueObj;
                for (int i = 0; i < values.length; i++) {
                    value = values[i] + ",";
                }
                value = value.substring(0, value.length() - 1);
            } else {
                value = valueObj.toString();
            }
            returnMap.put(name, value);
        }
        return (HashMap<String, String>) returnMap;
    }

    /**
     * 将参数集合转换为实体类
     *
     * @param params HttpServletRequest.getParameterMap()
     * @param clazz
     * @return
     */
    public static <T> T parse(Map<String, String[]> params, Class<T> clazz) {
        T target = BeanUtils.instantiate(clazz);
        Iterator<Entry<String, String[]>> it = params.entrySet().iterator();
        while (it.hasNext()) {
            Entry<String, String[]> e = it.next();
            Field field = ReflectionUtils.findField(clazz, e.getKey());
            if (field == null)
                continue;
            Class<?> targetType = field.getType();
            Object value = convert(e.getValue(), targetType);
            if (value == null)
                continue;
            ReflectionUtils.makeAccessible(field);
            ReflectionUtils.setField(field, target, value);
        }
        return target;
    }

    /**
     * 将字符串转换成为原始数据类型
     *
     * @param source
     * @param targetType
     * @return
     */
    public static <T> T convert(String[] source, Class<T> targetType) {
        // 空字符串或非原始数据类型不予转换
        boolean special = (source.length == 1 && !StringUtils
                .hasText(source[0]));
        DefaultConversionService conversion = new DefaultConversionService();
        return special ? null : conversion.convert(source, targetType);
    }

    /**
     * 将字符串转换成为原始数据类型
     *
     * @param source
     * @param targetType
     * @return
     */
    public static <T> T convert(String source, Class<T> targetType) {
        // 空字符串或非原始数据类型不予转换
        boolean special = (!StringUtils.hasText(source));
        DefaultConversionService conversion = new DefaultConversionService();
        return special ? null : conversion.convert(source, targetType);
    }

    public static HashMap<String, String> getParamasToMap(
            HttpServletRequest request, String... param) {
        HashMap<String, String> hashMap = new HashMap<String, String>();
        Enumeration<String> enumeration = request.getParameterNames();
        while (enumeration.hasMoreElements()) {
            String string = (String) enumeration.nextElement();
            if (org.apache.commons.lang.StringUtils.isNotBlank(request
                    .getParameter(string))) {
                hashMap.put(string, request.getParameter(string));
            }
        }
        return hashMap;
    }

    public static String getValueToString(HashMap<String, String> hashMap,
                                          String... key) {
        for (String string : key) {
            if (hashMap.containsKey(string)) {
                return hashMap.get(string).toString();
            }
        }
        return "";

    }

    /**
     * 获取用户待的流程
     *
     * @param taskService
     * @param user
     * @param role
     * @return
     */
    public static String getCurrentUserTask(TaskService taskService,
                                            String user, String role) {
        List<Task> userTasks = taskService.createTaskQuery().taskAssignee(user)
                .list();

        List<Task> roleTasks = taskService.createTaskQuery()
                .taskCandidateGroup(role).list();

        String str = "";
        for (Task task : roleTasks) {
            str += task.getId() + ",";
        }

        for (Task task : userTasks) {
            str += task.getId() + ",";
        }

        if (org.apache.commons.lang.StringUtils.isNotBlank(str)) {
            str = str.substring(0, str.length() - 1);
        }
        return str;
    }

    public static String getUserViaSession(HttpServletRequest request) {
        return request.getSession().getAttribute("user")
                .toString();
    }

    public static String generateDynamicTemplate(String emailContent,
                                                 HashMap<String, Object> map) throws IOException,
            TemplateException {
        Configuration cfg = new Configuration();
        StringTemplateLoader sTmpLoader = new StringTemplateLoader();
        String id = UUID.randomUUID().toString();
        sTmpLoader.putTemplate(id, emailContent);
        cfg.setTemplateLoader(sTmpLoader);
        cfg.setDefaultEncoding("UTF-8");
        Template template = cfg.getTemplate(id);
        StringWriter writer = new StringWriter();
        template.process(map, writer);
        return writer.toString();
    }

    public static byte[] blobToBytes(Blob blob) {
        BufferedInputStream is = null;
        try {
            is = new BufferedInputStream(blob.getBinaryStream());
            byte[] bytes = new byte[(int) blob.length()];
            int len = bytes.length;
            int offset = 0;
            int read = 0;
            while (offset < len
                    && (read = is.read(bytes, offset, len - offset)) >= 0) {
                offset += read;
            }
            return bytes;
        } catch (Exception e) {
            return null;
        } finally {
            try {
                is.close();
                is = null;
            } catch (IOException e) {
                return null;
            }

        }
    }

    public static String inputStream2String(InputStream is) throws IOException {
        return IOUtils.toString(is, "UTF-8");
    }


    public static boolean checkEmail(String email) {

        Pattern pattern = Pattern.compile("^/w+([-.]/w+)*@/w+([-]/w+)*/.(/w+([-]/w+)*/.)*[a-z]{2,3}$");
        Matcher matcher = pattern.matcher(email);
        if (matcher.matches()) {
            return true;
        }
        return false;
    }

    public static boolean isIp(String text) {
        if (text != null && !text.isEmpty()) {
            // 定义正则表达式
            String regex = "^(1\\d{2}|2[0-4]\\d|25[0-5]|[1-9]\\d|[1-9])\\."
                    + "(1\\d{2}|2[0-4]\\d|25[0-5]|[1-9]\\d|\\d)\\."
                    + "(1\\d{2}|2[0-4]\\d|25[0-5]|[1-9]\\d|\\d)\\."
                    + "(1\\d{2}|2[0-4]\\d|25[0-5]|[1-9]\\d|\\d)$";
            if (text.matches(regex)) {
                return true;
            } else {
                return false;
            }
        }
        return false;
    }


    public static HashMap buildTrueOrFalseMap() {
        LinkedHashMap<Integer, String> states = new LinkedHashMap<Integer, String>();
        states.put(1, "否");
        states.put(0, "是");
        return states;
    }

    public static ModelAndView commonAdd(Boolean hasError,
                                         String prefix,
                                         Object object,
                                         String logTitle,
                                         Object mapper,
                                         RedirectAttributes redirectAttributes,
                                         Logger logger,
                                         String key) {
        if (hasError) {
            return new ModelAndView(prefix + "add");
        } else {
            ModelAndView modelAndView = new ModelAndView();
            try {
//                object.getClass().getDeclaredMethod("setCreatetime", Date.class).invoke(object, new Date());
//                object.getClass().getDeclaredMethod("setCreator", String.class).invoke(object, CommonUtility.getUserInfo());

//                CommonUtility.logEvent("[" + logTitle + "]" + new Gson().toJson(object));
                mapper.getClass().getDeclaredMethod("insertSelective", object.getClass()).invoke(mapper, object);
                redirectAttributes.addFlashAttribute(ConstantUtility.FLASH_SUCCESS_MESSAEG, ConstantUtility.CREATE_SUCCESS);
            } catch (Exception ex) {
                redirectAttributes.addFlashAttribute(ConstantUtility.FLASH_ERROR_MESSAEG, ConstantUtility.CREATE_FAIL);
                logger.error(ex.getMessage());
            }
            modelAndView.setViewName("redirect:/" + prefix + "index?key=" + key);

            return modelAndView;
        }
    }

    public static ModelAndView commonEdit(Boolean hasError,
                                          String prefix,
                                          Object object,
                                          String logTitle,
                                          Object mapper,
                                          RedirectAttributes redirectAttributes,
                                          Logger logger,
                                          String key) {
        if (hasError) {
            return new ModelAndView(prefix + "edit");
        } else {
            ModelAndView modelAndView = new ModelAndView();
            try {
//                object.getClass().getDeclaredMethod("setUpdatetime", Date.class).invoke(object, new Date());
//                object.getClass().getDeclaredMethod("setUpdator", String.class).invoke(object, CommonUtility.getUserInfo());

//                CommonUtility.logEvent("[" + logTitle + "]" + new Gson().toJson(object));
                mapper.getClass().getDeclaredMethod("updateByPrimaryKeySelective", object.getClass()).invoke(mapper, object);
                redirectAttributes.addFlashAttribute(ConstantUtility.FLASH_SUCCESS_MESSAEG, ConstantUtility.UPDATE_SUCCESS);
            } catch (Exception ex) {
                redirectAttributes.addFlashAttribute(ConstantUtility.FLASH_ERROR_MESSAEG, ConstantUtility.UPDATE_FAIL);
                logger.error(ex.getMessage());
            }
            modelAndView.setViewName("redirect:/" + prefix + "index?key=" + key);

            return modelAndView;
        }
    }

    public static ModelAndView commonDelete(String prefix, String logTitle, Object mapper,
                                            Integer id, RedirectAttributes redirectAttributes,
                                            String limit, String offset, Logger logger,
                                            String key) {
        ModelAndView modelAndView = new ModelAndView();
        try {
//            Object object=mapper.getClass().getDeclaredMethod("selectByPrimaryKey", Integer.class).invoke(mapper, id);
//            CommonUtility.logEvent("[" + logTitle + "]" + new Gson().toJson(object));

            mapper.getClass().getDeclaredMethod("deleteByPrimaryKey", Integer.class).invoke(mapper, id);
            redirectAttributes.addFlashAttribute(ConstantUtility.FLASH_SUCCESS_MESSAEG, ConstantUtility.DELETE_SUCCESS);
        } catch (Exception ex) {
            redirectAttributes.addFlashAttribute(ConstantUtility.FLASH_ERROR_MESSAEG, ConstantUtility.DELETE_FAIL);
            logger.error(ex.getMessage());
        }
        if (limit.equals("0") && offset.equals("0")) {
            modelAndView.setViewName("redirect:/" + prefix + "index?key=" + key);
        } else {
            modelAndView.setViewName("redirect:/" + prefix + "index?limit=" + limit + "&offset=" + offset + "&key=" + key);
        }

        return modelAndView;
    }

//    public static void completeWorkflow(TaskService taskService, ActRuTaskMapper taskMapper, String workflowid, HashMap<String, Object> map) {
//
//        ActRuTaskExample taskExample = new ActRuTaskExample();
//        String taskId = "";
//        try {
//            logger.info("Wfid====>" + workflowid);
//            taskExample.createCriteria().andExecutionIdEqualTo(String.valueOf(workflowid));
//            taskId = taskMapper.selectByExample(taskExample).get(0)
//                    .getId();
//            taskService.complete(taskId, map);
//        } catch (Exception ex) {
//            ex.printStackTrace();
//        }
//    }


    /**
     * 根据字典表的键获取值
     *
     * @param key
     * @return
     */
    public static String getDictValue(String key) {
        SysDictExample example = new SysDictExample();
        example.createCriteria().andDictkeyEqualTo(key);
        return SpringContainerUtility.context.getBean(SysDictMapper.class)
                .selectByExample(example).get(0).getDictvalues();
    }

//    public static MetaModel loadFrameWorkMetaResource(String key) {
//        try {
//            File file = ResourceUtils.getFile("classpath:metaconfigs/" + key + ".json");
//            String content = FileUtils.readFileToString(file);
//            return JSON.parseObject(content, MetaModel.class);
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//        return null;
//    }


}
