package com.lee.admin.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.log4j.Log4j;

@Log4j
@RequestMapping("/admin")
@Controller
public class AdminController {
	
	@GetMapping("/yeongyeong")
	public void doAdmin() {
		log.info("Admin only");
	}
	
	@GetMapping("/info")
	public void adminInfo() {
		log.info("Admin only");
	}
	
	@GetMapping("/contact/main")
	public void adminContact() {
		log.info("Admin only");
	}
	
	@GetMapping("/work")
	public void adminWork() {
		log.info("Admin only");
	}
	
	

}
