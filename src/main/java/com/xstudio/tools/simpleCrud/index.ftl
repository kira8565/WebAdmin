<%@ page language="java" pageEncoding="utf-8" %>
<%@ include file="../header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="app" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<section class="content">
    <app:t_message></app:t_message>

    <div class="box box-info">
        <div class="box-header with-border">
            <h3 class="box-title">${controllerDesc}管理</h3>
        </div>
        <form class="form-horizontal">
            <div class="box-body">

            </div>
            <div class="box-footer">
                <sec:authorize access="hasAuthority('${authPrefix}_ADD')">
                    <app:addButton></app:addButton>
                </sec:authorize>
                <app:searchButton></app:searchButton>
            </div>
        </form>
    </div>
    <div class="box">
        <!-- /.box-header -->
        <div class="box-body table-responsive no-padding">
            <table id="table" class="table table-hover">
                <tbody>

                </tbody>
            </table>
        </div>
    </div>
</section>
<script type="text/javascript">
</script>
<%@ include file="../footer.jsp" %>