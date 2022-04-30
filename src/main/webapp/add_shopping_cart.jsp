<%--
  Created by IntelliJ IDEA.
  User: chisanahn
  Date: 4/30/2022
  Time: 11:44 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="java.io.*" %>
<%@ page import="com.example.myhompage.shoppingCart.ShoppingCartDAO" %>
<%@ page import="java.util.Enumeration" %>
<% request.setCharacterEncoding("UTF-8"); %>
<html>
<head>
    <title>장바구니에 추가</title>
</head>
<body>
<%
    ShoppingCartDAO shoppingCartDAO = new ShoppingCartDAO();
    String memberId = (String) session.getAttribute("memberId");
    if(memberId == null) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('로그인이 필요합니다.')");
        script.println("location.href = 'login.html'");
        script.println("</script>");
    }
    Long productId = Long.parseLong(request.getParameter("productId"));
    System.out.println("productId = " + productId);
    try {
        shoppingCartDAO.addProduct(memberId, productId);
        response.sendRedirect("index.jsp");
    } catch (Exception e) {
        e.printStackTrace();
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('" + e.getMessage() + "')");
        script.println("history.back()");
        script.println("</script>");
    }
%>
</body>
</html>
