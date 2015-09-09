<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%String path = request.getContextPath(); %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta http-equiv="Content-type" content="text/html; charset=UTF-8">
<title>beexbee</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<!-- Le styles -->
<script type="text/javascript" src="<%=path%>/js/jquery-1.10.2.min.js" ></script>
<script type="text/javascript" src="<%=path%>/js/bootstrap.min.js" ></script>
<link rel="stylesheet" href="<%=path%>/css/bootstrap.min.css">
<link rel="stylesheet" href="<%=path%>/css/dishes.css">
<script type="text/javascript">
$(function() {
	
	$('#sub').on('click', function() {
		var $username = $("#username");
		var $password = $("#password");
		if($username.val() == '') {
			alert("手机号码不能为空！");
			return;
		}
		if($password.val() == '') {
			alert("密码不能为空！");
			return;
		}
		$('#loginForm').submit();
	});
	
});
</script>
</head>
<body>
	<header class="background-green">
		<div class="container">
			<div id="login-cta-content">
				<div class="text-center">
					<h1>	
						beexbee 
					</h1>
				</div>
			</div>
		</div>
	</header>
	<div class="padded">
		<div class="row">
			<div class="col-lg-4 col-lg-offset-4">
				<div class="login">
					<form id="loginForm" action="doSignIn.html" method="post">
						<c:if test="${!empty error}">
							<div class="form-group" style="background-color: #cd235c;color: #fff;padding: 10px 10px;font-size: 20px;">
								${error}
							</div>
						</c:if>
						<div class="form-group">
							<input id="username" class="form-control bordered" type="text" placeholder="手机号码" value="" name="username">
						</div>
						<div class="form-group">
							<input id="password" class="form-control bordered" type="password" placeholder="登录密码" name="password">
						</div>
						<div class="form-group">
							<button id="sub" class="btn btn-success btn-large pull-right" type="button">
								<span class="glyphicon glyphicon-log-in" style="padding-right: 10px;"></span>登  录
							</button>
						</div>
						<hr>
						<div class="form-group bottom-group">
							想快捷方便的订餐吗？
							<a href="/plans">马上注册 →</a>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</body>
</html>