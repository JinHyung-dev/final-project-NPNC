/**
 * 전자문서 상세보기 
 */
document.addEventListener("DOMContentLoaded", function() {
	//파일 상세보기
	$(document).on('click', '#fileViewBtn', function() {
		console.log('파일 상세보기');
		let fileName = $(this).data('filename');
		console.log('원본 파일명:', fileName);
		let encodedFileName = encodeURIComponent(fileName); // 파일명 인코딩
		console.log('인코딩된 파일명:', encodedFileName);
		console.log('요청주소', sessionStorage.getItem("path") + `/document/files/detail/${encodedFileName}`);
	    $.ajax({
	        url: sessionStorage.getItem("path") + `/document/files/detail/${encodedFileName}`,
	        method: 'GET',
	        success: function (data) {
				console.log(data);
				// 파일 확장자 확인
	            let fileExtension = data.fileOriName.split('.').pop().toLowerCase();
	            let imageExtensions = ['jpg', 'jpeg', 'png', 'gif', 'bmp', 'webp'];
	            $('#fileDetailOriname').text(data.fileOriName);
	            $('#fileDetailSize').text(data.fileSize + ' bytes');
	            $('#fileDetailUploadDate').text(new Date(data.fileUploadDate).toLocaleString());
	            
                // 이미지일 경우
	            if (imageExtensions.includes(fileExtension)) {
		            $('#fileDetailImage').attr('src', sessionStorage.getItem("path") + `/document/files/download/${encodedFileName}`).show();
	            } else {
                // 이미지가 아닌 경우
                	$('#fileDetailImage').hide();
            	}

	            $('#fileDetailModal').modal('show');
	        },
	        error: function (jqXHR, textStatus, errorThrown) {
				console.error("Error fetching file details: ", textStatus, errorThrown);
	            $('.modal-body').html('파일 정보를 불러오는 데 실패했습니다.');
	            $('#fileDetailModal').modal('show');
	        }
	    });
	});
	//파일 다운로드
	$(document).on('click', '#fileDownBtn', function() {
	    let fileName = $(this).data('filename');
	    window.location.href = sessionStorage.getItem("path") + `/document/files/download/${fileName}`;
	});
	$("#closeBtn").click(function(){
		window.history.back();
	});
	
});

//pdf 다운로드
function pdf_down(serial) {
	console.log("PDF 다운로드");
	//내용 가져오기
	var element = $("#content").html();
	const width = 800; // 컨텐츠의 전체 너비
	const height = 297 *3; // 컨텐츠의 전체 높이
	
	html2pdf().from(element).set({
	    margin: [10,10,10,10],
	    filename: serial + '.pdf',
	    html2canvas: { 
			scale: 4,
			scrollX: 0,
            scrollY: 0,
            width: width, // A4 페이지 너비 (축소 비율 고려)
            height: height // A4 페이지 높이 (축소 비율 고려)
		},
	    jsPDF: { 
			orientation: 'portrait', 
			unit: 'mm', 
			format: 'a4', 
			compressPDF: true,
			scaleFactor: 2 // 비율 조정
		}
	}).save();

	

}

function approveModal(no, serial){
	Swal.fire({
		title: '결재',
		html: `
		<div class="approve-group form-group d-flex align-items-center justify-content-center gap-2">
	      	<label>
            <input type="radio" name="approve" value="approve">
        	승인
	        </label><br>
	        <label>
            <input type="radio" name="approve" value="reject">
        	반려
	        </label><br>
	        <label>
            <input type="radio" name="approve" value="pend">
            보류(수정요청)
	        </label><br>
		<br>
		</div>
		<textarea class="form-control" id="input-field" placeholder="결재 의견을 작성하세요" style="resize:none"></textarea>`,
		showCancelButton: true,
		confirmButtonClass: 'btn btn-success',
		cancelButtonClass: 'btn btn-danger ms-2',
		confirmButtonText: '결재',
		cancelButtonText: '취소',
		buttonsStyling: false,
		reverseButtons: false
	}).then((result) => {
		if (result.isConfirmed) {
			// 결재 버튼이 클릭되었을 때 처리할 로직
			console.log('결재하기');
			
			let dochtml = $("#content").html();
			// 선택된 라디오 버튼의 값을 가져오기
    		let approvalType = $('input[name="approve"]:checked').val();

			if(dochtml != null){
				let opinion = $('#input-field').val();
				
		     	// AJAX로 폼 데이터를 전송
		        $.ajax({
					url : sessionStorage.getItem("path")+'/document/' + approvalType,
		            type: 'POST',
		            data: JSON.stringify({
						'no' : no,						
						'html' : dochtml,
						'msg' : opinion,
						'serial' : serial,
						'formNo' : sessionStorage.getItem("formNo")
						}),
					dataType : "json",
					contentType : "application/json; charset=utf-8",
					success : function(data){
			            console.log(data);
						
			            if (data.status == "success") {
			                alert(data.message);
							// 로컬 스토리지에서 데이터를 삭제
							sessionStorage.removeItem("formNo");
			                const writerKey = $("#docInfo").data('writer-key');
			                const serialKey = $("#docInfo").data('doc-serial');
			                const writerJobName = $("#docInfo").data('writer-job-name');
			                const writerName = $("#docInfo").data('writer-name');
							
							console.dir(data);
							
							 //다음 결재자 있으면 발송
							 if (data.nextAprover != null) {
			                	console.log('결재자 알람 send try');
			                	 console.log(data.nextAprover);
				                nextAproverAlarmSend(data.nextAprover.memberKey, writerKey, writerName, writerJobName, serialKey);
			                 }else{
								console.log('마지막 결재자');
								console.log(approvalType);
								if(approvalType == 'approve'){
									//다음결재자가 없으면서 승인인 경우
									console.log(writerName + "에게 최종승인 알람 send try");
									docCompleteAlarmSend(writerKey, writerKey, writerName, writerJobName, serialKey);
								}else if(approvalType == 'reject'){
									console.log(writerName + '에게 반려 알람 send try');
									docRejectedAlarmSend(writerKey, writerKey, writerName, writerJobName, serialKey);
								}
							
								 //참조인 있으면 발송
								if (data.referer != null && data.referer.length > 0) {
									console.log(data.referer.length);
									console.log('참조인 알람 send try');
									// 각 참조인에 대해 반복 전송
									$.each(data.referer, function(index, referer) {
										refererAlarmSend(referer.memberKey, writerKey, writerName, writerJobName, serialKey)
									});
								}
							}
							//alert('콘솔 확인용');
							
			                // 성공 시 페이지 리다이렉트
			                window.location.href = sessionStorage.getItem("path")+"/document/list/approver/waiting";
			            } else{
							alert(data.message);
						}
			        }
		       });
		    } else{
		        alert('문서 양식 불러오기 오류');
		    }
		}
	});
}