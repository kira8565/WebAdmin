<%@ page language="java" pageEncoding="utf-8" %>
<%@ include file="/WEB-INF/include/taglib.jsp"%>
<%@include file="../../header.jsp"%>
<div class="main-content">
    <div class="page-content">
        <app:f_section firstMenu="角色管理" secondMenu="配置菜单"></app:f_section>
        <section class="content">
            <div class="row-fluid">
                <div class="box box-primary">
                    <div class="box-body">

                        <form:form method="post" action="configMenuAction" modelAttribute="entity">
                            <form:hidden path="id"></form:hidden>
                            <app:hiddenInput id="menuids" value="${menuids}"></app:hiddenInput>
                            <ul id="tree" class="ztree" style="width:560px; overflow:auto;"></ul>
                            <script>
                                var setting = {
                                    check: {
                                        enable: true
                                    },
                                    view: {
                                        dblClickExpand: false,
                                        showLine: true,
                                        selectedMulti: false
                                    },
                                    data: {
                                        simpleData: {
                                            enable: true,
                                            idKey: "id",
                                            pIdKey: "pId",
                                            rootPId: ""
                                        }
                                    },
                                    callback: {
                                        onCheck: function (event, treeId, treeNode) {
                                            var treeObj = $.fn.zTree.getZTreeObj("tree");
                                            debugger;
                                            var nodes = treeObj.getCheckedNodes(true);
                                            var ids = "";
                                            $(nodes).each(function () {

                                                if (this.pId != '') {
                                                    ids += this.id + ",";
                                                }

                                            });
                                            $('#menuids').val(ids);
                                        }
                                    }
                                };

                                var zNodes = [
                                    <c:forEach var="vo" items="${list}">
                                    {id: "${vo.id}", pId: "${vo.parentid}", name: "${vo.name}", open: true},
                                    </c:forEach>
                                ];

                                $(document).ready(function () {

                                    var t = $("#tree");
                                    t = $.fn.zTree.init(t, setting, zNodes);
                                    var zTree = $.fn.zTree.getZTreeObj("tree");
                                    var cueentMenuids = '${menuids}';
                                    if (cueentMenuids != '') {
                                        var nodeids = cueentMenuids.split(",");
                                        debugger;
                                        $(nodeids).each(function (index, entity) {
                                            var node = zTree.getNodeByParam('id', entity);
                                            zTree.checkNode(node, true, true);
                                        });
                                    }
                                });
                            </script>
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
        var userids = '{$userids}';
        var ids = userids.split(',');
        $(ids).each(function () {
            $('#' + this).prop('checked', true);
        })
    });
</script>
<%@include file="../../footer.jsp"%>