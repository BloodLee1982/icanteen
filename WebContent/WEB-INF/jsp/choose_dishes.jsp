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
		$('#price').val(parseFloat($('#price').val()) + parseFloat(price));
		$('#dishes').val(JSON.stringify(order2));
		$('.badge').text(parseInt($('.badge').text()) + 1);
	});
	
	// 加套
	$('body').on('click', '#addtButt', function() {
		$this = $(this);
		var id = $this.data('id');
		var name = $this.data('name');
		var price = $this.data('price');
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
		$('#price').val(parseFloat($('#price').val()) + parseFloat(price));
		$('#packages').val(JSON.stringify(order));
		$('.badge').text(parseInt($('.badge').text()) + 1);
	});
	
	// 减套
	$('body').on('click', '#redtButt', function() {
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
				$('#price').val(parseFloat($('#price').val()) - parseFloat(price));
				$('#packages').val(JSON.stringify(order));
				if(parseInt($('.badge').text()) != 0) {
					$('.badge').text(parseInt($('.badge').text()) - 1);
				}
			}
		}
	});
	
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
				$('#price').val(parseFloat($('#price').val()) - parseFloat(price));
				$('#dishes').val(JSON.stringify(order2));
				if($('.badge').text() != '0') {
					$('.badge').text(parseInt($('.badge').text()) - 1);
				}
			}
		}
	});
	
	// 显单
	$('#showDishes').on('click', function() {
		var pack = $('#packages').val();
		var dish = $('#dishes').val();
		var packHtml = '';
		var dishHtml = '';
		if(pack != '' && pack != '{\"packages\":[]}') {
			var packObj = JSON.parse($('#packages').val());
			
			for(var i = 0; i < packObj.packages.length; i++) {
				packHtml += '<span><b>[' + packObj.packages[i].name + '<b/><b> ' + packObj.packages[i].num + '份]<b/>  <span/>';
			}
			$('#pl').html(packHtml);
		}
		if(dish != '' && dish != '{\"dishes\":[]}') {
			var dishObj = JSON.parse($('#dishes').val());
			for(var i = 0; i < dishObj.dishes.length; i++) {
				dishHtml += '<span><b>[' + dishObj.dishes[i].name + '<b/><b> ' + dishObj.dishes[i].num + '份]<b/>  <span/>';
			}
			$('#dl').html(dishHtml);
		}
		
		$('#price').val();
		$('#dishesList').show();
	});
	
	// 提单
	$('#submit').on('click', function() {
		if($('#tableNum').val() == 0) {
			alert('请选择台号！');
			return false;
		}
		$.ajax({
			type: 'get',
			url : 'checkCode.html',
			data: 'code=' + $('#wcode').val(),
			dataType : 'text',
			success : function(result) {
				if(result === 'false') {
					if($('#packages').val() == '') {
						$('#packages').val('{\"packages\":[]}');
					}
					if($('#dishes').val() == '') {
						$('#dishes').val('{\"dishes\":[]}');
					}
					$('#dishesForm').submit();
				} else {
					alert('编号错误！');
				}
			},
			error : function(msg) {
				alert(msg);
				return;
			}
		});
		
	});
	
	// 关
	$('#cloes').on('click', function() {
		$('#dishesList').hide();
	});
});

</script>
</head>
<body>
<div id="dishesList">
	<div id="pl"></div>
	<div id="dl"></div>
	<div class="oform">
		<form id="dishesForm" action="addOrder.html" method="post">
			<div class="input-group input-group-lg">
			<span class="input-group-addon" id="sizing-addon1">台号</span>
				<select id="tableNum" name="tableNum" class="form-control">
					<option value="0">--请选择台号--</option>
					<c:forEach var="tables" items="${tableList}" varStatus="stat">
						<option value="${tables.number}">${tables.number}</option>
					</c:forEach>
				</select>
			</div>
			<div class="input-group input-group-lg">
				<span class="input-group-addon" id="sizing-addon1">服务员号</span>
				<input class="form-control" id="wcode" name="wcode" type="text" >
			</div>
			<input id="packages" name="pname" type="hidden" value="">
			<input id="dishes" name="dishWords" type="hidden" value="">
			<input id="price" name="price" type="hidden" value="0">
		</form>
	</div>
	<div class="obutt">
		<button id="cloes" type="button" class="btn btn-danger btn-lg">关闭</button>
		<button id="submit" type="button" class="btn btn-success btn-lg">提交点菜</button>
	</div>
</div>
<header id="menu" class="flip" >
	<div id="menu-background2" style="top: 0px;"></div>
	<div class="nav-wrapper">
		<div class="container" role="navigation" >
			<a class="brand" alt="Placemeter Logo" href="/" >
				<span class="logo" style="color: #ffffff;">beexbee</span>
			</a>
			<nav style="position: absolute;margin-top: 15px;right: 20px;">
				<ul class="nav nav-pills" role="tablist">
			  		<li role="presentation" class="active">
				  		<a href="#" id="showDishes">查看点菜
				  			<span class="badge" style="margin-left: 5px;font-size: 20px;">0</span>
				  		</a>
			  		</li>
				</ul>
			</nav>
		</div>
	</div>
</header>
<div class="tdiv">
	<div class="tit">套餐</div>
	<section class="frameworks">
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
	</section>
	<div class="tit">单菜</div>
	<section class="frameworks">
		<div class="container-fluid wrapper wow fadeIn animated">
			<div class="row">
				<c:forEach var="dishes" items="${dishesList}" varStatus="stat">
					<article class="col-sm-4" style="border-bottom: 2px solid white;">
						<span class="number">${dishes.code}</span>
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
</body>
</html>