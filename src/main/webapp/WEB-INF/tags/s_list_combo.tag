<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ tag language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ attribute name="labelName" required="true" %>
<%@ attribute name="path" required="true" %>
<%@ attribute name="items" required="false" type="java.util.List" %>
<%@ attribute name="itemLabel" required="true" %>
<%@ attribute name="itemValue" required="true" %>
<%@ attribute name="canBlank" required="false"  type="java.lang.Boolean" %>
<div class="col-md-6">
    <div class="form-group">
        <label>${labelName}</label>
        <form:select path="${path}" cssClass="form-control">
            <c:if test="${canBlank}">
                <form:option value="" label="请选择"/>
            </c:if>
            <form:options items="${items}" itemLabel="${itemLabel}" itemValue="${itemValue}"></form:options>
        </form:select>
    </div>
</div>