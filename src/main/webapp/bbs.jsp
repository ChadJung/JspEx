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
<%@ page import="com.jspex.portfolio.domain.bbs.BbsDAO" %>
<%@ page import="com.jspex.portfolio.domain.bbs.Bbs" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
    <meta name="viewport" content="width=device-width" initial-scale="1">
    <link rel="stylesheet" href="css/bootstrap.css">
    <link rel="stylesheet" href="css/main.css">
    <title>JSP 게시판 웹 사이트</title>
</head>
<style type="text/css">
    a, a:hover {
        color: #000000;
        text-decoration: none;
    }
</style>
<body>
<%
    String userID = null;

    if (session.getAttribute("userID") != null) {
        userID = (String) session.getAttribute("userID");
    }

    int pageNumber = 1;

    if (request.getParameter("pageNumber") != null) {
        pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
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
                <th style="background-color: #eeeeee; text-align: center;">번호</th>
                <th style="background-color: #eeeeee; text-align: center;">제목</th>
                <th style="background-color: #eeeeee; text-align: center;">작성자</th>
                <th style="background-color: #eeeeee; text-align: center;">작성일</th>
            </tr>
            </thead>
            <tbody>
                <%
                    BbsDAO bbsDAO = new BbsDAO();
                    ArrayList<Bbs> list = bbsDAO.getList(pageNumber);
                    for (Bbs bbs : list) {
                        String date = bbs.getBbsDate();
                %>
                <tr>
                    <td><%= bbs.getBbsID() %>
                    </td>
                    <td><a href="view.jsp?bbsID=<%= bbs.getBbsID() %>"><%= bbs.getBbsTitle()%>
                    </a></td>
                    <td><%= bbs.getUserID() %>
                    </td>
                    <td><%= date.substring(0, 11) + date.substring(11, 13) + "시" + date.substring(14, 16) + "분" %>
                    </td>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>
        <%
            if (pageNumber != 1) {
        %>
        <a href="bbs.jsp?pageNumber=<%=pageNumber - 1%>" class="btn btn-success btn-arrow-left">이전</a>
        <%
            }

            if(bbsDAO.nextPage(pageNumber + 1)) {
        %>
        <a href="bbs.jsp?pageNumber=<%=pageNumber + 1%>" class="btn btn-success btn-arrow-right">다음</a>
        <%
            }
        %>
        <a href="write.jsp" class="btn btn-primary pull-right">글쓰기</a>
    </div>
</div>

<script src="js/jquery.min.js"></script>
<script src="js/bootstrap.js"></script>
</body>
</html>

