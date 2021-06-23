<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<title>Leeyeongyeong</title>
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, user-scalable=no" />
<link
	href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@900&display=swap"
	rel="stylesheet">
<style type="text/css">
body {
	background-image: url("/resources/images/bg.jpeg");
}

div {
	width: 100%;
	height: 90vh;
	display: -webkit-box;
	display: -moz-box;
	display: -ms-flexbox;
	display: flex;
	-webkit-box-align: center;
	-moz-box-align: center;
	-ms-flex-align: center;
	align-items: center; /* 수직 정렬 */
	-webkit-box-pack: center;
	-moz-box-pack: center;
	-ms-flex-pack: center;
	justify-content: center; /* 수평 정렬 */
}

a {
	font-family: 'Playfair Display', serif;
	color: #f1f2f3;
	text-transform: uppercase;
	letter-spacing: -2px;
	margin: 11px 0 17px 0;
	font-size: 80px;
	line-height: 100px;
	letter-spacing: -4px;
	text-shadow: 0 -2px 1px #6bff37;
}

a ::after{
	text-decoration: none;
}
</style>
</head>
<body>

	<div>

		<h1>
			<a href="/leeyeongyeong/main">Leeyeongyeong</a>
		</h1>

	</div>


</body>
</html>