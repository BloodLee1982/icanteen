/**
 * 
 */
package com.bee.ic.domain;

import javax.persistence.Entity;
import javax.persistence.Table;

/**
 * 台号实体
 * 
 * @author Administrator
 *
 */
@Entity
@Table(name = "t_tables")
public class Tables extends BaseDomain {

	private static final long serialVersionUID = 3952805785379393941L;

	private String number;// 桌号
	private int flag;// 座位是否占用标志位

	/**
	 * @return the number
	 */
	public String getNumber() {
		return number;
	}

	/**
	 * @param number the number to set
	 */
	public void setNumber(String number) {
		this.number = number;
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
	
}
