<%@ page language="java" pageEncoding="utf-8" %>
<%@ include file="/WEB-INF/include/taglib.jsp" %>
<%@include file="../../header.jsp" %>
<section class="content">
    <app:t_message></app:t_message>
    <div class="box box-info">
        <div class="box-header with-border">
            <h3 class="box-title">${metaModel.listTitle}</h3>
        </div>
        <form class="form-horizontal">
            <app:hiddenInput id="key" value="${param.key}"></app:hiddenInput>
            <div class="box-body">
                <c:forEach var="vo" items="${metaModel.filters}">
                    <c:if test="${vo.filterType=='input'}">
                        <app:searchinput defaultValue="${param[vo.paramName]}" labelName="${vo.labelName}"
                                         inputID="${vo.paramName}"></app:searchinput>
                    </c:if>
                </c:forEach>
            </div>
            <div class="box-footer">
                <app:addButton></app:addButton>
                <app:searchButton></app:searchButton>
            </div>
        </form>
    </div>
    <div class="box">
        <div class="box-body table-responsive no-padding">
            <table id="table" class="table table-hover">
                <tbody>
                <tr>
                    <c:forEach var="vo" items="${metaModel.columns}">
                        <th style="${vo.styles}">${vo.desc}</th>
                    </c:forEach>
                    <th style="width: 15%;">操作</th>
                </tr>
                <c:forEach var="vo" items="${result}">
                    <tr>
                        <c:forEach var="co" items="${vo}" begin="1">
                            <td>${co.value}</td>
                        </c:forEach>
                        <td>
                            <app:editButton id="${vo.id}"></app:editButton>
                            <app:deleteButton id="${vo.id}"></app:deleteButton>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
        <c:if test="${metaModel.needPage}">
            <%@include file="../../sys/common/pagenation.jsp" %>
        </c:if>

    </div>
</section>
<%@include file="../../footer.jsp" %>