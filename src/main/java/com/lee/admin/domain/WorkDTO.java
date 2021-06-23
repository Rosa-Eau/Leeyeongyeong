package com.lee.admin.domain;


import java.sql.Date;
import java.util.List;

import lombok.Data;

@Data
public class WorkDTO {
	
	private int wno;
	private String title;
	private String content;
	private Date workdate;
	
	private List<AttachFileDTO> attachList;
	

}
