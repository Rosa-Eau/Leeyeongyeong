package com.lee.admin.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class InfoDTO {
	
	private int tno;
	private String title;
	private String content;
	
}
