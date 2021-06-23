<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctx" value="${pageContext.request.contextPath == '/'?'' : pageContext.request.contextPath}" scope="application" />
	<%@include file="/resources/includes/header.jsp"%>
<title>Work</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<style>

		
		.dg{display: none !important}
		
		.spaced {
    		padding-top: 120px;
		}
		
		#regBtn {
			 background-color : #f7f8f9; 
			 font-size: 20px; 
			 border-radius: 50%; 
			 width:57px;
		}
		
		#regDiv{
			 text-align: center; 
			 padding:100px 0 100px 0;
		}
		
		.search {
			margin: 0px 0px 80px 0px;
			text-align: center;
			align-items: center;
		}
		
		.search input:hover {
			background: #ccc;
			outline: none;
		}
	
		.search input:focus {
			background: #ccc;
			outline: none;
		}
		
		.type_select{
			width: 150px;
			height: 35px;
			font-family: operetta-12, sans-serif;
			color: black;
			border-radius: 10px;	
			background: whitesmoke;
		}
		
		.type_select select:hover{
			background: #ccc;
			outline: none;
		}
		
		.type_select select:focus {
			background: #ccc;
			outline: 0;
		}
		
		.keyword {
		font-family: operetta-12, sans-serif;
		width: 250px;
		height: 30px;
		box-sizing: border-box;
		border-radius: 25px;
		border: 0;		
		background: whitesmoke;
		font-size: 17px;
		padding: 20px;
		color: black;
		transition: all 0.5s;
		margin: 10px 10px 10px 10px;
		}
		
		#Search{
			text-align: center;
			background: lawngreen;
			width: 80px;
		}
		
		.paginate_button {
			font-family: operetta-12, sans-serif;
			font-size: 10rem;
		}
		
		.paginate_button a:hover{
			color: lawngreen;
		}
		
		li.paginate_button.active a {
			color: yellow;
		}
		
		.paginate_button.previous a:hover {
			color:red;
		}
		
		.paginate_button.next a:hover {
			color:red;
		}
		
		.read:hover{
			color: blue;
		}
		
		option:focus {
			outline: none;
		}
		
		.type_select:focus-visible {
			outline:none;
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
			<div class="search">
			<form id='searchForm' action="/admin/work/main" method="get">
				<select class="type_select" name="type">
					<option value="">Select</option>
					<option value="T">Title</option>
					<option value="C">Content</option>
					<option value="TC">Title/Content</option>
				</select>
				<input class="keyword" type="text" size="60" placeholder="whatrulookin'4" 
				onfocus="this.placeholder=''" onblur="this.placeholder='whatrulookin'4'" name="keyword" /> 
				<button id="Search" class="btn btn-default">Search</button>
				<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
				<input type="hidden" name="amount" value="${pageMaker.cri.amount}">
			</form>
			</div>
				<!-- begin item -->
			<c:forEach items="${work}" var="work" begin="0" step="1">
				<div class="item">
					<input type="hidden" name="wno" value="${work.wno}"/>	
					<h2><a class="read" href="<c:out value="${work.wno}"/>"><c:out value="${work.title}" /></a></h2>
					<div style="float:right;">
				 </div>
				</div>
			</c:forEach>
				<!-- end item -->
				<div class="pagination">	
					<ul>
						<c:if test="${pageMaker.prev}">
							<li class="paginate_button previous"><a href="${pageMaker.startPage -1}">Prev</a></li>
						</c:if>
						
						<c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
							<li class="paginate_button ${pageMaker.cri.pageNum == num ? "active" : ""}"><a href="${num}">${num}</a></li>
						</c:forEach>
						
						<c:if test="${pageMaker.next}">
							<li class="paginate_button next"><a href="${pageMaker.endPage +1}">Next</a></li>
						</c:if>
					</ul>
				<form id='actionForm' action="/admin/work/main" method="get">
					<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
					<input type="hidden" name="amount" value="${pageMaker.cri.amount}">
					<input type="hidden" name="type" value='<c:out value="${pageMaker.cri.type}"/>'>
					<input type="hidden" name="keyword" value='<c:out value="${pageMaker.cri.keyword}"/>'>
				</form>
				</div>
				<div id="regDiv">
					<button id="regBtn" type="submit" data-oper="register" class="btn btn-primary"> + </button>
				</div>
			</section>
			<!-- end section -->
		</div>
		<!-- end scrollable -->
	</main>
	
	<%@include file="/resources/includes/include_admin/footer.jsp"%>
	

<script type="text/javascript">
$(document).ready(
		function() {
			
			$("#regBtn").on("click", function(){
				self.location = "/admin/work/register";
			});
			
			var str = $('p').val();

			str = str.split('<br/>').join("\r\n");

			$('#textarea').val(str);
			
			var actionForm = $("#actionForm");

				$(".read").on("click", function(e){
				
					
					e.preventDefault();
					actionForm.append("<input type='hidden' name='wno' value='"+$(this).attr("href")+"'>");
					actionForm.attr("action", "/admin/work/read");
					actionForm.submit();
				});	
			
				$(".paginate_button a").on("click", function(e){
					e.preventDefault();
					
					console.log('click');
					
					actionForm.find("input[name='pageNum']").val($(this).attr("href"));
					actionForm.submit();
				});
				
				var searchForm = $("#searchForm");
				
				$("#Search").on("click", function(e){
					
					if(!searchForm.find("option:selected").val()){
						alert("검색 종류를 선택하세요");
						return false;
					}
					
					if(!searchForm.find("input[name='keyword']").val()){
						alert("키워드를 입력하세요");
						return false;
					}
					
					searchForm.find("input[name='pageNum']").val("1");
					e.preventDefault();
					
					searchForm.submit();
				});
	
			
 });
</script>
</body>

</html>