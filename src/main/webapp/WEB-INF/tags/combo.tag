<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ tag language="java" pageEncoding="UTF-8" %>
<%@ attribute name="labelName" required="true" %>
<%@ attribute name="inputID" required="true" %>
<%@ attribute name="defaultValue" required="false" %>
<div class="col-md-6">
    <div class="form-group">
        <label>${labelName}</label>
        <select class="form-control" id="${inputID}" name="${inputID}">
            <option value="0"
                    <c:if test="${defaultValue==1}">selected="selected"</c:if>
            >否
            </option>
            <option value="1"
                    <c:if test="${defaultValue==1}">selected="selected"</c:if>
            >是
            </option>
        </select>
    </div>
</div>