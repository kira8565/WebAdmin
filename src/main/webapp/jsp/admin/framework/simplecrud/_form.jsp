<%@ page language="java" pageEncoding="utf-8" %>
<%@ include file="/WEB-INF/include/taglib.jsp" %>
<app:hiddenInput id="key" value="${param.key}"></app:hiddenInput>
<form:hidden path="id"></form:hidden>
<c:forEach var="vo" items="${metaModel.formConfig}">
    <c:if test="${vo.inputType=='input'}">
        <app:s_input labelName="${vo.labelName}" path="${vo.key}"></app:s_input>
    </c:if>
</c:forEach>

