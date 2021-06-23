package com.lee.admin.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lee.admin.domain.AttachFileDTO;
import com.lee.admin.domain.Criteria;
import com.lee.admin.domain.WorkDTO;
import com.lee.admin.mapper.WorkAttachMapper;
import com.lee.admin.mapper.WorkMapper;
import com.lee.admin.service.IWorkService;

import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class WorkServiceImpl implements IWorkService{

	@Autowired
	private WorkMapper mapper;
	
	@Autowired
	private WorkAttachMapper attachM;
	
	@Override
	public boolean delete(int wno) throws Exception {
		attachM.deleteAttachAll(wno);
		return mapper.delete(wno) == 1;
	}

	@Override
	public List<WorkDTO> list(Criteria cri) throws Exception {
		
		log.info("criteria ==> " + cri);
		
		return mapper.listWithPaging(cri);
	}

	@Override
	public WorkDTO read(int wno) throws Exception {
		return mapper.read(wno);
	}

	@Override
	public void register(WorkDTO wDto) throws Exception {
	
		mapper.register(wDto);
		
		if(wDto.getAttachList() == null || wDto.getAttachList().size() < 0) {
			return;
		}
		
		wDto.getAttachList().forEach(attach ->{
			attach.setWno(wDto.getWno());
			attachM.insert(attach);
		});
		
	}

	@Override
	public boolean modify(WorkDTO wDto) throws Exception {
		
		log.info("modify..............." + wDto);
		
		attachM.deleteAttachAll(wDto.getWno());
		
		boolean modifyResult = mapper.modify(wDto) == 1;
		
		if(modifyResult && wDto.getAttachList() != null && wDto.getAttachList().size() > 0) {
			
			wDto.getAttachList().forEach(attach -> {
				attach.setWno(wDto.getWno());
				attachM.insert(attach);
			});
		}
		
		return modifyResult;
	}

	@Override
	public int total(Criteria cri) {
		log.info("get total count");
		return mapper.total(cri);
	}

	@Override
	public List<AttachFileDTO> getAttachList(int wno) {
		return attachM.findByWno(wno);
	}

}
