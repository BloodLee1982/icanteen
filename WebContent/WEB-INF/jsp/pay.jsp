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
<script type="text/javascript" src="<%=path%>/js/buttons.js" ></script>
<script type="text/javascript" src="<%=path%>/js/bootstrap.min.js" ></script>
<script type="text/javascript" src="<%=path%>/js/json2.js" ></script>
<script type="text/javascript" src="<%=path%>/js/jquery.PrintArea.js" ></script>
<link rel="stylesheet" href="<%=path%>/css/bootstrap.min.css">
<link rel="stylesheet" href="<%=path%>/css/buttons.css">
<link rel="stylesheet" href="<%=path%>/css/site.css">
<script type="text/javascript">
$(function() {
	var flag = 1;
	$('#next').on('click', function() {
		if(flag === 1) {
			$('#no1').hide();
			$('#no2').show();
			$('#next').hide();
			flag = 2;
			return false;
		}
		if(flag === 2) {
			if($('#ss').val() == '') {
				alert('请输入实收金额！');
				return false;
			}
			var reg = new RegExp("^[0-9]*$");
			var ys = $('#ys').val();
			var ss = $('#ss').val();
			if(!reg.test(ss)) {
				$('#ss').val('');
				alert('请输入正确的实收金额！');
			}
			if(parseInt(ss) < parseInt(ys)) {
				alert('请输入正确的实收金额！');
				return false;
			}
			
			$('#no3').hide();
			$('#no4').show();
			$('#next').hide();
			return false;
		}
	});
	
	$('#card').on('click', function() {
		$('#no2').hide();
		$('#no4').show();
	});
	
	$('#cash').on('click', function() {
		$('#no2').hide();
		$('#no3').show();
		$('#next').show();
	});
	
	$('#ss').on('keyup', function() {
		var reg = new RegExp("^[0-9]*$");
		var ys = $('#ys').val();
		var ss = $('#ss').val();
		if(!reg.test(ss)) {
			$('#ss').val('');
			return false;
		}
		if($('#ss').val() == '') {
			$('#zl').text('');
			return false;
		}
		if(parseInt(ss) < parseInt(ys)) {
			return false;
		} else {
			$('#zl').text(parseInt(ss) - parseInt(ys));
		}
	});
	
	$('#kai').on('click', function() {
		alert('结账完成！');
		window.location.href = 'pay.html?id=' + $('#oid').val() + '&inv=' + 1;
	});
	
	$('#bk').on('click', function() {
		alert('结账完成！');
		window.location.href = 'pay.html?id=' + $('#oid').val() + '&inv=' + 0;
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
			<nav class="secondary-nav" style="top: -70px">
			<a class="demo btn btn-primary" track-link-placement="Site header" track-link=""Create Account" CTA clicked" href="<%=path%>/payOrderPage.html">返回结账页面</a>
			</nav>
		</div>
	</div>
</header>
<div id="order_div" style="margin-left: auto;margin-right: auto;top: 100px;width: 100%;margin-top: 100px;">
	<div id="no1" style="margin-left: auto;margin-right: auto;width: 1000px;font-size: 20px;font-weight: bold;border: 2px solid #000;padding: 20px 0px 20px 20px;">
		<p>台号：${order.tableNum}</p>
		<p>总价：${order.price}元</p>
	</div>
	<div id="no2" style="margin-left: auto;margin-right: auto;width: 1000px;font-size: 20px;font-weight: bold;border: 2px solid #000;padding: 20px 0px 20px 20px;display: none;">
		<a id="card" href="#" style="margin-left: auto;margin-right: auto;" class="button button-3d button-action button-pill">刷卡</a>
		<a id="cash" href="#" style="margin-left: auto;margin-right: auto;background-color: #ff4351;border-color: #ff4351;box-shadow: 0 7px 0 #ff1022, 0 8px 3px rgba(0, 0, 0, 0.3);" class="button button-3d button-action button-pill">现金</a>
	</div>
	<div id="no3" style="margin-left: auto;margin-right: auto;width: 1000px;font-size: 20px;font-weight: bold;border: 2px solid #000;padding: 20px 0px 20px 20px;display: none;">
		<p>应收：${order.price}元</p>
		<input type="hidden" id="ys" value="${order.price}" />
		实收：<input type="text" id="ss" value="" />
		<p style="margin-top: 10px;">找零：<b id="zl"></b></p>
	</div>
	<div id="no4" style="margin-left: auto;margin-right: auto;width: 1000px;font-size: 20px;font-weight: bold;border: 2px solid #000;padding: 20px 0px 20px 20px;display: none;">
		<input id="oid" type="hidden" value="${order.id}" />
		<a id="kai" href="#" style="margin-left: auto;margin-right: auto;" class="button button-3d button-action button-pill">开发票</a>
		<a id="bk" href="#" style="margin-left: auto;margin-right: auto;background-color: #ff4351;border-color: #ff4351;box-shadow: 0 7px 0 #ff1022, 0 8px 3px rgba(0, 0, 0, 0.3);" class="button button-3d button-action button-pill">不开发票</a>
	</div>
	<div style="margin-left: auto;margin-right: auto;width: 1000px;font-size: 20px;font-weight: bold;padding: 10px 0px 20px 1px;">
	<a id="next" href="#" style="margin-left: auto;margin-right: auto;display: ;" class="button button-3d button-action button-pill">下一步</a>
	
	</div>
	
	
</div>
<div class="col-sm-6" style="margin-top: 20px;padding-left: 5px;">
	
</div>
</body>
</html>