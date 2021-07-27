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
<jsp:setProperty name="user" property="userName"/>
<jsp:setProperty name="user" property="userGender"/>
<jsp:setProperty name="user" property="userEmail"/>
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

        if(user.getUserID() == null || user.getUserPassword() == null || user.getUserName() == null || user.getUserGender() == null || user.getUserEmail() == null) {
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('입력되지 않은 사항이 있습니다'");
            script.println("history.back()");
            script.println("</script>");
        }
        else {
            UserDAO userDAO = new UserDAO();
            int result = userDAO.join(user);
            PrintWriter script = response.getWriter();
            if (result == -1) {
                script.println("<script>");
                script.println("alert('이미 존재하는 아이디입니다.')");
                script.println("history.back()");
                script.println("</script>");
            } else {
                session.setAttribute("userID", user.getUserID());
                script.println("<script>");
                script.println("location.href = 'main.jsp'");
                script.println("</script>");
            }
        }
    %>
</body>
</html>
