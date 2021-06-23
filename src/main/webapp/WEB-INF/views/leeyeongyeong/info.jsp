<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="ctx" value="${pageContext.request.contextPath == '/' ? '' : pageContext.request.contextPath}" scope="application" />
<%@include file="/resources/includes/header.jsp"%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Gothic+A1:wght@100&display=swap" rel="stylesheet">
	
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
			white-space: pre; 
			font-size: 20pt; 
			color: white;
			font-family: 'Gothic A1', sans-serif;
			
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
					<a class="info__link" href="/leeyeongyeong/info">Info</a>
					<a class="info__link" href="/leeyeongyeong/work/main">Work</a> 
					<a class="info__link" href="/leeyeongyeong/contact">Contact</a>
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
					<h2><c:out value="${info.title }" /> </h2>
					<p style="white-space:  pre-wrap;"><c:out value="${info.content }"></c:out> </p>
				</div>
			</c:forEach>
				<!-- end item -->
			</section>
		</div>
		<!-- end scrollable -->
	</main>
	<div id="container" style="padding: 80px;"></div>
	
	<%@include file="/resources/includes/footer.jsp"%>
</body>

</html>