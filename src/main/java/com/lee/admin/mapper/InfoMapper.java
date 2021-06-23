package com.lee.admin.mapper;

import java.util.List;

import com.lee.admin.domain.InfoDTO;

public interface InfoMapper {
	
	public List<InfoDTO> list();
	public void register(InfoDTO iDto);
	public InfoDTO read(int tno);
	public int modify(InfoDTO iDto);
	public int delete(int tno);
	
}
