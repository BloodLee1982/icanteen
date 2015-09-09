/**
 * 
 */
package com.bee.ic.domain;

import javax.persistence.Entity;
import javax.persistence.Table;

/**
 * @author Administrator
 * 
 */
@Entity
@Table(name = "t_week_dishes")
public class WeekDishes extends BaseDomain {

	private static final long serialVersionUID = -225200379635090207L;

	private String name;// 菜品
	private double price;// 单价
	private Integer did;

	/**
	 * @return the name
	 */
	public String getName() {
		return name;
	}

	/**
	 * @param name
	 *            the name to set
	 */
	public void setName(String name) {
		this.name = name;
	}

	/**
	 * @return the price
	 */
	public double getPrice() {
		return price;
	}

	/**
	 * @param price
	 *            the price to set
	 */
	public void setPrice(double price) {
		this.price = price;
	}

	/**
	 * @return the did
	 */
	public Integer getDid() {
		return did;
	}

	/**
	 * @param did the did to set
	 */
	public void setDid(Integer did) {
		this.did = did;
	}

}
