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
<script type="text/javascript" src="<%=path%>/js/json2.js" ></script>
<link rel="stylesheet" href="<%=path%>/css/bootstrap.min.css">
<link rel="stylesheet" href="<%=path%>/css/site.css">
<script type="text/javascript">
$(function() {
	
	$('#subm').on('click', function() {
		var orderHtml = '';
		$.ajax({
			type: 'get',
			data: 'username=' + $('#username').val(),
			url : 'doExchange.html',
			dataType : 'json',
			success : function(result) {
				orderHtml += '<b>预订人电话：' + result.wcode + '</b><br/><br/><b>预订菜品：</b><table>';
				var distJson = JSON.parse(result.dishWords);
				if(result.dishWords != '') {
					for(var j = 0; j < distJson.dishes.length; j++) {
						orderHtml += '<tr><td style="width: 110px;">' + distJson.dishes[j].name + '</td><td style="width: 50px;">' + distJson.dishes[j].num + '</td><td>' + distJson.dishes[j].price + '元</td></tr>';
					}
				}
				orderHtml += '</table><br/><table><tr><td style="width: 170px;">合计</td><td>' + result.price + '元</td></tr></table>';
				alert(orderHtml);
				$('#userorder').html(orderHtml);
			},
			error : function(msg) {
				alert(msg);
				return;
			}
		});
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
			<c:import url="nav.jsp"/>
			<nav class="secondary-nav">
				<a class="demo btn btn-primary" track-link-placement="Site header" track-link=""Create Account" CTA clicked" href="<%=path%>/index.html">返回首页</a>
			</nav>
		</div>
	</div>
</header>
<div style="margin-left: auto;margin-right: auto;top: 100px;width: 100%;margin-top: 100px;">
	<form id='orderForm' action="queryOrder.html" method="post">
	<div style="width: 300px;float: left;margin-left: 40px;">
		<div class="ic-title">订餐兑换</div>
		<P class="ic-font">手机号：</P> 
		<input id="username" name="username" class="form-control input-lg ic-input" type="text">
		<button id='subm' type="button" class="btn btn-success ic-button">兑  换</button> 
	</div>
	</form>
	<div style="width: 1400px;float: left;margin-left: 40px;">
		<div id="userorder" class="table-container">
			
		</div>
	</div>
</div>

<div class="col-sm-6" style="margin-top: 20px;padding-left: 5px;">
	
</div>
</body>
</html>