<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ tag language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<c:if test="${!empty t_error_message}">
    <p class="alert alert-danger alert-dismissable">
            ${t_error_message}
    </p>
</c:if>

<c:if test="${!empty t_success_massage}">
    <p class="alert alert-success alert-dismissable">
            ${t_success_massage}
    </p>
</c:if>
