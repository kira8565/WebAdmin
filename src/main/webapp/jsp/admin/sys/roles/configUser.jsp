<%@ page language="java" pageEncoding="utf-8" %>
<%@ include file="/WEB-INF/include/taglib.jsp"%>
<%@include file="../../header.jsp"%>
<div class="main-content">
    <div class="page-content">
        <app:f_section firstMenu="角色管理" secondMenu="配置用户"></app:f_section>
        <section class="content">
            <div class="row-fluid">
                <div class="box box-primary">
                    <div class="box-body">

                        <form:form method="post" action="configUserAction" modelAttribute="entity" >
                            <form:hidden path="id"></form:hidden>
                            <app:hiddenInput id="userids" value="${userids}"></app:hiddenInput>
                            <table id="sample-table-1" class="table table-hover">
                                <thead>
                                <tr>
                                    <th style="width: 1%;text-align: center"><input name="pmenu" type="checkbox"
                                                                                    onclick="checktb(this,'userids')"
                                    /></th>
                                    <th style="width: 45%;text-align: center">用户名称</th>
                                    <th style="width: 45%;text-align: center">备注</th>
                                </tr>
                                </thead>

                                <tbody>
                                <c:forEach var="vo" items="${list}">
                                    <tr>
                                        <td style="text-align: center;vertical-align: middle"><input id="${vo.id}"
                                                                                                     onclick="checktb(this,'userids')"
                                                                                                     type="checkbox"
                                        />
                                        </td>
                                        <td style="text-align: center;vertical-align: middle">${vo.name}</td>
                                        <td style="text-align: center;vertical-align: middle">${vo.comment}</td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                            <app:f_common_action></app:f_common_action>
                        </form:form>
                    </div>
                </div>
            </div>
        </section>
    </div>
</div>

<script>
    $(document).ready(function () {
        var userids = '${userids}';
        var ids = userids.split(',');
        $(ids).each(function () {
            $('#' + this).prop('checked', true);
        })
    });
</script>
<%@include file="../../footer.jsp"%>