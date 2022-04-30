<%--
  Created by IntelliJ IDEA.
  User: chisanahn
  Date: 4/30/2022
  Time: 11:44 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.myhompage.member.MemberDAO" %>
<%@page import="java.io.*" %>
<%@ page import="com.example.myhompage.exception.WrongPasswordException" %>
<% request.setCharacterEncoding("UTF-8"); %>
<html>
<head>
    <title>로그인</title>
</head>
<body>
<%
    MemberDAO memberDAO = new MemberDAO();
    String memberId = request.getParameter("memberId");
    String memberPassword = request.getParameter("memberPassword");
    try {
        memberDAO.login(memberId, memberPassword);
        response.sendRedirect("index.jsp");
        session.setAttribute("memberId", memberId);
    } catch (Exception e) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('" + e.getMessage() + "')");
        script.println("</script>");
    }
%>
</body>
</html>
