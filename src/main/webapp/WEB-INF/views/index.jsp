<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
	//세션에 현재 페이지를 저장
	session.setAttribute("lastPage", request.getRequestURL().toString());
%>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>Kaiadmin - Bootstrap 5 Admin Dashboard</title>
    <meta
      content="width=device-width, initial-scale=1.0, shrink-to-fit=no"
      name="viewport"
    />
    <link
      rel="icon"
      href="${path}/resources/assets/img/kaiadmin/favicon.ico"
      type="image/x-icon"
    />
	
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
      
      sessionStorage.setItem("path", "${path}"); 
    </script>

    <!-- CSS Files -->
    <link rel="stylesheet" href="${path}/resources/assets/css/bootstrap.min.css" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <link rel="stylesheet" href="${path }/resources/bm/css/bootstrap-4.min.css">
    <link rel="stylesheet" href="${path }/resources/bm/css/fullcalendar.css">
    <link rel="stylesheet" href="${path}/resources/assets/css/plugins.min.css" />
    <link rel="stylesheet" href="${path}/resources/assets/css/kaiadmin.min.css" />
     <link rel="stylesheet" href="${path }/resources/bm/css/daterangepicker.css">
    <!-- CSS Just for demo purpose, don't include it in your project -->
    <link rel="stylesheet" href="${path}/resources/assets/css/demo.css" />
    
      <!-- SweetAlert2 CSS -->
	  <link href="https://cdn.jsdelivr.net/npm/sweetalert2@10.10.2/dist/sweetalert2.min.css" rel="stylesheet">
	  <!-- SweetAlert2 JS -->
	  <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10.10.2/dist/sweetalert2.all.min.js"></script>
  </head>
 <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
 

<style>
#calendar-container {
  width: 100%;
  height: 100%; /* 화면 전체 높이 사용 */
  position: relative; /* 자식 요소의 절대 위치 지정에 필요 */
  overflow: hidden; /* 자식 요소가 넘칠 경우 스크롤바 제거 */
}

/* 캘린더의 크기를 부모 요소에 맞게 설정 */
#calendar {
  width: 100%;
  height: 100%; /* 부모 요소의 높이와 맞추기 */
}
.activity-feed {
  padding: 15px;
  list-style: none;
}

.activity-feed .feed-item {
  position: relative;
  padding-bottom: 20px;
  padding-left: 30px;
  border-left: 2px solid #e4e8eb;
}

.activity-feed .feed-item:last-child {
  border-color: transparent;
}

.activity-feed .feed-item::after {
  content: "";
  display: block;
  position: absolute;
  top: 0;
  left: -6px;
  width: 10px;
  height: 10px;
  border-radius: 6px;
  background: #fff;
  border: 1px solid #f37167;
}

.activity-feed .feed-item .date {
  display: block;
  position: relative;
  top: -5px;
  color: #8c96a3;
  text-transform: uppercase;
  font-size: 13px;
}

.activity-feed .feed-item .text {
  position: relative;
  top: -3px;
}

.activity-feed .feed-item .text small {
  display: block;
  font-size: 12px;
  color: #999;
}

.feed-item-info::after {
  background: #87CEFA !important;
}

.feed-item-secondary::after {
  background: #87CEFA !important;
}

.feed-item-danger::after {
  background: #F08080 !important;
}

.feed-item-warning::after {
  background: #F5DEB3 !important;
}

.feed-item-success::after {
  background: #90EE90 !important;
}
.date-display {
    font-weight: bold;
    color: #333;
    /* 추가적인 스타일 */
}
	     .main-header {
		    background: #fff;
		    min-height: 60px;
		    width:100%;
		    position: static;
		    z-index: 1001
		}
		.container{
			height: 100%;
			/* background-color: aquamarine; */
       		max-width: 1800px;
			
		}
		.firstwidget{
			display: flex;
			flex-direction: row;
			flex-wrap: noWrap;
       	
		}
		.firstwidget>div{
			margin-right: 30px;
		}
		 .pagination-container {
            display: flex;
            justify-content: center; /* Flexbox를 사용하여 중앙으로 정렬 */
           /*  margin-top: 20px; /* 위쪽 여백 추가 (선택사항) */ 
        }
        /* 전자결재 위젯 css */
    	#tablerow:hover{
    		cursor: pointer; 
    	}
    	.truncate {
		    overflow: hidden;
		    white-space: nowrap;
		    text-overflow: ellipsis;
		}
				
		.cityAndTem {
		    display: flex;
		    flex-direction: row;
		    flex-wrap: nowrap;
		    justify-content: space-between; /* .weather_icon을 왼쪽 정렬하고 나머지 요소를 오른쪽 정렬합니다 */
		    align-items: flex-start; /* 항목을 상단에 정렬합니다 */
		}
		
		.weather_icon {
		    margin-right: auto; /* 다른 항목들을 오른쪽으로 밀어냅니다 */
		}
		
		.right-container {
		    display: flex;
		    flex-direction: column;
		    align-items: flex-end;
		    margin-top: 36px;
		    margin-right: 40px;
		}
		
		.left-container {
		    display: flex;
		    flex-direction: column;
		    align-items: flex-start;
		    margin-top: 60px;
		    font-size: 11pt;
		}
		
		.weatherFont{
			color: black;
		}
		
		.attendanceBox{
			display: flex;
			flex-direction: row;
			flex-wrap: noWrap;
			justify-content: space-around;
		}
		
		#boardMainTable th{
		
			font-weight: normal !important;
			
		}
	</style>	
  <body>
               <%@ include file="/WEB-INF/views/common/header_bar.jsp" %>

        <div class="container">
          <div class="page-inner">
          
           
          
          <div class="firstwidget">
			<!--출퇴근, 날씨-->
             <div class="col-md-6" style="width: 26%; height: 470px;">
                <div class="card bg-primary-gradient" style="height: 228px;">
                  <div class="card-header">
                    <h4 class="card-title" style="color: white;">출/퇴근 버튼</h4>
                  </div>
                  <div class="card-body">
					<div>
						<div>
							<!-- clock widget start -->
							<script type="text/javascript"> var css_file=document.createElement("link"); css_file.setAttribute("rel","stylesheet"); css_file.setAttribute("type","text/css"); css_file.setAttribute("href","https://s.bookcdn.com//css/cl/bw-cl-180x170r4.css?v=0.0.1"); document.getElementsByTagName("head")[0].appendChild(css_file); </script> <div id="tw_14_2058017150"><div style="width:145px; height:50px; margin: 0 auto;"><a href="https://booked.kr/time/seoul-18406">서울특별시</a><br/></div></div> <script type="text/javascript"> function setWidgetData_2058017150(data){ if(typeof(data) != 'undefined' && data.results.length > 0) { for(var i = 0; i < data.results.length; ++i) { var objMainBlock = ''; var params = data.results[i]; objMainBlock = document.getElementById('tw_'+params.widget_type+'_'+params.widget_id); if(objMainBlock !== null) objMainBlock.innerHTML = params.html_code; } } } var clock_timer_2058017150 = -1; widgetSrc = "https://widgets.booked.net/time/info?ver=2;domid=593;type=14;id=2058017150;scode=;city_id=;wlangid=24;mode=2;details=0;background=ffffff;border_color=ffffff;color=e6e6e6;add_background=ffffff;add_color=e6e6e6;head_color=ffffff;border=0;transparent=0"; var widgetUrl = location.href; widgetSrc += '&ref=' + widgetUrl; var wstrackId = ""; if (wstrackId) { widgetSrc += ';wstrackId=' + wstrackId + ';' } var timeBookedScript = document.createElement("script"); timeBookedScript.setAttribute("type", "text/javascript"); timeBookedScript.src = widgetSrc; document.body.appendChild(timeBookedScript); </script>
							<!-- clock widget end -->
						</div>
						<div class="attendanceBox">
							<div style="margin-top:20px;">
								<button id="startAttendanceBtn" style="display: ${not empty checkStartTime ? 'none' : 'inline'}; width: 150px; font-size: 17px;" class="btn btn-light btn-round">
										출근
								</button>
								<div id="attendanceResult" style="color: white; font-size: 15px; margin-top:10px;">
								<c:if test="${not empty checkStartTime}">
									<%-- 출근 시간 : ${checkStartTime.substring(9, 17)}   --%>
									출근 시간 : ${fn:substring(checkStartTime, fn:length(checkStartTime) - 8, fn:length(checkStartTime))}
								</c:if>
								</div>	
							</div>
							<div style="margin-top:20px;">
								<button id="endAttendanceBtn" style="display: ${not empty checkEndTime ? 'none' : 'inline'}; width: 150px; font-size: 17px;"  class="btn btn-light btn-round">
									퇴근
								</button>
								<div id="attendanceEndResult" style="color: white; font-size: 15px; margin-top:10px;">
								<c:if test="${not empty checkEndTime}">
									<%-- 퇴근 시간 : ${checkEndTime.substring(9, 17)}   --%>
									퇴근 시간 : ${fn:substring(checkEndTime, fn:length(checkEndTime) - 8, fn:length(checkEndTime))}
								</c:if>
								</div>
							</div>	
						</div>
					</div>
                   
                  </div>
                </div>
                <!-- 날씨 위젯  -->
				<div class="card" style=" padding : 20px; color : #fff; height : 210px">
				 
				  <div class="cityAndTem">			
					  
				      <div class="weather_icon" >
				      </div>
					  
					  <div class=" right-container">
					      <div class="current_temp weatherFont" style="font-size : 35pt; "></div>
					      <div class="weather_description weatherFont" style="font-size : 20pt; "></div>
					      <div class="city weatherFont" style="font-size : 13pt"></div>
					  </div>
					   <div class="left-container" style="float : left; margin-top: 60px; font-size : 11pt">
					          <div class="temp_min weatherFont" style="width: 100px;"></div>
					          <div class="temp_max weatherFont" style="width: 100px;"></div>
					          <div class="humidity weatherFont" style="width: 100px;"></div>
					          <div class="wind weatherFont" style="width: 100px;"></div>
					          <div class="cloud weatherFont" style="width: 100px;"></div>
					  </div>
				  </div>
				</div>
              </div>
			<div class="col-md-6" style="width: 30%;">
			  <div class="card" style="height: 470px;">
			    <div class="card-header">
			      <div class="card-head-row card-tools-still-right">
			        <div class="card-title">금주의 일정</div>
			      </div>
			    </div>
			    <div class="card-body" style="overflow-y: auto; max-height: 470px;">
			      <ol class="activity-feed" style="padding-right: 15px;">
				<c:if test="${!empty weekCal}">
				  <c:forEach var="event" items="${weekCal}">
				    <li class="feed-item" style="border-left-color: ${event.backgroundColor};">
				    <span class="date-display">
					    ${fn:substring(event.start, 5, 7)}월 ${fn:substring(event.start, 8, 10)}일
					    <c:choose>
					        <c:when test="${fn:substring(event.start, 11, 13) == '01'}"> (월)</c:when>
					        <c:when test="${fn:substring(event.start, 11, 13) == '02'}"> (화)</c:when>
					        <c:when test="${fn:substring(event.start, 11, 13) == '03'}"> (수)</c:when>
					        <c:when test="${fn:substring(event.start, 11, 13) == '04'}"> (목)</c:when>
					        <c:when test="${fn:substring(event.start, 11, 13) == '05'}"> (금)</c:when>
					        <c:when test="${fn:substring(event.start, 11, 13) == '06'}"> (토)</c:when>
					        <c:when test="${fn:substring(event.start, 11, 13) == '07'}"> (일)</c:when>
					    </c:choose>
					</span>
					<br>
				      <span class="text">
				        ${event.title}
				        <c:if test="${event.allDay == 'N'}">
				          (${fn:substring(event.start, 11, 16)} - ${fn:substring(event.end, 11, 16)})
				        </c:if>
				        <c:if test="${event.allDay == 'Y'}">
				          (하루종일)
				        </c:if>
				        <br>
				        <small>${event.description}</small>
				      </span>
				    </li>
				  </c:forEach>
				</c:if>
				<c:if test="${empty weekCal}">
				  <span>금주의 일정이 없습니다.</span>
				</c:if>
			      </ol>
			    </div>
			  </div>
			</div>
               <div class="col-md-7"  style="width: 40%;">
                <div class="card" style="height: 470px;">
                  <div class="card-body">
                  	<div id="calendar-container">
                  		<div id="calendar"></div>
                  	</div>
                  </div>
                </div>
              </div>
               <!-- 여기다 first 위젯 박스 -->
              </div>
             <div class="col-md-8" style="width: 100%;">
                <div class="card card-round" style="height: 470px;">
                  <div class="card-header">
                    <div class="card-head-row card-tools-still-right">
                      <div class="card-title">전자결재 현황</div>
                      	<a href="${path }/document/form" class="btn-secondary btn-border btn btn-round ms-2 selectgroup-button">신규 작성</a>
                      <div class="card-tools">
                      	<div class="selectgroup selectgroup-secondary selectgroup-pills">
                            <label class="selectgroup-item">
                              <input type="radio" name="icon-input" value="1" class="selectgroup-input" checked>
                              <span class="selectgroup-button selectgroup-button-icon" id="btnInProgress">진행 문서</span>
                            </label>
                            <label class="selectgroup-item">
                              <input type="radio" name="icon-input" value="4" class="selectgroup-input">
                              <span class="selectgroup-button selectgroup-button-icon" id="btnPending">결재 대기 문서</span>
                            </label>
                          </div>
                      </div>
                    </div>
                  </div>
				  
				
				  
                  <div class="card-body p-0">
                    <div class="table-responsive">
                      <!-- Projects table -->
                      <table class="table table-hover align-items-center mb-0" id="inproTable" style="width: 100%;">
			            <thead class="thead-light">
			              <tr class="text-center">
			              	<!-- <th><input type="checkbox"></th> -->
			                <th scope="col" class="">#</th>
			                <th scope="col" class="">등록 번호</th>
			                <th scope="col" class="">문서 제목</th>
			                <th scope="col" class="">상신 일자</th>
			                <th scope="col" class="">결재 현황</th>
			              </tr>
			            </thead>
			            <tbody>
			              <c:if test="${empty doclist}">
			               <tr class="text-center">
			               	<td class="truncate"  colspan="5">진행 중인 문서가 없습니다</td>
			              	</tr>
			              </c:if>
			              <c:if test="${doclist ne null}">
			              	<c:forEach items="${doclist }" var="l" varStatus="vs" begin="0" end="4">
			               <tr class="text-center" id="tablerow" data-doc-id="${l.erDocKey }">
			               	<td class="truncate" >${vs.index+1 }</td>
			                  <td class="truncate text-muted">${l.erDocSerialKey }</td>
			                  <td class="truncate"><c:if test="${l.erDocEmergencyYn eq 'Y'}"><span style="color: red;">[긴급] </span></c:if>${l.erDocTitle }</td>
			                  <td class="truncate">
			                  	<fmt:formatDate value="${l.erDocCreateDate}" type="date" pattern="yyyy/MM/dd HH:mm:ss"/>
			                  </td>
			                  <td class="truncate approverNow p-3">
			                       <div class="progress progress-sm w-75 mx-auto">
			                 			<c:set var="count" value="0" />
			                  	<c:forEach items="${l.approvers}" var="ap">
								    <c:if test="${ap.state eq '승인'}">
								        <c:set var="count" value="${count + 1}" />
								    </c:if>
								</c:forEach>
			                  	<div class="progress-bar bg-danger" style="width: ${count/l.approvers.size()*100}%;" role="progressbar" aria-valuenow="${count }" aria-valuemin="0" aria-valuemax="${l.approvers.size() }"></div>
			                  	<%-- <c:forEach items="${l.approvers }" var="ap">
			                  		<c:if test="${ap.state eq '승인' }">
			                  			<div class="badge badge-success" style="min-width: 60px;">
			                  				<small class="">${ap.memberTeamName }</small><br>
			                  				<small class="">${ap.memberJobName} ${ap.memberName}</small>
			                  			</div>
			                  		</c:if>
			                		<c:if test="${ap.state eq '대기' }">
			                  			<div class="badge badge-count" style="min-width: 60px;">
			                  				<small class="">${ap.memberTeamName }</small><br>
			                  				<small class="">${ap.memberJobName} ${ap.memberName}</small>
			                  			</div>
			                  		</c:if>
			                		<c:if test="${ap.state eq '읽음' }">
			                  			<div class="badge badge-info" style="min-width: 60px;">
			                  				<small class="">${ap.memberTeamName }</small><br>
			                  				<small class="">${ap.memberJobName} ${ap.memberName}</small>
			                  			</div>
			                  		</c:if>
			                		<c:if test="${ap.state eq '보류' }">
			                  			<div class="badge badge-danger" style="min-width: 60px;">
			                  				<small class="">${ap.memberTeamName }</small><br>
			                  				<small class="">${ap.memberJobName} ${ap.memberName}</small>
			                  			</div>
			                  		</c:if>
			                  		<c:if test="${ap.state eq '반려' }">
			                  			<div class="badge badge-danger" style="min-width: 60px;">
			                  				<small class="">${ap.memberTeamName }</small><br>
			                  				<small class="">${ap.memberJobName} ${ap.memberName}</small>
			                  			</div>
			                 		</c:if>
			                    </c:forEach> --%>
			                    </div>
			                  </td>
			                  	<%-- <c:forEach items="${l.approvers }" var="ap">
			                  		<c:if test="${ap.state eq '승인' }">
			                  			<div class="badge badge-success" style="min-width: 60px;">
			                  				<small class="">${ap.memberTeamName }</small><br>
			                  				<small class="">${ap.memberJobName} ${ap.memberName}</small>
			                  			</div>
			                  		</c:if>
			                		<c:if test="${ap.state eq '대기' }">
			                  			<div class="badge badge-count" style="min-width: 60px;">
			                  				<small class="">${ap.memberTeamName }</small><br>
			                  				<small class="">${ap.memberJobName} ${ap.memberName}</small>
			                  			</div>
			                  		</c:if>
			                		<c:if test="${ap.state eq '읽음' }">
			                  			<div class="badge badge-info" style="min-width: 60px;">
			                  				<small class="">${ap.memberTeamName }</small><br>
			                  				<small class="">${ap.memberJobName} ${ap.memberName}</small>
			                  			</div>
			                  		</c:if>
			                		<c:if test="${ap.state eq '보류' }">
			                  			<div class="badge badge-danger" style="min-width: 60px;">
			                  				<small class="">${ap.memberTeamName }</small><br>
			                  				<small class="">${ap.memberJobName} ${ap.memberName}</small>
			                  			</div>
			                  		</c:if>
			                  		<c:if test="${ap.state eq '반려' }">
			                  			<div class="badge badge-danger" style="min-width: 60px;">
			                  				<small class="">${ap.memberTeamName }</small><br>
			                  				<small class="">${ap.memberJobName} ${ap.memberName}</small>
			                  			</div>
			                 		</c:if>
			                    </c:forEach> --%>
			                  </td>
			                </tr>
			                </c:forEach>
			               </c:if>
			            </tbody>
			          </table>
			          <!-- 결재 대기 문서 -->
			          <table class="table table-hover align-items-center mb-0" id="waitingTable" style="display: none; width: 100%;">
				           <thead class="thead-light">
				             <tr class="text-center">
				             	<!-- <th><input type="checkbox"></th> -->
				               <th scope="col" class="">#</th>
				               <th scope="col" class="">등록 번호</th>
				               <th scope="col" class="">문서 제목</th>
				               <th scope="col" class="">상신인</th>
				               <th scope="col" class="">상신 일자</th>
				               <th scope="col" class="">결재 현황</th>
				             </tr>
				           </thead>
				           <tbody>
				             <c:if test="${empty waitinglist}">
				              <tr class="text-center">
				              	<td class="truncate"  colspan="6">결재 대기 중인 문서가 없습니다</td>
				             	</tr>
				             </c:if>
				             <c:if test="${waitinglist ne null}">
				             	<c:forEach items="${waitinglist }" var="l" varStatus="vs" begin="0" end="4">
				              <tr class="text-center" id="tablerow" data-doc-id="${l.erDocKey }">
				              	<td class="truncate" >${vs.index+1 }</td>
				                 <td class="truncate text-muted">${l.erDocSerialKey }</td>
				                 <td class="truncate"><c:if test="${l.erDocEmergencyYn eq 'Y'}"><span style="color: red;">[긴급] </span></c:if>${l.erDocTitle }</td>
				                	<td class="truncate" >
				                		<c:forEach items="${l.approvers }" var="ap">
				                			<c:if test="${ap.orderby eq 0 }">
				                				<div class="badge badge-count" style="min-width: 60px;">
				                   				<small class="">${ap.memberTeamName }</small><br>
				                   				<small class="">${ap.memberJobName} ${ap.memberName}</small>
				                   			</div>
				                			</c:if>
				                		</c:forEach>
				                	</td>
				                 <td class="truncate">
				                 	<fmt:formatDate value="${l.erDocCreateDate}" type="date" pattern="yyyy/MM/dd HH:mm:ss"/>
				                 </td>
				                 <td class="truncate approverNow p-3">
				                 	<c:forEach items="${l.approvers }" var="ap">
				                 		<c:if test="${ap.state eq '승인' }">
				                   			<div class="badge badge-success" style="min-width: 60px;">
				                   				<small class="">${ap.memberTeamName }</small><br>
				                   				<small class="">${ap.memberJobName} ${ap.memberName}</small>
				                   			</div>
				                   		</c:if>
				                 		<c:if test="${ap.state eq '대기' }">
				                   			<div class="badge badge-count" style="min-width: 60px;">
				                   				<small class="">${ap.memberTeamName }</small><br>
				                   				<small class="">${ap.memberJobName} ${ap.memberName}</small>
				                   			</div>
				                   		</c:if>
				                 		<c:if test="${ap.state eq '읽음' }">
				                   			<div class="badge badge-info" style="min-width: 60px;">
				                   				<small class="">${ap.memberTeamName }</small><br>
				                   				<small class="">${ap.memberJobName} ${ap.memberName}</small>
				                   			</div>
				                   		</c:if>
				                 		<c:if test="${ap.state eq '보류' }">
				                   			<div class="badge badge-danger" style="min-width: 60px;">
				                   				<small class="">${ap.memberTeamName }</small><br>
				                   				<small class="">${ap.memberJobName} ${ap.memberName}</small>
				                   			</div>
				                   		</c:if>
				                   		<c:if test="${ap.state eq '반려' }">
				                   			<div class="badge badge-danger" style="min-width: 60px;">
				                   				<small class="">${ap.memberTeamName }</small><br>
				                   				<small class="">${ap.memberJobName} ${ap.memberName}</small>
				                   			</div>
				                		</c:if>
				                   </c:forEach>
				                 </td>
				               </tr>
				               </c:forEach>
				              </c:if>
				            </tbody>
				          </table>
                    </div>
                  </div>
                </div>
              </div>
            
             
               <!--  <div class="row row-card-no-pd">
              <div class="col-12 col-sm-6 col-md-6 col-xl-3">
                <div class="card">
                  <div class="card-body">
                    <div class="d-flex justify-content-between">
                      <div>
                        <h6><b>Todays Income</b></h6>
                        <p class="text-muted">All Customs Value</p>
                      </div>
                      <h4 class="text-info fw-bold">$170</h4>
                    </div>
                    <div class="progress progress-sm">
                      <div class="progress-bar bg-info w-75" role="progressbar" aria-valuenow="75" aria-valuemin="0" aria-valuemax="100"></div>
                    </div>
                    <div class="d-flex justify-content-between mt-2">
                      <p class="text-muted mb-0">Change</p>
                      <p class="text-muted mb-0">75%</p>
                    </div>
                  </div>
                </div>
              </div>
              <div class="col-12 col-sm-6 col-md-6 col-xl-3">
                <div class="card">
                  <div class="card-body">
                    <div class="d-flex justify-content-between">
                      <div>
                        <h6><b>Total Revenue</b></h6>
                        <p class="text-muted">All Customs Value</p>
                      </div>
                      <h4 class="text-success fw-bold">$120</h4>
                    </div>
                    <div class="progress progress-sm">
                      <div class="progress-bar bg-success w-25" role="progressbar" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"></div>
                    </div>
                    <div class="d-flex justify-content-between mt-2">
                      <p class="text-muted mb-0">Change</p>
                      <p class="text-muted mb-0">25%</p>
                    </div>
                  </div>
                </div>
              </div> -->
              <!-- <div class="col-12 col-sm-6 col-md-6 col-xl-3">
                <div class="card">
                  <div class="card-body">
                    <div class="d-flex justify-content-between">
                      <div>
                        <h6><b>New Orders</b></h6>
                        <p class="text-muted">Fresh Order Amount</p>
                      </div>
                      <h4 class="text-danger fw-bold">15</h4>
                    </div>
                    <div class="progress progress-sm">
                      <div class="progress-bar bg-danger w-50" role="progressbar" aria-valuenow="50" aria-valuemin="0" aria-valuemax="100"></div>
                    </div>
                    <div class="d-flex justify-content-between mt-2">
                      <p class="text-muted mb-0">Change</p>
                      <p class="text-muted mb-0">50%</p>
                    </div>
                  </div>
                </div>
              </div>
              <div class="col-12 col-sm-6 col-md-6 col-xl-3">
                <div class="card">
                  <div class="card-body">
                    <div class="d-flex justify-content-between">
                      <div>
                        <h6><b>New Users</b></h6>
                        <p class="text-muted">Joined New User</p>
                      </div>
                      <h4 class="text-secondary fw-bold">12</h4>
                    </div>
                    <div class="progress progress-sm">
                      <div class="progress-bar bg-secondary w-25" role="progressbar" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"></div>
                    </div>
                    <div class="d-flex justify-content-between mt-2">
                      <p class="text-muted mb-0">Change</p>
                      <p class="text-muted mb-0">25%</p>
                    </div>
                  </div>
                </div>
              </div>
            </div> -->
            
			<!-- 게시물 위젯 -->
			    <div class="card">
                  <div class="card-header">
                    <div class="card-title">최신 게시물</div>
                  </div>
                  <div class="card-body" >
                    
                    <table class="table table-head-bg-primary mt-4" id="boardMainTable" style="margin-top: 0px!important;">
                      <thead>
                        <tr>
                          <th scope="col">NUMBER</th>
                          <th scope="col">TITLE</th>
                          <th scope="col">WRITER</th>
                          <th scope="col" style="width:300px;">DATE</th>
                        </tr>
                      </thead>
                      <tbody>
                      <c:forEach items="${boards}" var="board" varStatus="status">
						    <c:if test="${status.index < 5}">
						        <tr>
						            <th>${board.BOARD_KEY}</th>
						            <th><a href="${path}/board/detail/boardKey?boardKey=${board.BOARD_KEY}" style="color:black;">${board.BOARD_TITLE} </a></th>
						            <th>${board.MEMBER_NAME}</th>
						            <th>
						                <fmt:formatDate value="${board.BOARD_ENROLL_DATE}" pattern="yyyy-MM-dd HH:mm:ss" />
						            </th>
						        </tr>
						    </c:if>
					  </c:forEach>
                        
                      </tbody>
                      
                    </table>
                 
                  </div>
                </div>
							
		      </div>
            
          </div>
        </div>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>
       

    
    <!--   Core JS Files   -->
    <script src="${path}/resources/assets/js/core/jquery-3.7.1.min.js"></script>
    <script src="${path}/resources/assets/js/core/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    <!-- jQuery Scrollbar -->
    <script src="${path}/resources/assets/js/plugin/jquery-scrollbar/jquery.scrollbar.min.js"></script>

    <!-- Chart JS -->
    <script src="${path}/resources/assets/js/plugin/chart.js/chart.min.js"></script>

    <!-- jQuery Sparkline -->
    <script src="${path}/resources/assets/js/plugin/jquery.sparkline/jquery.sparkline.min.js"></script>

    <!-- Chart Circle -->
    <script src="${path}/resources/assets/js/plugin/chart-circle/circles.min.js"></script>

    <!-- Datatables -->
    <script src="${path}/resources/assets/js/plugin/datatables/datatables.min.js"></script>

    <!-- Bootstrap Notify -->
    <script src="${path}/resources/assets/js/plugin/bootstrap-notify/bootstrap-notify.min.js"></script>

    <!-- jQuery Vector Maps -->
    <script src="${path}/resources/assets/js/plugin/jsvectormap/jsvectormap.min.js"></script>
    <script src="${path}/resources/assets/js/plugin/jsvectormap/world.js"></script>

    <!-- Google Maps Plugin -->
    <script src="${path}/resources/assets/js/plugin/gmaps/gmaps.js"></script>

    <!-- Sweet Alert -->
    <script src="${path}/resources/assets/js/plugin/sweetalert/sweetalert.min.js"></script>

    <!-- Kaiadmin JS -->
    <script src="${path}/resources/assets/js/kaiadmin.min.js"></script>
    <script src="${path}/resources/bm/js/dropdown-bootstrap-extended.js"></script>
  <script src="${path}/resources/bm/js/fullcalendar.global.js"></script>
   <script src="${path}/resources/bm/js/index.global.min.js"></script>
     <script src="${path}/resources/bm/js/daterangepicker-data.js"></script>
     <script src="${path}/resources/bm/js/moment.min.js"></script>
  <script src="${path}/resources/bm/js/daterangepicker.js"></script>
     <script src="${path}/resources/js/index.js"></script>
    <!-- 출퇴근버튼 js -->
    <%-- <script src="${path}/resources/assets/ws/attendance.js"></script>  --%>
    
    <script>
				//근태 출퇴근 버튼
				 $(document).ready(function(){
			         $('#endAttendanceBtn').click(function(){
			             $.ajax({
			                 type: 'POST',
			                 url: '${path}/attendance/endattendance',
			                 success: function(response) {
			                     var message = response.msg;
			                     console.log(message);
			                     var attendanceEnd = response.attendanceEnd;
			                     if(message == '실패'){
			                    	 Swal.fire({
			                             title: '실패!',
			                             text: '출근부터 찍어주세요!',
			                             icon: 'error',
			                             confirmButtonText: '확인'
			                         }).then((result) => {
			                             /* if (result.isConfirmed) {
			                                 location.replace('${path}');
			                             } */
			                         });
			                     }else{
			                    	 Swal.fire({
			                             title: '성공!',
			                             text: '퇴근이 성공적으로 완료되었습니다.',
			                             icon: 'success',
			                             confirmButtonText: '확인'
			                         })

				                    	$('#endAttendanceBtn').hide();
				                     	$('#attendanceEndResult').html('퇴근 시간 : ' + attendanceEnd);

			                     }
			                 },
			                 error: function(xhr, status, error) {
			                     alert('퇴근 처리에 실패하였습니다.');
			                 }
			             });
			         });
			         $('#startAttendanceBtn').click(function(){
			             $.ajax({
			                 type: 'POST',
			                 url: '${path}/attendance/startattendance',
			                 success: function(response) {
			                     var message = response.msg;
			                     var attendanceStart = response.attendanceStart;
			                     Swal.fire({
		                             title: '성공!',
		                             text: '출근이 성공적으로 완료되었습니다.',
		                             icon: 'success',
		                             confirmButtonText: '확인'
		                         })
			                     $('#startAttendanceBtn').hide();
			                     $('#attendanceResult').html('출근 시간 : ' + attendanceStart);
			                 },
			                 error: function(xhr, status, error) {
			                     alert('출근 처리에 실패하였습니다.');
			                 }
			             });
			         });
			         
			      	// 페이지 로드 시 저장된 값으로 라디오 버튼 체크
			         const selectedValue = sessionStorage.getItem('selectedOptionDoc');
			         if (selectedValue) {
			             const radioButton = document.querySelector(`input[name="option"][value="${selectedValue}"]`);
			             if (radioButton) {
			                 radioButton.checked = true;
			             }
			         }
			         
			     }); 	
    </script>
    <script>
 	const path = "${path}";
    </script>
	<script>
		// 날씨 api - fontawesome 아이콘
		var weatherIcon = {
		    '01' : '${path}/resources/assets/img/sun.png', /* 해 */
		    '02' : '${path}/resources/assets/img/cloudfull.png', /* 구름 */
		    '03' : '${path}/resources/assets/img/cloudfull.png', /* 구름 */
		    '04' : '${path}/resources/assets/img/cloudfull.png',  /* 구름 */
		    '09' : '${path}/resources/assets/img/rainfull.png', /* 비 */
		    '10' : '${path}/resources/assets/img/rainfull.png', /* 비 */
		    '11' : '${path}/resources/assets/img/rainfull.png',   /* 비 */
		    '13' : '${path}/resources/assets/img/rainfull.png',  /* 눈 */
		    '50' : '${path}/resources/assets/img/cloudfull.png'      /* 구름 */
		};

		


		// 날씨 api - 서울
	 	var apiURI = "http://api.openweathermap.org/data/2.5/weather?q="+'seoul'+"&appid="+"640e2c1052830e64ffcc65d6cd7e56f9"; 
		$.ajax({
		    url: apiURI,
		    dataType: "json",
		    type: "GET",
		    async: "false",
		    success: function(resp) {
				console.log(resp.weather[0].main);
				
		        var $Icon = (resp.weather[0].icon).substr(0,2);
		        var $weather_description = resp.weather[0].main;
		        var $Temp = Math.floor(resp.main.temp- 273.15) + 'º';
		        var $humidity = '습도&nbsp;&nbsp;&nbsp;&nbsp;' + resp.main.humidity+ ' %';
		        var $wind = '바람&nbsp;&nbsp;&nbsp;&nbsp;' +resp.wind.speed + ' m/s';
		        var $city = '서울';
		        var $cloud = '구름&nbsp;&nbsp;&nbsp;&nbsp;' + resp.clouds.all +"%";
		        var $temp_min = '최저 온도&nbsp;&nbsp;&nbsp;&nbsp;' + Math.floor(resp.main.temp_min- 273.15) + 'º';
		        var $temp_max = '최고 온도&nbsp;&nbsp;&nbsp;&nbsp;' + Math.floor(resp.main.temp_max- 273.15) + 'º';
		        

		        $('.weather_icon').append('<img src="' + weatherIcon[$Icon] +'"  />');
		        if($weather_description=='Thunderstorm'){
		        	$('.weather_description').prepend('Storm');
		        }else{
		        	$('.weather_description').prepend($weather_description);
		        }
		        $('.current_temp').prepend($Temp);
		        $('.humidity').prepend($humidity);
		        $('.wind').prepend($wind);
		        $('.city').append($city);
		        $('.cloud').append($cloud);
		        $('.temp_min').append($temp_min);
		        $('.temp_max').append($temp_max);               
		    }
		});

	</script>
   
  </body>
</html>
