<%--
  Created by IntelliJ IDEA.
  User: chisanahn
  Date: 4/30/2022
  Time: 2:40 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.myhompage.member.MemberDAO" %>
<%@page import="java.io.*" %>
<% request.setCharacterEncoding("UTF-8"); %>

<jsp:useBean id="member" class="com.example.myhompage.member.Member" scope="page"/>
<jsp:setProperty name="member" property="*"/>

<html>
<head>
    <title>Register</title>
</head>
<body>
<%
    MemberDAO memberDAO = new MemberDAO();
    PrintWriter script = response.getWriter();
    System.out.println(member);
    try {
        memberDAO.join(member);
        script.println("<script>");
        script.println("location.href = 'index.jsp'");
        script.println("</script>");
    } catch (Exception e) {
        e.printStackTrace();
        script.println("<script>");
        script.println("alert('회원을 생성할 수 없습니다.')");
        script.println("history.back()");
        script.println("</script>");
    }
%>
</body>
</html>
