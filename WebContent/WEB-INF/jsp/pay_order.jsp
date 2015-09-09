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
<script type="text/javascript" src="<%=path%>/js/json2.js" ></script>
<script type="text/javascript" src="<%=path%>/js/jquery.PrintArea.js" ></script>
<link rel="stylesheet" href="<%=path%>/css/bootstrap.min.css">
<link rel="stylesheet" href="<%=path%>/css/site.css">
<script type="text/javascript">
$(function() {
	
	loadOrder();
	
	$('body').on('click', '#print', function() {
		
		$('#' + $(this).data('id')).printArea();
		
	});
	
	$('body').on('click', '#pay', function() {
		$this = $(this);
		var id = $this.data('id');
		window.location.href = 'payPage.html?id=' + id;
		
	});
});

function loadOrder() {
	var orderHtml = '';
	$.ajax({
		type: 'get',
		data: 'flag=1',
		url : 'showOrder.html',
		dataType : 'json',
		success : function(result) {
			for(var i = 0; i < result.length; i++) {
				orderHtml += '<div style="width: 250px;float: left;margin-left: 40px;"><div class="ic-order" id="' + result[i].id + '">';
				orderHtml += '<b>台号：' + result[i].tableNum + '</b><br/>';
				orderHtml += '<b>值台人员编号：' + result[i].wcode + '</b><br/><br/><b>点菜目录：</b><table>';
				var distJson = JSON.parse(result[i].dishWords);
				var packJson = JSON.parse(result[i].pname);
				for(var k = 0; k < packJson.packages.length; k++) {
					orderHtml += '<tr><td style="width: 110px;">' + packJson.packages[k].name + '</td><td style="width: 50px;">' + packJson.packages[k].num + '</td><td>' + packJson.packages[k].price + '元</td></tr>';
				}
				for(var j = 0; j < distJson.dishes.length; j++) {
					orderHtml += '<tr><td style="width: 110px;">' + distJson.dishes[j].name + '</td><td style="width: 50px;">' + distJson.dishes[j].num + '</td><td>' + distJson.dishes[j].price + '元</td></tr>';
				}
				orderHtml += '</table><br/><table><tr><td style="width: 170px;">合计</td><td>' + result[i].price + '元</td></tr></table>';
				orderHtml += '</div><button id="print" type="button" data-id="' + result[i].id + '" class="btn btn-success btn-xs">重新打印</button>'+ 
				'<button id="pay" type="button" data-id="' + result[i].id + '" class="btn btn-danger btn-xs" style="margin-left: 10px;">结账</button>' + '</div>';
			}
			$('#order_div').html(orderHtml);
		},
		error : function(msg) {
			alert(msg);
			return;
		}
	});
}
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
			<nav class="secondary-nav" style="top: -70px">
			<a class="demo btn btn-primary" track-link-placement="Site header" track-link=""Create Account" CTA clicked" href="<%=path%>/index.html">返回首页</a>
			</nav>
		</div>
	</div>
</header>
<div id="order_div" style="margin-left: auto;margin-right: auto;top: 100px;width: 100%;margin-top: 100px;">
	
	<!-- <div class="ic-order">
		<b>台号：A004</b><br/>
		<b>值台人员编号：2556</b><br/><br/>
		<b>点菜目录：</b><br/>
		<table>
			<tr><td style="width: 180px;">A套餐</td><td>150元</td></tr>
		</table>
		<br/>
		<table>
			<tr><td style="width: 170px;">合计</td><td>1501元</td></tr>
		</table>
		
	</div> -->
	
</div>

<div class="col-sm-6" style="margin-top: 20px;padding-left: 5px;">
	
</div>
</body>
</html>