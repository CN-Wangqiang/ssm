<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>书籍列表</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- 引入 Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<div class="container">

    <div class="row clearfix">
        <div class="col-md-12 column">
            <div class="page-header">
                <h1>
                    <small>书籍列表 —— 显示所有书籍</small>
                </h1>

            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-md-9 column">
            <a class="btn btn-primary" href="${pageContext.request.contextPath}/book/toAddBook">新增</a>
            <a class="btn btn-primary" href="${pageContext.request.contextPath}/book/allBook">显示所有书籍</a>
            <span style="color: red">${error}</span>
        </div>
        <div class="col-md-3 column">
            <form action="${pageContext.request.contextPath}/book/queryBookByName" method="" >
                    <div class="input-group">
                        <input type="text" name="bookName" class="form-control" placeholder="请输入要查找的书籍">
                        <span class="input-group-btn">
                        <button class="btn btn-primary" type="submit">查询</button>
                        </span>
                    </div><!-- /input-group -->
            </form>
        </div>
    </div>

    <div class="row clearfix">
        <div class="col-md-12 column">
            <table class="table table-hover table-striped">
                <thead>
                <tr>
                    <th>书籍编号</th>
                    <th>书籍名字</th>
                    <th>书籍数量</th>
                    <th>书籍详情</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                    <c:forEach var="book" items="${list.data}">
                        <tr>
                            <td>${book.getBookId()}</td>
                            <td>${book.getBookName()}</td>
                            <td>${book.getBookCounts()}</td>
                            <td>${book.getDetail()}</td>
                            <td>
                                <a href="${pageContext.request.contextPath}/book/toUpdateBook?id=${book.getBookId()}">更改</a> |
                                <a href="${pageContext.request.contextPath}/book/del/${book.getBookId()}">删除</a>
                            </td>
                        </tr>
                    </c:forEach>

                </tbody>
            </table>
        </div>
    </div>
    <nav aria-label="Page navigation">
        <ul class="pagination" style="float: right">
            <c:if test="${list.showFirstPage}">
                <li>
                    <a href="${pageContext.request.contextPath}/book/allBook?curPage=1" aria-label="Previous">
                        <span aria-hidden="true">首页</span>
                    </a>
                </li>
            </c:if>

            <c:if test = "${list.showPrevious}">
            <li>
                <a href="${pageContext.request.contextPath}/book/allBook?curPage=${page -1}" aria-label="Previous">
                    <span aria-hidden="true">上一页</span>
                </a>
            </li>
            </c:if>

            <c:forEach var="page" items="${list.pages}" >
                <li><a href="${pageContext.request.contextPath}/book/allBook?curPage=${page}" >${page}</a></li>
            </c:forEach>

            <c:if test = "${list.showNext}">
                <li >
                    <a href="${pageContext.request.contextPath}/book/allBook?curPage=${page + 1}" aria-label="Next">
                        <span aria-hidden="true">下一页</span>
                    </a>
                </li>
            </c:if>

            <c:if test = "${list.showEndPage}">
                <li>
                    <a href="${pageContext.request.contextPath}/book/allBook?curPage=${list.totalPage}" aria-label="Previous">
                        <span aria-hidden="true">尾页</span>
                    </a>
                </li>
            </c:if>

        </ul>
    </nav>
</div>
