package com.lee.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.lee.domain.EmailDTO;
import com.lee.service.EmailService;

import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("/mail")
public class MailController {

//	@Autowired
//	private JavaMailSender mailSender;
//
//	// mailSending 코드
//	@RequestMapping(value = "/sending")
//	public String mailSending(HttpServletRequest request) {
//
//		String setTo = "-";
//		String email = request.getParameter("email"); // 보내 사람 이메일
//		String subject = request.getParameter("subject"); // 제목
//		String message = request.getParameter("message"); // 내용
//
//		try {
//			MimeMessage mail = mailSender.createMimeMessage();
//			MimeMessageHelper messageHelper = new MimeMessageHelper(mail, true, "UTF-8");
//
//			messageHelper.setTo(setTo); // 보내는사람 생략하면 정상작동을 안함
//			messageHelper.setFrom(email); // 받는사람 이메일
//			messageHelper.setSubject(subject); // 메일제목은 생략이 가능하다
//			messageHelper.setText(message); // 메일 내용
//
//			log.info(mail);
//			mailSender.send(mail);
//		} catch (Exception e) {
//			System.out.println(e);
//		}
//
//		return "leeyeongyeong/contact";
//	}
	
	@Autowired
    EmailService emailService; // 서비스를 호출하기위한 의존성 주입
 
    @RequestMapping("/send.do") // 확인 (메일발송) 버튼을 누르면 맵핑되는 메소드
    public String send(@ModelAttribute EmailDTO dto, Model model) {
        try {
 
            emailService.sendMail(dto); // dto (메일관련 정보)를 sendMail에 저장함
            model.addAttribute("message", "Email has been sent"); // 이메일이 발송되었다는 메시지를 출력시킨다.
            log.info("success");
            return "/leeyeongyeong/contact";
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("message", "Failed to send email"); // 이메일 발송이 실패되었다는 메시지를 출력
            log.info("fail");
        }
        return "/leeyeongyeong/contact"; // 실패했으므로 다시 write jsp 페이지로 이동함
    }
}
