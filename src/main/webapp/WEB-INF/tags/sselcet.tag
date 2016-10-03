<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ tag language="java" pageEncoding="UTF-8" %>
<%@ attribute name="labelName" required="true" %>
<%@ attribute name="inputID" required="true" %>
<%@ attribute name="list" required="true" type="java.util.ArrayList" %>
<%@ attribute name="defaultValue" required="false" %>
<%@ attribute name="canNone" required="false" %>
<div class="col-md-6">
    <div class="form-group">
        <label>${labelName}</label>
        <select class="form-control" id="${inputID}" name="${inputID}">
            <c:if test="${empty canNone}">
                <option value=""
                        <c:if test="${empty defaultValue}">selected="selected"</c:if> >请选择
                </option>
            </c:if>
            <c:forEach items="${list}" var="vo">
                <option value="${vo.id}"
                        <c:if test="${defaultValue==vo.id}">selected="selected"</c:if>
                >${vo.name}</option>
            </c:forEach>
        </select>
    </div>
</div>