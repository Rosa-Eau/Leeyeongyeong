<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="ctx" value="${pageContext.request.contextPath == '/' ? '' : pageContext.request.contextPath}" scope="application" />
<!DOCTYPE html>
<html class="no-js">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<head>
	<meta charset="UTF-8" />
	<title>Work</title>
	<%@include file="/resources/includes/header.jsp"%>
	<link rel="preconnect" href="https://fonts.gstatic.com">
	<link href="https://fonts.googleapis.com/css2?family=Gothic+A1:wght@100&display=swap" rel="stylesheet">
	
	<style>
		.dg{display: none !important}
		
		.item p{
			font-size: 20pt; 
			color: white;
			font-family: 'Gothic A1', sans-serif;
			white-space:  pre-wrap;
			
		}
		
		.spaced {
    		padding-top: 100px;
    		margin-bottom: 150px;
		}
		
		.btn-default {
			background: blue;
			color: white;
		}
		
		.uploadResult ul li{
			margin: 30px 0px 0px 0px;
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
				<!-- begin item -->
				<div class="item">
					<input type="hidden" name="tno" value="${work.wno}"/>	
					<h2><c:out value="${work.title }" /> </h2>
					<p><c:out value="${work.content }"></c:out></p>		
					        <div class="uploadResult"> 
					          <ul style="list-style: none;">
					          </ul>
					        </div>
					<label>Work date</label>
					<input class="form-control" name="workdate" value="<c:out value="${work.workdate }" />" readonly="readonly" style="background: black; border: none;">
					<br>
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
					<button type="submit" class="btn btn-default" data-oper="modify"> Modify </button>
					<button type="submit" class="btn btn-default" data-oper="remove"> Remove </button>
					<button type="submit" class="btn btn-default" data-oper="work"> Main </button>
				
				<form id="move" role="form" action="/admin/work/modify" method="get">
					<input type="hidden" name="wno" value='<c:out value="${work.wno}"/>'>
					<input type="hidden" name="pageNum" value="<c:out value="${cri.pageNum}"/>">
					<input type="hidden" name="amount" value="<c:out value="${cri.amount}"/>">
					<input type="hidden" name="type" value='<c:out value="${cri.type}"/>'>
					<input type="hidden" name="keyword" value='<c:out value="${cri.keyword}"/>'>
				</form>
				
				<form id="remove" role=form action="/admin/work/remove" method="post">
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
					<input type="hidden" name="wno" value='<c:out value="${work.wno}"/>'>
					<input type="hidden" name="pageNum" value="<c:out value="${cri.pageNum}"/>">
					<input type="hidden" name="amount" value="<c:out value="${cri.amount}"/>">
					<input type="hidden" name="type" value='<c:out value="${cri.type}"/>'>
					<input type="hidden" name="keyword" value='<c:out value="${cri.keyword}"/>'>
				</form>
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
		
		var formObj = $("#move");

		$('button').on("click", function(e) {
			
			e.preventDefault(); 
			 
			var operation = $(this).data("oper");
			 
			console.log(operation);
			
			if(operation === "modify"){
				formObj.attr("action", "${ctx}/admin/work/modify");
			} else if(operation === "work") {
				//move to main
				formObj.attr("action", "/admin/work/main");
				var pageNum = $("input[name='pageNum']").clone();
				var amount = $("input[name='amount']").clone();
				
				formObj.empty();
				formObj.append(pageNum);
				formObj.append(amount);
				
			}
			
			formObj.submit();

		});
		
		var rmObj = $("#remove");
		
		$("button[data-oper='remove']").on("click", function(e){
			rmObj.attr("action", "/admin/work/remove").submit();
		});
		
		$('textarea:first').click(function(){
		    $t = $(this).val().replace(/<br\s*\/?>/img,"x");
		    $(this).html($t)
		});
	});
</script>

<script type="text/javascript">
$(document).ready(function() {
	  (function() {
	  	var wno = "${work.wno}";
	    
	    $.getJSON("${ctx}/admin/work/getAttachList", {wno: wno}, function(arr) {
	        
	       console.log(arr);
	       
	       var str = "";
	       
	       $(arr).each(function(i, attach){
	       
	         if(attach.filetype){
	           var fileCallPath =  encodeURIComponent(attach.uploadPath+ "/" + attach.uuid +"_" + attach.fileName);
	           
	           str += "<li data-path='" + attach.uploadPath + "' data-uuid='" + attach.uuid + "' data-filename='" + attach.fileName + "' data-type='" + attach.filetype + "' ><div>";
	           str += "<img src='${ctx}/display?fileName=" + fileCallPath+"'>";
	           str += "</div>";
	           str +"</li>";
	         } else {
	        	 str += "<li data-path='" + attach.uploadPath + "' data-uuid='" + attach.uuid + "' data-filename='" + attach.fileName + "' data-type='" + attach.filetype+"' ><div>";
		         str += "<span> "+ attach.fileName + "</span><br/>";
		         str += "<img src='${ctx}/resources/images/file.png'></a>";
		         str += "</div>";
		         str +"</li>";
	         }
	       });
	       
	       $(".uploadResult ul").html(str);
	     });//end getjson
	  })();//end function
	  
	  $(".uploadResult").on("click","li", function(e){
	      
	    console.log("view image");
	    
	    var liObj = $(this);
	    
	    var path = encodeURIComponent(liObj.data("path")+"/" + liObj.data("uuid")+"_" + liObj.data("filename"));

	    if(liObj.data("type")){
	      showImage(path.replace(new RegExp(/\\/g),"/"));
	    } else {
	      self.location ="${ctx}/download?fileName=" + path;
	    }
	    
	    
	  });
	  
	  function showImage(fileCallPath){
	    $(".bigPictureWrapper").css("display","flex").show();
	    
	    $(".bigPicture")
	    .html("<img src='${ctx}/display?fileName="+fileCallPath+"' >")
	    .animate({width:"100%", height: "100%"}, 1000);
	    
	  }
	});


</script>
	
</body>
</html>