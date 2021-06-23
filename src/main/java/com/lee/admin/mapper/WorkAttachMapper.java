package com.lee.admin.mapper;

import java.util.List;

import com.lee.admin.domain.AttachFileDTO;

public interface WorkAttachMapper {

	public void insert(AttachFileDTO fDto);
	public void delete(String uuid);
	public List<AttachFileDTO> findByWno(int wno);
	public void deleteAttachAll(Integer bno);
	public List<AttachFileDTO> getOldFiles();

}
