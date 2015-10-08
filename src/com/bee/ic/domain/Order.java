package com.bee.ic.domain;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

/**
 * 套餐实体
 * 
 * @author Administrator
 * 
 */
@Entity
@Table(name = "t_order")
public class Order extends BaseDomain {

	private static final long serialVersionUID = -5946261921542621923L;

	private String wcode;// 点餐人
	private String pname;// 套餐名
	private String dishWords;// 点菜
	private String tableNum;// 桌号
	private double price;// 总价
	private Integer calorie;// 总卡路里
	private int flag;// 是否买单
	private int invoice;// 是否开发票

	/**
	 * @return the invoice
	 */
	public int getInvoice() {
		return invoice;
	}

	/**
	 * @param invoice the invoice to set
	 */
	public void setInvoice(int invoice) {
		this.invoice = invoice;
	}

	/**
	 * @return the flag
	 */
	public int getFlag() {
		return flag;
	}

	/**
	 * @param flag the flag to set
	 */
	public void setFlag(int flag) {
		this.flag = flag;
	}

	/**
	 * @return the pname
	 */
	public String getPname() {
		return pname;
	}

	/**
	 * @return the wcode
	 */
	public String getWcode() {
		return wcode;
	}

	/**
	 * @param wcode the wcode to set
	 */
	public void setWcode(String wcode) {
		this.wcode = wcode;
	}

	/**
	 * @param pname
	 *            the pname to set
	 */
	public void setPname(String pname) {
		this.pname = pname;
	}

	/**
	 * @return the dishWords
	 */
	 @Column(columnDefinition="TEXT", nullable=true)
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
	 * @return the tableNum
	 */
	public String getTableNum() {
		return tableNum;
	}

	/**
	 * @param tableNum
	 *            the tableNum to set
	 */
	public void setTableNum(String tableNum) {
		this.tableNum = tableNum;
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
