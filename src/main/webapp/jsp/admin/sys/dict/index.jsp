<%@ page language="java" pageEncoding="utf-8" %>
<%@ include file="/WEB-INF/include/taglib.jsp" %>
<%@include file="../../header.jsp" %>
<section class="content">
    <app:t_message></app:t_message>

    <div class="box box-info">
        <div class="box-header with-border">
            <h3 class="box-title">字典管理</h3>
        </div>
        <form class="form-horizontal">
            <div class="box-body">
                <app:searchinput defaultValue="${param.dictgroup}" labelName="字典分组"
                                 inputID="dictgroup"></app:searchinput>
                <app:searchinput defaultValue="${param.dictkey}" labelName="字典名称" inputID="dictkey"></app:searchinput>
            </div>
            <div class="box-footer">
                <sec:authorize access="hasAuthority('ROLE_SYS_DICT_ADD')">
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
                <tr>
                    <th style="width: 10%;">字典分组</th>
                    <th style="width: 10%;">字典名称</th>
                    <th style="width: 10%;">字典值</th>
                    <th style="width: 15%;">操作</th>
                </tr>
                <c:forEach var="vo" items="${result}">
                    <tr>
                        <td>${vo.dictgroup}</td>
                        <td>${vo.dictkey}</td>
                        <td>${vo.dictvalues}</td>
                        <td>
                            <sec:authorize access="hasAuthority('ROLE_SYS_DICT_EDIT')">
                                <app:editButton id="${vo.id}"></app:editButton>
                            </sec:authorize>
                            <sec:authorize access="hasAuthority('ROLE_SYS_DICT_DELETE')">
                                <app:deleteButton id="${vo.id}"></app:deleteButton>
                            </sec:authorize>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</section>
<script type="text/javascript">
    mc('table', 0, 0, 0);
</script>
<%@include file="../../footer.jsp" %>