<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>공지사항 목록</title>
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
        #tablerow:hover {
            cursor: pointer; 
        }

        .title-container {
            margin-bottom: 20px; /* 제목과 테이블 사이 여백 조절 */
        }

        .search-form {
            margin-bottom: 20px; /* 검색 폼과 제목 사이 여백 조절 */
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
                    <div class="title-container">
                        <h1>공지사항 목록</h1>
                  </div>
        
                    <!-- Search Form -->
                    <form method="get" action="${path}/notice/list" class="search-form">
                        <div class="row">
                            <div class="col-md-8">
                                <input type="text" name="searchKeyword" class="form-control" placeholder="제목 검색" value="${param.searchKeyword}">
                            </div>
                            <div class="col-md-4">
                                <button type="submit" class="btn btn-primary">검색</button>
                            </div>
                        </div>
                    </form>

                    <!-- Notice Table -->
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
                                        <c:forEach var="notice" items="${noticeList}">
                                            <tr>
                                                <td>${notice.noticeKey}</td>
                                                <td><a href="${path}/notice/detail?noticeKey=${notice.noticeKey}">${notice.noticeTitle}</a></td>
                                                <td>${notice.memberKey}</td>
                                                <td><fmt:formatDate value="${notice.noticeEnrollDate}" pattern="yyyy년 MM월 dd일" /></td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <%@ include file="/WEB-INF/views/common/footer.jsp" %>
        </div>
    </div>

    <!-- Bootstrap JS and dependencies -->
    <script src="${path}/resources/assets/js/core/jquery-3.7.1.min.js"></script>
    <script src="${path}/resources/assets/js/core/popper.min.js"></script>
    <script src="${path}/resources/assets/js/core/bootstrap.bundle.min.js"></script>

    <!-- Custom JS -->
    <script src="${path}/resources/assets/js/kaiadmin.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10.10.2/dist/sweetalert2.all.min.js"></script>
    
    <!-- Script for setting path in session storage -->
    <script>
        sessionStorage.setItem("path", "${pageContext.request.contextPath}");
    </script>
</body>
</html>
