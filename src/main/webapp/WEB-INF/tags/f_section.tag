<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ tag language="java" pageEncoding="UTF-8" %>
<%@ attribute name="firstMenu" required="true" %>
<%@ attribute name="secondMenu" required="true" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<section class="content-header">
    <h1>
        ${secondMenu}
    </h1>
    <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i>首页</a></li>
        <li><a href="#">${firstMenu}</a></li>
        <li class="active">${secondMenu}</li>
    </ol>
</section>