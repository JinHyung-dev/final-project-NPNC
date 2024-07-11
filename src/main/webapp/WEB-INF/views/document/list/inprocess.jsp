<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%> 
<c:set var="path" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>진행 중 문서</title>
    <meta
      content="width=device-width, initial-scale=1.0, shrink-to-fit=no"
      name="viewport"
    />
    <link
      rel="icon"
      type="image/x-icon"
    />
  <!-- SweetAlert2 CSS -->
  <link href="https://cdn.jsdelivr.net/npm/sweetalert2@10.10.2/dist/sweetalert2.min.css" rel="stylesheet">
  <!-- SweetAlert2 JS -->
  <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10.10.2/dist/sweetalert2.all.min.js"></script>
    <style>
    	#tablerow:hover{
    		cursor: pointer; 
    	}
    </style>
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
          <c:import url="${path}/WEB-INF/views/common/header_bar.jsp"/>
        </div>
		<!-- 메인 내용 -->
        <div class="container">
          <div class="page-inner">
            <div
              class="d-flex align-items-left align-items-md-center flex-column flex-md-row pt-2 pb-4"
            >
              <div>
                <h3 class="fw-bold mb-3">결재 상신함</h3>
              </div>
            </div>
            <div class="row">
              <div class="">
                <div class="card card-round">
                  <div class="card-header">
                    <div class="card-head-row card-tools-still-right">
                      <div class="card-title">진행 중인 문서</div>
                      <div class="card-tools">
                      </div>
                    </div>
                  </div>
                  <div class="card-body p-0">
                    <div class="table-responsive">
                      <!-- Projects table -->
                      <table class="table table-hover align-items-center mb-0">
                        <thead class="thead-light">
                          <tr class="text-center">
                          	<!-- <th><input type="checkbox"></th> -->
                            <th scope="col" class="">#</th>
                            <th scope="col" class="">등록 번호</th>
                            <th scope="col" class="">문서 제목</th>
                            <th scope="col" class="">상신 일자</th>
                            <th scope="col" class="">결재 현황</th>
                            <th scope="col" class=""></th>
                          </tr>
                        </thead>
                        <tbody>
	                         <c:if test="${doclist eq null}">
		                         <tr class="text-center">
		                         	<td colspan="5">진행 중인 문서가 없습니다</td>
	                         	</tr>
	                         </c:if>
	                         <c:if test="${doclist ne null}">
	                         	<c:forEach items="${doclist }" var="l" varStatus="vs">
		                         <tr class="text-center" id="tablerow">
		                         	<td>${vs.index+1 }</td>
		                            <td class="text-muted">${l.erDocSerialKey }</td>
		                            <td class=""><c:if test="${l.erDocEmergencyYn eq 'Y'}"><span style="color: red;">[긴급] </span></c:if>${l.erDocTitle }</td>
		                            <td class="">
		                            	<fmt:formatDate value="${l.erDocCreateDate}" type="date" pattern="yy/MM/dd HH:mm"/>
		                            </td>
		                            <td class="approverNow">
		                            	<c:forEach items="${l.approvers }" var="ap">
		                            		<c:if test="${ap.state eq '승인' }">
		                              			<div class="badge badge-success p-1">
		                              				<small class="">${ap.memberTeam }</small><br>
		                              				<small class="">${ap.memberName}</small>
		                              			</div>
		                              		</c:if>
		                            		<c:if test="${ap.state eq '대기' }">
		                              			<div class="badge badge-count">
		                              				<small class="">${ap.memberTeam }</small><br>
		                              				<small class="">${ap.memberName}</small>
		                              			</div>
		                              		</c:if>
		                            		<c:if test="${ap.state eq '읽음' }">
		                              			<div class="badge badge-warning">
		                              				<small class="">${ap.memberTeam }</small><br>
		                              				<small class="">${ap.memberName}</small>
		                              			</div>
		                              		</c:if>
		                            		<c:if test="${ap.state eq '보류' }">
		                              			<div class="badge badge-danger">
		                              				<small class="">${ap.memberTeam }</small><br>
		                              				<small class="">${ap.memberName}</small>
		                              			</div>
		                              		</c:if>
		                              </c:forEach>
		                            </td>
		                         	<td colspan=""><input type="button" value="회수" class="btn btn-outline-secondary" id="retrieveBtn" onclick="modal('${l.erDocSerialKey}');"></td>
		                          </tr>
		                          </c:forEach>
	                          </c:if>
                        </tbody>
                      </table>
                    </div>
                  </div>
                </div>
              </div>
            </div>
           </div>
          </div>
        </div>
      </div>
<script>
	const modal = (no)=>{
		// SweetAlert2 모달 띄우기
		console.log(no);
		Swal.fire({
			title: '회수 확인',
			html: '<h4>정말 회수하시겠습니까? <br>진행 중인 결재가 취소됩니다</h4>',
			showCancelButton: true,
			confirmButtonClass: 'btn btn-success',
			cancelButtonClass: 'btn btn-danger ms-2',
			confirmButtonText: '회수',
			cancelButtonText: '취소',
			buttonsStyling: false,
			reverseButtons: false
		}).then(result => {
			if (result.isConfirmed) {
				// 결재 버튼이 클릭되었을 때 처리할 로직
				console.log('회수하기');
				$.ajax({
					url: `${path}/document/retrieve`,
					data: {no : no},
					dataType: "text",
					method: "post",
					success: data=>{
						if(data==1){
							Swal.fire({
								title: '회수 완료',
								html: '<h4>정상적으로 회수되었습니다.<br>회수 문서함으로 이동하시겠습니까?</h4>',
								showCancelButton: true,
								confirmButtonClass: 'btn btn-success',
								cancelButtonClass: 'btn btn-danger ms-2',
								confirmButtonText: '회수',
								cancelButtonText: '취소',
								buttonsStyling: false,
								reverseButtons: false
							}).then((result) => {
								if (result.isConfirmed) {
									location.assign(`${path}/document/retrieve;`)
								}else{
									location.reload();
								}
							});
						}
					}
				});
			}
		});
	};
</script>
  </body>
</html>
