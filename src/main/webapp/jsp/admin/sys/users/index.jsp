<%@ page language="java" pageEncoding="utf-8" %>
<%@ include file="/WEB-INF/include/taglib.jsp"%>
<%@include file="../../header.jsp"%>
<section class="content">
    <div class="box box-info">
        <div class="box-header with-border">
            <h3 class="box-title">用户管理</h3>
        </div>
        <form class="form-horizontal">
            <div class="box-body">
                <app:searchinput defaultValue="${param.name}" labelName="用户名称" inputID="name"></app:searchinput>
            </div>
            <div class="box-footer">
                <sec:authorize access="hasAuthority('ROLE_SYS_USER_ADD')">
                    <app:addButton></app:addButton>
                </sec:authorize>
                <app:searchButton></app:searchButton>
            </div>
        </form>
    </div>
    <div class="box">
        <!-- /.box-header -->
        <div class="box-body table-responsive no-padding">
            <table class="table table-hover">
                <tbody>
                <tr>
                    <th style="width: 10%;">用户名称</th>
                    <th style="width: 10%;">用户备注</th>
                    <th style="width: 10%;">联系方式</th>
                    <th style="width: 10%;">性别</th>
                    <th style="width: 20%;">操作</th>
                </tr>
                <c:forEach var="vo" items="${result}">
                    <tr>
                        <td>${vo.name}</td>
                        <td>${vo.comment}</td>
                        <td>${vo.tel}</td>
                        <td>${vo.sexname}</td>
                        <td>
                            <sec:authorize access="hasAuthority('ROLE_SYS_USER_EDIT')">
                                <app:editButton id="${vo.id}"></app:editButton>
                            </sec:authorize>

                            <sec:authorize access="hasAuthority('ROLE_SYS_USER_CONFIGROLE')">
                                <a href="configRole?id=${vo.id}" class="btn btn-success">设置角色</a>
                            </sec:authorize>

                            <sec:authorize access="hasAuthority('ROLE_SYS_USER_DELETE')">
                                <app:deleteButton id="${vo.id}"></app:deleteButton>
                            </sec:authorize>

                        </td>
                    </tr>
                </c:forEach>
                </tr>
                </tbody>
            </table>
        </div>
        <%@include file="../common/pagenation.jsp" %>
    </div>

</section>
<%@include file="../../footer.jsp"%>