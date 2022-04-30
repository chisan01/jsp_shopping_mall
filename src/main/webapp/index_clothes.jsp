<%@ page import="com.example.myhompage.product.ProductDAO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.example.myhompage.product.Product" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>SHOPPING MALL</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
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
    <button>장바구니</button>
    <button>구매기록</button>
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
            <li><a target="iframe1" href="./index.jsp">전체</a></li>
            <li><a target="iframe1" href="./index_book.jsp">도서</a></li>
            <li><a target="iframe1" href="./index_clothes.jsp">의류</a></li>
            <li><a target="iframe1" href="./index_food.jsp">식품</a></li>
        </ul>
    </aside>
    <section id="popular"></section>
    <section id="normal">
        <div class="container">
            <%
                ProductDAO productDAO = new ProductDAO();
                ArrayList<Product> list = productDAO.findAllByCategory("clothes");
                for(Product p : list) {
            %>
            <div class="item" style="border: 1px solid black; width: fit-content;">
                <img src="./img/<%=p.getImageSrc()%>" alt="<%=p.getName()%>">
                <p><%=p.getName()%></p>
                <p><%=p.getPrice()%>원</p>
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
</body>
</html>