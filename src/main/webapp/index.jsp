<%@ page import="com.example.myhompage.product.ProductDAO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.example.myhompage.product.Product" %>
<%@ page import="com.example.myhompage.order.OrderDAO" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    final String category = "all";
%>
<!DOCTYPE html>
<html>
<head>
    <title>SHOPPING MALL</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
<div>
    <nav>
        <%
            String memberId = (String) session.getAttribute("memberId");
            if (memberId == null) {
        %>
        <button onclick="location.href='./login.html'">로그인</button>
        <%
        } else {
        %>
        <button onclick="location.href='./logout.jsp'">로그아웃</button>
        <button onclick="location.href='./shopping_cart.jsp'">장바구니</button>
        <button onclick="location.href='./order_history.jsp'">구매기록</button>
        <%
            }
        %>
    </nav>
    <header>
        <a href="./index.jsp">
            <h1>SHOPPING MALL</h1>
        </a>
    </header>
    <main>
        <aside id="category">
            <ul>
                <li><a href="./index.jsp">전체</a></li>
                <li><a href="./index_book.jsp">도서</a></li>
                <li><a href="./index_clothes.jsp">의류</a></li>
                <li><a href="./index_food.jsp">식품</a></li>
                <li>
                    <form action="search_result.jsp" method="post" >
                        <input type="search" name="keyword" id="keyword">
                        <button type="submit">검색</button>
                    </form>
                </li>
            </ul>
        </aside>
        <section id="popular">
            <h2>누적판매량 TOP 3</h2>
            <div class="container">
                <%
                    ProductDAO productDAO = new ProductDAO();
                    OrderDAO orderDAO = new OrderDAO();
                    ArrayList<Long> top3OrderedProductIds = orderDAO.getTop3OrderedProductIdsByCategory(category);
                    for (int i = 0; i < top3OrderedProductIds.size(); i++) {
                        Product p = productDAO.findById(top3OrderedProductIds.get(i));
                %>
                <div class="item">
                    <h3><%=i + 1%>
                    </h3>
                    <img src="./img/<%=p.getImageSrc()%>" alt="<%=p.getName()%>">
                    <p><%=p.getName()%>
                    </p>
                    <p><%=p.getPrice()%>원</p>
                    <form action="add_shopping_cart.jsp" method="POST">
                        <input type="hidden" name="productId" value="<%=p.getId()%>">
                        <button type="submit">장바구니에 추가</button>
                    </form>
                </div>
                <%
                    }
                %>
            </div>
        </section>
        <section id="normal">
            <div class="container">
                <%
                    productDAO = new ProductDAO();
                    ArrayList<Product> list = productDAO.findAllByCategory(category);
                    for (Product p : list) {
                %>
                <div class="item">
                    <img src="./img/<%=p.getImageSrc()%>" alt="<%=p.getName()%>">
                    <p><%=p.getName()%>
                    </p>
                    <p><%=p.getPrice()%>원</p>
                    <form action="add_shopping_cart.jsp" method="POST">
                        <input type="hidden" name="productId" value="<%=p.getId()%>">
                        <button type="submit">장바구니에 추가</button>
                    </form>
                </div>
                <%
                    }
                %>
            </div>
        </section>
    </main>
    <footer>
        제작자 GitHub : https://github.com/chisan01
    </footer>
</div>
</body>
</html>