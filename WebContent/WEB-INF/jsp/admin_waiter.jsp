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
			<nav class="primary-nav">
				<ul class="list-unstyled clearfix">
					<li>
						<a class="title" href="<%=path%>/adTablesPage.html">台号管理</a>
						<a class="title" href="<%=path%>/adWaiterPage.html">服务员管理</a>
						<a class="title" href="<%=path%>/adDishesPage.html">菜品管理</a>
						<a class="title" href="<%=path%>/adPackagePages.html">套餐管理</a>
						<a class="title" href="<%=path%>/adminWeekDishesPage.html">周菜单管理</a>
						<a class="title" href="<%=path%>/adOrderPage.html">查看订单</a>
						<a class="title" href="<%=path%>/showUserOrderPage.html">查看预订</a>
						<a class="title" href="<%=path%>/exchangePage.html">兑换预订</a>
					</li>
				</ul>
			</nav>
			<nav class="secondary-nav">
			<a class="demo btn btn-primary" track-link-placement="Site header" track-link=""Create Account" CTA clicked" href="<%=path%>/index.html">返回首页</a>
			</nav>
		</div>
	</div>
</header>
<div style="margin-left: auto;margin-right: auto;top: 100px;width: 100%;margin-top: 100px;">
	<form id="stForm" action="addWaiter.html" method="post">
	<div style="width: 300px;float: left;margin-left: 40px;">
		<div class="ic-title">服务员管理</div>
		<P class="ic-font">姓名：</P> 
		<input placeholder="" id="name" name="name" class="form-control input-lg ic-input" type="text">
		<P class="ic-font">编号：</P> 
		<input placeholder="" id="code" name="code" class="form-control input-lg ic-input" type="text">
		<P class="ic-font">密码：</P> 
		<input placeholder="" id="password" name="password" class="form-control input-lg ic-input" type="text">
		<button type="submit" class="btn btn-success ic-button">添  加</button> 
	</div>
	</form>
	<div style="width: 1400px;float: left;margin-left: 40px;">
		<div class="table-container">
				<table class="table table-bordered">
					<thead>
						<tr>
							<th>姓名</th>
							<th>编号</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="waiter" items="${waiterList}" varStatus="stat">
							<tr>
								<td>${waiter.name}</td>
								<td>${waiter.code}</td>
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