<%--
  Created by IntelliJ IDEA.
  User: sj
  Date: 2021-07-24
  Time: 오후 1:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="com.jspex.portfolio.domain.bbs.BbsDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="bbs" class="com.jspex.portfolio.domain.bbs.Bbs" scope="page"/>
<jsp:setProperty name="bbs" property="bbsTitle"/>
<jsp:setProperty name="bbs" property="bbsContent"/>
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

    if (userID == null) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('로그인이 필요합니다.')");
        script.println("location.href = 'login.jsp'");
        script.println("</script>");
    }
    else{
        if(bbs.getBbsTitle() == null || bbs.getBbsContent() == null) {
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('입력되지 않은 사항이 있습니다'");
            script.println("history.back()");
            script.println("</script>");
        }
        else {
            BbsDAO bbsDAO = new BbsDAO();
            int result = bbsDAO.write(bbs.getBbsTitle(), userID, bbs.getBbsContent());
            PrintWriter script = response.getWriter();
            if (result == -1) {
                script.println("<script>");
                script.println("alert('글쓰기에 실패했습니다.')");
                script.println("history.back()");
                script.println("</script>");
            } else {
                script.println("<script>");
                script.println("location.href = 'bbs.jsp'");
                script.println("</script>");
            }
        }
    }
%>
</body>
</html>
