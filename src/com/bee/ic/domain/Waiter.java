/**
 * 
 */
package com.bee.ic.domain;

import javax.persistence.Entity;
import javax.persistence.Table;

/**
 * 服务员实体
 * 
 * @author
 * 
 */
@Entity
@Table(name = "t_waiter")
public class Waiter extends BaseDomain {

	private static final long serialVersionUID = -3725260129876861321L;

	private String name;
	private String code;
	private String password;

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
	 * @return the password
	 */
	public String getPassword() {
		return password;
	}

	/**
	 * @param password
	 *            the password to set
	 */
	public void setPassword(String password) {
		this.password = password;
	}

}
