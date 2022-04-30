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
    <title>장바구니 삭제/구매</title>
</head>
<body>
<%
    ShoppingCartDAO shoppingCartDAO = new ShoppingCartDAO();
    String[] shoppingCartIds = request.getParameterValues("shopping_cart_id");
    try {
        // 장바구니에서 물건을 삭제하는 경우
        if (request.getParameter("action").equals("delete")) {
            for (String shoppingCartId : shoppingCartIds) {
                shoppingCartDAO.delProduct(Long.parseLong(shoppingCartId));
            }
            response.sendRedirect("shopping_cart.jsp");
        }
        // 장바구니에서 물건을 구매하는 경우
        else if (request.getParameter("action").equals("buy")) {
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('상품 구매')");
            script.println("history.back()");
            script.println("</script>");
        }
    } catch (Exception e) {
        e.printStackTrace();
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('" + e.getMessage() + "')");
        script.println("history.back()");
        script.println("</script>");
    }
//    ShoppingCartDAO shoppingCartDAO = new ShoppingCartDAO();
//    String memberId = (String) session.getAttribute("memberId");
//    if(memberId == null) {
//        PrintWriter script = response.getWriter();
//        script.println("<script>");
//        script.println("alert('로그인이 필요합니다.')");
//        script.println("location.href = 'login.html'");
//        script.println("</script>");
//    }
//    Long productId = Long.parseLong(request.getParameter("productId"));
//    System.out.println("productId = " + productId);
//    try {
//        shoppingCartDAO.addProduct(memberId, productId);
//        response.sendRedirect("index.jsp");
//    } catch (Exception e) {
//        e.printStackTrace();
//        PrintWriter script = response.getWriter();
//        script.println("<script>");
//        script.println("alert('" + e.getMessage() + "')");
//        script.println("history.back()");
//        script.println("</script>");
//    }
%>
</body>
</html>
