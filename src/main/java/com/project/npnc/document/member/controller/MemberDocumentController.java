package com.project.npnc.document.member.controller;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStreamReader;
import java.nio.charset.StandardCharsets;
import java.sql.Date;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.project.npnc.admin.document.model.dto.StorageFolder;
import com.project.npnc.admin.document.model.service.AdminDocumentService;
import com.project.npnc.admin.vacation.model.dto.Vacation;
import com.project.npnc.admin.vacation.model.service.VacationService;
import com.project.npnc.document.model.dto.Approver;
import com.project.npnc.document.model.dto.ApproverLine;
import com.project.npnc.document.model.dto.ApproverLineStorage;
import com.project.npnc.document.model.dto.Document;
import com.project.npnc.document.model.dto.DocumentForm;
import com.project.npnc.document.model.dto.DocumentFormFolder;
import com.project.npnc.document.model.service.MemberDocumentService;
import com.project.npnc.organization.dto.OrganizationDto;
import com.project.npnc.organization.service.OrganizationService;
import com.project.npnc.security.dto.Member;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/document")
@RequiredArgsConstructor
@Slf4j 
public class MemberDocumentController {
	private final MemberDocumentService serv;
	private final OrganizationService orserv;
	private final AdminDocumentService adminserv;
	private final VacationService vacserv;
	@Value("${file.upload-dir}")
    private String uploadDir;
	
	
	@GetMapping("/home")
	public void docHome(Model m) {
		Member user = getCurrentUser();
		m.addAttribute("doclist", serv.selectInprocessDocs(user.getMemberKey()));
		log.debug("{}", m.getAttribute("doclist"));
		m.addAttribute("waitinglist", serv.selectWaitingDocs(user.getMemberKey()));
		log.debug("{}", m.getAttribute("waitinglist"));
	}
	@GetMapping("/form")
	public void formChoice(Model m){
		log.debug("----전자문서 양식 조회----");
		List<DocumentFormFolder> result = serv.selectformFolders();
		log.debug("{}", result);
		m.addAttribute("folderlist", result);
	}
	
//	사원 문서 목록 조회
	@GetMapping("/list/employee/inprocess")
	public void selectInprocessDoc(Model m){
		log.debug("----진행중인 문서 조회----");
		Member user = getCurrentUser();
		List<Document> result = serv.selectInprocessDocs(user.getMemberKey());
		log.debug("{}", result);
		m.addAttribute("doclist", result);
	}
	@GetMapping("/list/employee/complete")
	public void selectMyCompleteDocs(Model m){
		log.debug("----승인 문서 조회----");
		Member user = getCurrentUser();
		log.debug(user.getMemberKey()+"번 사원");
		List<Document> result = serv.selectMyCompleteDocs(user.getMemberKey());
		log.debug("{}", result);
		m.addAttribute("completelist", result);
	}
	@GetMapping("/list/employee/reject")
	public void selectMyRejectDocs(Model m) {
		log.debug("----반려 문서 조회----");
		Member user = getCurrentUser();
		List<Document> result = serv.selectMyRejectDocs(user.getMemberKey());
		log.debug("{}", result);
		m.addAttribute("doclist", result);
	}
	@GetMapping("/list/employee/retrieve")
	public void selectRetrieveDocs(Model m) {
		log.debug("----회수 문서 조회----");
		Member user = getCurrentUser();
		List<Document> result = serv.selectRetrieveDocs(user.getMemberKey());
		log.debug("{}", result);
		m.addAttribute("doclist", result);
	}
	@GetMapping("/list/employee/draft")
	public void selectDraftDocs(Model m){
		log.debug("----임시보관 문서 조회----");
		Member user = getCurrentUser();
		List<Document> result = serv.selectDraftDocs(user.getMemberKey());
		log.debug("{}", result);
		m.addAttribute("doclist", result);
	}
	
//	결재자 문서 목록 조회
	@GetMapping("/list/approver/waiting")
	public void selectWaitingDocs(Model m){
		Member user = getCurrentUser();
		log.debug("----- " + user.getMemberKey()+"번 사원의 결재 대기 문서 조회 -----");
		List<Document> result = serv.selectWaitingDocs(user.getMemberKey());
		log.debug("{}", result);
		m.addAttribute("waitinglist", result);
	}
	@GetMapping("/list/approver/complete")
	public void selectCompleteDocs(Model m){
		Member user = getCurrentUser();
		log.debug("----- " + user.getMemberKey()+"번 사원이 승인한 문서 조회 -----");
		List<Document> result = serv.selectCompleteDocs(user.getMemberKey());
		log.debug("{}", result);
		m.addAttribute("completelist", result);
	}
	@GetMapping("/list/approver/pending")
	public void selectPendingDocs(Model m){
		Member user = getCurrentUser();
		log.debug("----- " + user.getMemberKey()+"번 사원이 보류한 문서 조회 -----");
		List<Document> result = serv.selectPendingDocs(user.getMemberKey());
		log.debug("{}", result);
		m.addAttribute("pendinglist", result);
	}
	@GetMapping("/list/approver/rejected")
	public void selectRejectedDocs(Model m){
		Member user = getCurrentUser();
		log.debug("----- " + user.getMemberKey()+"번 사원이 반려한 문서 조회 -----");
		List<Document> result = serv.selectRejectedDocs(user.getMemberKey());
		log.debug("{}", result);
		m.addAttribute("rejectedlist", result);
	}
	
//	참조 문서 목록
	@GetMapping("/list/referer/reference")
	public void selectReferenceDocs(Model m){
		Member user = getCurrentUser();
		log.debug("----- " + user.getMemberKey()+"번 사원의 참조 문서 조회 -----");
		List<Document> result = serv.selectReferenceDocs(user.getMemberKey());
		log.debug("{}", result);
		m.addAttribute("referencelist", result);
	}
	
	
//	전자문서 상세보기
	@PostMapping("/view/docDetail")
	public void viewDoc(int docId, 
			@RequestParam(required = false) String history, 
											Model m) throws Exception {
		log.debug("----" + docId + "번 문서 상세보기----");
		Document document = serv.selectDocById(docId);
		log.debug("{}", document);
		m.addAttribute("l", document);
		//문서파일 html 가져오기
		String html = readHtmlFile("dochtml", document.getErDocFilename());
		if(html == null || html.equals("")) {
			log.debug("문서 내용 -> " + html);
			throw new Exception("문서 불러오기 실패");
		}
		
		if(history != null) {
			m.addAttribute("history", history);
		}
		log.debug("문서 내용 -> " + html);
		m.addAttribute("html", html);
	}
	
	
	@GetMapping("/request/docForm{formNo}")
	public String formDoc(String form) {
		log.debug(form + "양식 불러오기");
		return readHtmlFile("/docformhtml", form+".html");
	}
	
	
	@PostMapping("/formlist")
	@ResponseBody
	public List<DocumentForm> formList(int folderNo, Model m) {
		log.debug("----전자문서 양식 "+ folderNo+"번 폴더 조회----");
		List<DocumentForm> result = serv.selectForms(folderNo);
		log.debug("{}", result);
		return result;
	}
	@PostMapping("/formsearch")
	@ResponseBody
	public List<DocumentForm> formList(String target, Model m) {
		log.debug("----전자문서 양식명 "+ target+" 조회----");
		List<DocumentForm> result = serv.selectFormsBySearch(target);
		log.debug("{}", result);
		return result;
	}
	@GetMapping("/write")
	public String formWrite(int form, Model m) {
		log.debug("----전자문서 작성시작----");
		String html = readHtmlFile("docformhtml", form+".html");
		//휴가 신청폼인 경우 휴가 데이터 첨부
		if(form ==3) {
			log.debug("----휴가 신청----");
			html = html.replace("[잔여 연차]", serv.selectRemainingVac(getCurrentUser().getMemberKey())+"");
			
			List<Vacation> vacation =vacserv.selectVacationAll();
			String vacselect = "<select class=\"form-select form-control-sm w-25\" id=\"vacationHalfArea\">";
			vacselect += "<option>---선택---</option>";
			for(Vacation v : vacation) {
				vacselect += "<option data-key=\"" + v.getVacationKey() + "\">" + v.getVacationName() + "</option>";
			}
			vacselect += "</select>";
			html = html.replace("[휴가 종류]", vacselect);
			
			m.addAttribute("vacationCategory", html);
		}
		//기안부서 적용
//		html = html.replace("[기안부서]", getCurrentUser().getDepartmentName());
		//기안일 적용
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy/MM/dd");
		html = html.replace("[기안일]", LocalDate.now().format(formatter));
		//기안자
//		html = html.replace("[기안자]", getCurrentUser().getJobName()+ " " + getCurrentUser().getMemberName());
		
		m.addAttribute("html", html);
		m.addAttribute("form", form);
		return "document/write/normal";
	}
	@PostMapping("/rewrite")
	public String docRewrite(String serial, Model m) {
		log.debug("----전자문서 재작성----");
		Document d = serv.selectDocBySerial(serial);
		String html = readHtmlFile("dochtml", d.getErDocFilename());
		log.debug(html);
		m.addAttribute("html", html);
		m.addAttribute("doc", d);
		log.debug("{}", d);
		
		//날짜- 제거
		String afterF = serial.substring(serial.indexOf("F"));
		//뒤 -이후 제거
		String afterFbeforebar = afterF.substring(0, afterF.indexOf("-"));
		if(afterFbeforebar.contains("TEMP")) {
			afterFbeforebar.replace("TEMP", "");
		}
		String formNo = afterFbeforebar.replace("F", "");
		System.out.println(formNo);
        	m.addAttribute("form", formNo);
        	log.debug(m.getAttribute("form").toString());
//        }else {
//            log.warn("No match found.");
//        }
		return "document/rewrite/normal";
	}
//	팝업
	//결재자 선택팝업 호출, 조직도와 저장된 결재라인 출력
	@GetMapping("/write/approver")
	public void docApprover(Model m) {
		List<OrganizationDto> list = orserv.selectOrganAll();
		log.debug("----- 결재자 선택 -----");
		m.addAttribute("list", list);
		log.debug("{}", list); 
		//저장된 결재라인들 출력
		List<ApproverLineStorage> ap = serv.selectApproverLines(getCurrentUser().getMemberKey());
		m.addAttribute("aplist", ap);
		log.debug("{}", ap); 
	}
	//보관함 선택 팝업 호출
	@GetMapping("/write/storage")
	public void docStorage(Model m) {
		List<StorageFolder> folders = adminserv.selectAdminDocumentFormAll();
		m.addAttribute("folders",folders);
		log.debug("----- 보관함 선택 -----");
		m.addAttribute("folders", folders);
		log.debug("{}", folders); 
	}
	//결재 승인
	@PostMapping("/approve")
	public ResponseEntity<Map<String,Object>> updateApproveDoc(
			@RequestBody Map<String, Object> requestBody
			){
		log.debug("{}", requestBody);
		String html = (String) requestBody.get("html");
	    String msg = (String) requestBody.get("msg");
	    String serial = (String) requestBody.get("serial");
	    int no = Integer.parseInt((String) requestBody.get("no"));
		log.debug("----- " + serial + "문서 결재 : " + msg + " -----");
		log.debug("html -> " + html);
		Map<String,Object> response = new HashMap<>();
		
		int result=0;
		try {
			result = serv.updateApproveDoc(no, serial, msg);
			if(result <=0) {
				response.put("status", "error");
				response.put("message", "문서 결재 실패");
			}else {
				response.put("status","success");
				response.put("message", "문서 결재 완료");
			}
		} catch (Exception e) {
			e.printStackTrace();
			response.put("status", "error");
			response.put("message", "문서 결재 실패");
		}
		return ResponseEntity.ok(response);
	}
	//결재 반려
	@PostMapping("/reject")
	public ResponseEntity<Map<String,Object>> updateRejectDoc(
			@RequestBody Map<String, Object> requestBody
			){
		log.debug("{}", requestBody);
		String html = (String) requestBody.get("html");
		String msg = (String) requestBody.get("msg");
		String serial = (String) requestBody.get("serial");
		int no = Integer.parseInt((String) requestBody.get("no"));
		log.debug("----- " + serial + "문서 반려 : " + msg + " -----");
		log.debug("html -> " + html);
		Map<String,Object> response = new HashMap<>();
		
		int result=0;
		try {
			result = serv.updateRejectDoc(no, serial, msg);
			if(result <=0) {
				response.put("status", "error");
				response.put("message", "문서 결재 실패");
			}else {
				response.put("status","success");
				response.put("message", "문서 결재 완료");
			}
		} catch (Exception e) {
			e.printStackTrace();
			response.put("status", "error");
			response.put("message", "문서 결재 실패");
		}
		return ResponseEntity.ok(response);
	}
	//결재 보류
	@PostMapping("/pend")
	public ResponseEntity<Map<String,Object>> updatePendDoc(
			@RequestBody Map<String, Object> requestBody
			){
		log.debug("{}", requestBody);
		String html = (String) requestBody.get("html");
		String msg = (String) requestBody.get("msg");
		String serial = (String) requestBody.get("serial");
		int no = Integer.parseInt((String) requestBody.get("no"));
		log.debug("----- " + serial + "문서 보류 : " + msg + " -----");
		log.debug("html -> " + html);
		Map<String,Object> response = new HashMap<>();
		
		int result=0;
		try {
			result = serv.updatePendDoc(no, serial, msg);
			if(result <=0) {
				response.put("status", "error");
				response.put("message", "문서 결재 실패");
			}else {
				response.put("status","success");
				response.put("message", "문서 결재 완료");
			}
		} catch (Exception e) {
			e.printStackTrace();
			response.put("status", "error");
			response.put("message", "문서 결재 실패");
		}
		return ResponseEntity.ok(response);
	}
	
	//결재라인 저장
	@PostMapping("/write/save/approverline")
	public ResponseEntity<Map<String,Object>> insertApproverLine(
			@RequestBody ApproverLineStorage data) throws Exception {
//			@RequestBody Map<String, Object> data) {
		log.debug("----- 결재라인 저장 -----");
		//결재라인명
		log.debug(data.getErApLineStorageName());
		//결재자들
		List<ApproverLine> list = data.getApprovers();
		log.debug("{}", list);
		int result = serv.insertApproverLine(getCurrentUser().getMemberKey(), data.getErApLineStorageName(), data.getApprovers());
//		log.debug("{}", data.get("name"));
//		List<Approver> list = (List<Approver>) data.get("approvers");
//		log.debug("{}", list);
//		int result = serv.insertApproverLine(getCurrentUser().getMemberKey(),(String) data.get("name"), list);
		Map<String,Object> response = new HashMap<>();
		
		if(result>0) {
			response.put("status","success");
			response.put("message", "결재라인 저장을 성공했습니다.");
		}
		else {
			response.put("status", "error");
			response.put("message", "결재라인 저장에 실패했습니다.");
		}
		return ResponseEntity.ok(response);
		
	}
	//결재라인 삭제
	@PostMapping("/write/delete/approverline")
	public ResponseEntity<Map<String,Object>> deleteApproverLine(
			@RequestBody int no) {
//		@RequestBody Map<String, Integer> requestBody) {
//		int no = requestBody.get("no");
		log.debug("----- 결제라인 "+ no + " 삭제 요청 -----");
		int result = serv.deleteApproverLine(no);
		Map<String,Object> response = new HashMap<>();
		
		if(result>0) {
			log.debug("결제라인 삭제 성공");
			response.put("status","success");
			response.put("message", "결재라인 삭제에 성공했습니다.");
		}
		else {
			log.debug("결제라인 삭제 실패");
			response.put("status", "error");
			response.put("message", "결재라인 삭제에 실패했습니다.");
		}
		return ResponseEntity.ok(response);
		
	}
	//참조인 선택
	@GetMapping("/write/referer")
	public void docReferer(Model m) {
		m.addAttribute("list", orserv.selectOrganAll());
	}
//	
	
	//문서 임시저장
	@PostMapping(path="/savedraft", consumes = {"multipart/form-data"})
	public ResponseEntity<Map<String,Object>> insertDraftDoc(
			String msg, Model m, Document doc, String html, @RequestParam(required = false) int form,
			@RequestParam(value="upfile")MultipartFile[] file
			){
		Member user = getCurrentUser();
		log.debug("{}", html);
		log.debug("{}", user);
		doc.setErDocSerialKey(user.getDepartmentKey()+"F"+form + "TEMP"); //문서구분키 생성을 위한 사전세팅(부서코드양식코드)
//		doc.setErDocStorageKey(); //문서보관함 임시세팅
		
		//기안자=로그인유저
		doc.setErDocWriter(user.getMemberKey()); 
		log.debug("{}", doc);
		
		int result=0;
		Map<String,Object> response = new HashMap<>();
		
		//문서 등록
		try { 
			log.debug(user.getMemberName()+ "사원의 문서 임시저장");
			result = serv.insertDraftDoc(doc, file, html);
		} catch (Exception e) {
			log.debug("문서 임시저장 실패");
			e.printStackTrace();
			response.put("status", "error");
			response.put("message", "문서 임시저장에 실패했습니다.");
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
		}
		
		//기안, 결재자 등록 성공시
		response.put("status", "success");
		response.put("message", "문서 임시저장 완료");
		
		return ResponseEntity.ok(response);
	}
	
	//전자문서 기안(기안자번호, 기안자결재의견, 기본정보, 결재자들, 첨부파일)
	@PostMapping(path="/writeend", consumes = {"multipart/form-data"}) 
	public ResponseEntity<Map<String,Object>> insertDoc(
			String msg, Model m, Document doc, String html, @RequestParam(required = false) int form,
			@RequestParam(value="upfile", required = false) MultipartFile[] file) {
		Member user = getCurrentUser();
		if(msg.equals(",")) msg=""; //debug
		if (msg != null && msg.endsWith(",")) {
		    msg = msg.substring(0, msg.length() - 1); // 마지막 문자를 제거
		}//debug
		
		log.debug("{}", html);
		log.debug(file.toString());
		log.debug("{}", user);
		doc.setErDocSerialKey(user.getDepartmentKey()+"F"+form); //문서구분키 생성을 위한 사전세팅(부서코드양식코드)
		doc.setDocFormKey(form);
		
		//기안자=로그인유저
		doc.setErDocWriter(user.getMemberKey()); 
		//결재자에 기안자도 추가
		Approver me = Approver.builder().memberKey(user.getMemberKey())
									.memberTeamKey(user.getDepartmentKey())
									.memberJobKey(user.getJobKey())
									.memberName(user.getMemberName())
									.category("기안")
									.opinion(msg)
									.state("승인")
									.date(Date.valueOf(LocalDate.now()))
									.orderby(0)
						.build();
		List<Approver> ap = doc.getApprovers();
		ap.removeIf(a -> {
		    boolean toRemove = a.getMemberKey() == 0;
		    if (toRemove) {
		        log.debug("없는 결재자 삭제");
		        log.debug("{}", a);
		    }
		    return toRemove;
		});//debug
		ap.add(me);
		doc.setApprovers(ap);
		log.debug("{}", doc);
		
		int result=0;
		Map<String,Object> response = new HashMap<>();
		
		//문서 등록
		try { 
			log.debug(user.getMemberName()+ "사원의 문서 기안 -> " + msg);
			result = serv.insertDoc(doc, file, html);
		} catch (Exception e) {
			log.error(e.getMessage());
			e.printStackTrace();
			response.put("status", "error");
			response.put("message", "문서 등록에 실패했습니다.");
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
		}
		
		//기안, 결재자 등록 성공시
		response.put("status", "success");
		response.put("message", "문서 등록 완료");
//		response.put("no", "문서 등록 완료");
		
		//모두 성공시 전자결재홈으로
		return ResponseEntity.ok(response);
		//return "redirect:home"; 
	}
	
	@PostMapping("/retrieve")
	@ResponseBody
	public int retrieveDoc(String no) {
		log.debug("------"+no + "번 문서 회수 요청------");
		int result=0;
		try {
			result = serv.retrieveDoc(no);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	@PostMapping("/delete")
	@ResponseBody
	public ResponseEntity<Map<String,Object>> deleteDraftDoc(int no) {
		log.debug("------"+no + " 보관 문서 삭제 요청------");
		Map<String,Object> response = new HashMap<>();
		int result=0;
		try {
			result = serv.deleteDraftDoc(no);
		} catch (Exception e) {
			e.printStackTrace();
			response.put("status", "error");
			response.put("message", "문서 삭제에 실패했습니다.");
			return ResponseEntity.ok(response);
		}
		response.put("status", "success");
		response.put("message", "문서 삭제 완료");
		return ResponseEntity.ok(response);
	}
	
	//html 파일 읽기
	public String readHtmlFile(String dir, String title) {
        String path = uploadDir + dir + "/" + title;
        log.debug("문서 읽기 경로 : " + path);
        File file = new File(path);
        StringBuilder content = new StringBuilder();

        try (BufferedReader br = new BufferedReader(
              new InputStreamReader(
                    new FileInputStream(file), StandardCharsets.UTF_8))) {
            String line;
            while ((line = br.readLine()) != null) {
                content.append(line).append("\n");
            }
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return content.toString();
  }
	private Member getCurrentUser() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        return (Member) authentication.getPrincipal();
    }
}
