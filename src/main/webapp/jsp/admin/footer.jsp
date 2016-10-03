<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- Content Header (Page header) -->
</div>
<!-- /.content-wrapper -->
<footer class="main-footer ">
    <div class="pull-right hidden-xs">
        <b>WebAdmin</b> 0.0.1
    </div>
    <strong>Copyright &copy; 2014-2015 <a href="#">Speed Studio</a>.</strong> All rights reserved.
</footer>

<!-- /.control-sidebar -->
<!-- Add the sidebar's background. This div must be placed
immediately after the control sidebar -->
<div class="control-sidebar-bg"></div>
</div>
<!-- ./wrapper -->

<!-- AdminLTE for demo purposes -->
<script>
    function loadAndSetMenuSession(fMenu, sMenu, url) {
        $.post('${pageContext.servletContext.contextPath}/admin/setMenuSession',
                {'id': fMenu, 'subid': sMenu},
                function (rs) {
                    window.location.href = '${pageContext.servletContext.contextPath}' + url;
                }
        );
    }

    function validate() {
        var obj = $("div[required]");
        var flag = true;
        for (var i = 0; i < obj.length; i++) {
            if (obj[i].children[1].children[0].value == "") {
                alert("请填写[" + obj[i].children[0].textContent + "]");
                flag = false;
                break;
            }
        }
        return flag;
    }
    function commonSubmit(formName, actionName, reload) {
        var data = $('#' + formName).serialize();
        if (validate()) {
            $.post(actionName, data, function (rs) {
                debugger;
                if (rs == "") {
                    if (reload == true) {
                        window.location.reload();
                    } else {
                        location.href = document.referrer;
                    }
                } else {
                    alert(rs);
                }
            }).error(function () {
                alert('操作异常，请联系管理员');
            });
        }
    }


    function checktb(obj, id) {
        if (obj.name == 'pmenu' && obj.checked == true) {
            $($("input[type='checkbox']")).each(function () {
                $(this).prop('checked', true);
            });
        }
        if (obj.name == 'pmenu' && obj.checked == false) {
            $($("input[type='checkbox']")).each(function () {
                $(this).removeAttr("checked");
            });
        }

        var uids = "";
        $($("input[type='checkbox']")).each(function () {
            if (this.checked == true && this.name != 'pmenu') {
                uids += this.id + ",";
            }
        });
        $("#" + id).val(uids);
    }
</script>
</body>
</html>
