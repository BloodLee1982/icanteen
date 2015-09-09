
package com.bee.ic.util;

import java.io.IOException;

import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ImageServlet extends HttpServlet {

	private static final long serialVersionUID = 2669396304810561630L;

	public void doGet(HttpServletRequest request, HttpServletResponse response)

	throws ServletException, IOException {

		this.doPost(request, response);

	}

	// 生成数字和字母的验证码

	public void doPost(HttpServletRequest request, HttpServletResponse response)

	throws ServletException, IOException {

		CheckCode checkCode = new CheckCode();   
		           
		checkCode = checkCode.createCheckCode();  

		request.getSession().setAttribute("rand", checkCode.getCheckCodeStr());

		ImageIO.write(checkCode.getBuffImg(), "JPG", response.getOutputStream());

	}
}
