package com.lee.admin.service;

import java.util.List;

import com.lee.admin.domain.AttachFileDTO;
import com.lee.admin.domain.Criteria;
import com.lee.admin.domain.WorkDTO;

public interface IWorkService {
	
	public boolean delete(int wno) throws Exception;
	public List<WorkDTO> list(Criteria cri) throws Exception;
	public WorkDTO read(int wno) throws Exception;
	public void register(WorkDTO wDto) throws Exception;
	public boolean modify(WorkDTO wDto) throws Exception;
	public int total(Criteria cri);
	
	public List<AttachFileDTO> getAttachList(int wno);

}
