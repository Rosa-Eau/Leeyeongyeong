<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="https://fonts.googleapis.com/css?family=Montserrat"
	rel="stylesheet">
<link href="/resources/css/shopping.css" rel="stylesheet">
<title>Login</title>
</head>
<body>
	<div class="login">
		<h2 id="LOGIN">LOGIN</h2>
		<h2 style="text-align: center; color: red;">
			<c:out value="${error}" />
		</h2>
		<div class="input_id_pw">
			<form action="/login" method="post">
				<input class="input" type="text" size="60" placeholder="ID" 
				onfocus="this.placeholder=''" onblur="this.placeholder='ID'" name="username"> 
				<input autocomplete="off" class="input" type="password" size="60" placeholder="PASSWORD" 
				onfocus="this.placeholder=''" onblur="this.placeholder='PASSWORD'" name="password">
				<div class="buttons">
					<input type="submit" id="Sign_up" value="Sign Up">
				</div>
				<input type="hidden" name="${_csrf.parameterName}"
					value="${_csrf.token}" />
			</form>
		</div>
		<h2>
			<c:out value="${logout}" />
		</h2>
	</div>
</body>
</html>