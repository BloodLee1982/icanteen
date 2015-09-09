/**
 * 
 */
package com.bee.ic.util;

import javax.servlet.http.HttpServletRequest;

/**
 * 验证会话
 * 
 * @author bloodlee
 *
 */
public class CheckSession {

	public static boolean check(HttpServletRequest request, String sCode) {
		if(request.getSession().getAttribute(sCode) == null) {
			return false;
		} else {
			return true;
		}
	}
}
