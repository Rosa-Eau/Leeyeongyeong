package com.lee.admin.controller;

import java.io.File;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.lee.admin.domain.AttachDTO;

import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnails;

@Controller
@Log4j
public class UplaodController {

	private String uploadPath = "/Users/kami/Desktop/SpringMVC/STS/Leeyeongyeong/src/main/webapp/resources/upload";

	@GetMapping("/uploadForm")
	public void uploadForm() {
		log.info("upload Form........");
	}

	@PostMapping("/uploadFormAction")
	// 받아오는 이름(input태그 name)과 일치해야 함
	public void uploadFormPost(MultipartFile[] uploadFile, Model model) {
		for (MultipartFile multipartFile : uploadFile) {
			log.info("------------------------------------");
			log.info("Upload File Name : " + multipartFile.getOriginalFilename());
			log.info("Upload File Size : " + multipartFile.getSize());
			log.info("Upload File ContentType : " + multipartFile.getContentType());
		}
		log.info("upload Form Post........");
	}

	@GetMapping("/uploadAjax")
	public void uploadAjax() {
		log.info("upload ajax.......");
	}

	private String getFolder() {

		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date date = new Date();
		String str = sdf.format(date);

		return str.replace("-", File.separator);
	}

	public boolean checkImageType(File file) {
		try {
			String contentType = Files.probeContentType(file.toPath());
			return contentType.startsWith("image"); // true
		} catch (Exception e) {
			e.printStackTrace();
		}

		return false;
	}

	@PostMapping(value = "/uploadAjaxAction", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<AttachDTO>> uploadAjaxPost(MultipartFile[] uploadFile) {
		log.info("update ajax post.............");
		List<AttachDTO> attachList = new ArrayList<>();

		String uploadFolderPath = getFolder();

		// make Folder
		File uploadFolder = new File(uploadPath, getFolder());

		log.info("uploadFolder path : " + uploadFolder);

		if (uploadFolder.exists() == false) {
			uploadFolder.mkdirs();
		}

		for (MultipartFile multipartFile : uploadFile) {
			log.info("------------------------------------");
			log.info("Upload File Name : " + multipartFile.getOriginalFilename());
			log.info("Upload File Size : " + multipartFile.getSize());
			log.info("Upload File ContentType : " + multipartFile.getContentType());

			AttachDTO attachDTO = new AttachDTO();

			String uploadFileName = multipartFile.getOriginalFilename();

			uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("/") + 1);
			log.info("only file name : " + uploadFileName);

			attachDTO.setFileName(uploadFileName);

			UUID uuid = UUID.randomUUID();

			uploadFileName = uuid.toString() + "_" + uploadFileName;

			try {
				File saveFile = new File(uploadFolder, uploadFileName);
				multipartFile.transferTo(saveFile);

				attachDTO.setUuid(uuid.toString());
				attachDTO.setUploadPath(uploadFolderPath);

				if (checkImageType(saveFile)) {
					attachDTO.setImage(true);

					File thumbnail = new File(uploadFolder, "s_" + uploadFileName);

					Thumbnails.of(saveFile).size(100, 100).toFile(thumbnail);
				}

				attachList.add(attachDTO);
			} catch (Exception e) {
				log.error(e.getMessage());
			}
		}
		return new ResponseEntity<>(attachList, HttpStatus.OK);

	}

	@GetMapping("/display")
	@ResponseBody
	public ResponseEntity<byte[]> getFile(String fileName) {
		log.info("fileName : " + fileName);

		File file = new File(uploadPath + "/" + fileName);
		log.info("file : " + file);

		ResponseEntity<byte[]> result = null;

		try {
			HttpHeaders header = new HttpHeaders();
			// IO객체
			header.add("Content-Type : ", Files.probeContentType(file.toPath()));
			result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;
	}

	@GetMapping(value = "/download", produces = MediaType.APPLICATION_OCTET_STREAM_VALUE)
	public ResponseEntity<Resource> downloadFile(@RequestHeader("User-Agent") String userAgent, String fileName) {
		Resource resource = new FileSystemResource(uploadPath + "/" + fileName);

		if (resource.exists() == false) {
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}

		String resourceName = resource.getFilename();
		// UUID 제거("_" 를 기준으로)
		String resourceOriginalName = resourceName.substring(resourceName.indexOf("_") + 1);

		HttpHeaders headers = new HttpHeaders();

		try {
			boolean checkIE = (userAgent.indexOf("MSIE") > -1 || userAgent.indexOf("Trident") > -1);

			String downloadName = null;

			// Internet Explorer download
			if (checkIE) {
				downloadName = URLEncoder.encode(resourceOriginalName, "UTF-8").replaceAll("/+", " ");
			} else { // 한글 인코딩(다국어 지원) //한글 깨짐 방지
				downloadName = new String(resourceOriginalName.getBytes("UTF-8"), "ISO-8859-1");
			} // others

			headers.add("Content-Disposition", "attachment; filename=" + downloadName);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return new ResponseEntity<>(resource, headers, HttpStatus.OK);
	}

	@PostMapping("/deleteFile")
	@ResponseBody
	public ResponseEntity<String> deleteFile(String fileName, String type) {

		log.info("deleteFile : " + fileName);
		HttpHeaders headers = new HttpHeaders();
		headers.add("Content-Type", "text/html;charset=UTF-8");

		File file;

		try {
			file = new File(uploadPath + "/" + URLDecoder.decode(fileName, "UTF-8"));

			file.delete();

			// img
			if (type.equals("image")) { // 섬네일과 원본 제거
				String largeFileName = file.getAbsolutePath().replace("/s_", "/");

				log.info("largeFileName : " + largeFileName);

				file = new File(largeFileName);
				file.delete();
			}
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}

		return new ResponseEntity<>("삭제되었습니다.", headers, HttpStatus.OK);
	}
}
