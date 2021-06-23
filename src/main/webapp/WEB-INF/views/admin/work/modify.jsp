<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="ctx" value="${pageContext.request.contextPath == '/' ? '' : pageContext.request.contextPath}" scope="application" />
<%@include file="/resources/includes/header.jsp"%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<title>Work</title>

	<style>
		.dg{display: none !important}

		
		.item h1{
			text-align: center;
			color: white;
			font-family: operetta-12, sans-serif;
		}
		
		
		.col-lg-12 {
			padding: 0 0 0 0;
		}
		
		.spaced {
    		padding-top: 150px;
    		margin-bottom: 150px;
		}
		
		
		.panel {
			background: none;
			color: white;
			margin: 40px 0px 0px 0px;
		}
		
		.btn-default {
			background: blue;
			color: white;
		}
	
		.uploadResult ul li {
			display: inline-block;
			list-style: none;
			width: 150px;			
		}
		
	</style>
</head>

<body class="loading">
	<main>
		<!-- begin scrollable -->
		<div data-scroll>
			<header class="header">
				<h1 class="header__title" style="color:white">WORK</h1>
				<div class="info">
					<a class="info__link" href="/admin/info/main">Info</a>
					<a class="info__link" href="/admin/work/main">Work</a> 
					<a class="info__link" href="/admin/contact/main">Contact</a>
			    </div>
			</header>

			<!-- begin section -->
			<section class="section spaced">
				<div class="item">
					<h1>Modify</h1>
				</div>
				<!-- begin item -->
				<div class="item">
				<form id="modForm" role="form" action="/admin/work/modify" method="post">
					<div>
					<label>Title</label>
					<input id="title" class="form-control" name="title" value="<c:out value="${work.title }" />">					
					</div>
					<br>
					<div>				
					<label>Content</label>
					<textarea id="content" class="form-control" name="content" cols="30" rows="6"  wrap="hard"><c:out value="${work.content }" /></textarea>
					</div>
					<br>
					<div>				
					<label>Work date</label>
					<input id="workdate" class="form-control" name="workdate" value="<c:out value="${work.workdate }" />">
					</div>
					<br>
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
					<input type="hidden" name="wno" value="${work.wno}" />
					<input type="hidden" name="pageNum" value="${cri.pageNum}">
					<input type="hidden" name="amount" value="${cri.amount}">
					<input type="hidden" name="type" value='<c:out value="${cri.type}"/>'>
					<input type="hidden" name="keyword" value='<c:out value="${cri.keyword}"/>'>
					<!-- end item -->
					<button id="modBtn" type="button" class="btn btn-default" data-oper="modify"> Modify </button>
					<button type="button" class="btn btn-default" data-oper="remove"> Remove </button>
					<button type="button" class="btn btn-default" data-oper="work"> Main </button>	
				</form>

				  <div class="col-lg-12">
				    <div class="panel panel-default">
				      <div class="panel-heading">Image Upload</div>
				      <!-- /.panel-heading -->
				      <div class="panel-body">
				        <div class="form-group uploadDiv">
				            <input type="file" name="uploadFile" multiple="multiple">
				        </div>
				        
				        <div class="uploadResult"> 
				          <ul>
				          
				          </ul>
				        </div>
				    </div>
				    <!--  end panel-body -->
				  </div>
				  <!-- end panel -->
				</div>
			</div>
			</section>
			<!-- end section -->
		</div>
		<!-- end scrollable -->
	</main>
	<div id="container"></div>
	
	<%@include file="/resources/includes/footer.jsp"%>
	
	<script type="text/javascript">
	$(document).ready(function() {
	
		$('textarea:first').click(function(){
		    $t = $(this).val().replace(/<br\s*\/?>/img,"x");
		    $(this).html($t)
		});
		
		var formObj = $("form");

		$('button').on("click", function(e) {
			
			e.preventDefault();
			 
			var operation = $(this).data("oper");
			 
			console.log(operation);
			 
			if(operation === "remove") {
				formObj.attr("action", "/admin/work/remove");
			} else if(operation === "work") {
				//move to main
				self.location = "${ctx}/admin/work/main";
				
				return;
				
			} else if (operation === "modify") {
		        console.log("submit clicked");
		        
		        if($("#title").val() == ""){
					alert("title을 입력해주세요");
					$("#title").focus();
					return false;
				} else if ($("#content").val() == ""){
					alert("content를 입력해주세요");
					$("#content").focus();
					return false;
				} else if($("#workdate").val() == ""){
					alert("workdate를 입력해주세요");
					$("#workdate").focus();
					return false;
				}
				
				var date_pattern = /^(19|20)\d{2}-(0[1-9]|1[012])-(0[1-9]|[12][0-9]|3[0-1])$/; 

			    if (!date_pattern.test($('#workdate').val())) {
			        alert("날짜는 yyyy-mm-dd 형식으로 입력해주세요");
			        $("#workdate").focus();
			        return false;
			    }
		        
		        var str = "";
		        
		        $(".uploadResult ul li").each(function(i, obj){
		          
		          var jobj = $(obj);
		          
		          console.dir(jobj);
		          
		          str += "<input type='hidden' name='attachList["+i+"].fileName' value='"+jobj.data("filename")+"'>";
		          str += "<input type='hidden' name='attachList["+i+"].uuid' value='"+jobj.data("uuid")+"'>";
		          str += "<input type='hidden' name='attachList["+i+"].uploadPath' value='"+jobj.data("path")+"'>";
		          str += "<input type='hidden' name='attachList["+i+"].filetype' value='"+ jobj.data("type")+"'>";
		          
		          
		        });
		        
		        formObj.append(str).submit();
		                
			}
			
			formObj.submit();

		});
		
	
	});
</script>

<script>


$(document).ajaxSend(function(e, xhr, options) {
	xhr.setRequestHeader( "${_csrf.headerName}", "${_csrf.token}" );
});


$(document).ready(function() {
  (function() {
    
    var wno = "${work.wno}";
    
    $.getJSON("/admin/work/getAttachList", {wno: wno}, function(arr) {
    
      console.log(arr);
      
      var str = "";


      $(arr).each(function(i, attach){
          
          //image type
          if(attach.filetype){
            var fileCallPath = encodeURIComponent(attach.uploadPath + "/s_" + attach.uuid + "_" + attach.fileName);
            
            str += "<li data-path='" + attach.uploadPath + "' data-uuid='" + attach.uuid + "' "
            str +=" data-filename='" + attach.fileName +"' data-type='" + attach.filetype + "' ><div>";
            str += "<span> "+ attach.fileName + "</span>";
            str += "<button type='button' data-file=\'" + fileCallPath + "\' data-type='image' "
            str += "class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
            str += "<img src='${ctx}/display?fileName=" + fileCallPath + "'>";
            str += "</div>";
            str +"</li>";
          } else {
            str += "<li data-path='" + attach.uploadPath + "' data-uuid='" + attach.uuid + "' "
            str += "data-filename='" + attach.fileName + "' data-type='" + attach.filetype + "' ><div>";
            str += "<span> "+ attach.fileName + "</span><br/>";
            str += "<button type='button' data-file=\'" + fileCallPath + "\' data-type='file' "
            str += " class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
            str += "<img src='${ctx}/resources/images/file.png'></a>";
            str += "</div>";
            str +"</li>";
          }
       });
      $(".uploadResult ul").html(str);
    });//end getjson
  })();//end function
  
  
  $(".uploadResult").on("click", "button", function(e){
	    
    console.log("delete file");
      
    if(confirm("Remove this file? ")){
    
      var targetLi = $(this).closest("li");
      targetLi.remove();
    }
  });  
  
  var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
  var maxSize = 5242880; //5MB
  
  function checkExtension(fileName, fileSize){
    
    if(fileSize >= maxSize){
      alert("파일 사이즈 초과");
      return false;
    }
    
    if(regex.test(fileName)){
      alert("해당 종류의 파일은 업로드할 수 없습니다.");
      return false;
    }
    return true;
  }
  
  $("input[type='file']").change(function(e){

    var formData = new FormData();
    
    var inputFile = $("input[name='uploadFile']");
    
    var files = inputFile[0].files;
    
    for(var i = 0; i < files.length; i++){

      if(!checkExtension(files[i].name, files[i].size) ){
        return false;
      }
      formData.append("uploadFile", files[i]);
      
    }
    
    $.ajax({
      url: "${ctx}/uploadAjaxAction",
      processData: false, 
      contentType: false,data: 
      formData,type: "POST",
      dataType:"json",
      success: function(result){
          console.log(result); 
		  showUploadResult(result); 

      }
    }); //$.ajax
    
  });    

  function showUploadResult(uploadResultArr){
	    
    if(!uploadResultArr || uploadResultArr.length == 0){ return; }
    
    var uploadUL = $(".uploadResult ul");
    
    var str ="";
    
    $(uploadResultArr).each(function(i, obj){
		
		if(obj.image){
			var fileCallPath =  encodeURIComponent(obj.uploadPath + "/s_"+obj.uuid + "_" + obj.fileName);
			str += "<li data-path='" + obj.uploadPath + "'";
			str +=" data-uuid='" + obj.uuid + "' data-filename='" + obj.fileName + "' data-type='" + obj.image + "'"
			str +" ><div>";
			str += "<span> "+ obj.fileName + "</span>";
			str += "<button type='button' data-file=\'" + fileCallPath + "\' "
			str += "data-type='image' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
			str += "<img src='${ctx}/display?fileName=" + fileCallPath + "'>";
			str += "</div>";
			str +"</li>";
		}else{
			var fileCallPath = encodeURIComponent(obj.uploadPath + "/" + obj.uuid + "_" + obj.fileName);			      
		    var fileLink = fileCallPath.replace(new RegExp(/\\/g),"/");
		      
			str += "<li "
			str += "data-path='" + obj.uploadPath + "' data-uuid='" + obj.uuid+"' data-filename='" + obj.fileName + "' data-type='" + obj.image + "' ><div>";
			str += "<span> " + obj.fileName + "</span>";
			str += "<button type='button' data-file=\'" + fileCallPath + "\' data-type='file' " 
			str += "class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
			str += "<img src='${ctx}/resources/images/file.png'></a>";
			str += "</div>";
			str +"</li>";
		}

    });
    
    uploadUL.append(str);
  }
  
});
</script>
	
</body>
</html>