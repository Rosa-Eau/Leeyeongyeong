package com.lee.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class EmailDTO {
    private String email;    //발신자 이메일 주소
    private String subject;            //제목
    private String message;            //본문

    
}