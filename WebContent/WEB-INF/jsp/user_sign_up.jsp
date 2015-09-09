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
		var $rpassword = $("#password2");
		var pattern12 = /^1[3|4|5|8][0-9]\d{4,8}$/;
		var pattern16 = /^[0-9A-Za-z]{8,16}$/;
		if($username.val() == '') {
			alert("手机号码不能为空！");
			return;
		}
		if(!(pattern12.test($username.val()))) {
			alert("请输入正确的手机号码！");
			return;
		}
		if($password.val() == '') {
			alert("密码不能为空！");
			return;
		}
		if(!(pattern16.test($password.val()))) {
			alert("请输入正确8到16位的密码！");
			return;
		}
		if($rpassword.val() == '') {
			alert("重复密码不能为空！");
			return;
		}
		if($rpassword.val() != $password.val()) {
			alert("两次输入的密码不一致！");
			return;
		}
		$('#signupForm').submit();
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
					<form id="signupForm" action="doSignUp.html" method="post">
						<c:if test="${!empty error}">
							<div class="form-group" style="background-color: #cd235c;color: #fff;padding: 10px 10px;font-size: 20px;">
								${error}
							</div>
						</c:if>
						<div class="form-group">
							<input id="username" class="form-control bordered" type="text" placeholder="手机号码" value="" name="username" maxlength="11">
						</div>
						<div class="form-group">
							<input id="password" class="form-control bordered" type="password" placeholder="登录密码" name="password" maxlength="12">
						</div>
						<div class="form-group">
							<input id="password2" class="form-control bordered" type="password" placeholder="重复登录密码" maxlength="12">
						</div>
						<div class="form-group">
							<button class="btn btn-success btn-large pull-right" id="sub" type="button">
								<span class="glyphicon glyphicon-user" style="padding-right: 10px;"></span>注  册
							</button>
						</div>
						<hr>
						<div class="form-group bottom-group">
							想快捷方便的订餐吗？
							<a href="/plans">登录订餐 →</a>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</body>
</html>