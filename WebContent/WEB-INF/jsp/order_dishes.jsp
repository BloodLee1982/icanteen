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
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<!-- Le styles -->
<script type="text/javascript" src="<%=path%>/js/jquery-1.10.2.min.js" ></script>
<script type="text/javascript" src="<%=path%>/js/bootstrap.min.js" ></script>
<script type="text/javascript" src="<%=path%>/js/iscroll.js" ></script>
<link rel="stylesheet" href="<%=path%>/css/bootstrap.min.css">
<link rel="stylesheet" href="<%=path%>/css/dishes.css">
<script type="text/javascript">
var myScroll;
var menuScroll;
var order = {// 单品json
		dishes: []
	};
$(function() {
	
	
	myScroll = new IScroll('#wrapper', {
		scrollbars: true,
		mouseWheel: true,
		interactiveScrollbars: true,
		shrinkScrollbars: 'scale',
		fadeScrollbars: true
	});
	
	$('#obutt').on('click', function() {

		if($('#dishes').val() == '') {
			alert('请先预定菜品再下单！');
			return false;
		}
		if($('#price').val() == '0') {
			alert('请先预定菜品再下单！');
			return false;
		}
		
		$.ajax({
			type: 'post',
			data: $('#dishesForm').serialize(),
			url : 'addUserOrder.html',
			dataType : 'json',
			success : function(result) {
				if(result == 2) {
					alert('恭喜你预订成功！');
				} else if(result == 3) {
					alert('你今天已预订过菜品了！');
				} else if(result == 1) {
					window.location.href = 'signInPage.html';
				}
			},
			error : function(msg) {
				alert(msg);
				return;
			}
		});
		
	});
	
	$('#scroller').on('click', '#addButt', function() {
		$this = $(this);
		var id = $this.data('id');
		var name = $this.data('name');
		var price = $this.data('price');
		var listOrder = order.dishes;
		var html = '';
		var flag = true;
		for(var i = 0; i < listOrder.length; i++) {
			var cur_listOrder = listOrder[i];
			if(cur_listOrder.id == id) {
				listOrder[i].num = parseInt(listOrder[i].num + 1);
				$('#' + id + 'm').children().text(listOrder[i].num);
				$('#unmber').text(parseInt($('#unmber').text()) + 1);
				//$this.prev().text(listOrder[i].num);
				flag = false;
			}
		}
		if(flag) {
			var temp = {id: id, name: name, price: price, num: 1};
			order.dishes.push(temp);
			html = '<li id="'+ id + 'm">' + name + '<span class="badge" style="float:right;margin-top:10px;background-color: #cd235c;">1</span></li>';
			$('#unmber').text(parseInt($('#unmber').text()) + 1);
			$('#menuList').append($(html));
			$this.prevAll().show();
		}
		$('#price').val(parseFloat($('#price').val()) + parseFloat(price));
		$('#totle').text($('#price').val());
		$('#dishes').val(JSON.stringify(order));
		menuScroll = new IScroll('#menu', {
			scrollbars: true,
			mouseWheel: true,
			interactiveScrollbars: true,
			shrinkScrollbars: 'scale',
			fadeScrollbars: true
		});
	});
	
	$('body').on('click', '#redButt', function() {
		$this = $(this);
		var id = $this.data('id');
		var price = $this.data('price');
		var listOrder = order.dishes;
		
		for(var i = 0; i < listOrder.length; i++) {
			var cur_listOrder = listOrder[i];
			if(cur_listOrder.id == id) {
				if(listOrder[i].num == 1) {
					order.dishes.splice(i, 1);
					$('#' + id + 'm').remove();
					$this.hide();
					//$this.next().hide();
				} else {
					listOrder[i].num = parseInt(listOrder[i].num - 1);
					$('#' + id + 'm').children().text(listOrder[i].num);
					// $this.next().text(listOrder[i].num);
				}
				$('#unmber').text(parseInt($('#unmber').text()) - 1);
				$('#price').val(parseFloat($('#price').val()) - parseFloat(price));
				$('#totle').text($('#price').val());
				$('#dishes').val(JSON.stringify(order));
			}
		}
		
	});
	
});
document.addEventListener('touchmove', function (e) { e.preventDefault(); }, false);
</script>
</head>
<body>
	<div id="header">beexbee</div>

<div id="menu">
	<div id="menu-scrooler">
		<ul id="menuList">
			<li>我点的菜</li>
		</ul>
	</div>
</div>
<div id="wrapper">
	<div id="scroller">
		<c:forEach var="dishes" items="${dishesList}" varStatus="stat">
			<div class="item">
				<p>${dishes.name}</p>
				<p>单价：<fmt:formatNumber value="${dishes.price}" pattern="#"/>元</p>
				<div style="float: right;margin-right: 120px;margin-top: -50px;">
					<button id="redButt" type="button" data-id="${dishes.id}" style="display: none;padding: 0 13px 0 13px;position: absolute;right: 180px;margin-top: 3px" data-price="${dishes.price}" class="btn btn-success btn-xs">
						-
					</button>
					<!-- <span style="display: none;font-size: 25px;font-weight: bold;margin-top: 10px;right: 170px;position: absolute;float: right;" id="spanNum">1</span> -->
					<button id="addButt" type="button" data-name="${dishes.name}" data-id="${dishes.id}" data-price="${dishes.price}" class="btn btn-success btn-xs">
						+
					</button>
				</div>
			</div>
		</c:forEach>
	</div>
</div>
<form id="dishesForm">
	<input id="dishes" name="dishWords" type="hidden" value="">
	<input id="price" name="price" type="hidden" value="0">
</form>
<div id="footer" style="color: #fff;">
	<div style="font-size: 24px;margin: 8px 0 0 10px;">
		<p>你点了<b id="unmber">0</b>个菜   共<b id="totle">0</b>元<span style="float: right;margin-top: -5px;margin-right: 5px;"><button type="button" id="obutt" class="btn btn-primary btn-lg" style="background-color: #cd235c;border-color: #cd235c;height: 42px;">下单预订</button></span></p>
	</div>
</div>
</body>
</html>