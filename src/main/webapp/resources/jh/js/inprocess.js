/**
 *  진행중 문서
 */
	
function modal(no){
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
			// 회수 버튼이 클릭되었을 때 처리할 로직
			console.log('회수하기');
			$.ajax({
				url: sessionStorage.getItem("path") + `/document/retrieve`,
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
							confirmButtonText: '이동',
							cancelButtonText: '취소',
							buttonsStyling: false,
							reverseButtons: false
						}).then((result) => {
							if (result.isConfirmed) {
								location.assign(sessionStorage.getItem("path") + `/document/list/retrieve`)
							}
						});
					}
				}
			});
		}
	});
};
document.addEventListener("DOMContentLoaded", function() {
    //const table = document.getElementById('docTable');

    $("table").on('click', "button", function(e) {
        e.stopPropagation();
    });
    
    $("table").on('click', function(event) {
        const target = event.target;
     // 버튼이 클릭된 경우 이벤트 전파를 막고 함수를 종료
        if (target.tagName.toLowerCase() === 'button'|| (target.tagName.toLowerCase() === 'input' && target.type === 'button')) {
            event.stopPropagation();
            return;
        }

        const row = target.closest('tr');
        if (row && row.dataset.docId) {
            const docId = row.dataset.docId;
            console.log(docId);
            selectDoc(docId);
        }
    });
    
    
	//상세보기
	function selectDoc(docId){
		const $form = $("<form>").attr({'action': sessionStorage.getItem("path") + '/document/view/docDetail', 'method': 'post'});
		$("<input>").attr({'value': docId, 'name': 'docId','type': 'hidden'}).appendTo($form);
		$form.appendTo("body").submit();
	}
});