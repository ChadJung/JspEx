<%--
  Created by IntelliJ IDEA.
  User: sj
  Date: 2021-07-24
  Time: 오후 1:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="com.jspex.portfolio.domain.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="com.jspex.portfolio.domain.User" scope="page"/>
<jsp:setProperty name="user" property="userID"/>
<jsp:setProperty name="user" property="userPassword"/>
<html>
<head>
    <title>JSP 게시판 웹 사이트</title>
</head>
<body>
    <%
        UserDAO userDAO = new UserDAO();
        int result = userDAO.login(user.getUserID(), user.getUserPassword());
        PrintWriter script = response.getWriter();
        if (result == 1) {
            script.println("<script>");
            script.println("location.href = 'main.jsp");
            script.println("</script>");
        } else if (result == 0) {
            script.println("<script>");
            script.println("alert('Password is incorrect')");
            script.println("history.back()");
            script.println("</script>");
        }else if (result == -1) {
            script.println("<script>");
            script.println("alert('ID doesn't exist')");
            script.println("history.back()");
            script.println("</script>");
        }else if (result == -2) {
            script.println("<script>");
            script.println("alert('Database error')");
            script.println("history.back()");
            script.println("</script>");
        }
    %>
</body>
</html>
