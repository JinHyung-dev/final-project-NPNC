<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<c:set var="path" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
  <!-- SweetAlert2 CSS -->
  <link href="https://cdn.jsdelivr.net/npm/sweetalert2@10.10.2/dist/sweetalert2.min.css" rel="stylesheet">
  <!-- SweetAlert2 JS -->
  <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10.10.2/dist/sweetalert2.all.min.js"></script>
</head>
<body>

	<c:if test="${loginMember.accessKey eq 2 }">
 		<%@ include file="/WEB-INF/views/admin/manageadminsidebar.jsp" %> 
 	</c:if>
 	<c:if test="${loginMember.accessKey != 2 }">
 		<%@ include file="/WEB-INF/views/admin/adminsidebar.jsp" %> 
 	</c:if>
 	<div class="main-panel">
 	<c:if test="${loginMember.accessKey eq 2 }">
  		<%@ include file="/WEB-INF/views/common/header_bar.jsp" %> 
  	</c:if>
  	 <c:if test="${loginMember.accessKey != 2 }">
 		<%@ include file="/WEB-INF/views/admin/adminheader_bar.jsp" %>  
 	</c:if>
		<div>	
			<br><br><br><br>
		    <div>
		   		<h4 class="card-title">부서관리</h4>
			</div>
			<form action="${path }/admin/dept/insertdept.do" method="post">
				<div class="form-group">
            		<div class="form-group form-inline">
                          <label
                            for="deptName"
                            class="col-md-3 col-form-label"
                            >부서등록</label
                          >
                          <div class="col-md-9 p-0" style="display:flex">
                            <input
                              type="text"
                              class="form-control input-full"
                              id="deptName"
                              name="deptName"
                              placeholder="부서명"
                            />
                            &ensp;&ensp;&ensp;
							<input type="submit" value="등록" class="btn btn-dark btn-round" data-color="dark">
                          </div>
               		</div>	
               	</div>		
			</form>
		</div>
		<div class="col-md-12">
			<div class="card">
		    <div class="card-body">
		     <div class="table-responsive">
			<table
				id="multi-filter-select"
			    class="display table table-striped table-hover"
			>
				<tr>
					<th>부서코드</th>
					<th>부서명</th>
					<th>비고</th>
				</tr>
				<c:if test="${not empty depts}">
					<c:forEach var="d" items="${depts}">
						<tr>
							<td>${d.deptKey }</td>
							<td>${d.deptName }</td>
							<td>
								<button type="button" class="btn btn-dark btn-round" data-toggle="modal" data-target="#deptformModal" data-member-key="${d.deptKey }">
									수정
								</button>
								 &ensp;&ensp;&ensp;
								<button onclick="deleteModal('${d.deptKey}');" class="btn btn-dark btn-round">삭제</button>
							</td>
						</tr>
					</c:forEach>
				</c:if>
				
			</table>
		</div>
	   </div>
	  </div>
	 </div>
	 	<%@ include file="/WEB-INF/views/admin/dept/updatedept.jsp" %> 
	 	<%@ include file="/WEB-INF/views/common/footer.jsp" %> 	
	</div>
	
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  	<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
  	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
	
	<script>
	 $('#deptformModal').on('show.bs.modal', function (event) {
	        var button = $(event.relatedTarget); // 버튼을 클릭한 요소
	        var deptKey = button.data('member-key'); // `data-member-key` 속성 값
	        
	        $.ajax({
	            url: '${path}/admin/dept/updatedept', // 서버의 실제 엔드포인트로 대체
	            type: 'GET',
	            data: { deptKey: deptKey },
	            dataType: 'json', // 서버 응답을 JSON으로 처리
	            success: function(data) {
	                console.log(data); // 전체 응답을 확인

	                $('#deptNameMo').val(data.dept.deptName);
	                $('#deptKeyMo').val(data.dept.deptKey);

	            },
	            error: function(xhr, status, error) {
	                console.error("AJAX Error: ", status, error);
	            }
	        });
	    });
		
	 
	 function deleteModal(no){
			console.log(no);
			Swal.fire({
				title: '삭제 확인',
				html: '<h4>정말 삭제하시겠습니까?</h4>',
				showCancelButton: true,
				confirmButtonClass: 'btn btn-success',
				cancelButtonClass: 'btn btn-danger ms-2',
				confirmButtonText: '삭제',
				cancelButtonText: '취소',
				buttonsStyling: false,
				reverseButtons: false
			}).then(result => {
				if (result.isConfirmed) {
					//삭제 요청 전송
					$.ajax({
						url: '${path}/admin/dept/deletedept.do',
						data: {no : no},
						dataType: "json",
						method: "post",
						success: data=>{
							console.log();
							if(data.status==="success"){
								Swal.fire({
									title: '삭제 완료',
									html: '<h4>정상적으로 삭제되었습니다.</h4>',
									showCancelButton: true,
									confirmButtonClass: 'btn btn-success',
									cancelButtonClass: 'btn btn-danger ms-2',
									confirmButtonText: '확인',
									cancelButtonText: '취소',
									buttonsStyling: false,
									reverseButtons: false
								}).then(result => {
									location.reload();
								});
							}else{
					            alert("다음과 같은 에러가 발생하였습니다. (" + data.message + ")");
					        };
						},
						error: (xhr, status, error) => {
		                    console.error("Error: ", error);
		                    alert("삭제 요청 중 오류가 발생했습니다.");
		                }
					});
				}
			});
		};
		
		const deleteDept=(key)=>{
		   if(confirm("정말 삭제 하시겠습니까?")){
	           let form = document.createElement("form");
	           form.setAttribute("method", "post");
	           form.setAttribute("action", "${path}/admin/dept/deletedept.do");
	
	           let $key = document.createElement("input");
	           $key.setAttribute("type", "hidden");
	           $key.setAttribute("name", "key");
	           $key.setAttribute("value", key);
	 
	           form.appendChild($key);
	
	
	           document.body.appendChild(form);
	           form.submit();
		   }else{
			   alert("삭제가 취소되었습니다.");
		   }
		   
		}
	</script>
</body>
</html>