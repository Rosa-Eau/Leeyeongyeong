package com.lee.admin.domain;

import lombok.Data;

@Data
public class AttachFileDTO {
	
	private String uuid;
	private String fileName;
	private String uploadPath;
	private boolean filetype;

	private Integer wno;

}
