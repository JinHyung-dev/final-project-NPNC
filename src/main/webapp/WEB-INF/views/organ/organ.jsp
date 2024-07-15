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
<style>
	.list-group-item{
			display: flex;
			flex-direction: row;
		justify-content: space-between;
	}
</style>
	<div class="accordion" id="accordionPanelsStayOpenExample">
		<c:forEach var="d" items="${list}" varStatus="status">
		
			<div class="accordion-item">
			    <h2 class="accordion-header">
			      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#panelsStayOpen-collapse${status.index}" aria-expanded="true" aria-controls="panelsStayOpen-collapse${status.index}">
			     
			      
			        ${d.departmentName} 
			      </button>
			    </h2>
    			<div id="panelsStayOpen-collapse${status.index}" class="accordion-collapse collapse">
			      <div class="accordion-body" style='padding: 0!important;'>
			         <div class="list-group" >
		 				<c:forEach var="memberlist" items="${d.memberlist}">
		 				
						  <a href="#" class="list-group-item list-group-item-action">&emsp;${memberlist.memberName} &nbsp; ${memberlist.jobName} 
						  <div>
						  <button type="button" class="btn btn-icon btn-round btn-success" style=" height: 1.6rem; width: 1.6rem!important; min-width: 0rem!important; border-radius: 50%!important; font-size: 1rem;"  >
	                        <i class="fas fa-envelope"></i>
	                      </button>
	                      <div class="btn btn-icon btn-round btn-primary" style=" height: 1.6rem; width: 1.6rem!important;  border-radius: 50%!important; min-width: 0rem!important; margin-left:7px; font-size: 1rem;">
                              <i class="fa fa-comment"></i>
                            </div>
						  </div>
						   </a>
						
		  				</c:forEach>
					</div>
			      </div>
			    </div>
			</div>
		
		
		</c:forEach>	
	</div> 




</body>
</html>