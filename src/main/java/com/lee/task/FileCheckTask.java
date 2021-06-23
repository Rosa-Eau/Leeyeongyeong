package com.lee.task;

import java.io.File;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.lee.admin.domain.AttachFileDTO;
import com.lee.admin.mapper.WorkAttachMapper;

import lombok.extern.log4j.Log4j;

@Log4j
@Component
public class FileCheckTask {
	
	@Autowired
	private WorkAttachMapper attachMapper;
	
	private String uploadPath = "/Users/kami/Desktop/SpringMVC/STS/Leeyeongyeong/src/main/webapp/resources/upload";

	
	private String getFolderYesterday() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		Calendar cal = Calendar.getInstance();
		
		cal.add(Calendar.DATE, -2);
		
		String str = sdf.format(cal.getTime());
		
		return str.replace("-", File.separator);
		
	}
	
	//cron 초 분 시 일 월  (주단위)
	@Scheduled(cron = "0 0 9 * * *")
	public void checkFiles() {
		
		log.warn("File Check Task run...............");
		log.warn(new Date());
		
		//file list in database
		List<AttachFileDTO> fileList = attachMapper.getOldFiles();
		
		//ready for check file in directory with database file list
		List<Path> filePaths = fileList.stream().map(vo -> Paths
				.get(uploadPath, vo.getUploadPath(), vo.getUuid() + "_" + vo.getFileName()))
				.collect(Collectors.toList());
		
		//image file has thumnail file
		fileList
		.stream()
		.filter(vo -> vo.isFiletype() == true)
		.map(vo -> Paths.get(uploadPath, vo.getUploadPath(), "s_" + vo.getUuid() + "_" + vo.getFileName()))
		.forEach(p -> filePaths.add(p));
		
		
		log.warn("=====================================");
		
		filePaths.forEach(p -> log.warn(p));
		
		//files in yesterday directory
		
		File targetDir = Paths.get(uploadPath, getFolderYesterday()).toFile();
		
		File[] removeFiles = targetDir.listFiles(file -> filePaths.contains(file.toPath()) == false);
		
		log.warn("--------------------------------------");
		
		for (File file : removeFiles) {
			
			log.warn(file.getAbsolutePath());
			
			file.delete();
		}
		

		
	}

	
}
