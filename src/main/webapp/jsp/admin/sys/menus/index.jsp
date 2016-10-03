<%@ page language="java" pageEncoding="utf-8" %>
<%@ include file="/WEB-INF/include/taglib.jsp"%>
<%@include file="../../header.jsp"%>
<section class="content">
    <app:t_message></app:t_message>
    <div class="box box-info">
        <div class="box-header with-border">
            <h3 class="box-title">菜单管理</h3>
        </div>
        <form class="form-horizontal">
            <div class="box-footer">
                <sec:authorize access="hasAuthority('ROLE_SYS_MENU_ADD')">
                    <app:addButton></app:addButton>
                </sec:authorize>
            </div>
        </form>
    </div>
    <div class="box">
        <!-- /.box-header -->
        <div class="box-body table-responsive no-padding">
            <table id="list" class="table table-hover">
                <tbody>
                <tr>
                    <th style="width: 10%;">菜单名称</th>
                    <th style="width: 10%;">菜单排序</th>
                    <th style="width: 10%;">菜单图表</th>
                    <th style="width: 15%;">菜单地址</th>
                    <th style="width: 10%;">上级菜单</th>
                    <th style="width: 15%;">操作</th>
                </tr>
                <c:forEach var="vo" items="${result}">
                    <c:if test="${empty vo.parentid}">
                        <tr data-tt-id="${vo.id}" data-tt-parent-id="${vo.parentid}">
                            <td>${vo.name}</td>
                            <td>${vo.orders}</td>
                            <td>${vo.icons}</td>
                            <td>${vo.urls}</td>
                            <td>${vo.pname}</td>
                            <td>
                                <sec:authorize access="hasAuthority('ROLE_SYS_MENU_EDIT')">
                                    <app:editButton id="${vo.id}"></app:editButton>
                                </sec:authorize>
                                <sec:authorize access="hasAuthority('ROLE_SYS_MENU_DELETE')">
                                    <app:deleteButton id="${vo.id}"></app:deleteButton>
                                </sec:authorize>
                            </td>
                        </tr>
                        <c:forEach var="co" items="${result}">
                            <c:if test="${co.parentid eq vo.id}">
                                <tr data-tt-id="${co.id}" data-tt-parent-id="${co.parentid}">
                                    <td>${co.name}</td>
                                    <td>${co.orders}</td>
                                    <td>${co.icons}</td>
                                    <td>${co.urls}</td>
                                    <td>${do.pname}</td>
                                    <td>
                                        <sec:authorize access="hasAuthority('ROLE_SYS_MENU_EDIT')">
                                            <app:editButton id="${co.id}"></app:editButton>
                                        </sec:authorize>
                                        <sec:authorize access="hasAuthority('ROLE_SYS_MENU_DELETE')">
                                            <app:deleteButton id="${co.id}"></app:deleteButton>
                                        </sec:authorize>
                                    </td>
                                </tr>
                                <c:forEach var="do" items="${result}">
                                    <c:if test="${do.parentid eq co.id}">
                                        <tr data-tt-id="${do.id}" data-tt-parent-id="${do.parentid}">
                                            <td>${do.name}</td>
                                            <td>${do.orders}</td>
                                            <td>${do.icons}</td>
                                            <td>${do.urls}</td>
                                            <td>${do.pname}</td>
                                            <td>
                                                <sec:authorize access="hasAuthority('ROLE_SYS_MENU_EDIT')">
                                                    <app:editButton id="${do.id}"></app:editButton>
                                                </sec:authorize>
                                                <sec:authorize access="hasAuthority('ROLE_SYS_MENU_DELETE')">
                                                    <app:deleteButton id="${do.id}"></app:deleteButton>
                                                </sec:authorize>
                                            </td>
                                        </tr>
                                    </c:if>
                                </c:forEach>
                            </c:if>
                        </c:forEach>
                    </c:if>
                </c:forEach>
                </tr>
                </tbody>
            </table>
        </div>

    </div>
</section>

<script>
    $("#list").treetable({ expandable: true,stringExpand:"展开",stringCollapse:'收缩' });
</script>
<%@include file="../../footer.jsp"%>