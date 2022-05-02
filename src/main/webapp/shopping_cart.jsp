<%@ page import="com.example.myhompage.product.ProductDAO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.example.myhompage.product.Product" %>
<%@ page import="com.example.myhompage.shoppingCart.ShoppingCartDAO" %>
<%@ page import="com.example.myhompage.shoppingCart.ShoppingCart" %>
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
        <form action="edit_shopping_cart.jsp" method="post">
            <table>
                <thead>
                <tr>
                    <th>선택</th>
                    <th>상품명</th>
                    <th>카테고리</th>
                    <th>가격</th>
                    <th>수량</th>
                </tr>
                </thead>
                <tbody>
                <%
                    int totalPrice = 0;
                    ShoppingCartDAO shoppingCartDAO = new ShoppingCartDAO();
                    ProductDAO productDAO = new ProductDAO();
                    ArrayList<ShoppingCart> list = shoppingCartDAO.findAllByMemberId((String) session.getAttribute("memberId"));
                    for (int i = 0; i < list.size(); i++) {
                        Product curProduct = productDAO.findById(list.get(i).getProductId());
                        totalPrice += curProduct.getPrice() * list.get(i).getAmount();
                %>
                <tr>
                    <td><input type="checkbox" name="product_id_list" value="<%=curProduct.getId()%>"></td>
                    <td><%= curProduct.getName() %>
                    </td>
                    <td><%= curProduct.getCategory() %>
                    </td>
                    <td><%= curProduct.getPrice() %>
                    </td>
                    <td><%= list.get(i).getAmount() %>
                    </td>
                </tr>
                <%
                    }
                %>
                </tbody>
            </table>
            <h2 class="total_price"><%="총 가격 = " + totalPrice%>
            </h2>
            <button type="submit" name="action" value="delete">선택한 제품 삭제</button>
            <button type="submit" name="action" value="buy">선택한 제품 구매</button>
        </form>
    </main>
    <footer>
        제작자 GitHub : https://github.com/chisan01
    </footer>
</div>
</body>
</html>