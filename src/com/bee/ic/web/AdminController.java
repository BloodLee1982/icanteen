/**
 * 
 */
package com.bee.ic.web;

import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.bee.ic.domain.Dishes;
import com.bee.ic.domain.Order;
import com.bee.ic.domain.PackageDishes;
import com.bee.ic.domain.Packages;
import com.bee.ic.domain.Tables;
import com.bee.ic.domain.User;
import com.bee.ic.domain.UserOrder;
import com.bee.ic.domain.Waiter;
import com.bee.ic.domain.WeekDishes;
import com.bee.ic.service.IcanteenService;
import com.bee.ic.util.DateUtil;

/**
 * @author Administrator
 *
 */
@Controller
public class AdminController {

	@Autowired
	private IcanteenService icanteenService;
	
	@RequestMapping("/cindex")
	public ModelAndView cindex() {
		ModelAndView view = new ModelAndView();
		view.setViewName("cindex");
		return view;
	}
	
	@RequestMapping("/exchangePage")
	public ModelAndView exchangePage() {
		ModelAndView view = new ModelAndView();
		view.setViewName("admin_exchange");
		return view;
	}
	
	/**
	 * 根据用户名兑换预订菜品
	 * 
	 * @param username
	 * @return
	 */
	@RequestMapping("/doExchange")
	@ResponseBody
	public UserOrder doExchange(String username) {
		List<UserOrder> uoList = icanteenService.getTodayUserOrder(username);
		if(uoList.size() == 0) {
			return null;
		} else if(uoList.size() > 1) {
			return null;
		} else {
			UserOrder uo = uoList.get(0);
			uo.setFlag(1);
			icanteenService.updateUserOrder(uo);
			return uo;
		}
	}
	
	@RequestMapping("/showUserOrderPage")
	public ModelAndView showUserOrderPage() {
		ModelAndView view = new ModelAndView();
		view.setViewName("admin_user_order");
		return view;
	}
	
	@RequestMapping("/getUserOrder")
	@ResponseBody
	public List<UserOrder> getUserOrder(String mydate, int flag) {
		
		return icanteenService.getNoExchangeOrder(mydate, flag);
	}
	
	@RequestMapping("/adminWeekDishesPage")
	public ModelAndView adminWeekDishesPage() {
		ModelAndView view = new ModelAndView();
		view.addObject("dishesList", icanteenService.getAllDishes());
		view.addObject("weekDishesList", icanteenService.getAllWeekDishes());
		view.setViewName("admin_week_dishes");
		return view;
	}
	
	@RequestMapping("/addWeekDishes")
	public ModelAndView addWeekDishes(WeekDishes wd) {
		ModelAndView view = new ModelAndView();
		icanteenService.saveWeekDishes(wd);
		view.setViewName("redirect:adminWeekDishesPage.html");
		return view;
	}
	
	
	@RequestMapping("/signInPage")
	public ModelAndView signInPage(HttpServletRequest request) {
		ModelAndView view = new ModelAndView();
		
		// 判断用户是否从session登陆
		HttpSession session = request.getSession();
		if (session.getAttribute("KEY_BEE_IC_USER") != null) {
			view.setViewName("redirect:orderDishesPage.html");
			return view;
		}
		
		// session里不存在，从cookie里取得登录信息
		Cookie[] cookies = request.getCookies();
		Cookie numberCookie = null, passwordCookie = null;
		if (cookies == null) {
			view.setViewName("user_sign_in");
			return view;
		}
		for (Cookie c : cookies) {
			if (c.getName().equals("KEY_BEE_IC_USER")) {
				numberCookie = c;
				continue;
			}
			if (c.getName().equals("KEY_BEE_IC_PASSWORD")) {
				passwordCookie = c;
				continue;
			}
		}
		
		// 如果cookie里存在信息，判断是否登陆
		if (numberCookie != null && passwordCookie != null) {
			User tu = icanteenService.getUserByUsernameAndPassNoSHA(numberCookie.getValue(),
					passwordCookie.getValue());
			// 登陆成功，直接跳转到首页
			if (tu != null) {
				session.setAttribute("KEY_BEE_IC_USER", tu);
				view.setViewName("redirect:orderDishesPage.html");
			}
		} else {
			view.setViewName("user_sign_in");
		}
		
		return view;
	}
	
	@RequestMapping("/doSignIn")
	public ModelAndView doSignIn(HttpServletRequest request, HttpServletResponse response, User user) {
		ModelAndView view = new ModelAndView();
		User tu = icanteenService.getUserByUsernameAndPass(user.getUsername(), user.getPassword());
		if (tu == null) {
			view.addObject("error", "用户名或密码有误，请重新登录！");
			view.setViewName("user_sign_in");
			return view;
		} else {
			Cookie cookie = new Cookie("KEY_BEE_IC_USER", tu.getUsername());
			Cookie cookie2 = new Cookie("KEY_BEE_IC_PASSWORD",
					tu.getPassword());
			cookie.setMaxAge(315360000);
			cookie2.setMaxAge(315360000);
			request.getSession().setAttribute("KEY_BEE_IC_USER", tu);
			response.addCookie(cookie);
			response.addCookie(cookie2);
			view.setViewName("redirect:signInPage.html");
			return view;
		}
	}
	
	@RequestMapping("/signUpPage")
	public ModelAndView signUpPage(HttpServletRequest request) {
		ModelAndView view = new ModelAndView();
		
		// 判断用户是否从session登陆
		HttpSession session = request.getSession();
		if (session.getAttribute("KEY_BEE_IC_USER") != null) {
			view.setViewName("redirect:orderDishesPage.html");
			return view;
		}
		
		// session里不存在，从cookie里取得登录信息
		Cookie[] cookies = request.getCookies();
		Cookie numberCookie = null, passwordCookie = null;
		if (cookies == null) {
			view.setViewName("user_sign_up");
			return view;
		}
		for (Cookie c : cookies) {
			if (c.getName().equals("KEY_BEE_IC_USER")) {
				numberCookie = c;
				continue;
			}
			if (c.getName().equals("KEY_BEE_IC_PASSWORD")) {
				passwordCookie = c;
				continue;
			}
		}
		
		// 如果cookie里存在信息，判断是否登陆
		if (numberCookie != null && passwordCookie != null) {
			User tu = icanteenService.getUserByUsernameAndPassNoSHA(numberCookie.getValue(),
					passwordCookie.getValue());
			// 登陆成功，直接跳转到首页
			if (tu != null) {
				session.setAttribute("KEY_BEE_IC_USER", tu);
				view.setViewName("redirect:orderDishesPage.html");
			}
		} else {
			view.setViewName("user_sign_up");
		}

		return view;
	}
	
	@RequestMapping("/doSignUp")
	public ModelAndView doSignUp(User user, HttpServletRequest request,
			HttpServletResponse response) {
		ModelAndView view = new ModelAndView();
		if (icanteenService.userRegist(user) == 1) {
			HttpSession session = request.getSession();
			session.setAttribute("KEY_BEE_IC_USER", user);
			Cookie cookie = new Cookie("KEY_BEE_IC_USER", user.getUsername());
			Cookie cookie2 = new Cookie("KEY_BEE_IC_PASSWORD",
					user.getPassword());
			cookie.setMaxAge(315360000);
			cookie2.setMaxAge(315360000);
			request.getSession().setAttribute("KEY_BEE_IC_USER", user);
			response.addCookie(cookie);
			response.addCookie(cookie2);
			view.setViewName("redirect:orderDishesPage.html");
		} else {
			view.addObject("error", "该手机号已被他人使用，请重新输入！");
			view.setViewName("user_sign_up");
			return view;
		}
		return view;
	}
	
	@RequestMapping("/orderDishesPage")
	public ModelAndView orderDishesPage() {
		ModelAndView view = new ModelAndView();
		view.addObject("dishesList", icanteenService.getAllWeekDishes());
		view.setViewName("order_dishes");
		return view;
	}
	
	@RequestMapping("/addUserOrder")
	@ResponseBody
	public int addUserOrder(HttpServletRequest request, UserOrder userOrder) {
		// session里不存在，从cookie里取得登录信息
		Cookie[] cookies = request.getCookies();
		Cookie numberCookie = null, passwordCookie = null;
		if (cookies == null) {
			return 1;
		}
		for (Cookie c : cookies) {
			if (c.getName().equals("KEY_BEE_IC_USER")) {
				numberCookie = c;
				continue;
			}
			if (c.getName().equals("KEY_BEE_IC_PASSWORD")) {
				passwordCookie = c;
				continue;
			}
		}
		// 如果cookie里存在信息，判断是否登陆
		if (numberCookie != null && passwordCookie != null) {
			User tu = icanteenService.getUserByUsernameAndPassNoSHA(numberCookie.getValue(),
					passwordCookie.getValue());
			// 登陆成功，直接跳转到首页
			if (tu != null) {
				List<UserOrder> uo = icanteenService.getTodayUserOrder(tu.getUsername());
				if(uo.size() == 0) {
					userOrder.setFlag(0);
					userOrder.setWcode(tu.getUsername());
					icanteenService.saveUserOrder(userOrder);
					return 2;// 成功预订
				} else {
					return 3;// 返回3今天已预订
				}
				
			} else {
				return 1;// 重新登录
			}
		} else {
			return 1;
		}
	}
	
	/**
	 * 首页
	 * 
	 * @return
	 */
	@RequestMapping("/index")
	public ModelAndView loginPage() {
		ModelAndView view = new ModelAndView();
		view.setViewName("index");
		return view;
	}
	
	/**
	 * 管理台号页面
	 * 
	 * @return
	 */
	@RequestMapping("/adTablesPage")
	public ModelAndView adTablesPage() {
		ModelAndView view = new ModelAndView();
		view.addObject("tablesList", icanteenService.getAllTables());
		view.setViewName("admin_tables");
		return view;
	}
	
	/**
	 * 添加台号
	 * 
	 * @return
	 */
	@RequestMapping("/addTables")
	public ModelAndView addTables(Tables tables) {
		ModelAndView view = new ModelAndView();
		icanteenService.saveTables(tables);
		view.setViewName("redirect:adTablesPage.html");
		return view;
	}
	
	/**
	 * 管理服务员页面
	 * 
	 * @return
	 */
	@RequestMapping("/adWaiterPage")
	public ModelAndView adWaiterPage() {
		ModelAndView view = new ModelAndView();
		view.addObject("waiterList", icanteenService.getAllWaiter());
		view.setViewName("admin_waiter");
		return view;
	}
	
	/**
	 * 添加服务员
	 * 
	 * @return
	 */
	@RequestMapping("/addWaiter")
	public ModelAndView addTables(Waiter waiter) {
		ModelAndView view = new ModelAndView();
		icanteenService.saveWaiter(waiter);
		view.setViewName("redirect:adWaiterPage.html");
		return view;
	}
	
	/**
	 * 管理菜品页面
	 * 
	 * @return
	 */
	@RequestMapping("/adDishesPage")
	public ModelAndView adDishesPage() {
		ModelAndView view = new ModelAndView();
		view.addObject("dishesList", icanteenService.getAllDishes());
		view.setViewName("admin_dishes");
		return view;
	}
	
	@RequestMapping("/adOrderPage")
	public ModelAndView adOrder() {
		ModelAndView view = new ModelAndView();
		view.setViewName("admin_order");
		return view;
	}
	
	@RequestMapping("/queryOrder")
	public ModelAndView queryStock(String mydate) {
		ModelAndView view = new ModelAndView();
		view.addObject("orderList", icanteenService.queryOrder(mydate));
		view.setViewName("admin_order");
		return view;
	}
	
	/**
	 * 添加菜品
	 * 
	 * @return
	 */
	@RequestMapping("/addDishes")
	public ModelAndView addDishes(Dishes dishes) {
		ModelAndView view = new ModelAndView();
		icanteenService.saveDishes(dishes);
		view.setViewName("redirect:adDishesPage.html");
		return view;
	}
	
	/**
	 * 管理套餐页面
	 * 
	 * @return
	 */
	@RequestMapping("/adPackagePages")
	public ModelAndView adPackagePages() {
		ModelAndView view = new ModelAndView();
		view.addObject("packagesList", icanteenService.getAllPackages());
		view.setViewName("admin_packages");
		return view;
	}
	
	/**
	 * 添加菜品
	 * 
	 * @return
	 */
	@RequestMapping("/addPackages")
	public ModelAndView addPackages(Packages packages) {
		ModelAndView view = new ModelAndView();
		icanteenService.savePackages(packages);
		view.setViewName("redirect:adPackagePages.html");
		return view;
	}
	
	/**
	 * 管理套餐菜品页面
	 * 
	 * @return
	 */
	@RequestMapping("/adPackageDishesPages")
	public ModelAndView adPackageDishesPages(Integer pid) {
		ModelAndView view = new ModelAndView();
		view.addObject("packages", icanteenService.getPackagesById(pid));
		view.addObject("pdList", icanteenService.getPackageDishesByPid(pid));
		view.addObject("dishesList", icanteenService.getAllDishes());
		view.setViewName("admin_packages_dishes");
		return view;
	}
	
	/**
	 * 添加套餐菜品
	 * 
	 * @param pid
	 * @param dishes
	 * @return
	 */
	@RequestMapping("/addPackageDishes")
	public ModelAndView addPackageDishes(Integer pid, Dishes dishes) {
		ModelAndView view = new ModelAndView();
		PackageDishes pd = new PackageDishes();
		pd.setPid(pid);
		pd.setCode(dishes.getCode());
		pd.setName(dishes.getName());
		pd.setCalorie(dishes.getCalorie());
		icanteenService.savePackageDishes(pd);
		view.setViewName("redirect:adPackageDishesPages.html?pid=" + pid);
		return view;
	}
	
	@RequestMapping("/deletePackageDishes")
	public ModelAndView deletePackageDishes(Integer id, Integer pid) {
		ModelAndView view = new ModelAndView();
		icanteenService.deletePdById(id);
		view.setViewName("redirect:adPackageDishesPages.html?pid=" + pid);
		return view;
	}
	
	@RequestMapping("/deleteWeekDishes")
	public ModelAndView deletePackageDishes(Integer id) {
		ModelAndView view = new ModelAndView();
		icanteenService.deletWdByid(id);
		view.setViewName("redirect:adminWeekDishesPage.html");
		return view;
	}
	
	@RequestMapping("/checkPd")
	@ResponseBody
	public boolean checkPd(Integer pid, String code) {
		List<PackageDishes> pdList = icanteenService.getPdByPidAndCode(pid, code);
		if(pdList.size() == 0) {
			return true;
		} else {
			return false;
		}
	}
	
	@RequestMapping("/checkWd")
	@ResponseBody
	public boolean checkWd(Integer did) {
		List<WeekDishes> wdList = icanteenService.getWeekDishesByDid(did);
		if(wdList.size() == 0) {
			return true;
		} else {
			return false;
		}
	}
	
	@RequestMapping("/checkCode")
	@ResponseBody
	public boolean checkCode(String code) {
		Waiter waiter = icanteenService.getWarterByCode(code);
		if(waiter == null) {
			return true;
		} else {
			return false;
		}
	}
	
	@RequestMapping("/chooseDishesPageNew")
	public ModelAndView chooseDishesPageNew() {
		ModelAndView view = new ModelAndView();
		view.addObject("packagesList", icanteenService.getAllPackages());
		view.addObject("dishesList", icanteenService.getAllDishes());
		view.setViewName("choose_dishes_new");
		return view;
	}
	
	/**
	 * 点菜页面
	 * 
	 * @return
	 */
	@RequestMapping("/chooseDishesPage")
	public ModelAndView chooseDishesPage() {
		ModelAndView view = new ModelAndView();
		view.addObject("tableList", icanteenService.getAllTables());
		view.addObject("packagesList", icanteenService.getAllPackages());
		view.addObject("dishesList", icanteenService.getAllDishes());
		view.setViewName("choose_dishes");
		return view;
	}
	
	/**
	 * 添加order
	 * 
	 * @param order
	 * @return
	 */
	@RequestMapping("/addOrder")
	public ModelAndView addOrder(Order order) {
		ModelAndView view = new ModelAndView();
		order.setFlag(2);// 临时修改
		order.setUpdateDate(DateUtil.nowDate(DateUtil.DATE_PATTERN_YYYYMMDDHHMM));
		icanteenService.saveOrder(order);
		view.setViewName("redirect:chooseDishesPageNew.html");
		return view;
	}
	
	@RequestMapping("/payOrderPage")
	public ModelAndView payOrderPage() {
		ModelAndView view = new ModelAndView();
		view.setViewName("pay_order");
		return view;
	}
	
	@RequestMapping("/payPage")
	public ModelAndView payPage(Integer id) {
		ModelAndView view = new ModelAndView();
		view.addObject("order", icanteenService.getOrderById(id));
		view.setViewName("pay");
		return view;
	}
	
	@RequestMapping("/pay")
	public ModelAndView pay(Integer id, int inv) {
		ModelAndView view = new ModelAndView();
		Order order = icanteenService.getOrderById(id);
		order.setInvoice(inv);
		order.setFlag(2);
		order.setUpdateDate(DateUtil.nowDate(DateUtil.DATE_PATTERN_YYYYMMDDHHMM));
		icanteenService.updateOrder(order);
		view.setViewName("redirect:payOrderPage.html");
		return view;
	}
	
	/**
	 * 查看订单
	 * 
	 * @return
	 */
	@RequestMapping("/showOrderPage")
	public ModelAndView showOrderPage() {
		ModelAndView view = new ModelAndView();
		/*List<Order> orderList = icanteenService.getOrderByFlag(0);
		List<Packages> packList = new ArrayList<Packages>();
		List<Dishes> dishList = new ArrayList<Dishes>();
		JSONObject jbp =  JSONObject.fromObject(orderList.get(0).getPname());
		JSONArray jap = jbp.getJSONArray("packages");
		JSONObject jbd =  JSONObject.fromObject(orderList.get(0).getDishWords());
		JSONArray jad = jbd.getJSONArray("dishes");
		 for (int i = 0; i < jap.size(); i++) {
			 Packages packages = new Packages();
			 packages.setName(jap.getJSONObject(i).getString("name"));
			 packages.setPrice(Double.valueOf(jap.getJSONObject(i).getString("price")));
			 packages.setCalorie(Integer.valueOf(jap.getJSONObject(i).getString("num")));
			 packList.add(packages);
		 }
		 for (int j = 0; j < jad.size(); j++) {
			 Dishes dishes = new Dishes();
			 dishes.setName(jad.getJSONObject(j).getString("name"));
			 dishes.setPrice(Double.valueOf(jad.getJSONObject(j).getString("price")));
			 dishes.setCalorie(Integer.valueOf(jad.getJSONObject(j).getString("num")));
			 dishList.add(dishes);
		 }*/
		
		// view.addObject("orderList", icanteenService.getOrderByFlag(0));
		view.setViewName("show_order");
		return view;
	}
	
	@RequestMapping("/showOrder")
	@ResponseBody
	public List<Order> showOrder(int flag) {
		return icanteenService.getOrderByFlag(flag);
	}
	
	@RequestMapping("/printOrder")
	@ResponseBody
	public boolean printOrder(Integer id) {
		Order or = icanteenService.getOrderById(id);
		or.setFlag(1);
		icanteenService.updateOrder(or); 
		return true;
	}
}
