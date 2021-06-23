package com.lee.admin.mapper;

import java.util.List;

import com.lee.admin.domain.Criteria;
import com.lee.admin.domain.WorkDTO;

public interface WorkMapper {
	
	public List<WorkDTO> listWithPaging(Criteria cri);
	public void register(WorkDTO wDto);
	public WorkDTO read(int wno);
	public int modify(WorkDTO wDto);
	public int delete(int wno);
	public int total(Criteria cri);

}
