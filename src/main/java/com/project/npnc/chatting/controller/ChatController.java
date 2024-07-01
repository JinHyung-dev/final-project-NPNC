package com.project.npnc.chatting.controller;



import static com.project.npnc.chatting.model.dto.ChattingMessage.createChattingMessage;

import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.messaging.handler.annotation.DestinationVariable;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.npnc.chatting.model.dto.ChattingMessage;
import com.project.npnc.chatting.model.service.ChatService;

import lombok.RequiredArgsConstructor;
@Controller
@RequiredArgsConstructor
public class ChatController {
    private final WebSocketEventListener webSocketEventListener;

	private final ChatService service;
    private Set<Integer> users = new HashSet<>();

	
	
	@MessageMapping("/{roomId}") //여기로 전송되면 메서드 호출 -> WebSocketConfig prefixes 에서 적용한건 앞에 생략
	@SendTo("/room/{roomId}")   //구독하고 있는 장소로 메시지 전송 (목적지)  -> WebSocketConfig Broker 에서 적용한건 앞에 붙어줘야됨
	public ChattingMessage test(@DestinationVariable int roomId, ChattingMessage message) {
//		HttpSession session=(HttpSession)RequestContextHolder.currentRequestAttributes()
//		.resolveReference(RequestAttributes.REFERENCE_SESSION);
//		System.out.println(session);
		
		System.out.println("Received message: " + message);
//		Received message: ChattingMessage(chatMsgKey=0, memberKey=2, chatRoomKey=10, chatMsgDetail=ㅈㅇㅂㅇㅈㅂ, chatMsgTime=Sun Jun 30 23:19:09 KST 2024, chatMsgNotice=null, chatReadCount=0)
		// 채팅 저장

        
        Map<String, Object> chatInfo = service.insertChat(message);
            System.out.println("Insert result: " + chatInfo.get("seq"));
      
            ChattingMessage chat = createChattingMessage((int)chatInfo.get("seq"),message.getMemberKey(),roomId,  message.getChatMsgDetail(), message.getChatMsgTime(),"N",(int)chatInfo.get("readCount"));

        System.out.println("After insertChat call"+ message);
        System.out.println("After insertChat call"+ message);

        return chat;
    
	}
	

    @GetMapping("/room/{roomId}/users")
    @ResponseBody
    public Set<String> getUsersInRoom(@PathVariable String roomId) {
    	System.out.println("gerUsersInRoom");
        return webSocketEventListener.getSessionsForRoom(roomId);
    }

    @GetMapping("/room/{roomId}/sessionCount")
    @ResponseBody
    public int getChatSessionCount(@PathVariable String roomId) {
    	System.out.println("getChatSessionCountgetChatSessionCount");
        return webSocketEventListener.getChatSessionCount(roomId);
    }
	@PostMapping("loadRecentChat")
	@ResponseBody
	public List<ChattingMessage> loadChat(@RequestParam int chatRoomKey) {
		Map<String, Object> readInfo = new HashMap<>();
		readInfo.put("roomId", chatRoomKey);
	    List<ChattingMessage> chats = service.selectRoomChatList(readInfo);

	    return chats;
	}
	
}
