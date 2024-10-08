package com.project.npnc.external.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.npnc.external.dto.ExternalDto;
import com.project.npnc.external.service.ExternalService;
import com.project.npnc.security.dto.Member;

import jakarta.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/external")
public class ExternalController {

    @Autowired
    private ExternalService externalService;

    @GetMapping("/list")
    public String listContacts(HttpServletRequest request,Authentication authentication) {
    	Member member = (Member) authentication.getPrincipal();
        List<ExternalDto> contacts = externalService.getAllContacts(member.getMemberKey());
        request.setAttribute("contacts", contacts);
        return "external/externalList";
    }

    @GetMapping("/search")
    public String searchContacts(@RequestParam("query") String query, HttpServletRequest request) {
        List<ExternalDto> contacts = externalService.searchContacts(query);
        request.setAttribute("contacts", contacts);
        return "external/externalList";
    }

    @PostMapping("/add")
    public String addContact(@ModelAttribute ExternalDto externalDto, Authentication authentication) {
        Member member = (Member) authentication.getPrincipal();
 
    	externalDto.setMEMBER_KEY(member.getMemberKey());
       	System.out.println(externalDto);
        externalService.addContact(externalDto);
        return "redirect:/external/list";
    }

    @PostMapping("/edit")                                                       
    public String editContact(@ModelAttribute ExternalDto externalDto) {
        externalService.updateContact(externalDto);
        return "redirect:/external/list";
    }
    
    @GetMapping("/write")
    public String showAddContactForm() {
        return "external/externalWrite"; 
    }

    @PostMapping("/delete")
    public ResponseEntity<Map<String, Boolean>> deleteContact(@RequestParam("AB_EXTERNAL_KEY") int id, Authentication authentication) {
        Member member = (Member) authentication.getPrincipal();
        ExternalDto externalDto = externalService.getContactById(id);
        Map<String, Boolean> response = new HashMap<>();
        System.out.println(externalDto.getMEMBER_KEY());
        System.out.println(member.getMemberKey());
        if (externalDto.getMEMBER_KEY() == member.getMemberKey()) {
        	System.out.println("gd");
            externalService.deleteContact(id);
            response.put("success", true);
        } else {
            response.put("success", false);
        }
        return ResponseEntity.ok(response);
    }


    @PostMapping("/toggleFavorite")
    @ResponseBody
    public String toggleFavorite(@RequestParam("AB_EXTERNAL_KEY") int id) {
        try {
            externalService.toggleFavorite(id);
            return "success";
        } catch (Exception e) {
            e.printStackTrace(); // 예외를 로그에 기록합니다.
            return "error";
        }
    }

    @GetMapping("/get/{id}")
    @ResponseBody
    public ExternalDto getContactById(@PathVariable("id") int id) {
        return externalService.getContactById(id);
    }
}
