<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%String path = request.getContextPath(); %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
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