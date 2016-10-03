<%@ page language="java" pageEncoding="utf-8" %>
<%@ include file="/WEB-INF/include/taglib.jsp"%>
<%--TODO ComboBox--%>
<form:hidden path="id"></form:hidden>
<app:s_list_combo canBlank="${true}" labelName="上级菜单" path="parentid" items="${parents}" itemLabel="name" itemValue="id"></app:s_list_combo>
<app:s_input labelName="菜单名称" path="name"></app:s_input>
<app:s_input labelName="菜单排序" path="orders"></app:s_input>
<app:s_input labelName="菜单图标" path="icons"></app:s_input>
<app:s_input labelName="菜单地址" path="urls"></app:s_input>
<app:s_tof_combo labelName="是否隐藏" path="isshow" items="${combo}"></app:s_tof_combo>
<app:s_input labelName="权限注解" path="authname"></app:s_input>

