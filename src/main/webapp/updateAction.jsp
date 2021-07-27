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
<%@ page import="com.jspex.portfolio.domain.bbs.Bbs" %>
<%@ page import="com.jspex.portfolio.domain.bbs.BbsDAO" %>
<% request.setCharacterEncoding("UTF-8"); %>
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
    int bbsID = 0;
    if (request.getParameter("bbsID") != null) {
        bbsID = Integer.parseInt(request.getParameter("bbsID"));
    }

    if (bbsID == 0) {
        PrintWriter printWriter = response.getWriter();
        printWriter.println("<script>");
        printWriter.println("console.log('????')");
        printWriter.println("alert('유효하지 않은 글입니다.')");
        printWriter.println("location.href = 'bbs.jsp'");
        printWriter.println("</script>");
    }

    Bbs bbs = new BbsDAO().getBbs(bbsID);
    if (!userID.equals(bbs.getUserID())) {
        PrintWriter printWriter = response.getWriter();
        printWriter.println("<script>");
        printWriter.println("console.log('????')");
        printWriter.println("alert('권한이 없습니다.')");
        printWriter.println("location.href = 'bbs.jsp'");
        printWriter.println("</script>");
    }
    else{
        if(request.getParameter("bbsTitle") == null || request.getParameter("bbsContent") == null) {
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('입력되지 않은 사항이 있습니다'");
            script.println("history.back()");
            script.println("</script>");
        }
        else {
            BbsDAO bbsDAO = new BbsDAO();
            int result = bbsDAO.update(bbsID, request.getParameter("bbsTitle"), request.getParameter("bbsContent"));
            PrintWriter script = response.getWriter();
            if (result == -1) {
                script.println("<script>");
                script.println("alert('글 수정에 실패했습니다.')");
                script.println("history.back()");
                script.println("</script>");
            } else {
                script.println("<script>");
                script.println("location.href = 'view.jsp?bbsID=" + bbsID + "'");
                script.println("</script>");
            }
        }
    }
%>
</body>
</html>
