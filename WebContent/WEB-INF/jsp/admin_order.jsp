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
	$( "#datepicker" ).datepicker();
	$( "#datepicker" ).datepicker( "option", "dateFormat", "yy-mm-dd" );
	
	$('#subm').on('click', function() {
		if($('#datepicker').val() == '') {
			alert('日期不能为空！');
			return false;
		}
		$('#orderForm').submit();
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
	<form id='orderForm' action="queryOrder.html" method="post">
	<div style="width: 300px;float: left;margin-left: 40px;">
		<div class="ic-title">查看订单</div>
		<P class="ic-font">日期：</P> 
		<input id="datepicker" name="mydate" class="form-control input-lg ic-input" type="text">
		<button id='subm' type="button" class="btn btn-success ic-button">查  询</button> 
	</div>
	</form>
	<div style="width: 1400px;float: left;margin-left: 40px;">
		<div class="table-container">
				<table class="table table-bordered">
					<thead>
						<tr>
							<th>值台编号</th>
							<th>台号</th>
							<th>总价</th>
							<th>发票</th>
							<th>结账时间</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="order" items="${orderList}" varStatus="stat">
							<tr>
								<td>${order.wcode}</td>
								<td>${order.tableNum}</td>
								<td>${order.price}</td>
								<c:choose>
									<c:when test="${order.invoice == 1}">
										<td>是</td>
									</c:when>
									<c:otherwise>
										<td>否</td>
									</c:otherwise>
								</c:choose>
								<td>
									<fmt:formatDate value="${order.createDate}" pattern="MM月dd日  HH:mm"/>
								</td>
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