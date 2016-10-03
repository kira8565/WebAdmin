<%@ tag language="java" pageEncoding="UTF-8" %>
<%@ attribute name="id" required="true" %>
<%@ attribute name="value" required="false" %>
<input type="text" name="<%=id%>" id="<%=id%>" value="<%=value%>"
       style="display: none;"/>