<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="ctx" value="${pageContext.request.contextPath == '/' ? '' : pageContext.request.contextPath}" scope="application" />
<!DOCTYPE html>
<html class="no-js">
	<%@include file="/resources/includes/header.jsp"%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<title>Info</title>
	<style>
		.dg{display: none !important}
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
				<form id="register" action="${ctx}/admin/info/register" method="post">
					<div>
					<label>Title</label>
					<input type="text" class="form-control" name="title" id="title">					
					</div>
					<br>
					<div>					
					<label>Content</label>
					<textarea class="form-control" name="content" cols="30" rows="6" wrap="hard" id="content"></textarea>
					</div>
					<br>
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />	
					<button id="subBtn" type="submit" class="btn btn-default" style="background-color : #f7f8f9; display: block;"> Submit </button>
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
	
		$("#subBtn").click(function(){
			
			if($("#title").val() == ""){
				alert("title을 입력해주세요.");
				$("#title").focus();
				return false;
			} else if ($("#content").val() == ""){
				alert("content를 입력해주세요");
				$("#content").focus();
				return false;
			}
	
	});
		
	});
	</script>
</body>
</html>