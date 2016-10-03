<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>WebAdmin</title>
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <link rel="stylesheet"
          href="${pageContext.servletContext.contextPath}/static/adminlte/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet"
          href="${pageContext.servletContext.contextPath}/static/adminlte/plugins/datatables/dataTables.bootstrap.css">
    <link rel="stylesheet" href="${pageContext.servletContext.contextPath}/static/adminlte/dist/css/AdminLTE.min.css">
    <link rel="stylesheet"
          href="${pageContext.servletContext.contextPath}/static/adminlte/dist/css/skins/_all-skins.min.css">
    <link rel="stylesheet"
          href="${pageContext.servletContext.contextPath}/static/Font-Awesome-3.2.1/css/font-awesome.css">

    <script src="${pageContext.servletContext.contextPath}/static/adminlte/plugins/jQuery/jQuery-2.1.4.min.js"></script>
    <script src="${pageContext.servletContext.contextPath}/static/adminlte/bootstrap/js/bootstrap.min.js"></script>
    <script src="${pageContext.servletContext.contextPath}/static/adminlte/plugins/datatables/jquery.dataTables.min.js"></script>
    <script src="${pageContext.servletContext.contextPath}/static/adminlte/plugins/datatables/dataTables.bootstrap.min.js"></script>
    <script src="${pageContext.servletContext.contextPath}/static/adminlte/plugins/slimScroll/jquery.slimscroll.min.js"></script>
    <script src="${pageContext.servletContext.contextPath}/static/adminlte/plugins/fastclick/fastclick.min.js"></script>
    <script src="${pageContext.servletContext.contextPath}/static/adminlte/dist/js/app.min.js"></script>

    <script src="${pageContext.servletContext.contextPath}/static/underscore-min.js"></script>
    <link rel="stylesheet" href="${pageContext.servletContext.contextPath}/static/zTree/css/zTreeStyle/metro.css"/>
    <script src="${pageContext.servletContext.contextPath}/static/zTree/js/jquery.ztree.all-3.5.min.js"></script>
    <script src="${pageContext.servletContext.contextPath}/static/bootstrap-typeahead.js"></script>

    <link rel="stylesheet"
          href="${pageContext.servletContext.contextPath}/static/jquery-tree-table/css/jquery.treetable.css"/>
    <link rel="stylesheet"
          href="${pageContext.servletContext.contextPath}/static/jquery-tree-table/css/jquery.treetable.theme.default.css"/>
    <script src="${pageContext.servletContext.contextPath}/static/jquery-tree-table/jquery.treetable.js"></script>

    <link type="text/css" href="${pageContext.servletContext.contextPath}/static/jquery-ui/jquery-ui.theme.css" rel="stylesheet" />
    <link type="text/css" href="${pageContext.servletContext.contextPath}/static/jquery-ui/jquery-ui.css" rel="stylesheet" />
    <link rel="stylesheet" href="${pageContext.servletContext.contextPath}/static/sDashboard/sDashboard.css"/>
    <script src="${pageContext.servletContext.contextPath}/static/jquery-ui/jquery-ui.min.js"></script>

    <script src="${pageContext.servletContext.contextPath}/static/sDashboard/libs/datatables/jquery.dataTables.js"></script>
    <script src="${pageContext.servletContext.contextPath}/static/sDashboard/libs/flotr2/flotr2.ie.min.js" type="text/javascript"></script>
    <script src="${pageContext.servletContext.contextPath}/static/sDashboard/libs/flotr2/flotr2.js" type="text/javascript"></script>
    <script src="${pageContext.servletContext.contextPath}/static/sDashboard/jquery-sDashboard.js"></script>

</head>
<style>
    th {
        vertical-align: middle;
        text-align: center;
    }

    td {
        vertical-align: middle;
        text-align: center;
    }
</style>
<body class="hold-transition skin-blue sidebar-mini">
<div class="wrapper">
    <header class="main-header">
        <a href="${pageContext.servletContext.contextPath}/static/adminlte/index2.html" class="logo">
            <span class="logo-lg">WebAdmin</span>
        </a>
        <nav class="navbar navbar-static-top" role="navigation">
            <div class="navbar-custom-menu">
                <ul class="nav navbar-nav">
                    <li class="dropdown user user-menu">
                        <a href="${pageContext.servletContext.contextPath}/logout">
                            <span class="hidden-xs">注销</span>
                        </a>

                    </li>
                </ul>
            </div>
        </nav>
    </header>
    <aside class="main-sidebar">
        <section class="sidebar">
            <ul class="sidebar-menu">
                <c:forEach var="vo" items="${sessionScope._menus}">
                    <c:if test="${empty vo.parentid}">
                        <c:if test="${sessionScope._sid eq vo.id}">
                            <li class="treeview active">
                        </c:if>
                        <c:if test="${sessionScope._sid != vo.id}">
                            <li class="treeview">
                        </c:if>

                        <a href="#">
                            <i class="fa fa-dashboard "></i>${vo.name}<span></span> <i
                                class="fa fa-angle-left pull-right"></i>
                        </a>
                        <ul class="treeview-menu menu-open">
                            <c:forEach var="so" items="${sessionScope._menus}">
                                <c:set var="soid" value="${so.parentid}"></c:set>
                                <c:set var="coid" value="${vo.id}"></c:set>
                                <c:if test="${coid eq soid}">
                                    <c:if test="${_subid eq so.id}">
                                        <li class="active">
                                    </c:if>
                                    <c:if test="${_subid != so.id}">
                                        <li>
                                    </c:if>

                                    <a
                                            onclick="loadAndSetMenuSession('${so.parentid}',
                                                    '${so.id}','${so.urls}')"
                                            href="javascript:coid(0)"><i
                                            class="fa fa-circle-o"></i>
                                            ${so.name}</a></li>
                                </c:if>
                            </c:forEach>
                        </ul>
                        </li>
                    </c:if>
                </c:forEach>

            </ul>
        </section>
        <!-- /.sidebar -->
    </aside>

    <!-- Content Wrapper. Contains page content -->
    <div class="content-wrapper">



<script>
//    function tableOrder(tableid) {
//        let tables=$('#'+tableid)[0].children[0].children[0];
//        for(let i=0;i<tables.children.length;i++){
//            let id=tables.children[i].id;
//            tables.children[i].onclick=function () {
////                alert(id);
//                $(tables.children[i]).addClass("icon-arrow-up");
//            }
//        }
//    }
    //合并单元格
    function mc(tableId, startRow, endRow, col) {
        var tb = document.getElementById(tableId);
        if (col >= tb.rows[0].cells.length) {
            return;
        }
        if (col == 0) { endRow = tb.rows.length-1; }
        for (var i = startRow; i < endRow; i++) {
            if (tb.rows[startRow].cells[col].innerHTML == tb.rows[i + 1].cells[0].innerHTML) {
                tb.rows[i + 1].removeChild(tb.rows[i + 1].cells[0]);
                tb.rows[startRow].cells[col].rowSpan = (tb.rows[startRow].cells[col].rowSpan | 0) + 1;
                if (i == endRow - 1 && startRow != endRow) {
                    mc(tableId, startRow, endRow, col + 1);
                }
            } else {
                mc(tableId, startRow, i + 0, col + 1);
                startRow = i + 1;
            }
        }
    }
</script>