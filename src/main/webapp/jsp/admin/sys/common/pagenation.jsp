<%@ page pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<div class="box-footer clearfix" id="example1_paginate">
    <div class="dataTables_paginate paging_bootstrap">

        <c:if test="${empty param.limit }">
            <c:set value="10" var="limit"></c:set>
        </c:if>
        <c:if test="${!(empty param.limit) }">
            <c:set value="${param.limit }" var="limit"></c:set>
        </c:if>
			<span style="float: left;">当前第
			${currentpage} 页 共 ${total }页</div>
    </span>

    <ul class="pagination pagination-sm no-margin pull-right">
        <li class="" id="example1_previous"><a
                onclick="page('${limit }','0')"
                href="javascript:void(0)">首页</a>
        </li>

        <c:if test="${total <=8}">
            <c:set value="1" var="pageStart"></c:set>
            <c:set value="${total }" var="pageEnd"></c:set>
        </c:if>
        <c:if test="${total >8}">
            <c:if
                    test="${currentpage-8>=0&& (param.offset/param.limit)+1<total-4}">
                <c:set value="${currentpage-4 }" var="pageStart"></c:set>
                <c:set value="${currentpage+4 }" var="pageEnd"></c:set>
            </c:if>
            <c:if
                    test="${currentpage-8>=0&& (param.offset/param.limit)+1>=total-4}">
                <c:set value="${currentpage-4 }" var="pageStart"></c:set>
                <c:set value="${total }" var="pageEnd"></c:set>
            </c:if>
            <c:if test="${currentpage-8<0}">
                <c:set value="1" var="pageStart"></c:set>
                <c:set value="8" var="pageEnd"></c:set>
            </c:if>
        </c:if>

        <c:forEach begin="${pageStart }" end="${pageEnd }" var="i">
            <c:if test="${(param.offset/param.limit)+1==i }">
                <li class=" active"><a class="fg-button ui-button ui-state-default ui-state-disabled"
                                                      onclick="page('${limit}','${(i-1)*limit }')"
                                                      href="javascript:void(0)">${i }</a></li>
            </c:if>
            <c:if test="${(param.offset/param.limit)+1!=i }">
                <li class=" "><a onclick="page('${limit}','${(i-1)*limit }')"
                                                class="fg-button ui-button ui-state-default"
                                                href="javascript:void(0)">${i }</a></li>
            </c:if>

        </c:forEach>
        <li class="" id="example1_next">
            <a class="last ui-corner-tr ui-corner-br fg-button ui-button ui-state-default"
               onclick="page('${limit}','${(total-1)*param.limit }')"
               href="javascript:void(0)">末页</a></li>
    </ul>
</div>


<script>
    function replaceParamVal(url, paramName, replaceWith) {
        var oUrl = url;
        var re = eval('/(' + paramName + '=)([^&]*)/gi');
        var nUrl = url.replace(re, paramName + '=' + replaceWith);
        return nUrl;
    }
    function page(limit, offset) {
        var url = window.location.href;
        if (url.indexOf("?") == -1) {
            if (url.indexOf("limit") == -1) {
                url += "?limit=" + limit;
            } else {
                url = replaceParamVal(url, 'limit', limit);
            }
            if (url.indexOf("offset") == -1) {
                url += "&offset=" + offset;
            } else {
                url = replaceParamVal(url, 'offset', offset);
            }
        } else {
            if (url.indexOf("limit") == -1) {
                url += "&limit=" + limit;
            } else {
                url = replaceParamVal(url, 'limit', limit);
            }
            if (url.indexOf("offset") == -1) {
                url += "&offset=" + offset;
            } else {
                url = replaceParamVal(url, 'offset', offset);
            }
        }
        window.location.href = url;
    }
</script>