package com.project.npnc.admin.document.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.project.npnc.admin.document.model.dto.AdminDocument;
import com.project.npnc.admin.document.model.dto.StorageFolder;
import com.project.npnc.admin.document.model.service.AdminDocumentService;

import lombok.RequiredArgsConstructor;

@RequestMapping("/admin/documentForm")
@Controller
@RequiredArgsConstructor
public class AdminDocumentFormController {
    private final ObjectMapper objectMapper;

	private final AdminDocumentService service;
	@GetMapping("/selectAdminDocumentFormAll")
	public String selectAdminDocumentFormAll(Model model) {
		List<StorageFolder> folders = service.selectAdminDocumentFormAll();
		model.addAttribute("folders",folders);
		return "admin/document/docStorage";
		
	}
	@GetMapping("/selectDoc")
	public ResponseEntity<?> selectDocAll (@RequestParam int folderKey) {
		List<AdminDocument> docs = service.selectDocAll(folderKey);
		return ResponseEntity.ok(docs);
	}
	
    @PostMapping("/updateFolderOrder")
    public ResponseEntity<?> updateOrder(@RequestBody Map<String,Object>folderKeys) {
    
    	StorageFolder draggedFolder = service.selectStorageFolder((int)folderKeys.get("draggedFolder"));
    	StorageFolder targetFolder = service.selectStorageFolder((int)folderKeys.get("targetFolder"));
    	

    	
    	Map<String,Object>folderInfo = new HashMap<>();
    	folderInfo.put("draggedFolder", draggedFolder);
    	folderInfo.put("targetFolder", targetFolder);
    	System.out.println(draggedFolder+"draggedFolderdraggedFolderdraggedFolder");
    	System.out.println(targetFolder+"targetFoldertargetFoldertargetFolder");
    	service.increaseFolderOrder(folderInfo);
    	
    	int targetOrder = targetFolder.getFolderOrderBy();
    	if(targetFolder.getFolderLevel()==1) targetOrder+=1;

    	draggedFolder.setFolderOrderBy(targetOrder);
    	
    	int result = service.updateStorageGroup(folderInfo);
    	return ResponseEntity.ok(result);
    }

    @PostMapping("/removeFolder")
    public ResponseEntity<?>removeFolder(@RequestParam int draggedFolderKey){
    	int result = service.removeFolder(draggedFolderKey);
    	System.out.println(draggedFolderKey);
    	return ResponseEntity.ok(result);
    }
    @PostMapping("/createFolder")
    public ResponseEntity<?>createFolder(@RequestBody StorageFolder storageFolder ){
    	System.out.println(storageFolder);
    	service.insertFolder(storageFolder);
    	return ResponseEntity.ok(storageFolder);
    }
}
