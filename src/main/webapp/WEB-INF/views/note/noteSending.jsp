<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<c:set var="path" value="${pageContext.request.contextPath }"/>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<sec:authentication var="loginMember" property="principal"/>
<!DOCTYPE html>
<html>
  <head>
  	<meta charset="UTF-8">
  	
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
    </script>
     <!-- Sweet Alert -->
    <script src="${path}/resources/assets/js/plugin/sweetalert/sweetalert.min.js"></script>
    <!-- 모달 스타일  -->
	<style>
			h2{
    			text-align: center;
			}
			.modal_btn {
			    display: block;
			    margin: 40px auto;
			    padding: 10px 20px;
			    background-color: royalblue;
			    border: none;
			    border-radius: 5px;
			    color: #fff;
			    cursor: pointer;
			    transition: box-shadow 0.2s;
			}
			.modal_btn:hover {
			    box-shadow: 3px 4px 11px 0px #00000040;
			}
			
			/*모달 팝업 영역 스타일링*/
			.modal {
			/*팝업 배경*/
				display: none; /*평소에는 보이지 않도록*/
			    position: absolute;
			    top:0;
			    left: 0;
			    width: 100%;
			    height: 100vh;
			    overflow: hidden;
			    background: rgba(0,0,0,0.5);
			}
			.modal .modal_popup {
			/*팝업*/
			    position: absolute;
			    top: 50%;
			    left: 50%;
			    transform: translate(-50%, -50%);
			    padding: 20px;
			    background: #ffffff;
			    border-radius: 20px;
			}
			.modal .modal_popup .close_btn {
			  /*   display: block; */
			    padding: 10px 20px;
			    background-color: rgb(116, 0, 0);
			    border: none;
			    border-radius: 5px;
			    color: #fff;
			    cursor: pointer;
			    transition: box-shadow 0.2s;
			}
			.modal.on {
			    display: block;
			}
	
	</style>
	<style>
	.button-margin{
		margin-right:20px;
	}
	.badge-margin{
		margin-right:17px;
	}
	.namebox{
/* 		display: flex;
		flex-direction: row; */
		/* flex-wrap: wrap; */
		 
	}
	.modalDetailGo{}
	.modalDetailGo:hover {
            cursor: pointer; /* 커서를 포인터로 변경 */
        }
	</style>
    <!-- CSS Files -->
    <link rel="stylesheet" href="${path}/resources/assets/css/bootstrap.min.css" />
    <link rel="stylesheet" href="${path}/resources/assets/css/plugins.min.css" />
    <link rel="stylesheet" href="${path}/resources/assets/css/kaiadmin.min.css" />

    <!-- CSS Just for demo purpose, don't include it in your project -->
    <link rel="stylesheet" href="${path}/resources/assets/css/demo.css" />
  </head>
  <body>
    <div class="wrapper">
      <!-- Sidebar -->
      <div class="sidebar" data-background-color="dark">
        <div class="sidebar-logo">
          <!-- Logo Header -->
          <div class="logo-header" data-background-color="dark">
            <a href="index.html" class="logo">
              <img
                src="${path}/resources/assets/img/KakaoTalk_Photo_2024-07-08-14-27-11.png"
                alt="navbar brand"
                class="navbar-brand"
                height="90"
              />
            </a>
            <div class="nav-toggle">
              <button class="btn btn-toggle toggle-sidebar">
                <i class="gg-menu-right"></i>
              </button>
              <button class="btn btn-toggle sidenav-toggler">
                <i class="gg-menu-left"></i>
              </button>
            </div>
            <button class="topbar-toggler more">
              <i class="gg-more-vertical-alt"></i>
            </button>
          </div>
          <!-- End Logo Header -->
		    </div>
		    <div class="sidebar-wrapper scrollbar scrollbar-inner">
		      <div class="sidebar-content">
		        <ul class="nav nav-secondary">
		        
		          <li class="nav-section">
		            <span class="sidebar-mini-icon">
		              <i class="fa fa-ellipsis-h"></i>
		            </span>
		            <h4 class="text-section" style="font-size: 20px; color: white;">쪽지</h4>
		          </li>
		  	  
		          <li class="nav-item" >
		            <a data-bs-toggle="collapse" href="${path}/notehome">
		              <i class="fas fa-file-upload"></i>
		              <p>받은 쪽지함</p>
		            </a>
		           
		          </li>
		          <li class="nav-item">
		            <a data-bs-toggle="collapse" href="${path}/sendNoteHome">
		              <i class="fas fa-file-download"></i>
		              <p>보낸 쪽지함</p>
		            </a>
		            
		          </li>
		  	 
		  	   <li class="nav-item">
		              <a data-bs-toggle="collapse" href="${path}/noteSendMe">
		                <i class="fas fa-street-view"></i>
		                <p>내게 쓴 쪽지함</p>
		              </a>
		              
		            </li>
		  		<li class="nav-item">
		                <a data-bs-toggle="collapse" href="${path}/noteBookMark">
		  			  <i class="fas fa-folder-open"></i>
		                  <p>즐겨찾기</p>
		                </a>
		              </li>       
		  		
		        </ul>
		      </div>
		    </div>
		  </div>
		  <script>
		     document.addEventListener("DOMContentLoaded", function() {
		         document.querySelectorAll('.nav-item').forEach(function(li) {
		             li.addEventListener('click', function() {
		                 var anchor = li.querySelector('a');
		                 if (anchor) {
		                     window.location.href = anchor.href;
		                 }
		             });
		         });
		     });
		  </script>

      <!-- End Sidebar -->

      <div class="main-panel">
        <!-- header_bar  -->
          <%@ include file="/WEB-INF/views/common/header_bar.jsp" %>
       
		
        <div class="container">
          <div class="page-inner">
          <input type="hidden" name="hiddenField" id="memberKey" value="${loginMember.memberKey}">
          
            <div
              class="d-flex align-items-left align-items-md-center flex-column flex-md-row pt-2 pb-4"
            >
              <div>
                <h3 class="fw-bold mb-3">보낸 쪽지함</h3>
                <h6 class="op-7 mb-2">총 ${totalData}건의 쪽지가 있습니다.</h6>
              </div>
              <div class="ms-md-auto py-2 py-md-0">
              <!--  <button type="button" class="modal_btn btn btn-label-info btn-round me-2">쪽지 발송</button>
               <button type="button" class="modal_btn btn btn-primary btn-round">전체 쪽지 발송</button>  -->
                <!-- <a href="javascript:openOrgan();" class="btn btn-primary btn-round">조직도 예시</a> -->
              </div>
            </div>
          	<div class="col-md-12">
                <div class="card">
                  <div class="card-header">
                    <h4 class="card-title">목록</h4>
                  </div>
                  <div class="card-body">
                    <div class="table-responsive">
                      <table
                        id="basic-datatables"
                        class="display table table-striped table-hover"
                      >
                        <thead>
                          <tr>
                          <th> 
                          	<input type="checkbox" id="deleteCheckAll" value="">
                         		  
                          
                          	</th>
                            <th>Number</th>
                            <th>보낸이</th>
                            <th>title</th>
                            <th>Date</th>
                            
                          </tr>
                        </thead>
                       
                        <tbody id="pagingtbody">
                      <c:forEach var="d" items="${notelist}" varStatus="status2">
                      
                        
           	    			<tr>
           	    				<th><input type="checkbox" name="deleteCheck" value="${d.postMsgSendKey}"></th>
           	  					<th>${d.postMsgSendKey}<p>
           	  					<th>${d.sendMemberKey}<p>
           	  					<th class="modalDetailGo" onclick="modalDetailGo(${d.postMsgSendKey},${d.sendMemberKey})">${d.postMsgSendTitle}<p>
           	  					<th>${d.postMsgSendTime}<p>
           	  				</tr>
	
          		 	  </c:forEach>
          		 	
                        </tbody>
                        
                      </table>
                      <div>
                      	  <div id="deleteButton"> 
                      	  	<button class="btn btn-info" onclick="deleteSendGo();">삭제하기</button>
                      	  </div>
	                      <div id="pageBarList">${pageBar}</div>
	                      <!-- <button type="button" onclick="paging();"> 에이작스 test </button> -->
	                      </div>
                      </div>
                  </div>
                </div>
              </div>
           
			  <div class="modal">
				    <div class="modal_popup">
				         <div>
				         <%--   	  <c:forEach var="d" items="${AllMemberList}">
				           	    <input type="radio"  name="reMemberKey1" value="${d.memberKey }">
				           	  	<p>${d.memberKey}<p>
				           	  </c:forEach>  --%>
				           	  
				           	  <div class="form-group">
				           	    <div class="namebox" >
				           		  <!--  <h2>전체 쪽지</h2> -->
				           		</div>
				           	</div>   
				           		    <div class="form-group">
			                          <div class="input-group">
			                            <span class="input-group-text">제목</span>
			                            <textarea
			                              class="form-control"
			                              aria-label="With textarea"
			                              id="postMsgTitleAll"
			                              rows="1" cols="50"
			                            ></textarea>
			                          </div>
                    			   </div>		
								   <div class="form-group">
			                          <div class="input-group">
			                            <span class="input-group-text">내용</span>
			                            <textarea
			                              class="form-control"
			                              aria-label="With textarea"
			                              id="postMsgDetailAll"
			                              rows="8" cols="50"
			                            ></textarea>
			                          </div>
                    			   </div>	
                    			   <div class="form-group" id="downloadButtonBox">
                    			   	
                    			   </div>	           	   
								 <div class="form-group">
								<button class="btn btn-primary" style="margin-right: 10px;" onclick="noteAllgo();">전송</button>
								<button class="btn btn-primary btn-border close_btn" >닫기</button>
								</div>
				          </div>
				    </div>
			  </div>
			
			<script>
		  
		    </script>
          	<script>
          	
          	const modal = document.querySelectorAll('.modal');
            const modalButtons = document.querySelectorAll('.modal_btn');
          	const modalCloses = document.querySelectorAll('.close_btn');
		
          	//열기 버튼을 눌렀을 때 모달팝업이 열림
          	   modalButtons.forEach((button, index) => {
		            button.addEventListener('click', function() {
		                // 인덱스 출력
		                console.log('Modal button index:', index);
		
		                // 'on' 클래스 추가
		                modal[index].classList.add('on');
		            });
		        });
          	
          	modalCloses.forEach((button, index) => {
	            button.addEventListener('click', function() {
	                // 인덱스 출력
	                console.log('Modal button index:', index);
	
	                // 'on' 클래스 추가
	                modal[index].classList.remove('on');
	            });
	        });
          	
          	/* 체크되어있는 체크박스의 값을 구해오는 로직 */
          	function deleteSendGo(){
          		 var checkboxes = document.querySelectorAll('input[name="deleteCheck"]');
          		 let checkDeleteValue=[];
           	    for (var checkbox of checkboxes) {
           	        
           	        
           	        if(checkbox.checked){
           	        	checkDeleteValue.push(checkbox.value);
           	        }
           	    }

				$.ajax({
					url : '${path}/noteSendDelete',
					type : 'POST',
					data : {checkDeleteValue : checkDeleteValue
						
							},
					success : function(response){
						
						fn_paging(1);

					}
				});
           	    
          	}
          	
          	/* 전체 선택 누르면 각 체크박스 돌아가는 로직 */
          	document.getElementById('deleteCheckAll').addEventListener('change', function() {
          	    var checkboxes = document.querySelectorAll('input[name="deleteCheck"]');
          	    for (var checkbox of checkboxes) {
          	        checkbox.checked = this.checked;
          	    }
          	});
          	
         /* 보낸 쪽지함 개별 조회 */
          	function modalDetailGo(postMsgSendKey,sendMemberKey){
          	    event.stopPropagation(); 
          		console.log(postMsgSendKey,sendMemberKey);
          		$.ajax({
					url : '${path}/selectSendOne',
					type : 'POST',
					data : {postMsgSendKey : postMsgSendKey,
							sendMemberKey: sendMemberKey
							},
					success : function(response){
						
		      			var namebox=document.getElementsByClassName("namebox");
						var downloadButtonBox= document.getElementById("downloadButtonBox");
						
						namebox[0].innerHTML="";
						downloadButtonBox.innerHTML="";
						
						var recMember=response.recMember;
						if(recMember.length>10){
							namebox[0].innerHTML='<h2>전체 쪽지<h2>';
						}else{
							for(let i=0;i<recMember.length;i++){
								 var newElement=document.createElement("span");
					                newElement.classList.add("badge");
					                newElement.classList.add("badge-info");
					                newElement.classList.add("badge-margin");
					                newElement.classList.add("badge-margin");
					                newElement.id=recMember[i].memberKey;
					                newElement.textContent=recMember[i].memberName+' '+recMember[i].jobName;
					                namebox[0].appendChild(newElement);
	
							}
						}
						var files= response.files;
						if(files.length>0){
						console.log(files);
							for(let i=0;i<files.length;i++){
								 var newElement=document.createElement("button");
					                newElement.classList.add("btn");
					                newElement.classList.add("btn-success");
					                
					               	newElement.textContent=files[i].postMessageFileOri;
					                
					               	newElement.onclick = function() {
					                     fn_download(files[i].postMessageFileOri,files[i].postMessageFilePost);
					                };
					               	
					               	
					                downloadButtonBox.appendChild(newElement);
	
							}
						}
			            
 						

				        $('#postMsgTitleAll').val(response.postMsgSendTitle);

				        $('#postMsgDetailAll').val(response.postMsgSendDetail);
				     
										    
						modal[0].classList.add('on');
					}
				});
          		
          	}
          	
          	function fn_download(ori,post){
          		location.assign("${path}/note/filedownload?oriname="+ori+"&rename="+post);
          	}
          	
          		
          	
          		
          		
          		function fn_paging(pageNo){
    	            var memberKey = document.getElementById('memberKey').value;

					$.ajax({
						url : '${path}/notepagingsend',
						type : 'POST',
						data : {cPage : pageNo,
								memberKey: memberKey
								},
						success : function(response){
							var tbody=$('#pagingtbody');
							tbody.empty();
						  	 console.log(response.notepagelist);
	           	    			

						  $.each(response.notepagelist, function(index, item) {
				                    var row = `<tr>
		           	    				<th><input type="checkbox" name="deleteCheck" value="\${item.postMsgSendKey}"></th>

				                        <th>\${item.postMsgSendKey}</th>
				                        <th>\${item.sendMemberKey}</th>
				                        <th class="modalDetailGo" onclick="modalDetailGo(\${item.postMsgSendKey},\${item.sendMemberKey})">\${item.postMsgSendTitle}</th>
				                        <th>\${item.postMsgSendTime}</th>
				                    </tr>`;
				                    tbody.append(row);
				                }); 
						  	var pageBarList=$('#pageBarList');
						  	pageBarList.empty();
						  	pageBarList.append(response.pagebar);
						    
						}
					});
          			
          		}	
          	
          	</script>
          
            
          </div>
        </div>

        <!-- footer -->
          <%@ include file="/WEB-INF/views/common/footer.jsp" %>
      </div>

      <!-- Custom template | don't include it in your project! -->
      <div class="custom-template">
        <div class="title">Settings</div>
        <div class="custom-content">
          <div class="switcher">
            <div class="switch-block">
              <h4>Logo Header</h4>
              <div class="btnSwitch">
                <button
                  type="button"
                  class="selected changeLogoHeaderColor"
                  data-color="dark"
                ></button>
                <button
                  type="button"
                  class="changeLogoHeaderColor"
                  data-color="blue"
                ></button>
                <button
                  type="button"
                  class="changeLogoHeaderColor"
                  data-color="purple"
                ></button>
                <button
                  type="button"
                  class="changeLogoHeaderColor"
                  data-color="light-blue"
                ></button>
                <button
                  type="button"
                  class="changeLogoHeaderColor"
                  data-color="green"
                ></button>
                <button
                  type="button"
                  class="changeLogoHeaderColor"
                  data-color="orange"
                ></button>
                <button
                  type="button"
                  class="changeLogoHeaderColor"
                  data-color="red"
                ></button>
                <button
                  type="button"
                  class="changeLogoHeaderColor"
                  data-color="white"
                ></button>
                <br />
                <button
                  type="button"
                  class="changeLogoHeaderColor"
                  data-color="dark2"
                ></button>
                <button
                  type="button"
                  class="changeLogoHeaderColor"
                  data-color="blue2"
                ></button>
                <button
                  type="button"
                  class="changeLogoHeaderColor"
                  data-color="purple2"
                ></button>
                <button
                  type="button"
                  class="changeLogoHeaderColor"
                  data-color="light-blue2"
                ></button>
                <button
                  type="button"
                  class="changeLogoHeaderColor"
                  data-color="green2"
                ></button>
                <button
                  type="button"
                  class="changeLogoHeaderColor"
                  data-color="orange2"
                ></button>
                <button
                  type="button"
                  class="changeLogoHeaderColor"
                  data-color="red2"
                ></button>
              </div>
            </div>
            <div class="switch-block">
              <h4>Navbar Header</h4>
              <div class="btnSwitch">
                <button
                  type="button"
                  class="changeTopBarColor"
                  data-color="dark"
                ></button>
                <button
                  type="button"
                  class="changeTopBarColor"
                  data-color="blue"
                ></button>
                <button
                  type="button"
                  class="changeTopBarColor"
                  data-color="purple"
                ></button>
                <button
                  type="button"
                  class="changeTopBarColor"
                  data-color="light-blue"
                ></button>
                <button
                  type="button"
                  class="changeTopBarColor"
                  data-color="green"
                ></button>
                <button
                  type="button"
                  class="changeTopBarColor"
                  data-color="orange"
                ></button>
                <button
                  type="button"
                  class="changeTopBarColor"
                  data-color="red"
                ></button>
                <button
                  type="button"
                  class="selected changeTopBarColor"
                  data-color="white"
                ></button>
                <br />
                <button
                  type="button"
                  class="changeTopBarColor"
                  data-color="dark2"
                ></button>
                <button
                  type="button"
                  class="changeTopBarColor"
                  data-color="blue2"
                ></button>
                <button
                  type="button"
                  class="changeTopBarColor"
                  data-color="purple2"
                ></button>
                <button
                  type="button"
                  class="changeTopBarColor"
                  data-color="light-blue2"
                ></button>
                <button
                  type="button"
                  class="changeTopBarColor"
                  data-color="green2"
                ></button>
                <button
                  type="button"
                  class="changeTopBarColor"
                  data-color="orange2"
                ></button>
                <button
                  type="button"
                  class="changeTopBarColor"
                  data-color="red2"
                ></button>
              </div>
            </div>
            <div class="switch-block">
              <h4>Sidebar</h4>
              <div class="btnSwitch">
                <button
                  type="button"
                  class="changeSideBarColor"
                  data-color="white"
                ></button>
                <button
                  type="button"
                  class="selected changeSideBarColor"
                  data-color="dark"
                ></button>
                <button
                  type="button"
                  class="changeSideBarColor"
                  data-color="dark2"
                ></button>
              </div>
            </div>
          </div>
        </div>
        <div class="custom-toggle">
          <i class="icon-settings"></i>
        </div>
      </div>
      <!-- End Custom template -->
    </div>
    <!--   Core JS Files   -->
    <script src="${path}/resources/assets/js/core/jquery-3.7.1.min.js"></script>
    <script src="${path}/resources/assets/js/core/popper.min.js"></script>
    <%-- <script src="${path}/resources/assets/js/core/bootstrap.min.js"></script> --%>
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

   

    <!-- Kaiadmin JS -->
    <script src="${path}/resources/assets/js/kaiadmin.js"></script>

    <!-- Kaiadmin DEMO methods, don't include it in your project! -->
    <script src="${path}/resources/assets/js/setting-demo.js"></script>
    <script src="${path}/resources/assets/js/demo.js"></script>
    <script>
      $("#lineChart").sparkline([102, 109, 120, 99, 110, 105, 115], {
        type: "line",
        height: "70",
        width: "100%",
        lineWidth: "2",
        lineColor: "#177dff",
        fillColor: "rgba(23, 125, 255, 0.14)",
      });

      $("#lineChart2").sparkline([99, 125, 122, 105, 110, 124, 115], {
        type: "line",
        height: "70",
        width: "100%",
        lineWidth: "2",
        lineColor: "#f3545d",
        fillColor: "rgba(243, 84, 93, .14)",
      });

      $("#lineChart3").sparkline([105, 103, 123, 100, 95, 105, 115], {
        type: "line",
        height: "70",
        width: "100%",
        lineWidth: "2",
        lineColor: "#ffa534",
        fillColor: "rgba(255, 165, 52, .14)",
      });
    </script>
  </body>
</html>
