<%@ page import="com.example.myhompage.product.ProductDAO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.example.myhompage.product.Product" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>SHOPPING MALL</title>
</head>
<body>
<nav>
    <%
        String memberId = (String) session.getAttribute("memberId");
        if (memberId == null) {
    %>
    <a href="./login.html">
        <button>로그인</button>
    </a>
    <%
    } else {
    %>
    <a href="./logout.jsp">
        <button>로그아웃</button>
    </a>
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
            <li><a href="./index.jsp">전체</a></li>
            <li><a href="./index_book.jsp">도서</a></li>
            <li><a href="./index_clothes.jsp">의류</a></li>
            <li><a href="./index_food.jsp">식품</a></li>
        </ul>
    </aside>
    <section id="popular"></section>
    <section id="normal">
        <div class="container">
            <%
                ProductDAO productDAO = new ProductDAO();
                ArrayList<Product> list = productDAO.findAllByCategory("food");
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