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

<script type="text/javascript" src="<%=path%>/js/jquery-1.10.2.min.js" ></script>
<script type="text/javascript" src="<%=path%>/js/bootstrap.min.js" ></script>
<script type="text/javascript" src="<%=path%>/js/jquery.PrintArea.js" ></script>
<script type="text/javascript" src="<%=path%>/js/json2.js" ></script>
<link rel="stylesheet" href="<%=path%>/css/bootstrap.min.css">
<link rel="stylesheet" href="<%=path%>/css/site.css">
<script type="text/javascript">
$(function() {
	
	var order = {// 套餐json
			packages: []
	};
	
	var order2 = {// 单品json
			dishes: []
	};
	
	// 加单
	$('body').on('click', '#adddButt', function() {
		$this = $(this);
		var id = $this.data('id');
		var name = $this.data('name');
		var price = $this.data('price');
		var htm = '';
		var listOrder2 = order2.dishes;
		var flag = true;
		for(var i = 0; i < listOrder2.length; i++) {
			var cur_listOrder2 = listOrder2[i];
			if(cur_listOrder2.id == id) {
				listOrder2[i].num = parseInt(listOrder2[i].num + 1);
				flag = false;
			}
		}
		if(flag) {
			var temp = {id: id, name: name, price: price, num: 1};
			order2.dishes.push(temp);
		}
		if(!$('#' + id + 'd').html()) {
			htm = '<tr id="' + id + 'd"><td style="width: 110px;">' + name + '</td><td style="width: 50px;">1</td><td>' + price + '元</td></tr>';
			if(name.indexOf('面') >= 0) {
				$('#packages_tab').append($(htm));
			} else {
				$('#dishes_tab').append($(htm));
			}
			
		} else {
			var textd = $('#' + id + 'd').children().eq(1).text();
			$('#' + id + 'd').children().eq(1).text(parseInt(textd) + 1);
		}
		
		$('#price').val(parseFloat($('#price').val()) + parseFloat(price));
		$('#dishes').val(JSON.stringify(order2));
		$('.badge').text(parseInt($('.badge').text()) + 1);
		$('#sum').text($('#price').val() + '元');
	});
	
	// 加套
	/* $('body').on('click', '#addtButt', function() {
		$this = $(this);
		var id = $this.data('id');
		var name = $this.data('name');
		var price = $this.data('price');
		var htm = '';
		var listOrder = order.packages;
		var flag = true;
		for(var i = 0; i < listOrder.length; i++) {
			var cur_listOrder = listOrder[i];
			if(cur_listOrder.id == id) {
				listOrder[i].num = parseInt(listOrder[i].num + 1);
				flag = false;
			}
		}
		if(flag) {
			var temp = {id: id, name: name, price: price, num: 1};
			order.packages.push(temp);
		}
		if(!$('#' + id + 'p').html()) {
			htm = '<tr id="' + id + 'p"><td style="width: 110px;">' + name + '</td><td style="width: 50px;">1</td><td>' + price + '元</td></tr>';
			$('#packages_tab').append($(htm));
		} else {
			var textd = $('#' + id + 'p').children().eq(1).text();
			$('#' + id + 'p').children().eq(1).text(parseInt(textd) + 1);
		}
		$('#price').val(parseFloat($('#price').val()) + parseFloat(price));
		$('#packages').val(JSON.stringify(order));
		$('.badge').text(parseInt($('.badge').text()) + 1);
		$('#sum').text($('#price').val() + '元');
	}); */
	
	// 减套
	/* $('body').on('click', '#redtButt', function() {
		$this = $(this);
		var id = $this.data('id');
		var price = $this.data('price');
		var listOrder = order.packages;
		
		for(var i = 0; i < listOrder.length; i++) {
			var cur_listOrder = listOrder[i];
			if(cur_listOrder.id == id) {
				if(listOrder[i].num == 1) {
					order.packages.splice(i, 1);
				} else {
					listOrder[i].num = parseInt(listOrder[i].num - 1);
				}
				var textd = $('#' + id + 'p').children().eq(1).text();
				if(textd === '1') {
					$('#' + id + 'p').remove();
				} else {
					$('#' + id + 'p').children().eq(1).text(parseInt(textd) - 1);
				}
				$('#price').val(parseFloat($('#price').val()) - parseFloat(price));
				$('#packages').val(JSON.stringify(order));
				if(parseInt($('.badge').text()) != 0) {
					$('.badge').text(parseInt($('.badge').text()) - 1);
				}
			}
		}
		$('#sum').text($('#price').val() + '元');
	}); */
	
	// 减单
	$('body').on('click', '#reddButt', function() {
		$this = $(this);
		var id = $this.data('id');
		var price = $this.data('price');
		var listOrder = order2.dishes;
		
		for(var i = 0; i < listOrder.length; i++) {
			var cur_listOrder = listOrder[i];
			if(cur_listOrder.id == id) {
				if(listOrder[i].num == 1) {
					order2.dishes.splice(i, 1);
				} else {
					listOrder[i].num = parseInt(listOrder[i].num - 1);
				}
				var textd = $('#' + id + 'd').children().eq(1).text();
				if(textd === '1') {
					$('#' + id + 'd').remove();
				} else {
					$('#' + id + 'd').children().eq(1).text(parseInt(textd) - 1);
				}
				$('#price').val(parseFloat($('#price').val()) - parseFloat(price));
				$('#dishes').val(JSON.stringify(order2));
				if($('.badge').text() != '0') {
					$('.badge').text(parseInt($('.badge').text()) - 1);
				}
			}
		}
		$('#sum').text($('#price').val() + '元');
	});
	
	/* // 显单
	$('#showDishes').on('click', function() {
		var pack = $('#packages').val();
		var dish = $('#dishes').val();
		var orderHtml = '';
		orderHtml += '<b>公司名</b><br><br><b>点菜目录：</b><table>';
		if(pack != '' && pack != '{\"packages\":[]}') {
			var packObj = JSON.parse($('#packages').val());
			
			for(var i = 0; i < packObj.packages.length; i++) {
				orderHtml += '<tr><td style="width: 110px;">' + packObj.packages[i].name + '</td><td style="width: 50px;">' + packObj.packages[i].num + '</td><td>' + packObj.packages[i].price + '元</td></tr>';
			}
		}
		if(dish != '' && dish != '{\"dishes\":[]}') {
			var dishObj = JSON.parse($('#dishes').val());
			for(var i = 0; i < dishObj.dishes.length; i++) {
				orderHtml += '<tr><td style="width: 110px;">' + dishObj.dishes[i].name + '</td><td  style="width: 50px;">' + dishObj.dishes[i].num + '</td><td>' + dishObj.dishes[i].price + '元</td></tr>';
			}
		}
		orderHtml += '</table><table><tr style="font-weight: bold;"><td style="width: 170px;">合计</td><td>' + $('#price').val() + '元</td></tr></table>';
		$('#order').html(orderHtml);
		$('#dishesList').show();
	}); */
	
	// 提单
	$('#submit').on('click', function() {
		$('#time').text('');
		if($('#packages').val() == '' && $('#dishes').val() == '') {
			return false;
		}
		if($('#packages').val() == '{\"packages\":[]}' && $('#dishes').val() == '{\"dishes\":[]}') {
			return false;
		}
		if($('#packages').val() == '') {
			$('#packages').val('{\"packages\":[]}');
		}
		if($('#dishes').val() == '') {
			$('#dishes').val('{\"dishes\":[]}');
		}
		// $('#time').text(getNowFormatDate());
		// $('#order').printArea();
		$('#dishesForm').submit();
	});
	
	$('#printTable').on('click', function() {
		if($('#packages').val() == '' && $('#dishes').val() == '') {
			return false;
		}
		if($('#packages').val() == '{\"packages\":[]}' && $('#dishes').val() == '{\"dishes\":[]}') {
			return false;
		}
		$('#time').text(getNowFormatDate());
		$('#order').printArea();
	});
	
	// 关
	$('#cloes').on('click', function() {
		$('#dishesList').hide();
	});
});
function getNowFormatDate() {
    var date = new Date();
    var seperator1 = "-";
    var seperator2 = ":";
    var month = date.getMonth() + 1;
    var strDate = date.getDate();
    if (month >= 1 && month <= 9) {
        month = "0" + month;
    }
    if (strDate >= 0 && strDate <= 9) {
        strDate = "0" + strDate;
    }
    var currentdate = date.getFullYear() + seperator1 + month + seperator1 + strDate
            + " " + date.getHours() + seperator2 + date.getMinutes();
    return currentdate;
} 
</script>
</head>
<body>

<header id="menu" class="flip" >
	<div id="menu-background2" style="top: 0px;"></div>
	<div class="nav-wrapper">
		<div class="container" role="navigation" >
			<a class="brand" alt="Placemeter Logo" href="/" >
				<span class="logo" style="color: #ffffff;">beexbee</span>
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
<div class="tdiv">
<div style="width: 16%;float: left;">
	<div id="order" class="ic-order" style="margin-left: 30px;margin-top: 30px;">
		<b style="margin-left: 80px">美达快厨</b><br/>
		<table id="packages_tab" style="border-bottom: 2px solid #000;">
			
		</table>
		<table id="dishes_tab" style="border-bottom: 2px solid #000;">
			
		</table>
		<table>
			<tr><td style="width: 110px;">总价</td><td style="width: 50px;"></td><td id="sum"></td></tr>
		</table>
		<div id="time" style="font-size: 5px;"></div>
	</div>
	<div class="oform">
		<form id="dishesForm" action="addOrder.html" method="post">
			<input id="packages" name="pname" type="hidden" value="">
			<input id="dishes" name="dishWords" type="hidden" value="">
			<input id="price" name="price" type="hidden" value="0">
		</form>
	</div>
	<div class="obutt">
	<button id="printTable" type="button" class="btn btn-success btn-lg">打印订单</button>
		<button id="submit" type="button" class="btn btn-success btn-lg">保存</button>
	</div>
</div>
<div style="width: 600px;float: left;margin-left: 140px;">
	<!-- <div class="tit">套餐</div> -->
	<%-- <section class="frameworks"> 
		<div class="container-fluid wrapper wow fadeIn animated">
			<div class="row">
				<c:forEach var="packages" items="${packagesList}" varStatus="stat">
					<article class="col-sm-4" style="border-bottom: 2px solid white;">
						<span class="number">${stat.index + 1}</span>
						<div class="framework">
							<h4>${packages.name}</h4>
							<p>${packages.price}元</p>
						</div>
						<button id="redtButt" type="button" data-id="${packages.id}" data-price="${packages.price}" class="btn btn-danger btn-xs"><span class="glyphicon glyphicon-minus" aria-hidden="true"></span></button>
						<button id="addtButt" type="button" data-name="${packages.name}" data-id="${packages.id}" data-price="${packages.price}" class="btn btn-success btn-xs"><span class="glyphicon glyphicon-plus" style="" aria-hidden="true"></span></button>
					</article>
				</c:forEach>
			</div>
		</div>
	</section> --%>
	<div class="tit">单菜</div>
	<section class="frameworks">
		<div class="container-fluid wrapper wow fadeIn animated">
			<div class="row">
				<c:forEach var="dishes" items="${dishesList}" varStatus="stat">
					<article class="col-sm-6" style="border-bottom: 2px solid white;">
						<!-- <span class="number">${dishes.code}</span> -->
						<div class="framework">
							<h4>${dishes.name}</h4> 
							<p>${dishes.price}元</p>
						</div>
						<button id="reddButt" type="button" data-id="${dishes.id}" data-price="${dishes.price}" class="btn btn-danger btn-xs"><span class="glyphicon glyphicon-minus" aria-hidden="true"></span></button>
						<button id="adddButt" type="button" data-name="${dishes.name}" data-id="${dishes.id}" data-price="${dishes.price}" class="btn btn-success btn-xs"><span class="glyphicon glyphicon-plus" aria-hidden="true"></span></button>
					</article>
				</c:forEach>
			</div>
		</div>
	</section>
</div>
</div>
</body>
</html>