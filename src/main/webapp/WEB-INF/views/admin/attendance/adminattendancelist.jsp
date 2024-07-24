<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<c:set var="path" value="${pageContext.request.contextPath }"/>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%@ include file="/WEB-INF/views/admin/adminsidebar.jsp" %> 
 	<div class="main-panel">

	<%@ include file="/WEB-INF/views/common/header_bar.jsp" %> 	
		<div class="col-md-12">
		                <div class="card">
		                  <br><br><br><br>
		              	  <div class="card-header">
		                    <h4 class="card-title">전체사원근태관리</h4>
		                  </div>
		                  <div class="card-body">
		                  		  <nav
					                 class="navbar navbar-header-left navbar-expand-lg navbar-form nav-search p-0 d-none d-lg-flex"
					              >
					              
					              <select class="form-select input-fixed" >
					              	<option>1</option>
					              	<option>2</option>
					              	<option>3</option>
					              </select>
		                          <div class="input-group">
				                    <div class="input-group-prepend">
				                      <button type="submit" class="btn btn-search pe-1">
				                        <i class="fa fa-search search-icon"></i>
				                      </button>
				                    </div>
				                    <input
				                      type="text"
				                      id="searchKey"
				                      name="searchKey"
				                      placeholder="Search ..."
				                      class="form-control"
				                    />
				                  </div>          
				               </nav>
		                    <div class="table-responsive">
		                      <table
		                        id="multi-filter-select"
		                        class="display table table-striped table-hover"
		                      >
		                        <thead>
		                          <tr>
		                            <th>근무날짜</th>
		                            <th>ID</th>
		                            <th>이름</th>
		                            <th>출근시간</th>
		                            <th>퇴근시간</th>
		                            <th>초과근무시간</th>
		                            <th>상태</th>
		                          </tr>
		                        </thead>
		                        <tbody>	
		                        <c:if test="${not empty attendance }">
		                        	<c:forEach var="a" items="${attendance }">
				                          <tr>
				                            <td>${a.attendanceDate}</td>
				                            <td>${a.member.memberId}</td>
				                            <td>${a.member.memberName}</td>
				                            <td>${a.attendanceStart.substring(9, 17)}</td>
				                            <td>${a.attendanceEnd.substring(9, 17) }</td>
				                            <td>${a.overtimeKey }</td>
				                            <td>${a.attendanceState}</td>
				                          </tr>
			                        </c:forEach>
		                         </c:if>
		                         <c:if test="${empty attendance }">
		                         	<tr>
		                         		<td><h3>등록된 근태가 없습니다.</h3></td>
		                         	</tr>
		                         	
		                         </c:if>
		                         
		                        </tbody>
		                      </table>
		              		<div>${pagebar}</div>
		                </div>
		              </div>

	</div>
	<%@ include file="/WEB-INF/views/common/footer.jsp" %> 	
	</div>
	</div>
</body>
</html>