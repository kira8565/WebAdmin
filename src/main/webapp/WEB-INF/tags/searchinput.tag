<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ tag language="java" pageEncoding="UTF-8" %>
<%@ attribute name="labelName" required="true" %>
<%@ attribute name="inputID" required="true" %>
<%@ attribute name="defaultValue" required="false" %>
<label class="col-sm-2 control-label">${labelName}</label>

<div class="col-xs-2">
    <input value="${defaultValue}" class="form-control" id="${inputID}" name="${inputID}">
</div>
