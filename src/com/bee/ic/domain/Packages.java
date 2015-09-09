/**
 * 
 */
package com.bee.ic.domain;

import javax.persistence.Entity;
import javax.persistence.Table;

/**
 * 套餐实体
 * 
 * @author BloodLee
 * 
 */
@Entity
@Table(name = "t_package")
public class Packages extends BaseDomain {

	private static final long serialVersionUID = -1265048672441396597L;

	private String name;// 套餐名称
	private double price;// 套餐价格
	private Integer calorie;// 套餐卡路里

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
	 * @return the calorie
	 */
	public Integer getCalorie() {
		return calorie;
	}

	/**
	 * @param calorie
	 *            the calorie to set
	 */
	public void setCalorie(Integer calorie) {
		this.calorie = calorie;
	}

}
