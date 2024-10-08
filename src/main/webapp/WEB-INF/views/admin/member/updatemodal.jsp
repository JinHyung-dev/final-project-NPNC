<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<c:set var="path" value="${pageContext.request.contextPath }"/>	
<div class="modal fade" id="updateformModal" tabindex="-1" aria-labelledby="formModalLabel" aria-hidden="true">
	    <div class="modal-dialog modal-lg">
	      <div class="modal-content">
	        <div class="modal-header">
	          <h5 class="modal-title" id="formModalLabel">사원 수정</h5>
	          <button type="button" class="close" data-dismiss="updatemodal" aria-label="Close">
	            <span aria-hidden="true">&times;</span>
	          </button>
	        </div>
        <div class="modal-body">
			<form action="${path}/admin/member/updatememberend.do" method="post" onsubmit="return combineAddressesup();">
				 <div class="container">
		          <div class="page-inner">
		            	<div class="form-group">
							<div class="form-group form-inline">
		                          <label
		                            for="memberIdup"
		                            class="col-md-3 col-form-label"
		                            >아이디</label
		                          >
		                          <div class="col-md-9 p-0">
		                            <input
		                              type="text"
		                              class="form-control input-full"
		                              id="memberIdup"
		                              name="memberId"
									  <%-- value="${member.memberId}" --%>
		                              placeholder="아이디"
									  readonly
		                            />
		                          </div>
		               		</div>	
		            		<div class="form-group form-inline">
		                          <label
		                            for="memberNameup"
		                            class="col-md-3 col-form-label"
		                            >이름</label
		                          >
		                          <div class="col-md-9 p-0">
		                            <input
		                              type="text"
		                              class="form-control input-full"
		                              id="memberNameup"
		                              name="memberName"
									  value="${member.memberName}"
		                              placeholder="이름"
		                            />
		                          </div>
		               		</div>
		               		<div class="form-group form-inline">
		                          <label
		                            for="memberAddressup"
		                            class="col-md-3 col-form-label"
		                            >주소</label
		                          >
		                          <div class="col-md-9 p-0">      
		                             <div style="display:flex">
		                          	<input type="text"
		                          	  		id="zip_code2" 
		                          	  		name="zip_code" 
		                          	  		onclick="openZipSearchUp();" 
		                          	  		readonly="readonly" 
		                          	  		placeholder="우편번호"  
		                          	  		class="form-control input-full">
		                          	&ensp;
								 	<input type="text"
								 	 		 id="addr2" 
								 	 		 name="addr" 
								 	 		 onclick="openZipSearchUp();" 
								 	 		 readonly="readonly" 
								 	 		 placeholder="기본주소"   
								 	 		 class="form-control input-full">
								  	</div>
								  <input type="text"  
								  		id="addr_dtl2"
								  		name="addr_dtl" 
								  		placeholder="상세주소"   
								  		class="form-control input-full">
		                          </div>
		                           <input
		                              type="hidden"
		                              class="form-control input-full"
		                              id="memberAddressup"
		                              name="memberAddress"
									 
		                              placeholder="주소"
		                              readonly
		                            />
		               		</div>
		               		<div class="form-group form-inline">
		                          <label
		                            for="memberPhoneup"
		                            class="col-md-3 col-form-label"
		                            >핸드폰</label
		                          >
		                          <div class="col-md-9 p-0">
		                            <input
		                              type="text"
		                              class="form-control input-full"
		                              id="memberPhoneup"
		                              name="memberPhone"
									  value="${member.memberPhone}"
		                              placeholder="핸드폰번호"
		                            />
		                          </div>
		               		</div>
		               		<div class="form-group form-inline">
		                          <label
		                            for="memberTellup"
		                            class="col-md-3 col-form-label"
		                            >사내번호</label
		                          >
		                          <div class="col-md-9 p-0">
		                            <input
		                              type="text"
		                              class="form-control input-full"
		                              id="memberTellup"
		                              name="memberTell"
									  value="${member.memberTell}"
		                              placeholder="사내번호 예)845-0000"
		                            />
		                          </div>
		               		</div>
								<div class="form-group">
		                          <label for="memberEmailup">Email Address</label>
		                          <input
		                            type="email"
		                            class="form-control"
		                            id="memberEmailup"
		                            name="memberEmail"
									value="${member.memberEmail}"
		                            placeholder="Enter Email"
		                          />
		                        </div>
		                        
		               		<div class="form-group">
			            		<div class="form-group form-inline">
			                          <label
			                            for="memberEnrollDateup"
			                            class="col-md-3 col-form-label"
			                            >입사일</label
			                          >
			                          <div class="col-md-9 p-0">
			                            <input
			                              type="date"
			                              class="form-control input-full"
			                              id="memberEnrollDateup"
			                              name="memberEnrollDate"
										  value="${member.memberEnrollDate}"
			                            />
			                          </div>
		               			</div>
		               		</div>
		               		
							<%-- <c:if test="${member.memberState eq '퇴사'}"> --%>
			               		<div class="form-group">
				            		<div class="form-group form-inline">
				                          <label
				                            for="memberLeaveDateup"
				                            class="col-md-3 col-form-label"
				                            >퇴사일</label
				                          >
				                          <div class="col-md-9 p-0">
				                            <input
				                              type="date"
				                              class="form-control input-full"
				                              id="memberLeaveDateup"
				                              name="memberLeaveDate"
				                              value="0001-01-01"
											  readonly
				                            />
				                          </div>
			               			</div>
			               		</div>
		               		<%-- </c:if> --%>
		               		<div class="form-group">
			            		<div class="form-group form-inline">
			                          <label
			                            for="memberBirthdateup"
			                            class="col-md-3 col-form-label"
			                            >생년월일</label
			                          >
			                          <div class="col-md-9 p-0">
			                            <input
			                              type="date"
			                              class="form-control input-full"
			                              id="memberBirthdateup"
			                              name="memberBirthdate"
										  value="${member.memberBirthdate}"
			                            />
			                          </div>
		               			</div>
		               		</div>
		                        
		                         <div class="form-group">
		                          <label>Gender</label><br />
		                          <div class="d-flex">
		                            <div class="form-check">
		                              <label
		                                class="form-check-label"
		                                for="memberGenderup"
		                              >
		                                남
		                              </label>
		                              <input
		                                class="form-check-input"
		                                type="radio"
		                                name="memberGender"
		                                id="memberGenderup"
		                                value="M"
										<c:if test="${member.memberGender eq 'M'}">checked</c:if>
		                              />

		                            </div>
		                            <div class="form-check">
		                              <label
		                                class="form-check-label"
		                                for="memberGender2up"
		                              >
		                                여
		                              </label>
		                              <input
		                                class="form-check-input"
		                                type="radio"
		                                name="memberGender"
		                                id="memberGender2up"
		                                value="F"
										<c:if test="${member.memberGender eq 'F'}">checked</c:if>
		                              />

		                            </div>
		                          </div>
		                        </div>
		                        
		                         <div class="form-group">
		                          <label for="departmentup"
		                            >부서</label
		                          >
		                          <select
		                            class="form-select"
		                            id="departmentup"
		                            name="deptKey"
		                          >
			                          <c:if test="${not empty dept}">
			                          	<c:forEach var="d" items="${dept }">
			                            <option value="${d.deptKey}" <c:if test="${member.department.deptKey eq d.deptKey}">selected</c:if>>${d.deptName }</option>
			                            </c:forEach>
			                           </c:if>
			                           <c:if test="${empty dept}">
			                            <option value="">select</option>
			                           </c:if>
		                          </select>
		                          
		                          
		                        </div>
		                        <div class="form-group">
		                          <label for="jobup"
		                            >직급</label
		                          >
		                          <select
		                            class="form-select"
		                            id="jobup"
		                            name="jobKey"
		                          >
		                            <c:if test="${not empty job}">
			                          	<c:forEach var="j" items="${job }">
			                            <option value="${j.jobKey }" <c:if test="${member.job.jobKey eq j.jobKey}">selected</c:if>>${j.jobName }</option>
			                            </c:forEach>
			                           </c:if>
			                           <c:if test="${empty job}">
			                            <option value="">select</option>
			                           </c:if>
		                          </select>
		                        </div>
		                        <div class="form-group">
		                          <label for="memberStateup"
		                            >현황</label
		                          >
		                          <select
		                            class="form-select"
		                            id="memberStateup"
		                            name="memberState"
		                            onchange="toggleReadOnly(this)"
		                          >
								  		<option value="재직" <c:if test="${member.memberState eq '재직'}">selected</c:if>>재직</option>
								        <option value="휴직" <c:if test="${member.memberState eq '휴직'}">selected</c:if>>휴직</option>
								        <option value="퇴사" <c:if test="${member.memberState eq '퇴사'}">selected</c:if>>퇴사</option>
		                          </select>
		                        </div>
		 
		                       <div class="form-group">
		                          <label class="form-label">권한</label>
		                 <%--          <div class="selectgroup selectgroup-pills">
		                            <label class="selectgroup-item">
		                              <input
		                                type="checkbox"
		                                name="accessKey"
		                                value="1"
		                                class="selectgroup-input"
										<c:if test="${member.accessKey == 1}">checked</c:if>
		                              />
		                              <span class="selectgroup-button">관리자</span>
		                            </label>
		                            <label class="selectgroup-item">
		                              <input
		                                type="checkbox"
		                                name="accessKey"
		                                value="2"
		                                class="selectgroup-input"
										<c:if test="${member.accessKey == 2}">checked</c:if>
		                              />
		                              <span class="selectgroup-button">경영</span>
		                            </label>
		                            <label class="selectgroup-item">
		                              <input
		                                type="checkbox"
		                                name="accessKey"
		                                value="3"
		                                class="selectgroup-input"
										<c:if test="${member.accessKey == 3}">checked</c:if>
		                              />
		                              <span class="selectgroup-button">인사</span>
		                            </label>
		                            <label class="selectgroup-item">
		                              <input
		                                type="checkbox"
		                                name="accessKey"
		                                value="3"
		                                class="selectgroup-input"
										<c:if test="${member.accessKey == 4}">checked</c:if>
		                              />
		                              <span class="selectgroup-button">사원</span>
		                            </label>
		                          </div> --%>
				                  <select
		                            class="form-select"
		                            id="accessKeyup"
		                            name="accessKey"
		                          >
		                            <option value="4" <c:if test="${member.accessKey eq '4'}">selected</c:if>>사원</option>
		                            <option value="3" <c:if test="${member.accessKey eq '3'}">selected</c:if>>인사</option>
		                            <option value="2" <c:if test="${member.accessKey eq '2'}">selected</c:if>>경영</option>
		                            <option value="1" <c:if test="${member.accessKey eq '1'}">selected</c:if>>관리자</option>
		                            
		                          </select>
		                        </div>
		                          <button
					                  type="submit"
					                  class="btn btn-success"
					                  data-color="dark"
					                >수정</button>
		                      </div>
		            
		           </div>
		          </div>
		 
				</form>		
		</div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
        </div>
      </div>
    </div>
  </div> 
  

<script>
function openZipSearchUp() {
    new daum.Postcode({
    	oncomplete: function(data) {     
		var addr = ''; 
		if (data.userSelectedType === 'R') { 
			addr = data.roadAddress;
		} else {
			addr = data.jibunAddress;
		}

		$("#zip_code2").val(data.zonecode);
		$("#addr2").val(addr);
		$("#addr_dtl2").val("");
		$("#addr_dtl2").focus();
		
        }
    }).open();
}

function combineAddressesup() {
    // 각 입력 필드의 값 가져오기
    var zipCode = $("#zip_code2").val();
    var basicAddress = $("#addr2").val();
    var detailedAddress = $("#addr_dtl2").val();
    
    // 값을 결합하여 하나의 문자열로 만들기 (구분자는 필요에 따라 설정)
    var fullAddress = zipCode + ' ' + basicAddress + ' ' + detailedAddress;
    console.log(fullAddress);
    // 숨겨진 입력 필드에 결합된 값을 설정
    document.getElementById('memberAddressup').value = fullAddress;
    
    // 폼 제출
    return true; // 폼이 정상적으로 제출되도록 함
}
</script>