<%--
  Created by IntelliJ IDEA.
  User: chisanahn
  Date: 4/30/2022
  Time: 5:14 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="java.io.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
<html>
<head>
    <title>Logout</title>
</head>
<body>
<%
    session.removeAttribute("memberId");
    PrintWriter script = response.getWriter();
    script.println("<script>");
    script.println("location.href = 'index.jsp'");
    script.println("</script>");
%>
</body>
</html>
