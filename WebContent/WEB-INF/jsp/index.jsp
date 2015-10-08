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
<link rel="stylesheet" href="<%=path%>/css/site.css">
<script type="text/javascript">

</script>
</head>
<body>

<header id="menu" class="flip">
	<div id="menu-background" style="top: 0px;"></div>
	<div class="nav-wrapper">
		<div class="container" role="navigation">
			<a class="brand" alt="Placemeter Logo" href="/">
				<span class="logo">beexbee</span>
			</a>
			<nav class="secondary-nav">
			<a class="demo btn btn-primary" track-link-placement="Site header" track-link=""Create Account" CTA clicked" href="<%=path%>/index.html">返回首页</a>
			</nav>
		</div>
	</div>
</header>
<div class="col-sm-8" style="margin-left: auto;margin-right: auto;top: 100px;margin-left: 17%">
<div class="col-sm-6" style="margin-top: 20px;padding-left: 5px;">
	<div class="solution solution-1">
		<a track-link="solutions" href="<%=path%>/chooseDishesPageNew.html">
			<div class="text">
				<p class="byline">点餐查看</p>
			</div>
			<span class="glyphicon glyphicon-cutlery" style="bottom: 10px;position: absolute;right: 30px;top: 110px;font-size: 120px" aria-hidden="true"></span>
		</a>
	</div>
</div>

<%-- <div class="col-sm-6" style="margin-top: 20px;padding-left: 5px;">
	<div class="solution solution-2">
		<a track-link="solutions" href="<%=path%>/payOrderPage.html">
			<div class="text">
				<p class="byline">结账收款</p>
			</div>
			<span class="glyphicon glyphicon-yen" style="bottom: 10px;position: absolute;right: 30px;top: 110px;font-size: 120px" aria-hidden="true"></span>
		</a>
	</div>
</div> --%>
<div class="col-sm-6" style="margin-top: 20px;padding-left: 5px;">
	<div class="solution solution-3">
		<a track-link="solutions" href="<%=path%>/excelPage.html">
			<div class="text">
				<p class="byline">导出报表</p>
			</div>
			<span class="glyphicon glyphicon-open-file" style="bottom: 10px;position: absolute;right: 30px;top: 110px;font-size: 120px" aria-hidden="true"></span>
		</a>
	</div>
</div>

<div class="col-sm-6" style="margin-top: 20px;padding-left: 5px;">
	<div class="solution solution-4">
		<a track-link="solutions" href="<%=path%>/adTablesPage.html">
			<div class="text">
				<p class="byline">后台操作</p>
			</div>
			<span class="glyphicon glyphicon-list-alt" style="bottom: 10px;position: absolute;right: 30px;top: 110px;font-size: 120px" aria-hidden="true"></span>
		</a>
	</div>
</div>
</div>
</body>
</html>