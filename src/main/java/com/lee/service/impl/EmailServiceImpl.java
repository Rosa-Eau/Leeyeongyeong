package com.lee.service.impl;

import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import com.lee.domain.EmailDTO;
import com.lee.service.EmailService;

import lombok.extern.log4j.Log4j;

@Log4j
@Service // 서비스 빈으로 등록
public class EmailServiceImpl implements EmailService {
 
    @Autowired
    JavaMailSender mailSender; // root-context.xml에 설정한 bean, 의존성을 주입
 
    @Override
    public void sendMail(EmailDTO dto) {
        try {
            // 이메일 객체
            MimeMessage msg = mailSender.createMimeMessage();
            MimeMessageHelper messageHelper = new MimeMessageHelper(msg, true, "UTF-8");
            
            String myEmail = "tory020900@gmail.com";
            
            
            messageHelper.setTo(dto.getEmail()); // 보내는사람 생략하면 정상작동을 안함
			messageHelper.setFrom(myEmail); // 받는사람 이메일
			messageHelper.setSubject(dto.getSubject()); // 메일제목은 생략이 가능하다
			messageHelper.setText(dto.getMessage()); // 메일 내용
			
			log.info(msg);
            
// 
//            // 받는 사람을 설정 (수신자, 받는사람의 이메일 주소 객체를 생성해서 수신자 이메일주소를 담음)
//            msg.addRecipient(RecipientType.TO, new InternetAddress(MyEmail));
// 
//            /*
//             * createMimeMessage() : MimeMessage객체를 생성시킴 (이것을 이용해서 메시지를 구성한 뒤 메일 발송)
//             * addRecipient() : 메시지의 발신자를 설정 InternetAddress() : 이메일 주소 getReceiveMail() :
//             * 수신자 이메일 주소
//             */
// 
//            // 보내는 사람(이메일주소+이름)
//            // (발신자, 보내는 사람의 이메일 주소와 이름을 담음)
//            // 이메일 발신자
//            msg.addFrom(new InternetAddress[] { new InternetAddress(dto.getEmail()) } );
// 
//            // 이메일 제목 (인코딩을 해야 한글이 깨지지 않음)
//            msg.setSubject(dto.getSubject(), "utf-8");
//            // 이메일 본문 (인코딩을 해야 한글이 깨지지 않음)
//            msg.setText(dto.getMessage(), "utf-8");
 
//            html로 보낼 경우            
//            MimeMessage message = mailSender.createMimeMessage();
//            MimeMessageHelper helper 
//            = new MimeMessageHelper(message, true);
//            helper.setTo("test@host.com");
//            helper.setText("<html><body><img src='cid:identifier1234'></body></html>", true);
 
            // 이메일 보내기
            mailSender.send(msg);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
}