<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ tag language="java" pageEncoding="UTF-8" %>
<%@ attribute name="labelName" required="true" %>
<%@ attribute name="path" required="true" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<div class="col-md-6">
    <div class="form-group">
        <label>${labelName}</label>
        <form:password path="${path}" cssClass="form-control"></form:password>
        <form:errors path="${path}" cssClass="error"></form:errors>
    </div>
</div>