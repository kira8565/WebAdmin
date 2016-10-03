<%@ page language="java" pageEncoding="utf-8" %>
<%@ include file="/WEB-INF/include/taglib.jsp"%>

<form:hidden path="id"></form:hidden>
<app:hiddenInput id="enabled" value="1"></app:hiddenInput>
<app:s_input labelName="用户昵称" path="name"></app:s_input>
<app:s_input labelName="用户名称" path="accounts"></app:s_input>
<app:s_password labelName="用户密码" path="password"></app:s_password>
<app:s_input labelName="用户备注" path="comment"></app:s_input>
<app:s_input labelName="联系方式" path="tel"></app:s_input>
<app:s_list_combo labelName="性别" path="sex" items="${sex}" itemLabel="dictkey" itemValue="dictvalues"></app:s_list_combo>
