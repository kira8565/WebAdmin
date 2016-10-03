<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ tag language="java" pageEncoding="UTF-8" %>
<%@ attribute name="labelName" required="true" %>
<%@ attribute name="inputID" required="true" %>
<%@ attribute name="defaultValue" required="false" %>
<%@ attribute name="inputtype" required="false" %>
<div class="col-md-6">
    <div class="form-group">
        <label>${labelName}</label>
        <input value="${defaultValue}" type="${empty inputtype?"text":inputtype}" id="${inputID}" name="${inputID}"
               class="form-control">
    </div>
</div>
