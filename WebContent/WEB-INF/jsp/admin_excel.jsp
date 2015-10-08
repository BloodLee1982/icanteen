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
<script type="text/javascript" src="<%=path%>/js/jquery-ui.min.js" ></script>
<link rel="stylesheet" href="<%=path%>/css/jquery-ui.css">
<link rel="stylesheet" href="<%=path%>/css/bootstrap.min.css">
<link rel="stylesheet" href="<%=path%>/css/site.css">
<script type="text/javascript">
$(function() {
	$( "#start" ).datepicker();
	$( "#start" ).datepicker( "option", "dateFormat", "yy-mm-dd" );
	$( "#end" ).datepicker();
	$( "#end" ).datepicker( "option", "dateFormat", "yy-mm-dd" );
	
	$('#subm').on('click', function() {
		window.location.href = 'exportExcel.html';
	});
	
	$('#daysubm').on('click', function() {
		var start = $('#start').val();
		var end = $('#end').val();
		if(start == '') {
			alert('开始日期不能为空！');
			return false;
		}
		if(end == '') {
			alert('结束日期不能为空！')
			return false;
		}
		$('#dateForm').submit();
	});
});
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
			<nav class="primary-nav">
				<ul class="list-unstyled clearfix">
					<li>
						
					</li>
				</ul>
			</nav>
			<nav class="secondary-nav" style="top: -70px;">
			<a class="demo btn btn-primary" track-link-placement="Site header" track-link=""Create Account" CTA clicked" href="<%=path%>/index.html">返回首页</a>
			</nav>
		</div>
	</div>
</header>
<div style="margin-left: auto;margin-right: auto;top: 100px;width: 100%;margin-top: 100px;">
	<form id='dateForm' action="exportExcelByDay.html" method="post">
	<div style="width: 400px;float: left;margin-left: 40px;">
		<div class="ic-title">导出Excel表</div>
		<button id='subm' type="button" class="btn btn-success ic-button">导出日报表</button> 
		<P class="ic-font">日期段导出：</P> 
		<input id="start" name="startDate" placeholder="开始日期" class="form-control input-lg ic-input" type="text" readonly="readonly">
		<input id="end" name="endDate" placeholder="结束日期" class="form-control input-lg ic-input" type="text" readonly="readonly">
		<button id='daysubm' type="button" class="btn btn-success ic-button">导出</button> 
	</div>
	</form>
	
</div>

<div class="col-sm-6" style="margin-top: 20px;padding-left: 5px;">
	
</div>
</body>
</html>