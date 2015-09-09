package com.bee.ic.domain;

import javax.persistence.Entity;
import javax.persistence.Table;

@Entity
@Table(name = "t_user_order")
public class UserOrder extends BaseDomain {

	private static final long serialVersionUID = -2718041368707691716L;

	private String wcode;// 点餐人
	private String dishWords;// 点菜
	private double price;// 总价
	private int flag;// 是否买单

	/**
	 * @return the wcode
	 */
	public String getWcode() {
		return wcode;
	}

	/**
	 * @param wcode
	 *            the wcode to set
	 */
	public void setWcode(String wcode) {
		this.wcode = wcode;
	}

	/**
	 * @return the dishWords
	 */
	public String getDishWords() {
		return dishWords;
	}

	/**
	 * @param dishWords
	 *            the dishWords to set
	 */
	public void setDishWords(String dishWords) {
		this.dishWords = dishWords;
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
	 * @return the flag
	 */
	public int getFlag() {
		return flag;
	}

	/**
	 * @param flag
	 *            the flag to set
	 */
	public void setFlag(int flag) {
		this.flag = flag;
	}

}
