package com.lee.admin.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.lee.admin.domain.InfoDTO;
import com.lee.admin.service.IInfoService;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/admin/info")
@Log4j
public class InfoController {

	@Autowired
	IInfoService iService;

	@GetMapping("/main")
	public void info(Model model) throws Exception {
		log.info("info list...........");
		model.addAttribute("info", iService.list());
	}

	@GetMapping("/register")
	public void registerGET() {
		log.info("register get..............");
	}
	
	@PostMapping("/register")
	public String registerPOST(InfoDTO iDto, RedirectAttributes rttr) throws Exception {
		log.info("info modifyInfo post..............");
		log.info("/register ===> " + iDto);
		
		iDto.getContent().replaceAll("<br>", "\r\n");

		iService.register(iDto);

		rttr.addFlashAttribute("result", iDto.getTno());

		return "redirect:/admin/info/main";
	}
	

	@GetMapping("/modify")
	public void modifyGET(@RequestParam("tno") int tno, Model model) throws Exception {
		log.info("modify Get............");

		model.addAttribute("info", iService.read(tno));
	}


	@PostMapping("/modify")
	public String modifyPOST(InfoDTO iDto, RedirectAttributes rttr, Model model) throws Exception {
		
		log.info("modify ===> " + iDto);
		
		if(iService.modify(iDto)) {
			rttr.addFlashAttribute("result", "success");
		}
		
		return "redirect:/admin/info/main";
	
	}
	
	
	@PostMapping("/remove")
	public String remove(@RequestParam("tno") int tno, RedirectAttributes rttr) throws Exception{
		log.info("remove ===> " + tno);
		
		if(iService.delete(tno)) {
			rttr.addFlashAttribute("result", "success");
		}
		
		return "redirect:/admin/info/main";
	}

	
}
