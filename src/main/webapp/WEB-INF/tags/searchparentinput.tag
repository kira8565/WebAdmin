<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ tag language="java" pageEncoding="UTF-8" %>
<%@ attribute name="labelName" required="true" %>
<%@ attribute name="inputID" required="true" %>
<%@ attribute name="defaultValue" required="false" %>
<%@ attribute name="list" required="true" type="java.util.ArrayList" %>
<label for="parentid" class="col-sm-2 control-label">${labelName}</label>

<div class="col-xs-2">
    <select name="parentid" id="parentid" class="form-control">
        <option value="">请选择</option>
        <c:forEach items="${list}" var="vo">
            <option <c:if test="${defaultValue==vo.id}">selected="selected"</c:if> value="${vo.id}">${vo.name}</option>
        </c:forEach>
    </select>
</div>