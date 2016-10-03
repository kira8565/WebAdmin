<%@ page language="java" pageEncoding="utf-8" %>
<%@ include file="/WEB-INF/include/taglib.jsp" %>
<%@include file="../../header.jsp" %>
<div class="main-content">
    <div class="page-content">
        <app:f_section firstMenu="用户管理" secondMenu="配置角色"></app:f_section>
        <section class="content">
            <div class="row-fluid">
                <div class="box box-primary">
                    <div class="box-body">

                        <form:form method="post" action="configRoleAction" modelAttribute="entity">
                            <form:hidden path="id"></form:hidden>
                            <app:hiddenInput id="roleids" value="${roleids}"></app:hiddenInput>
                            <table id="sample-table-1" class="table table-hover">
                                <thead>
                                <tr>
                                    <th style="width: 1%;text-align: center"><input name="pmenu" type="checkbox"
                                                                                    onclick="checktb(this,'roleids')"
                                    /></th>
                                    <th style="width: 45%;text-align: center">角色名称</th>
                                    <th style="width: 45%;text-align: center">备注</th>
                                </tr>
                                </thead>

                                <tbody>
                                <c:forEach var="vo" items="${list}">
                                    <tr>
                                        <td style="text-align: center;vertical-align: middle"><input id="${vo.id}"
                                                                                                     onclick="checktb(this,'roleids')"
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
        var roleids = '${roleids}';
        var ids = roleids.split(',');
        $(ids).each(function () {
            $('#' + this).prop('checked', true);
        })
    });
</script>
<%@include file="../../footer.jsp" %>