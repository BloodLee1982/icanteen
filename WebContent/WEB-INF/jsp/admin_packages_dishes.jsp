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
$(function() {
	$('body').on('click', '#dishesButt', function() {
		$this = $(this);
		$.ajax({
			type: 'get',
			url : 'checkPd.html',
			data: 'pid=' + $('#pid').val() + '&code=' + $this.data('code'),
			dataType : 'text',
			success : function(result) {
				if(result === 'true') {
					$('#name').val($this.data('name'));
					$('#code').val($this.data('code'));
					$('#calorie').val($this.data('calorie'));
					$('#pdForm').submit();
				} else {
					alert('该菜品已添加到套餐中了！');
				}
			},
			error : function(msg) {
				alert(msg);
				return;
			}
		});
	});
	
	$('body').on('click', '#deleteButt', function() {
		var id = $(this).data('id');
		var pid = $(this).data('pid');
		window.location.href = 'deletePackageDishes.html?id=' + id + '&pid=' + pid;
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
			<a class="demo btn btn-primary" track-link-placement="Site header" track-link=""Create Account" CTA clicked" href="<%=path%>/adPackagePages.html">返回套餐管理页面</a>
			</nav>
		</div>
	</div>
</header>
<div style="margin-left: auto;margin-right: auto;top: 100px;width: 100%;margin-top: 100px;">
	
	<div style="width: 300px;float: left;margin-left: 40px;">
		<div class="ic-title">${packages.name}</div>
		<table class="table table-bordered">
			<c:forEach var="pd" items="${pdList}" varStatus="stat">
				<tr>
					<td>${pd.name}</td>
					<td><button id="deleteButt" type="button" data-id="${pd.id}" data-pid="${pd.pid}" class="btn btn-danger btn-xs"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span></button></td>
				</tr>
			</c:forEach>
		</table>
	</div>
	<form id="pdForm" action="addPackageDishes.html" method="post">
		<input id='pid' name='pid' type="hidden" value="${packages.id}">
		<input id='name' name='name' type="hidden" value="">
		<input id='code' name='code' type="hidden" value="">
		<input id='calorie' name='calorie' type="hidden" value="">
	</form>
	<div style="width: 1400px;float: left;margin-left: 40px;">
		<div class="table-container">
				<table class="table table-bordered">
					<thead>
						<tr>
							<th>菜名</th>
							<th>编码</th>
							<th></th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="dishes" items="${dishesList}" varStatus="stat">
							<tr>
								<td>${dishes.name}</td>
								<td>${dishes.code}</td>
								<td><button id="dishesButt" type="button" data-name="${dishes.name}" data-code="${dishes.code}" data-calorie="${dishes.calorie}" class="btn btn-success btn-xs"><span class="glyphicon glyphicon-plus" aria-hidden="true"></span></button></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
	</div>
</div>

<div class="col-sm-6" style="margin-top: 20px;padding-left: 5px;">
	
</div>
</body>
</html>