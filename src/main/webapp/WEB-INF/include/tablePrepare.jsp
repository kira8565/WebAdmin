<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${empty param.limit}">
    <c:set var="limit" value="0"></c:set>
</c:if>
<c:if test="${!empty param.limit}">
    <c:set var="limit" value="${param.limit}"/>
</c:if>

<c:if test="${empty param.offset}">
    <c:set var="offset" value="0"></c:set>
</c:if>
<c:if test="${!empty param.offset}">
    <c:set var="offset" value="${param.offset}"/>
</c:if>


