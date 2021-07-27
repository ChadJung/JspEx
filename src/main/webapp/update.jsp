<%--
  Created by IntelliJ IDEA.
  User: sj
  Date: 2021-07-23
  Time: 오후 12:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"
         pageEncoding="UTF-8" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="com.jspex.portfolio.domain.bbs.Bbs" %>
<%@ page import="com.jspex.portfolio.domain.bbs.BbsDAO" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
    <meta name="viewport" content="width=device-width" initial-scale="1">
    <link rel="stylesheet" href="css/bootstrap.css">
    <link rel="stylesheet" href="css/main.css">
    <title>JSP 게시판 웹 사이트</title>
</head>
<body>
    <%
        String userID = null;

        if (session.getAttribute("userID") != null) {
            userID = (String) session.getAttribute("userID");
        }

        if (userID == null) {
            PrintWriter printWriter = response.getWriter();
            printWriter.println("<script>");
            printWriter.println("console.log('????')");
            printWriter.println("alert('로그인이 필요합니다.')");
            printWriter.println("location.href = 'login.jsp'");
            printWriter.println("</script>");
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
    %>
    <nav class="navbar navbar-default">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed"
                    data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
                    aria-expanded="false">
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="main.jsp">JSP 게시판 웹 사이트</a>
        </div>
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav">
                <li><a href="main.jsp">메인</a></li>
                <li class="active"><a href="bbs.jsp">게시판</a></li>
            </ul>
            <ul class="nav navbar-nav navbar-right">
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle"
                       data-toggle="dropdown" role="button" aria-haspopup="true"
                       aria-expanded="false">회원관리<span class="caret"></span></a>
                    <ul class="dropdown-menu">
                        <li><a href="logoutAction.jsp">로그아웃</a></li>
                    </ul>
                </li>
            </ul>
        </div>
    </nav>
    <div class="container">
        <div class="row">
            <form method="post" action="updateAction.jsp?bbsID=<%= bbsID %>">
                <table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
                    <thead>
                    <tr>
                        <th colspan="2" style="background-color: #eeeeee; text-align: center;">게시판 글 수정 양식</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td><input type="text" class="form-control" placeholder="글 제목" name="bbsTitle" maxlength="50" value="<%= bbs.getBbsTitle()%>"></td>
                    </tr>
                    <tr>
                        <td><textarea class="form-control" placeholder="글 내용" name="bbsContent" maxlength="2048"
                                      style="height: 350px; resize: none;"><%= bbs.getBbsContent()%></textarea></td>
                    </tr>
                    </tbody>
                </table>
                <input type="submit" class="btn btn-primary pull-right" value="글 수정"/>
            </form>
        </div>
    </div>

<script src="js/jquery.min.js"></script>
<script src="js/bootstrap.js"></script>
</body>
</html>
