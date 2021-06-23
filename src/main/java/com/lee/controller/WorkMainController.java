package com.lee.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.lee.admin.domain.AttachFileDTO;
import com.lee.admin.domain.Criteria;
import com.lee.admin.domain.PageDTO;
import com.lee.admin.service.IWorkService;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/leeyeongyeong/work")
@Log4j
public class WorkMainController {
	
	@Autowired
	private IWorkService wService;
	
	@GetMapping("/main")
	public void work(Criteria cri, Model model) throws Exception {
		log.info("work list...........");
		log.info("work: " + cri);

		model.addAttribute("work", wService.list(cri));
		
		int total = wService.total(cri);
		
		log.info("total : " + total);
		
		model.addAttribute("pageMaker", new PageDTO(cri, total));
	}
	
	@GetMapping("/read")
	public void read(@RequestParam("wno") int wno, @ModelAttribute("cri") Criteria cri, Model model) throws Exception {
		model.addAttribute("work", wService.read(wno));
		log.info("read ==>" + wno);
	}
	
	@GetMapping(value="/getAttachList", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public ResponseEntity<List<AttachFileDTO>> getAttachList(int wno){
		
		log.info("get Attach List " + wno);
		
		return new ResponseEntity<List<AttachFileDTO>>(wService.getAttachList(wno), HttpStatus.OK);
		
	}
	

}
