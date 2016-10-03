<%@ page language="java" pageEncoding="utf-8" %>
<%@include file="../../header.jsp"%>
<%@ taglib prefix="app" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<div class="main-content">
    <div class="page-content">
        <app:f_section firstMenu="角色管理" secondMenu="新增角色"></app:f_section>
        <section class="content">
            <div class="row-fluid">
                <div class="box box-primary">
                    <div class="box-body">
                        <form:form method="post" action="addEntity" modelAttribute="sysRole">
                            <%@ include file="_form.jsp" %>
                            <app:f_common_action></app:f_common_action>
                        </form:form>
                    </div>
                </div>
            </div>
        </section>
    </div>
</div>
<%@include file="../../footer.jsp"%>