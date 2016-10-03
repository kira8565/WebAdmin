<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ tag language="java" pageEncoding="UTF-8" %>
<%@ attribute name="labelName" required="true" %>
<%@ attribute name="inputID" required="true" %>
<%@ attribute name="defaultValue" required="false" %>
<div>
    <div class="form-group">
        <label>${labelName}</label>
        <input value="${defaultValue}" type="text" id="${inputID}" name="${inputID}" class="form-control">
    </div>
</div>
