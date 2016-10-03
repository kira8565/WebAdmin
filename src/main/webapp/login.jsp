<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/include/taglib.jsp" %>
<html>
<head>
    <title>${fns:getConfig('product')} | 登陆</title>
    <link rel="stylesheet"
          href="${pageContext.servletContext.contextPath}/static/adminlte/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.servletContext.contextPath}/static/adminlte/dist/css/AdminLTE.min.css">
    <link rel="stylesheet"
          href="${pageContext.servletContext.contextPath}/static/adminlte/plugins/iCheck/square/blue.css">
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
</head>
<body class="hold-transition login-page">
<div class="login-box">
    <div class="login-logo">
        <a href="#"><b>${fns:getConfig('product')}</b></a>
    </div>
    <div class="login-box-body">
        <p class="login-box-msg">登陆</p>
        <form action="${pageContext.servletContext.contextPath}/login" method="post">
            <c:if test="${param.maxnum != null}">
                <p style="color: red;">
                    该账户已登录
                </p>
            </c:if>
            <c:if test="${param.session != null}">
                <p style="color: red;">
                    当前会话已超时
                </p>
            </c:if>
            <c:if test="${param.error != null}">
                <p style="color: red;">
                    用户名密码不匹配
                </p>
            </c:if>
            <c:if test="${param.logout != null}">
                <p style="color: red;">
                    成功登出
                </p>
            </c:if>

            <div class="form-group has-feedback">
                <input type="text" name="username" class="form-control" placeholder="用户名">
                <span class="glyphicon glyphicon-envelope form-control-feedback"></span>
            </div>

            <div class="form-group has-feedback">
                <input name="password" type="password" class="form-control" placeholder="密码">
                <span class="glyphicon glyphicon-lock form-control-feedback"></span>
            </div>

            <input type="hidden"
                   name="${_csrf.parameterName}"
                   value="${_csrf.token}"/>

            <div class="row">
                <div class="col-xs-8">
                </div>
                <div class="col-xs-4">
                    <button type="submit" class="btn btn-primary btn-block btn-flat">登陆</button>
                </div>
            </div>
        </form>
    </div>
</div>
<script src="${pageContext.servletContext.contextPath}/static/adminlte/plugins/jQuery/jQuery-2.1.4.min.js"></script>
<script src="${pageContext.servletContext.contextPath}/static/adminlte/bootstrap/js/bootstrap.min.js"></script>
<script src="${pageContext.servletContext.contextPath}/static/adminlte/plugins/iCheck/icheck.min.js"></script>
</body>
</html>
