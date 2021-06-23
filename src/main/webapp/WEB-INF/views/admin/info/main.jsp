<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctx" value="${pageContext.request.contextPath == '/'?'' : pageContext.request.contextPath}" scope="application" />
	<%@include file="/resources/includes/header.jsp"%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Gothic+A1:wght@100&display=swap" rel="stylesheet">
	<title>Info</title>
	<style>
		
		.dg{display: none !important}
		
		#regBtn {
			 background-color : #f7f8f9; 
			 font-size: 20px; 
			 border-radius: 50%; 
			 width:57px;
		}
		
		#regDiv{
			 text-align: center; 
			 padding:100px 0 50px 0;
		}
		
		.item p{
			font-size: 20pt; 
			color: white;
			font-family: 'Gothic A1', sans-serif;
			white-space:  pre-wrap;
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
					<h2>Name</h2>
					<p>이연경</p>
					<p>Lee yeong Gyeong</p>
				</div>
				<!-- end item -->

				<!-- begin item -->
			<c:forEach items="${info}" var="info" begin="0" step="1">
				<div class="item">
					<input type="hidden" name="tno" value="${info.tno}"/>	
					<h2><c:out value="${info.title }" /> </h2>
					<p><c:out value="${info.content }"/> </p>
					<div style="float:right;">
					<button id="modBtn" type="button" class="btn btn-primary" style="margin:10px auto;"
					onclick="location.href='/admin/info/modify?tno=<c:out value="${info.tno}"/>'">MODIFY</button>
					 </div>
				</div>
			</c:forEach>
				<!-- end item -->
				<div id="regDiv">
					<button id="regBtn" type="submit" data-oper="register" class="btn btn-primary"> + </button>
				</div>
			</section>
			<!-- end section -->
		</div>
		<!-- end scrollable -->
	</main>
	<div id="container" style="padding: 80px;"></div>
	
				
<%@include file="/resources/includes/include_admin/footer.jsp"%>
	

<script type="text/javascript">
$(document).ready(
		function() {
			
			$("#regBtn").on("click", function(){
				self.location = "/admin/info/register";
			});
			
			var str = $('p').val();

			str = str.split('<br/>').join("\r\n");

			$('#textarea').val(str);
			
 });
</script>
</body>

</html>