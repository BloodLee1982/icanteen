/**
 * 
 */
package com.bee.ic.service;

import java.util.Date;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bee.ic.dao.DishesDao;
import com.bee.ic.dao.OrderDao;
import com.bee.ic.dao.PackageDishesDao;
import com.bee.ic.dao.PackagesDao;
import com.bee.ic.dao.TablesDao;
import com.bee.ic.dao.UserDao;
import com.bee.ic.dao.UserOrderDao;
import com.bee.ic.dao.WaiterDao;
import com.bee.ic.dao.WeekDishesDao;
import com.bee.ic.domain.Dishes;
import com.bee.ic.domain.Order;
import com.bee.ic.domain.PackageDishes;
import com.bee.ic.domain.Packages;
import com.bee.ic.domain.Tables;
import com.bee.ic.domain.User;
import com.bee.ic.domain.UserOrder;
import com.bee.ic.domain.Waiter;
import com.bee.ic.domain.WeekDishes;
import com.bee.ic.util.DateUtil;
import com.bee.ic.util.HashUtil;

/**
 * 
 * 
 * @author BloodLee
 *
 */
@Service
public class IcanteenService {

	@Autowired
	private DishesDao dishesDao;
	@Autowired
	private OrderDao orderDao;
	@Autowired
	private PackageDishesDao packageDishesDao;
	@Autowired
	private PackagesDao packagesDao;
	@Autowired
	private TablesDao tablesDao;
	@Autowired
	private WaiterDao waiterDao;
	@Autowired
	private UserDao userDao;
	@Autowired
	private UserOrderDao userOrderDao;
	@Autowired
	private WeekDishesDao weekDishesDao;
	
	public void saveWeekDishes(WeekDishes wd) {
		weekDishesDao.save(wd);
	}
	
	public List<WeekDishes> getAllWeekDishes() {
		return weekDishesDao.loadAll();
	}
	
	public void deletWdByid(Integer id) {
		weekDishesDao.remove(weekDishesDao.get(id));
	}
	
	public List<UserOrder> getTodayUserOrder(String username) {
		String hql = "from UserOrder u where u.flag = 0 and u.wcode = ? and u.createDate > ? and u.createDate < ?";
		Date startDate = DateUtil.nowDate(DateUtil.DATE_PATTERN_YYYYMMDD1);
		Date endDate = DateUtil.addDays(startDate, 1);
		return userOrderDao.find(hql, username, startDate, endDate);
	}
	
	public List<UserOrder> getNoExchangeOrder(String mydate, int flag) {
		String hql = "from UserOrder u where u.flag = ? and u.createDate > ? and u.createDate < ?";
		Date startDate = DateUtil.stringToDate(mydate , DateUtil.DATE_PATTERN_YYYYMMDD1);
		Date endDate = DateUtil.addDays(startDate, 1);
		return userOrderDao.find(hql, flag, startDate, endDate);
	}
	
	public List<WeekDishes> getWeekDishesByDid(Integer did) {
		String hql = "from WeekDishes w where w.did = ?";
		return weekDishesDao.find(hql, did);
	}
	
	public User getUserByUsername(String username) {
		Query query = userDao
				.createQuery(" from User as u where u.username=:username ");
		query.setString("username", username);
		Object o = query.uniqueResult();
		return o == null ? null : (User) o;
	}
	
	public int userRegist(User user) {
		String sql = " select count(id) from t_user where username=:username ";
		SQLQuery query = userDao.getSession().createSQLQuery(sql);
		query.setString("username", user.getUsername());
		if (Integer.parseInt(query.uniqueResult().toString()) == 0) {
			user.setPassword(HashUtil.getSHA(user.getPassword()));
			userDao.save(user);
			return 1;
		} else {
			return 0;
		}
	}
	
	public User getUserByUsernameAndPass(String username, String password) {
		Query query = userDao
				.createQuery(" from User as u where u.username=:username and u.password=:password ");
		query.setString("username", username);
		query.setString("password", HashUtil.getSHA(password));
		Object o = query.uniqueResult();
		return o == null ? null : (User) o;
	}
	
	public User getUserByUsernameAndPassNoSHA(String username, String password) {
		Query query = userDao
				.createQuery(" from User as u where u.username=:username and u.password=:password ");
		query.setString("username", username);
		query.setString("password", password);
		Object o = query.uniqueResult();
		return o == null ? null : (User) o;
	}
	
	public List<UserOrder> getUserOrderByUser(String username) {
		String hql = "from UserOrder o where o.username = ? and o.flag = ?";
		return userOrderDao.find(hql, username, 0);
	}
	
	public void saveUserOrder(UserOrder userOrder) {
		userOrderDao.save(userOrder);
	}
	
	public void updateUserOrder(UserOrder userOrder) {
		userOrderDao.update(userOrder);
	}
	
	public void saveUser(User user) {
		userDao.save(user);
	}
	
	public void saveDishes(Dishes dishes) {
		dishesDao.save(dishes);
	}
	
	public void saveOrder(Order order) {
		orderDao.save(order);
	}
	
	public void savePackageDishes(PackageDishes packageDishes) {
		packageDishesDao.save(packageDishes);
	}
	
	public void savePackages(Packages packages) {
		packagesDao.save(packages);
	}
	
	public void saveTables(Tables tables) {
		tablesDao.save(tables);
	}
	
	public void saveWaiter(Waiter waiter) {
		waiterDao.save(waiter);
	}
	
	public Waiter getWarterByCode(String code) {
		String hql = "from Waiter w where w.code = ?";
		List<Waiter> wlist = waiterDao.find(hql, code);
		if(wlist.size() == 0) {
			return null;
		} else {
			return wlist.get(0);
		}
	}
	
	public List<Waiter> getAllWaiter() {
		return waiterDao.loadAll();
	}
	
	public List<Tables> getAllTables() {
		return tablesDao.loadAll();
	}
	
	public List<Packages> getAllPackages() {
		return packagesDao.loadAll();
	}
	
	public List<PackageDishes> getPackageDishesByPid(Integer pid) {
		String hql = "from PackageDishes p where p.pid = ?";
		return packageDishesDao.find(hql, pid);
	}
	
	public List<PackageDishes> getPdByPidAndCode(Integer pid, String code) {
		String hql = "from PackageDishes p where p.pid = ? and p.code = ?";
		return packageDishesDao.find(hql, pid, code);
	}
	
	public void deletePdById(Integer id) {
		packageDishesDao.remove(packageDishesDao.get(id));
	}
	
	public List<Dishes> getAllDishes() {
		return dishesDao.loadAll();
	}
	
	public Packages getPackagesById(Integer pid) {
		return packagesDao.get(pid);
	}
	
	public List<Order> getOrderByFlag(int flag) {
		String hql = "from Order o where o.flag = ?";
		return orderDao.find(hql, flag);
	}
	
	public Order getOrderById(Integer id) {
		return orderDao.get(id);
	}
	
	public void updateOrder(Order order) {
		orderDao.update(order);
	}
	
	@SuppressWarnings("unchecked")
	public List<Order> queryOrder(String mydate) {
		String hql = "from Order o where o.flag = 2 and o.createDate > ? and o.createDate < ?";
		Date startDate = DateUtil.stringToDate(mydate , DateUtil.DATE_PATTERN_YYYYMMDD1);
		Date endDate = DateUtil.addDays(startDate, 1);
		return orderDao.find(hql, startDate, endDate);
	}
	
	@SuppressWarnings("unchecked")
	public List<Order> queryOrderByDate(String startDate, String endDate) {
		String hql = "from Order o where o.flag = 2 and o.createDate > ? and o.createDate < ?";
		Date startDateT = DateUtil.stringToDate(startDate , DateUtil.DATE_PATTERN_YYYYMMDD1);
		Date endDateT = DateUtil.addDays(DateUtil.stringToDate(endDate , DateUtil.DATE_PATTERN_YYYYMMDD1), 1);
		return orderDao.find(hql, startDateT, endDateT);
	}
	
}
