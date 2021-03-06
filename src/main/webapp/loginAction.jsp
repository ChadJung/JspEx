<%--
  Created by IntelliJ IDEA.
  User: sj
  Date: 2021-07-24
  Time: 오후 1:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="com.jspex.portfolio.domain.user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="com.jspex.portfolio.domain.user.User" scope="page"/>
<jsp:setProperty name="user" property="userID"/>
<jsp:setProperty name="user" property="userPassword"/>
<html>
<head>
    <title>JSP 게시판 웹 사이트</title>
</head>
<body>
    <%
        String userID = null;

        if (session.getAttribute("userID") != null) {
            userID = (String) session.getAttribute("userID");
        }

        if (userID != null) {
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('이미 로그인이 되어있습니다.')");
            script.println("location.href = 'main.jsp");
            script.println("</script>");
        }

        UserDAO userDAO = new UserDAO();
        int result = userDAO.login(user.getUserID(), user.getUserPassword());
        PrintWriter script = response.getWriter();
        if (result == 1) {
            session.setAttribute("userID", user.getUserID());
            script.println("<script>");
            script.println("location.href = 'main.jsp'");
            script.println("</script>");
        } else if (result == 0) {
            script.println("<script>");
            script.println("alert('비밀번호가 틀립니다.')");
            script.println("history.back()");
            script.println("</script>");
        }else if (result == -1) {
            script.println("<script>");
            script.println("alert('아이디가 존재하지 않습니다.')");
            script.println("history.back()");
            script.println("</script>");
        }else if (result == -2) {
            script.println("<script>");
            script.println("alert('데이베이스 에러')");
            script.println("history.back()");
            script.println("</script>");
        }
    %>
</body>
</html>
