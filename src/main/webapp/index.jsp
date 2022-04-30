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
            <li><a target="iframe1" href="computer.html">전체</a></li>
            <li><a target="iframe1" href="computer.html">도서</a></li>
            <li><a target="iframe1" href="clothing.html">의류</a></li>
            <li><a target="iframe1" href="music.html">식품</a></li>
        </ul>
    </aside>
    <section id="popular"></section>
    <section id="normal"></section>
</main>
<footer>
    제작자 GitHub : https://github.com/chisan01
</footer>
</body>
</html>