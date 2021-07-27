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

    int bbsID = 0;

    if (request.getParameter("bbsID") != null) {
        bbsID = Integer.parseInt(request.getParameter("bbsID"));
    }

    if (bbsID == 0) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('유효하지 않은 글입니다.')");
        script.println("location.href = 'bbs.jsp");
        script.println("</script>");
    }

    Bbs bbs = new BbsDAO().getBbs(bbsID);
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
        <%
            if (userID == null) {
        %>
        <ul class="nav navbar-nav navbar-right">
            <li class="dropdown">
                <a href="#" class="dropdown-toggle"
                   data-toggle="dropdown" role="button" aria-haspopup="true"
                   aria-expanded="false">접속하기<span class="caret"></span></a>
                <ul class="dropdown-menu">
                    <li><a href="login.jsp">로그인</a></li>
                    <li><a href="join.jsp">회원가입</a></li>
                </ul>
            </li>
        </ul>
        <%
        } else {
        %>
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
        <%
            }
        %>
    </div>
</nav>
<div class="container">
    <div class="row">
        <table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
            <thead>
            <tr>
                <th colspan="3" style="background-color: #eeeeee; text-align: center;">게시판 글 보기</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td style="width: 20%">글 제목</td>
                <td colspan="2"><%=bbs.getBbsTitle()%></td>
            </tr>
            <tr>
                <td style="width: 20%">작성자</td>
                <td colspan="2"><%=bbs.getUserID()%></td>
            </tr>
            <tr>
                <td style="width: 20%">작성일자</td>
                <td colspan="2"><%=bbs.getBbsDate()%></td>
            </tr>
            <tr>
                <td style="width: 20%">내용</td>
                <td colspan="2" style="min-height: 200px; text-align: left"><%=bbs.getBbsContent()%></td>
            </tr>
            </tbody>
        </table>
        <a href="bbs.jsp" class="btn btn-primary">목록</a>
        <%
            if (userID != null && userID.equalsIgnoreCase(bbs.getUserID())) {
        %>
                <a href="update.jsp?bbsID=<%= bbsID %>" class="btn btn-primary">수정</a>
                <a onclick="return confirm('정말로 삭제하시겠습니까?')" href="deleteAction.jsp?bbsID=<%= bbsID %>" class="btn btn-primary">삭제</a>
        <%
            }
        %>
    </div>
</div>

<script src="js/jquery.min.js"></script>
<script src="js/bootstrap.js"></script>
</body>
</html>
