<%@ page import="com.example.myhompage.product.ProductDAO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.example.myhompage.product.Product" %>
<%@ page import="com.example.myhompage.order.OrderDAO" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    final String category = request.getParameter("category");
%>
<!DOCTYPE html>
<html>
<head>
    <title>SHOPPING MALL</title>
    <link rel="stylesheet" href="style.css">
    <script>
        function reveal() {
            var reveals = document.querySelectorAll(".reveal");

            for (var i = 0; i < reveals.length; i++) {
                var windowHeight = window.innerHeight;
                var elementTop = reveals[i].getBoundingClientRect().top;
                var elementVisible = 150;

                if (elementTop < windowHeight - elementVisible) {
                    reveals[i].classList.add("active");
                } else {
                    reveals[i].classList.remove("active");
                }
            }
        }

        window.addEventListener("scroll", reveal);

        <%
            ProductDAO productDAO = new ProductDAO();
            OrderDAO orderDAO = new OrderDAO();
            ArrayList<Long> top3OrderedProductIds = orderDAO.getTop3OrderedProductIdsByCategory(category);
        %>

        class Product {
            constructor(id, imgSrc, name, price) {
                this.id = id;
                this.imgSrc = imgSrc;
                this.name = name;
                this.price = price;
            }
        }

        const products = [];
        <%
        for(int i=0; i<top3OrderedProductIds.size(); i++){
            Product p = productDAO.findById(top3OrderedProductIds.get(i));
        %>
        products[<%=i%>] = new Product(<%=p.getId()%>, "<%=p.getImageSrc()%>", "<%=p.getName()%>", <%=p.getPrice()%>);
        <%
        }
        %>

        let top30index = 0;

        function prev() {
            const top30item = document.querySelector(".top30_item");

            top30index = (top30index - 1 + <%=top3OrderedProductIds.size()%>) % <%=top3OrderedProductIds.size()%>;
            top30item.children[0].innerHTML = top30index + 1;
            top30item.children[1].src = "./img/" + products[top30index].imgSrc;
            const top30item_detail = top30item.children[2];
            top30item_detail.children[0].innerHTML = products[top30index].name;
            top30item_detail.children[1].innerHTML = "" + products[top30index].price + "원";
            top30item_detail.children[2].children[0].value = products[top30index].id;
        }

        function next() {
            const top30item = document.querySelector(".top30_item");

            top30index = (top30index + 1) %<%=top3OrderedProductIds.size()%>;
            top30item.children[0].innerHTML = top30index + 1;
            top30item.children[1].src = "./img/" + products[top30index].imgSrc;
            const top30item_detail = top30item.children[2];
            top30item_detail.children[0].innerHTML = products[top30index].name;
            top30item_detail.children[1].innerHTML = "" + products[top30index].price + "원";
            top30item_detail.children[2].children[0].value = products[top30index].id;
        }

        setInterval(next, 2000);

    </script>
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
    <main class="list">
        <aside id="category">
            <ul>
                <li>
                    <button onclick="location.href='./index.jsp'">전체</button>
                </li>
                <li>
                    <button onclick="location.href='./index.jsp?category=book'">도서</button>
                </li>
                <li>
                    <button onclick="location.href='./index.jsp?category=clothes'">의류</button>
                </li>
                <li>
                    <button onclick="location.href='./index.jsp?category=food'">식품</button>
                </li>
                <li>
                    <form action="search_result.jsp" method="post">
                        <input type="search" name="keyword" id="keyword">
                        <button type="submit">검색</button>
                    </form>
                </li>
            </ul>
        </aside>
        <section class="highlight">
            <h2>누적판매량 TOP 3</h2>
            <button class="prev" onclick="prev()"><</button>
            <div class="container">
                <%
                    if (top3OrderedProductIds.size() > 0) {
                        Product p = productDAO.findById(top3OrderedProductIds.get(0));
                %>
                <div class="top30_item">
                    <h3>1</h3>
                    <img src="./img/<%=p.getImageSrc()%>" alt="<%=p.getName()%>">
                    <div class="product_detail">
                        <p><%=p.getName()%>
                        </p>
                        <p class="price"><%=p.getPrice()%>원</p>
                        <form action="add_shopping_cart.jsp" method="POST">
                            <input type="hidden" name="productId" value="<%=p.getId()%>">
                            <button type="submit">장바구니에 추가</button>
                        </form>
                    </div>
                </div>
                <%
                    }
                %>
            </div>
            <button class="next" onclick="next()">></button>
        </section>
        <section class="normal">
            <div class="container">
                <%
                    productDAO = new ProductDAO();
                    ArrayList<Product> list = productDAO.findAllByCategory(category);
                    for (Product p : list) {
                %>
                <div class="item reveal">
                    <p class="empty"></p>
                    <img src="./img/<%=p.getImageSrc()%>" alt="<%=p.getName()%>">
                    <p><%=p.getName()%>
                    </p>
                    <p class="price"><%=p.getPrice()%>원</p>
                    <form action="add_shopping_cart.jsp" method="POST">
                        <input type="hidden" name="productId" value="<%=p.getId()%>">
                        <button type="submit">장바구니에 추가</button>
                    </form>
                    <p class="empty"></p>
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