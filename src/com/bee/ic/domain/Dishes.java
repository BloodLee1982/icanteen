package com.bee.ic.domain;

import javax.persistence.Entity;
import javax.persistence.Table;

/**
 * 菜品实体
 */
@Entity
@Table(name = "t_dishes")
public class Dishes extends BaseDomain {

	private static final long serialVersionUID = -1662797207979148301L;

	private String name;// 菜品
	private double price;// 单价
	private String code;// 代码
	private Integer calorie;// 卡路里

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
	 * @return the code
	 */
	public String getCode() {
		return code;
	}

	/**
	 * @param code
	 *            the code to set
	 */
	public void setCode(String code) {
		this.code = code;
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
