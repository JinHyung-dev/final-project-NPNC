package com.project.npnc.document.model.service;

import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import com.project.npnc.document.model.dto.ApproverLine;
import com.project.npnc.document.model.dto.ApproverLineStorage;
import com.project.npnc.document.model.dto.DocFile;
import com.project.npnc.document.model.dto.Document;
import com.project.npnc.document.model.dto.DocumentForm;
import com.project.npnc.document.model.dto.DocumentFormFolder;
import com.project.npnc.document.model.dto.OvertimeApply;
import com.project.npnc.document.model.dto.Referer;
import com.project.npnc.document.model.dto.VacationApply;

public interface MemberDocumentService {
	
	List<DocumentFormFolder> selectformFolders();
	List<DocumentForm> selectForms(int no);
	List<DocumentForm> selectFormsBySearch(String target);
	DocumentForm selectFormByNo(int no);
	
	int insertDoc(Document d, MultipartFile[] file, String html) throws Exception;
	int insertVacDoc(Document d, MultipartFile[] file, String html, VacationApply vac, String uploadDir) throws Exception;
	int insertOvertimeDoc(Document d, MultipartFile[] file, String html, OvertimeApply ot, String uploadDir) throws Exception;
	int insertDraftDoc(Document d, MultipartFile[] file, String html) throws Exception;
	int insertDraftVacDoc(Document d, MultipartFile[] file, String html, VacationApply vac) throws Exception;
//	int deleteDoc(Document d) throws Exception;
//	int insertDoc(Document d, ApproversList request, RefererList referers) throws Exception;
	int insertApprovers(Document d) throws Exception;
	int insertReferers(Document d) throws Exception;
	List<Document> selectInprocessDocs(int no);
	List<Document> selectWaitingDocs(int no);
	List<Document> selectRetrieveDocs(int no);
	List<Document> selectDraftDocs(int no);
	List<Document> selectPendingDocs(int no);
	List<Document> selectMyRejectDocs(int no);
	List<Document> selectMyCompleteDocs(int no);
	List<Document> selectMyPendingDocs(int no);
	List<Document> selectCompleteDocs(int no);
	List<Document> selectRejectedDocs(int no);
	List<Document> selectReferenceDocs(int no);
	int retrieveDoc(String docSerial) throws Exception;
	int deleteDraftDoc(int docKey) throws Exception;
	
	Document selectDocById(int docId);
	Document selectDocBySerial(String serial);
	
	int insertApproverLine(int no, String name, List<ApproverLine> list) throws Exception;
	List<ApproverLine> selectApproverLineList(int storageKey, int memberNo);
	List<Referer> selectReferer(String serial);
	List<ApproverLineStorage> selectApproverLines(int memberNo);
	int deleteApproverLine(int no);
	
	int insertDocFile(List<DocFile> list) throws Exception;
	int deleteDocFile(String docSerial) throws Exception;
	String selecetDocFileOriname(String filename);
	
	
	int selectRemainingVac(int memberKey);
	int insertVacationApply(VacationApply vac);
	int updateVacationApply(String docSerial, String status);
	int updateOvertiemApply(String docSerial, String status);
	DocFile getFileDetailByRename(String filename);
	
	Map<String, String> selectStorageAndFolder(int erDocStorageKey);
	int selectVacApply(int memberKey, Timestamp start, Timestamp end);
}