<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<c:set var="path" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>문서 작성</title>
    <meta
      content="width=device-width, initial-scale=1.0, shrink-to-fit=no"
      name="viewport"
    />
    <link
      rel="icon"
      href="${path}/resources/assets/img/kaiadmin/favicon.ico"
      type="image/x-icon"
    />
  </head>
  <body>
    <div class="wrapper">
      <!-- Sidebar -->
      <c:import url="${path }/WEB-INF/views/document/documentSidebar.jsp"/>
      <!-- End Sidebar -->

      <div class="main-panel">
        <div class="main-header">
          <div class="main-header-logo">
          </div>
          <!--  header Navbar 넣을 곳 -->
        </div>
		<!-- 메인 내용 -->
        <div class="container">
          <div class="page-inner">
            <div
              class="d-flex align-items-left align-items-md-center flex-column flex-md-row pt-2 pb-4"
            >
              <div>
                <h3 class="fw-bold mb-3">문서 작성</h3>
                <nav class="navbar navbar-header-left navbar-expand-lg navbar-form nav-search p-0 d-none d-lg-flex">
					<div class="input-group">
						<div class="input-group-prepend pe-1">
							<button type="submit" class="btn btn-search pe-1">
								<i class="fa fa-search search-icon"></i>
							</button>
						</div>
						<input type="text" placeholder="양식명으로 검색" class="form-control">
					</div>
				</nav>
              </div>
              <div class="ms-md-auto py-2 py-md-0">
                <!-- <a href="#" class="btn btn-label-info btn-round me-2">Manage</a> -->
              </div>
            </div>
            <div class="row">
              <div class="col-md-4">
                <div class="card card-round">
                  <div class="card-body">
                    <div class="card-head-row card-tools-still-right">
                      <div class="card-title">양식 목록</div>
                      <div class="card-tools">
                      </div>
                    </div>
                    <!-- 양식폴더 출력 -->
                    <div class="card-list py-4">
                    <c:forEach var="f" items="${folderlist }">
                      <button class="btn item-list border rounded w-100 mb-2">
                        <div class="ms-3">
                        	<i class="icon-drawer"></i>
                        </div>
                        <div class="info-user ms-3">
                          <div class="username text-start">${f.ER_FORM_FOLDER_NAME }</div>
                        </div>
                      </button>
                      </c:forEach> 
                    </div>
                  </div>
                </div>
              </div>
              <div class="col-md-8">
                <div class="card card-round">
                  <div class="card-header">
                    <div class="card-head-row card-tools-still-right">
                      <div class="card-title">Transaction History</div>
                      <div class="card-tools">
                      </div>
                    </div>
                  </div>
                 <div class="card-list p-4 ">
                  <!-- 양식 출력 -->
                  	
                    <c:forEach var="f" begin="1" end="3" step="1">
                      <button class="btn item-list border rounded w-100 mb-2">
                        <div class="ms-3">
                        	<i class="icon-drawer"></i>
                        </div>
                        <div class="info-user ms-3">
                          <div class="username text-start">기본 양식</div>
                        </div>
                      </button>
                      </c:forEach> 
                    </div>
                </div>
              </div>
            </div>
          </div>
        </div>
        </div>
  </body>
</html>
