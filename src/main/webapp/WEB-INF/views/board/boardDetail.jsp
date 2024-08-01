<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>게시판 목록</title>
    <meta content="width=device-width, initial-scale=1.0, shrink-to-fit=no" name="viewport"/>

    <!-- Favicon -->
    <link rel="icon" href="${path}/resources/assets/img/kaiadmin/favicon.ico" type="image/x-icon"/>

    <!-- Fonts and icons -->
    <script src="${path}/resources/assets/js/plugin/webfont/webfont.min.js"></script>
    <script>
      WebFont.load({
        google: { families: ["Public Sans:300,400,500,600,700"] },
        custom: {
          families: [
            "Font Awesome 5 Solid",
            "Font Awesome 5 Regular",
            "Font Awesome 5 Brands",
            "simple-line-icons",
          ],
          urls: ["${path}/resources/assets/css/fonts.min.css"],
        },
        active: function () {
          sessionStorage.fonts = true;
        },
      });
    </script>

    <!-- CSS Files -->
    <link rel="stylesheet" href="${path}/resources/assets/css/bootstrap.min.css" />
    <link rel="stylesheet" href="${path}/resources/assets/css/plugins.min.css" />
    <link rel="stylesheet" href="${path}/resources/assets/css/kaiadmin.min.css" />
    <link rel="stylesheet" href="${path}/resources/assets/css/demo.css" />

    <!-- SweetAlert2 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/sweetalert2@10.10.2/dist/sweetalert2.min.css" rel="stylesheet">

    <!-- Custom Styles -->
    <style>
        body {
            font-family: 'Public Sans', sans-serif;
            background-color: #f8f9fa;
            color: #333;
        }

        .container {
            margin-top: 20px;
            padding: 20px;
            background-color: #ffffff;
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }

        h1 {
            font-size: 24px;
            margin-bottom: 20px;
            color: #343a40;
            font-weight: bold;
        }

        form {
            margin-bottom: 20px;
        }

        input[type="text"] {
            padding: 10px;
            border: 1px solid #ced4da;
            border-radius: 4px;
            flex: 1;
        }

        button {
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            background-color: #007bff;
            color: #fff;
            font-size: 16px;
            cursor: pointer;
        }

        button:hover {
            background-color: #0056b3;
        }

        .card {
            border: 1px solid #dee2e6;
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }

        .card-body {
            padding: 20px;
        }

        .table {
            width: 100%;
            margin-bottom: 1rem;
            color: #212529;
            border-collapse: collapse;
        }

        .table th, .table td {
            padding: 12px;
            vertical-align: middle;
            border: 1px solid #dee2e6;
            text-align: center;
        }

        .table thead th {
            background-color: #007bff;
            color: #fff;
            font-weight: bold;
        }

        .table tbody tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        .table tbody tr:hover {
            background-color: #e2e6ea;
        }

        .table a {
            text-decoration: none;
            color: #007bff;
        }

        .table a:hover {
            text-decoration: underline;
        }

        .sidebar {
            background-color: #343a40;
            color: #fff;
        }

        .sidebar .nav-item a {
            color: #fff;
            padding: 10px;
            border-radius: 4px;
            margin: 5px 0;
            display: flex;
            align-items: center;
            text-decoration: none;
        }

        .sidebar .nav-item a:hover {
            background-color: #495057;
        }

        .sidebar-logo .logo-header .navbar-brand {
            max-height: 40px;
        }
    </style>
</head>
<body>
    <!-- Header -->

    <div class="wrapper">
        <!-- Sidebar -->
        <%@ include file="/WEB-INF/views/board/boardSidebar.jsp" %>

        <!-- Main Panel -->
        <div class="main-panel">
          <%@ include file="/WEB-INF/views/common/header_bar.jsp" %>
          <div class="page-inner">
            
            <div class="container">
                <h1>게시판 목록</h1>
                <!-- Search Form -->
                <form method="get" action="${path}/board/list">
                    <div class="row mt-4">
                        <div class="col-md-8">
                            <input type="text" name="searchKeyword" class="form-control" placeholder="제목 검색" value="${param.searchKeyword}">
                        </div>
                        <div class="col-md-4">
                            <button type="submit" class="btn btn-primary">검색</button>
                        </div>
                    </div>
                </form>
                <div class="row mt-4">
                    <div class="col-md-12">
                        <div class="card">
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table id="multi-filter-select" class="display table table-striped table-hover">
                                        <thead>
                                            <tr>
                                                <th>번호</th>
                                                <th>제목</th>
                                                <th>작성자</th>
                                                <th>작성일</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="board" items="${boardList}">
                                                <tr>
                                                    <td>${board.BOARD_KEY}</td>
                                                    <td><a href="${path}/board/detail/boardKey?boardKey=${board.BOARD_KEY}">${board.BOARD_TITLE}</a></td>
                                                    <td>${board.MEMBER_KEY}</td>
                                                    <td>
                                                        <fmt:formatDate value="${board.BOARD_ENROLL_DATE}" pattern="yyyy년 MM월 dd일" />
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
          </div>
          <%@ include file="/WEB-INF/views/common/footer.jsp" %>
        </div>
    </div>
    
</body>
</html>
