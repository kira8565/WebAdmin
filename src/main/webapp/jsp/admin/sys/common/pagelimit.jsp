<%@ page pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="">
    <div id="sample-table-2_length" class="dataTables_length" style="width: 100%">
        <label>显示 <select size="1" name="sample-table-2_length"
                          id="sl_limit" onchange="changelimit()" aria-controls="sample-table-2">
            <c:if test="${!empty param.limit }">
                <option value="10" >10</option>
                <option value="25">25</option>
                <option value="50" selected="selected">50</option>
                <option value="100">100</option>
            </c:if>
            <c:if test="${empty param.limit }">
                <option value="10"
                        <c:if test="${limit ==10}">selected="selected"</c:if>>10
                </option>
                <option value="25"
                        <c:if test="${limit ==25}">selected="selected"</c:if>>25
                </option>
                <option value="50"
                        <c:if test="${limit ==50}">selected=="selected"</c:if>>50
                </option>
                <option value="100"
                        <c:if test="${limit ==100}">selected="selected"</c:if>>100
                </option>
            </c:if>
        </select> 条记录
            <snap style="margin-left: 73%"><strong>总记录数：${all} 条</strong></snap>
        </label>

    </div>
</div>

<script>
    function changelimit() {
        window.location.href = "?offset=0&limit=" + $("#sl_limit").val() + "&_pid=${param._pid}";
    }
</script>