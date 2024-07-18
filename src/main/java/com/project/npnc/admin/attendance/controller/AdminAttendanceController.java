package com.project.npnc.admin.attendance.controller;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.project.npnc.attendance.model.dto.Attendance;
import com.project.npnc.attendance.model.dto.AttendanceEdit;
import com.project.npnc.attendance.model.service.AttendanceService;
import com.project.npnc.common.PageFactory;

import lombok.RequiredArgsConstructor;

@RequestMapping("/admin/attendance")
@Controller
@RequiredArgsConstructor
public class AdminAttendanceController {
	
	private final AttendanceService service;
	private final PageFactory pageFactory;
	
	@GetMapping("/selectAdminAttendanceAll")
	public String selectAdminAttendanceAll(
			@RequestParam(defaultValue = "1") int cPage,
			@RequestParam(defaultValue = "10") int numPerpage,
			Model m) {
		Map page=Map.of("cPage",cPage,"numPerpage",numPerpage);
		int totaldata=service.selectAdminAttendanceAllCount();
		List<Attendance> attendance=service.selectAdminAttendanceAll(page);
		m.addAttribute("pagebar",pageFactory.getPage(cPage, numPerpage, totaldata, "selectAdminAttendanceAll"));
		m.addAttribute("attendance",attendance);
		return "admin/attendance/adminattendancelist";
	}
	
	@GetMapping("/selectAdminAttendanceEditAll")
	public String selectAdminAttendanceEditAll(
			@RequestParam(defaultValue = "1") int cPage,
			@RequestParam(defaultValue = "10") int numPerpage,	
			Model m) {
		Map page=Map.of("cPage",cPage,"numPerpage",numPerpage);
		int totaldata=service.selectAdminAttendanceEditCount();
		List<AttendanceEdit> attendanceEdit=service.selectAdminAttendanceEditAll(page);
		m.addAttribute("pagebar",pageFactory.getPage(cPage, numPerpage, totaldata, "selectAdminAttendanceEditAll"));
		m.addAttribute("attendanceEdit",attendanceEdit);
		return "admin/attendance/adminattendanceeditlist";
	}
	
	@PostMapping("/adminAttendanceEditDetail")
	public String adminAttendanceEditDetail(int attendanceEditKey,Model m) {
		AttendanceEdit attendanceEdit=service.selectAttendanceEditByKey(attendanceEditKey);
		m.addAttribute("attendanceEdit",attendanceEdit);
		
		return "admin/attendance/adminattendanceEditDetail";
	}
	
	@PostMapping("/updateAttendanceEdit")
	public String updateAttendanceEdit(int attendanceEditKey,String attendanceEditOpinion,Model m) {
		AttendanceEdit attendanceEdit=AttendanceEdit.builder().attendanceEditKey(attendanceEditKey).attendanceEditOpinion(attendanceEditOpinion).build();
		int result=service.updateAttendanceEdit(attendanceEdit);
		String msg,loc;
		if(result>0) {
			msg="반려성공";
			loc="/admin/attendance/selectAdminAttendanceEditAll";
		}else {
			msg="반려실패";
			loc="/admin/attendance/selectAdminAttendanceEditAll";
		}
		m.addAttribute("msg",msg);
		m.addAttribute("loc",loc);
		return "common/msg";
	}
	
	
	@PostMapping("/updateAttendance")
	public String updateAttendance(AttendanceEdit attendanceEdit,int attendanceKey,Model m) {
		attendanceEdit.setAttendance(Attendance.builder().attendanceKey(attendanceKey).build());
		int result=service.updateAttendance(attendanceEdit);
		String msg,loc;
		if(result>0) {
			msg="승인성공";
			loc="/admin/attendance/selectAdminAttendanceEditAll";
		}else {
			msg="승인실패";
			loc="/admin/attendance/selectAdminAttendanceEditAll";
		}
		m.addAttribute("msg",msg);
		m.addAttribute("loc",loc);
		return "common/msg";
	}
}
