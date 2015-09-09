package com.bee.ic.util;

/**
 * 整个应用通用的常<br>
 * <b>类描</b>
 * 
 * <pre>
 * |
 * </pre>
 * 
 * @see
 * @since
 */
public class Constant {
	
	/**
	 * 用户对象放到Session中的键名
	 */
	public static final String USER_CONTEXT = "USER_CONTEXT";
	
	/**
	 * 商家对象放到Session中的键名
	 */
	public static final String SUPPLIER_CONTEXT = "SUPPLIER_CONTEXT";
	
	/**
	 * 帝国管理者放到Session中的键名
	 */
	public static final String EMPIRE_MANAGER = "EMPIRE_MANAGER";

	/**
	 * 将登录前的URL放到Session中的键名
	 */
	public static final String LOGIN_TO_URL = "toUrl";

	/**
	 * 每页的记录数
	 */
	public static final int PAGE_SIZE = 3;
	
	/**
	 * 搜索优惠券
	 */
	public static final int TYPE_COUPON = 3;
	
	/**
	 * 首页显示优惠券
	 */
	public static final int TYPE_TOP_COUPON = 2;
	
	/**
	 * 推广优惠券
	 */
	public static final int TYPE_EXTENSION = 1;
}
