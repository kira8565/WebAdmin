<%@ page language="java" pageEncoding="utf-8" %>
<%@ include file="/WEB-INF/include/taglib.jsp"%>
<%@include file="../../header.jsp"%>
<div class="main-content">
    <div class="page-content">
        <app:f_section firstMenu="角色管理" secondMenu="编辑角色"></app:f_section>
        <section class="content">
            <div class="row-fluid">
                <div class="box box-primary">
                    <div class="box-body">
                        <form:form method="post" action="editEntity" modelAttribute="sysRole">
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