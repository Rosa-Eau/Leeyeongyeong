package com.lee.domain;

import java.util.List;

import lombok.Data;

@Data
public class MemberDTO {

	private String id;
	private String userpw;
	private boolean enabled;

	private List<AuthDTO> authList;
}
