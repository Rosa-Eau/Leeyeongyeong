<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="ctx" value="${pageContext.request.contextPath == '/' ? '' : pageContext.request.contextPath}" scope="application" />
<!DOCTYPE html>
<html lang="en" class="no-js">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<head>
	<meta charset="UTF-8" />
	<title>Info</title>
	<%@include file="/resources/includes/header.jsp"%>
	<link rel="preconnect" href="https://fonts.gstatic.com">
	<link href="https://fonts.googleapis.com/css2?family=Gothic+A1:wght@100&display=swap" rel="stylesheet">

	<style>
		.dg{display: none !important}
		
		.form-control{
			white-space: pre; 
			font-size: 14pt; 
			color: white;
			font-family: 'Gothic A1', sans-serif;
		}
		
		.btn-default {
			background: blue;
			color: white;
		}
	</style>
</head>

<body class="loading">
	<main>
		<!-- begin scrollable -->
		<div data-scroll>
			<header class="header">
				<h1 class="header__title" style="color:white">INFO</h1>
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
				<form id="modifyForm" role="form" action="/admin/info/modify" method="post">
					<input type="hidden" name="tno" value="${info.tno}" />
					<div>
					<label>Title</label>
					<input id="title" class="form-control" name="title" value="<c:out value="${info.title }"  style="white-space:  pre-wrap;"/>">					
					</div>
					<br>
					<div>				
					<label>Content</label>
					<textarea id="content" class="form-control" name="content" cols="30" rows="6"  wrap="hard"><c:out value="${info.content }" /></textarea>
					</div>
					<br>
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />	
					<!-- end item -->
					<button type="button" class="btn btn-default" data-oper="modify"> Modify </button>
					<button type="button" class="btn btn-default" data-oper="remove"> Remove </button>
					<button type="button" class="btn btn-default" data-oper="info">Info </button>
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
		
		var formObj = $("form");

		$('button').on("click", function(e) {
			
			e.preventDefault(); 
			 
			var operation = $(this).data("oper");
			 
			console.log(operation);
			 
			if(operation === "remove") {
				formObj.attr("action", "${ctx}/admin/info/remove");
			} else if(operation === "info") {
				//move to main
				self.location = "${ctx}/admin/info/main";
			
				return;
				
			} else if (operation === "modify") {
					
				if($("#title").val() == ""){
					alert("title을 입력해주세요.");
					$("#title").focus();
					return false;
				} else if ($("#content").val() == ""){
					alert("content를 입력해주세요");
					$("#content").focus();
					return false;
				}
			}
			
			formObj.submit();

		});
		
		$('textarea:first').click(function(){
		    $t = $(this).val().replace(/<br\s*\/?>/img,"x");
		    $(this).html($t)
		});
		
		$("#modifyForm").submit(function(){
			
			
	
		});
	});
</script>
	
</body>
</html>