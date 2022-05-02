<%@ page import="com.example.myhompage.product.ProductDAO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.example.myhompage.product.Product" %>
<%@ page import="com.example.myhompage.shoppingCart.ShoppingCartDAO" %>
<%@ page import="com.example.myhompage.shoppingCart.ShoppingCart" %>
<%@ page import="com.example.myhompage.order.OrderDAO" %>
<%@ page import="com.example.myhompage.order.Order" %>
<%@ page import="com.example.myhompage.order.OrderItem" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>shopping cart</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
<div>
    <nav>
        <%
            String memberId = (String) session.getAttribute("memberId");
            if (memberId == null) {
                PrintWriter script = response.getWriter();
                script.println("<script>");
                script.println("alert('로그인이 필요합니다.')");
                script.println("location.href = 'login.html'");
                script.println("</script>");
            }
        %>
        <button onclick="location.href='./logout.jsp'">로그아웃</button>
        <button onclick="location.href='./shopping_cart.jsp'">장바구니</button>
        <button onclick="location.href='./order_history.jsp'">구매기록</button>
    </nav>
    <header>
        <a href="./index.jsp">
            <h1>SHOPPING MALL</h1>
        </a>
    </header>
    <main class="list">
        <table>
            <thead>
            <tr>
                <th>구매한 상품</th>
                <th>구매일</th>
                <th>총액</th>
            </tr>
            </thead>
            <tbody>
            <%
                OrderDAO orderDAO = new OrderDAO();
                ProductDAO productDAO = new ProductDAO();
                ArrayList<Order> orderList = orderDAO.findAllByMemberId((String) session.getAttribute("memberId"));
                String orderName;
                for (Order order : orderList) {
                    int totalPrice = 0;
                    ArrayList<OrderItem> orderItems = orderDAO.findAllOrderItemByOrderId(order.getId());
                    orderName = "<b>" + productDAO.findById(orderItems.get(0).getProductId()).getName() + "</b>";
                    if (orderItems.size() > 1) orderName += " 외 " + (orderItems.size() - 1) + "개";
                    for (OrderItem orderItem : orderItems) {
                        Product product = productDAO.findById(orderItem.getProductId());
                        totalPrice += product.getPrice() * orderItem.getAmount();
                    }
            %>
            <tr>
                <td><%= orderName %>
                </td>
                <td><%= order.getOrderedDate() %>
                </td>
                <td><%= totalPrice %>
                </td>
                <td>
                    <form action="order_detail.jsp" method="post">
                        <button type="submit" name="orderId" value="<%=order.getId()%>">상세보기</button>
                    </form>
                </td>
            </tr>
            <%
                }
            %>
            </tbody>
        </table>
    </main>
    <footer>
        제작자 GitHub : https://github.com/chisan01
    </footer>
</div>
</body>
</html>