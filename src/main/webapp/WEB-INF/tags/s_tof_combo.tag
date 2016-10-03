<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ tag language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ attribute name="labelName" required="true" %>
<%@ attribute name="path" required="true" %>
<%@ attribute name="items" required="false" type="java.util.HashMap" %>
<div class="col-md-6">
    <div class="form-group">
        <label>${labelName}</label>
        <form:select path="${path}" items="${items}" cssClass="form-control"></form:select>
        <form:errors path="${path}" cssClass="error"></form:errors>
    </div>
</div>