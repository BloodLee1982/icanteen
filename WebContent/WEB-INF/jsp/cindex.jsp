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
	<div class="fullheight">
		<ul>
			<li style="height:33.3333333333%">
				<a href="#">
					<div class="holder">
						<h2>beexbee</h2>
						<address>
							beexbee
						</address>
					</div>
				</a>
			</li>
			<li style="height:33.3333333333%">
				<a href="#">
					<div class="holder">
						<h2>beexbee</h2>
						<address>
							beexbee
						</address>
					</div>
				</a>
			</li>
			<li style="height:33.3333333333%">
				<a href="<%=path%>/orderDishesPage.html">
					<div class="holder">
						<h2>我要预订</h2>
						<address>
							精美食品任你选
						</address>
					</div>
				</a>
			</li>
		</ul>
	</div>
</body>
</html>