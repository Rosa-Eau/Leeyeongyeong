package com.lee.admin.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;

import com.lee.admin.domain.InfoDTO;
import com.lee.admin.mapper.InfoMapper;
import com.lee.admin.service.IInfoService;

import lombok.extern.log4j.Log4j;

@Service
public class InfoServiceImpl implements IInfoService {

	@Autowired
	private InfoMapper mapper;

	@Override
	public void register(InfoDTO iDto) throws Exception {
		mapper.register(iDto);
	}

	@Override
	public boolean modify(InfoDTO iDto) throws Exception {
		
		return mapper.modify(iDto) == 1;
	}

	@Override
	public boolean delete(int tno) throws Exception {
		
		return mapper.delete(tno) == 1;
	}

	@Override
	public List<InfoDTO> list() throws Exception {
		return mapper.list();
	}

	@Override
	public InfoDTO read(int tno) throws Exception {
		
		return mapper.read(tno);
	}
	
	

}
