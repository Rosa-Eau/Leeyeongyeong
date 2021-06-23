package com.lee.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.lee.admin.service.IInfoService;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/leeyeongyeong")
public class MainController {
	
	@Autowired
	IInfoService iService;
	
	@GetMapping("/main")
	public void main() {
		log.info("main page");
	}
	
	@GetMapping("/info")
	public void info(Model model) throws Exception {
		log.info("info list...........");
		model.addAttribute("info", iService.list());
	}
	
	@GetMapping("/contact")
	public void contact() {
		log.info("contact page");
	}

}
