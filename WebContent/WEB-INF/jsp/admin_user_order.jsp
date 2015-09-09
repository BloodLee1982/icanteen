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

//扩展Date的format方法   
Date.prototype.format = function (format) {  
    var o = {  
        "M+": this.getMonth() + 1,  
        "d+": this.getDate(),  
        "h+": this.getHours(),  
        "m+": this.getMinutes(),  
        "s+": this.getSeconds(),  
        "q+": Math.floor((this.getMonth() + 3) / 3),  
        "S": this.getMilliseconds()  
    }  
    if (/(y+)/.test(format)) {  
        format = format.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));  
    }  
    for (var k in o) {  
        if (new RegExp("(" + k + ")").test(format)) {  
            format = format.replace(RegExp.$1, RegExp.$1.length == 1 ? o[k] : ("00" + o[k]).substr(("" + o[k]).length));  
        }  
    }  
    return format;  
}  
/**   
*转换日期对象为日期字符串   
* @param date 日期对象   
* @param isFull 是否为完整的日期数据,   
*               为true时, 格式如"2000-03-05 01:05:04"   
*               为false时, 格式如 "2000-03-05"   
* @return 符合要求的日期字符串   
*/    
function getSmpFormatDate(date, isFull) {  
    var pattern = "";  
    if (isFull == true || isFull == undefined) {  
        pattern = "yyyy-MM-dd hh:mm:ss";  
    } else {  
        pattern = "yyyy-MM-dd";  
    }  
    return getFormatDate(date, pattern);  
}  
/**   
*转换当前日期对象为日期字符串   
* @param date 日期对象   
* @param isFull 是否为完整的日期数据,   
*               为true时, 格式如"2000-03-05 01:05:04"   
*               为false时, 格式如 "2000-03-05"   
* @return 符合要求的日期字符串   
*/    
function getSmpFormatNowDate(isFull) {  
    return getSmpFormatDate(new Date(), isFull);  
}  
/**   
*转换long值为日期字符串   
* @param l long值   
* @param isFull 是否为完整的日期数据,   
*               为true时, 格式如"2000-03-05 01:05:04"   
*               为false时, 格式如 "2000-03-05"   
* @return 符合要求的日期字符串   
*/    
function getSmpFormatDateByLong(l, isFull) {  
    return getSmpFormatDate(new Date(l), isFull);  
}  
/**   
*转换long值为日期字符串   
* @param l long值   
* @param pattern 格式字符串,例如：yyyy-MM-dd hh:mm:ss   
* @return 符合要求的日期字符串   
*/    
function getFormatDateByLong(l, pattern) {  
    return getFormatDate(new Date(l), pattern);  
}  
/**   
*转换日期对象为日期字符串   
* @param l long值   
* @param pattern 格式字符串,例如：yyyy-MM-dd hh:mm:ss   
* @return 符合要求的日期字符串   
*/    
function getFormatDate(date, pattern) {  
    if (date == undefined) {  
        date = new Date();  
    }  
    if (pattern == undefined) {  
        pattern = "yyyy-MM-dd hh:mm:ss";  
    }  
    return date.format(pattern);  
}

$(function() {
	$( "#datepicker" ).datepicker();
	$( "#datepicker" ).datepicker( "option", "dateFormat", "yy-mm-dd" );
	
	$('#subm').on('click', function() {
		
		if($('#datepicker').val() == '') {
			alert('日期不能为空！');
			return false;
		}
		
		var val_flag = $('#wrap input[name="options"]:checked ').val();
		
		$.ajax({
			type: 'get',
			data: 'mydate=' + $('#datepicker').val() + '&flag=' + parseInt(val_flag),
			url : 'getUserOrder.html',
			dataType : 'json',
			success : function(result) {
				var orderHtml = '';
				for(var i = 0; i < result.length; i++) {
					orderHtml += '<tr><td>' + result[i].wcode + '</td><td>';
					var distJson = JSON.parse(result[i].dishWords);
					if(result[i].dishWords != '') {
						for(var j = 0; j < distJson.dishes.length; j++) {
							orderHtml += distJson.dishes[j].name + distJson.dishes[j].num + '';
						}
					}
					orderHtml += '</td><td>' + result[i].price + '元</td>';
					orderHtml += '<td>' + getSmpFormatDateByLong(result[i].createDate, true) + '</td></tr>';
				}
				$('#show').html(orderHtml);
			},
			error : function(msg) {
				
				return;
			}
		});
		
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
	<form>
	<div style="width: 300px;float: left;margin-left: 40px;">
		<div class="ic-title">查看订单</div>
		<P class="ic-font">日期：</P> 
		<input id="datepicker" name="mydate" class="form-control input-lg ic-input" type="text">
		<div id="wrap">
		    <input type="radio" name="options" id="option2" value="0" checked="checked"> 未兑换
		    <input type="radio" name="options" id="option3" value="1"> 已兑换
		</div>
		<button id='subm' type="button" class="btn btn-success ic-button">查  询</button> 
	</div>
	</form>
	<div style="width: 1400px;float: left;margin-left: 40px;">
		<div class="table-container">
				<table class="table table-bordered">
					<thead>
						<tr>
							<th>预订手机</th>
							<th>预订菜品</th>
							<th>总价</th>
							<th>预订时间</th>
						</tr>
					</thead>
					<tbody id="show">
						
					</tbody>
				</table>
			</div>
		</div>
</div>

<div class="col-sm-6" style="margin-top: 20px;padding-left: 5px;">
	
</div>
</body>
</html>