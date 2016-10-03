<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ tag language="java" pageEncoding="UTF-8" %>
<%@ attribute name="id" required="true" %>

<c:if test="${empty param.limit}">
    <c:set var="limit" value="0"></c:set>
</c:if>
<c:if test="${!empty param.limit}">
    <c:set var="limit" value="${param.limit}"></c:set>
</c:if>

<c:if test="${empty param.offset}">
    <c:set var="offset" value="0"></c:set>
</c:if>
<c:if test="${!empty param.offset}">
    <c:set var="offset" value="${param.offset}"></c:set>
</c:if>

<a href="deleteEntity?id=${id}&limit=${limit}&offset=${offset}&key=${param.key}"
   class="btn btn-danger ">删除</a>
