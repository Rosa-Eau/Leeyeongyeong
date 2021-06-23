package com.lee.admin.controller;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.lee.admin.domain.AttachFileDTO;
import com.lee.admin.domain.Criteria;
import com.lee.admin.domain.PageDTO;
import com.lee.admin.domain.WorkDTO;
import com.lee.admin.service.IWorkService;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/admin/work")
@Log4j
public class WorkController {

	@Autowired
	IWorkService wService;
	
	private String uploadPath = "/Users/kami/Desktop/SpringMVC/STS/Leeyeongyeong/src/main/webapp/resources/upload";

	@GetMapping("/main")
	public void work(Criteria cri, Model model) throws Exception {
		log.info("work list...........");
		log.info("work: " + cri);

		model.addAttribute("work", wService.list(cri));
		
		int total = wService.total(cri);
		
		log.info("total : " + total);
		
		model.addAttribute("pageMaker", new PageDTO(cri, total));
	}

	@GetMapping("/register")
	public void registerGET() {
		log.info("register get..............");
	}
	
	@PostMapping("/register")
	public String registerPOST(WorkDTO wDto, RedirectAttributes rttr) throws Exception {
		log.info("work register post..............");
		log.info("/register ===> " + wDto);
	
		if(wDto.getAttachList() != null) {
			wDto.getAttachList().forEach(attach -> log.info(attach));
		}
		
		log.info("===========================================");

		wService.register(wDto);

		rttr.addFlashAttribute("result", wDto.getWno());

		return "redirect:/admin/work/main";
	}
	

	@GetMapping(value = {"/read", "/modify"})
	public void modifyGET(@RequestParam("wno") int wno, @ModelAttribute("cri") Criteria cri, Model model) throws Exception {
		log.info("read/modify Get............");

		model.addAttribute("work", wService.read(wno));
	}


	@PostMapping("/modify")
	public String modifyPOST(WorkDTO wDto, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) throws Exception {
		
		log.info("modify ===> " + wDto);
		
		if(wService.modify(wDto)) {
			rttr.addFlashAttribute("result", "success");
		}
		
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());
	    rttr.addAttribute("keyword", cri.getKeyword());
		
		return "redirect:/admin/work/main";
	
	}
	
	
	@PostMapping("/remove")
	public String remove(@RequestParam("wno") int wno, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) throws Exception{
		log.info("remove ===> " + wno);
		List<AttachFileDTO> attachList = wService.getAttachList(wno);
		log.info("attachList ==> " + attachList);
		
		if(wService.delete(wno)) {
			
			this.deleteFiles(attachList);
			rttr.addFlashAttribute("result", "success");
		}
	
		return "redirect:/admin/work/main" + cri.getListLink();
	}
	
	@GetMapping(value="/getAttachList", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public ResponseEntity<List<AttachFileDTO>> getAttachList(int wno){
		
		log.info("get Attach List " + wno);
		
		return new ResponseEntity<List<AttachFileDTO>>(wService.getAttachList(wno), HttpStatus.OK);
		
	}
	
	private void deleteFiles(List<AttachFileDTO> attachList) {
		   
		   if(attachList == null || attachList.size() <= 0) {
			   return;
		   }
		   
		   log.info("delete attach files........................");
		   log.info("" + attachList);
		   
		   attachList.forEach(attach -> {
			   try {
				Path file = Paths.get(uploadPath + attach.getUploadPath() + "\\" + attach.getUuid() + "_" + attach.getFileName());
				
				Files.deleteIfExists(file);
				
				if(Files.probeContentType(file).startsWith("image")) {
					Path thumbNail = Paths.get(uploadPath + attach.getUploadPath() + "\\s_" + attach.getUuid() + "_" + attach.getFileName());
					Files.delete(thumbNail);
				}
			} catch (Exception e) {
				log.error("delete file error : " + e.getMessage());
			}//end catch
		   }); //end forEach
	   }

	
}
