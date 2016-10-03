package com.xstudio.controllers.framework;

import java.util.LinkedHashMap;
import java.util.List;

/**
 * Created by kira on 16/8/21.
 */
public class MetaModel {
    private String entityName;

    private String entityPrefix;

    private List<LinkedHashMap<String, String>> columns;

    private String listTitle;

    private List<LinkedHashMap<String, String>> filters;

    private Boolean needPage;

    private List<LinkedHashMap<String, String>> formConfig;

    private String addTitle;

    private String editTitle;

    public MetaModel() {

    }


    public String getEntityName() {
        return entityName;
    }

    public void setEntityName(String entityName) {
        this.entityName = entityName;
    }

    public String getEntityPrefix() {
        return entityPrefix;
    }

    public void setEntityPrefix(String entityPrefix) {
        this.entityPrefix = entityPrefix;
    }

    public List<LinkedHashMap<String, String>> getColumns() {
        return columns;
    }

    public void setColumns(List<LinkedHashMap<String, String>> columns) {
        this.columns = columns;
    }

    public String getListTitle() {
        return listTitle;
    }

    public void setListTitle(String listTitle) {
        this.listTitle = listTitle;
    }

    public List<LinkedHashMap<String, String>> getFilters() {
        return filters;
    }

    public void setFilters(List<LinkedHashMap<String, String>> filters) {
        this.filters = filters;
    }

    public Boolean getNeedPage() {
        return needPage;
    }

    public void setNeedPage(Boolean needPage) {
        this.needPage = needPage;
    }

    public List<LinkedHashMap<String, String>> getFormConfig() {
        return formConfig;
    }

    public void setFormConfig(List<LinkedHashMap<String, String>> formConfig) {
        this.formConfig = formConfig;
    }

    public String getAddTitle() {
        return addTitle;
    }

    public void setAddTitle(String addTitle) {
        this.addTitle = addTitle;
    }

    public String getEditTitle() {
        return editTitle;
    }

    public void setEditTitle(String editTitle) {
        this.editTitle = editTitle;
    }
}
