package com.lee.admin.service;

import java.util.List;

import com.lee.admin.domain.InfoDTO;

public interface IInfoService {
	
	public boolean delete(int tno) throws Exception;
	public List<InfoDTO> list() throws Exception;
	public InfoDTO read(int tno) throws Exception;
	public void register(InfoDTO iDto) throws Exception;
	public boolean modify(InfoDTO iDto) throws Exception;

}
