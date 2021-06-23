<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<html>
<head>
<meta charset="UTF-8">
<c:set var="ctx"
	value="${pageContext.request.contextPath == '/'?'' : pageContext.request.contextPath}"
	scope="application" />
<title>Upload with Ajax</title>
<style type="text/css">
.uploadResult {
	width: 100%;
	background-color: gray;
}

.uploadResult ul {
	display: flex;
	flex-flow: row;
	justify-content: center;
	align-items: center;
}

.uploadResult ul li {
	list-style: none;
	padding: 10px;
	align-content: center;
	text-align: center;
}

.uploadResult ul li img {
	width: 100px;
}

.bicPictureWrapper {
	position: absolute;
	display: none;
	justify-content: center;
	align-items: center;
	top: 0%;
	width: 100%;
	height: 100%;
	background-color: gray;
	z-index: 100;
	background: rgba(255, 255, 255, 0.5);
}

.bigPicture {
	position: relative;
	display: flex;
	justify-content: center;
	align-items: center;
}

.bigPicture img {
	width: 600px;
}
</style>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">
	
	$(document).ajaxSend(function(e, xhr, options) {
		xhr.setRequestHeader( "${_csrf.headerName}", "${_csrf.token}" );
		});
	
		
	function showImage(fileCallPath) {
		$(".bigPictureWrapper").css("display", "flex").show();
		
		$(".bigPicture")
		.html("<img src='${ctx}/display?fileName=" + encodeURI(fileCallPath) + "'>")
		.animate({width:'100%', height:'100%'}, 1000); //효과가 실행되는 시간
	}
	
	//j쿼리
	$(document).ready(function(){ 
		//regular 정규식			//이런 종류의 파일은 받지 않음(압축파일)
		var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
		var maxSize = 5242880; //5MB
		
		function checkExtension(fileName, fileSize){
			if(fileSize >= maxSize){
				alert("파일 사이즈 초과");
				return false;
			}
			
			if (regex.test(fileName)) {
				alert("해당 종류의 파일은 업로드 할 수 없습니다.")
				return false;
				
			}
			
			return true;
		}
		
		var cloneObj = $(".uploadDiv").clone();
		
		$("#uploadBtn").on("click", function(e){
			var formData = new FormData();
			var inputFile = $("input[name='uploadFile']");
			var files = inputFile[0].files;
			console.log(files);
			
			for (var i = 0 ; i < files.length ; i++){
				if (!checkExtension(files[i].name, files[i].size)){
					return false;
				}
				
				formData.append("uploadFile", files[i]);
			}
			
			//비동기 방식
			$.ajax({
				//폼데이터 넘길때 설정해주어야 하는 필수 세가지 요소(url, processData, contentType)
				url : "${ctx}/uploadAjaxAction",
				processData : false,
				contentType : false,
				data : formData, 
				type : "post",
				dataType : "json",
				success : function(result){
					console.log(result);
					showUploadedFile(result);
					$(".uploadDiv").html(cloneObj.html());
				}
			});
		});
		
		var uploadResult = $(".uploadResult ul");
		
		function showUploadedFile(uploadResultArr){
			var str = "";
			//.each => jQuery 반복문
			$(uploadResultArr).each(function(i, obj){
				if (!obj.image) {
					var fileCallPath = encodeURIComponent(obj.uploadPath + "/" + obj.uuid + "_" + obj.fileName);
					var fileLink = fileCallPath.replace(new RegExp(/\\/g), "/");
					
					str += "<li><div><a href='${ctx}/download?fileName=" + fileCallPath + "'>" 
						+ "<img src='${ctx}/resources/img/file.png'>" + obj.fileName + "</a>"
						+ "<span data-file=\'" + fileCallPath + "\' data-type='file'>x</span>"
						+ "</div></li>";
				} else {
					var fileCallPath = encodeURIComponent(obj.uploadPath + "/s_" + obj.uuid + "_" + obj.fileName);
					var originPath = obj.uploadPath + "\\" + obj.uuid + "_" + obj.fileName;
					originPath = originPath.replace(new RegExp(/\\/g), "/");
					
					str += "<li><a href=\"javascript:showImage(\'"+ originPath + "\')\">"
						+ "<image src ='${ctx}/display?fileName=" + fileCallPath + "'></a>"
					   	+ "<span data-file=\'" + fileCallPath + "\' data-type='image'>x</span>"
					   	+ "</li>";
					
				}
			});
			
			//동적으로 돔객체를 생성해서 추가
			uploadResult.append(str);
		}
		
		$(".bigPictureWrapper").on("click", function(e){
			$(".bigPicture").animate({width:"0%", height: "0%"}, 1000); //유효기간이 1초, 사라지는 애니메이트
			
			setTimeout(() => {
				$(this).hide();
				}, 1000);
			});
			
			$(".uploadResult").on("click", "span", function(e){
				var targetFile = $(this).data("file");
				var type = $(this).data("type");
				console.log(targetFile);
				
				$.ajax({
					url : "${ctx}/deleteFile",
					data : {fileName : targetFile, type:type},
					dataType : "text",
					type : "POST",
					success : function(result){
						alert(result);
					}
				});
			});
	});
</script>
</head>
<body>
	<h1>Upload With Ajax</h1>
	<div class="bigPictureWrapper">
		<div class="bigPicture"></div>
	</div>
	<div class="uploadDiv">
		<input type="file" name="uploadFile" multiple="multiple">		
	</div>
	<div class="uploadResult">
		<ul>

		</ul>
	</div>
	<button id="uploadBtn">Upload</button>
</body>
</html>