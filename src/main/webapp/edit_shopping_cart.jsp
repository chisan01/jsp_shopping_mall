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
<%@ page import="com.example.myhompage.order.OrderDAO" %>
<%@ page import="com.example.myhompage.product.ProductDAO" %>
<%@ page import="java.util.Arrays" %>
<% request.setCharacterEncoding("UTF-8"); %>
<html>
<head>
    <title>장바구니 삭제/구매</title>
</head>
<body>
<%
    String memberId = (String) session.getAttribute("memberId");
    if(memberId == null) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('로그인이 필요합니다.')");
        script.println("location.href = 'login.html'");
        script.println("</script>");
    }

    ShoppingCartDAO shoppingCartDAO = new ShoppingCartDAO();
    long[] productIdList = Arrays.stream(request.getParameterValues("product_id_list")).mapToLong(Long::parseLong).toArray();
    // 선택한 물건이 없는 경우 예외처리
    if(productIdList.length == 0) response.sendRedirect("shopping_cart.jsp");

    try {
        // 장바구니에서 물건을 구매하는 경우
        if (request.getParameter("action").equals("buy")) {
            OrderDAO orderDAO = new OrderDAO();
            Long orderId = orderDAO.createOrder(memberId);
            for (long productId : productIdList) {
                int curItemAmount = shoppingCartDAO.countProductAmount(memberId, productId);
                orderDAO.addOrderItem(orderId, productId, curItemAmount);
            }
        }
        // 장바구니에서 물건 삭제 (구매가 완료된 물건도 장바구니에서 삭제)
        for (long productId : productIdList) {
            shoppingCartDAO.delProduct(productId);
        }
        response.sendRedirect("shopping_cart.jsp");

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
