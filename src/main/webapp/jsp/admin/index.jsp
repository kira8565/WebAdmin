<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/include/taglib.jsp" %>
<%@include file="header.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>首页</title>
</head>
<body>
<section class="content-header">
    <h1>
        仪表板
    </h1>
</section>
<section class="content">
    <ul id="myDashboard">

    </ul>
</section>
<div id="cpuinfo">
    <table>
        <tr>
            <td style="width: 40%">CPU核心数</td>
            <td>${availableProcessors}</td>
        </tr>
    </table>
</div>
<div id="cpuinfo1">
    <table>
        <tr>
            <td style="width: 40%">CPU核心数</td>
            <td>${availableProcessors}</td>
        </tr>
    </table>
</div>
<script src="${ctxStatic}/javascript/index.js"></script>
<%@include file="footer.jsp" %>
</body>
</html>
