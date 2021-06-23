<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link
	href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@900&display=swap"
	rel="stylesheet">
<style type="text/css">

div {
	text-align: center;
}

.menu {
	width: 100%;
	height: 68vh;
	display: -webkit-box;
	display: -moz-box;
	display: -ms-flexbox;
	display: flex;
	-webkit-box-align: center;
	-moz-box-align: center;
	-ms-flex-align: center;
	align-items: center; /* 수직 정렬 */
	-webkit-box-pack: center; -moz-box-pack : center;
	-ms-flex-pack: center;
	justify-content: center;
	-moz-box-pack: center; /* 수평 정렬 */
}

a {
	text-decoration: none;
	color: #f1f2f3;
	font-family: 'Playfair Display', serif;
	text-transform: uppercase;
	letter-spacing: -2px;
	margin: 11px 20px 17px 20px;
	font-size: 80px;
	line-height: 100px;
/* 	text-shadow: 0px -3px 2px #fe9bd0; */
}

.btn{
	color:black;
}

</style>
<title>Leeyeongyeong</title>
</head>
<body>
	<div>
		<a href="/leeyeongyeong"> << </a>
	</div>
	<div class="menu">
		<a href="/leeyeongyeong/info" class="btn">Info</a>
		<a href="/leeyeongyeong/work/main" class="btn">Work</a> 
		<a href="/leeyeongyeong/contact" class="btn">Contact</a>
	</div>
</body>
</html>