<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ tag language="java" pageEncoding="UTF-8" %>
<%@ attribute name="id" required="true" %>
<a href="edit?id=${id}&key=${param.key}" class="btn btn-info ">编辑</a>