/**
 * 전자문서 알람 관련 내용
 */
/* 타입 , 알람 , 수신인, 메세지  */


function refererAlarmSend(reMemberKey1, memberKey, memberName, jobName, serialKey){
 console.log('참조인 알람 send');
 console.log(reMemberKey1);
 console.log(memberKey);
 console.log(memberName);
 console.log(jobName);
	stompClient.send("/pub/msg/"+reMemberKey1,{},
		JSON.stringify({
			
			alarmType : 'DocReferer',
			alarmPath : 'document/list/referer/reference',
			alarmSendMember : memberKey,
			alarmReMember : reMemberKey1,
			alarmDate : new Date().toISOString(),
			memberName: memberName,
			jobName : jobName,
			docSerialKey : serialKey
			
		})
			
	);
	  
}

function nextAproverAlarmSend(reMemberKey1, memberKey, memberName, jobName, serialKey){
 console.log('결재자 알람 send');
 console.log(reMemberKey1);
 console.log(memberKey);
 console.log(memberName);
 console.log(jobName);
	stompClient.send("/pub/msg/"+reMemberKey1,{},
		JSON.stringify({
			
			alarmType : 'DocAprover',
			alarmPath : 'document/list/approver/waiting',
			alarmSendMember : memberKey,
			alarmReMember : reMemberKey1,
			alarmDate : new Date().toISOString(),
			memberName: memberName,
			jobName : jobName,
			docSerialKey : serialKey
			
		})
			
	);
	  
}

function docCompleteAlarmSend(reMemberKey1, memberKey, memberName, jobName, serialKey){
 console.log('승인 완료 알람 send');
	stompClient.send("/pub/msg/"+reMemberKey1,{},
		JSON.stringify({
			
			alarmType : 'DocComplete',
			alarmPath : 'document/list/employee/complete',
			alarmSendMember : memberKey,
			alarmReMember : reMemberKey1,
			alarmDate : new Date().toISOString(),
			memberName: memberName,
			jobName : jobName,
			docSerialKey : serialKey
			
		})
			
	);
	  
}
function docRejectedAlarmSend(reMemberKey1, memberKey, memberName, jobName, serialKey){
 console.log('반려 알람 send');
	stompClient.send("/pub/msg/"+reMemberKey1,{},
		JSON.stringify({
			
			alarmType : 'DocRejected',
			alarmPath : 'document/list/employee/rejected',
			alarmSendMember : memberKey,
			alarmReMember : reMemberKey1,
			alarmDate : new Date().toISOString(),
			memberName: memberName,
			jobName : jobName,
			docSerialKey : serialKey
			
		})
			
	);
	  
}