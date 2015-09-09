/***************************************************** 
 * 
 * Copyright:
 *	Copyright 2008 - 2009 © 版权所有：
 *  北京英能达科技发展有限公司
 * License:
 *
 * Created By Time:
 *       2008-4-9 下午04:53:44
 *****************************************************/
package com.bee.ic.util;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 操作Cookie的工具类
 * 
 * @author Blood Lee
 * @email : liguorui1982@163.com
 * @version 1.0
 */
public class CookieUtil {
	public static final String AUTH_CODE = "s_ac"; // 验证码
	public static final String USER_FAIL_COUNT = "u_fc"; // 用户登录失败数
	public static final String USER_ID = "u_id"; // 用户编号
	public static final String USER_ACCOUNT_ID = "u_aid"; // 用户登录帐号
	public static final String USER_EMAIL = "u_email"; // 用户邮件
	public static final String USER_GENDER = "u_gender"; // 用户性别
	public static final String USER_CHECK_ID = "u_ckid"; // 用户登录成功后检测的ID号
	public static final String USER_RANDOM_NUM = "r_num"; // 用户登录时所产生的随机数

	/**
	 * 获取Cookie
	 * 
	 * @param request
	 * @param name
	 * @return
	 */
	public static Cookie getCookie(HttpServletRequest request, String name) {
		Cookie cookies[] = request.getCookies();
		if (cookies == null || name == null || name.length() == 0)
			return null;
		Cookie cookie = null;
		for (int i = 0; i < cookies.length; i++) {
			if (!cookies[i].getName().equals(name))
				continue;
			cookie = cookies[i];
			if (request.getServerName().equals(cookie.getDomain()))
				break;
		}

		return cookie;
	}

	/**
	 * 获取Cookie的值
	 * 
	 * @param request
	 * @param name
	 * @return
	 */
	public static String getCookieValue(HttpServletRequest request, String name) {
		Cookie cookie = getCookie(request, name);
		if (cookie != null)
			return cookie.getValue();

		return null;
	}

	/**
	 * 获取Cookie的整型值
	 * 
	 * @param request
	 * @param name
	 * @return
	 */
	public static int getCookieIntegerValue(HttpServletRequest request,
			String name) {
		String value = getCookieValue(request, name);
		if (value == null || value.trim().length() == 0)
			return 0;
		else {
			try {
				return Integer.parseInt(value);
			} catch (NumberFormatException e) {
				return 0;
			}
		}
	}

	/**
	 * 获取Cookie的长整型值
	 * 
	 * @param request
	 * @param name
	 * @return
	 */
	public static long getCookieLongValue(HttpServletRequest request,
			String name) {
		String value = getCookieValue(request, name);
		if (value == null || value.trim().length() == 0)
			return 0;
		else {
			try {
				return Long.parseLong(value);
			} catch (NumberFormatException e) {
				return 0;
			}
		}
	}

	/**
	 * 获取Cookie的浮点型值
	 * 
	 * @param request
	 * @param name
	 * @return
	 */
	public static float getCookieFloatValue(HttpServletRequest request,
			String name) {
		String value = getCookieValue(request, name);
		if (value == null || value.trim().length() == 0)
			return 0;
		else {
			try {
				return Float.parseFloat(value);
			} catch (NumberFormatException e) {
				return 0;
			}
		}
	}

	/**
	 * 获取Cookie的双精度值
	 * 
	 * @param request
	 * @param name
	 * @return
	 */
	public static double getCookieDoubleValue(HttpServletRequest request,
			String name) {
		String value = getCookieValue(request, name);
		if (value == null || value.trim().length() == 0)
			return 0;
		else {
			try {
				return Double.parseDouble(value);
			} catch (NumberFormatException e) {
				return 0;
			}
		}
	}

	/**
	 * 删除指定名称的Cookie
	 * 
	 * @param response
	 * @param request
	 * @param name
	 */
	public static void deleteCookie(HttpServletResponse response,
			HttpServletRequest request, String name) {
		deleteCookie(response, getCookie(request, name));
	}

	/**
	 * 删除Cookie
	 * 
	 * @param response
	 * @param cookie
	 */
	public static void deleteCookie(HttpServletResponse response, Cookie cookie) {
		if (cookie != null) {
			cookie.setPath("/");
			cookie.setValue("");
			cookie.setMaxAge(0);
			response.addCookie(cookie);
		}
	}

	/**
	 * 设置Cookie
	 * 
	 * @param response
	 * @param name
	 * @param value
	 * @param save
	 */
	public static void setCookie(HttpServletResponse response, String name,
			String value, boolean save) {
		setCookie(response, null, name, value, save);
	}

	/**
	 * 设置Cookie
	 * 
	 * @param response
	 * @param domain
	 * @param name
	 * @param value
	 * @param save
	 */
	public static void setCookie(HttpServletResponse response, String domain,
			String name, String value, boolean save) {
		if (save)
			setCookie(response, name, value);
		else {
			if (value == null)
				value = "";
			Cookie cookie = new Cookie(name, value);
			cookie.setPath("/");
			if (domain != null && domain.trim().length() > 0)
				cookie.setDomain(domain);
			response.addCookie(cookie);
		}
	}

	/**
	 * 设置Cookie
	 * 
	 * @param response
	 * @param name
	 * @param value
	 */
	public static void setCookie(HttpServletResponse response, String name,
			String value) {
		setCookie(response, null, name, value);
	}

	/**
	 * 设置Cookie
	 * 
	 * @param response
	 * @param domain
	 * @param name
	 * @param value
	 */
	public static void setCookie(HttpServletResponse response, String domain,
			String name, String value) {
		setCookie(response, null, name, value, 0x278d00);
	}

	/**
	 * 设置Cookie
	 * 
	 * @param response
	 * @param name
	 * @param value
	 * @param maxAge
	 */
	public static void setCookie(HttpServletResponse response, String name,
			String value, int maxAge) {
		setCookie(response, null, name, value, maxAge);
	}

	/**
	 * 设置Cookie
	 * 
	 * @param response
	 * @param domain
	 * @param name
	 * @param value
	 * @param maxAge
	 */
	public static void setCookie(HttpServletResponse response, String domain,
			String name, String value, int maxAge) {
		if (value == null)
			value = "";
		Cookie cookie = new Cookie(name, value);
		cookie.setMaxAge(maxAge);
		cookie.setPath("/");
		if (domain != null && domain.trim().length() > 0)
			cookie.setDomain(domain);
		response.addCookie(cookie);
	}
}
