package com.bee.ic.domain;

import javax.persistence.Entity;
import javax.persistence.Table;

@Entity
@Table(name = "t_user")
public class User extends BaseDomain {

	private static final long serialVersionUID = -51116215795692613L;

	
	private String username;
	private String password;
	private String eMail;

	/**
	 * @return the username
	 */
	public String getUsername() {
		return username;
	}

	/**
	 * @param username
	 *            the username to set
	 */
	public void setUsername(String username) {
		this.username = username;
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

	/**
	 * @return the eMail
	 */
	public String geteMail() {
		return eMail;
	}

	/**
	 * @param eMail
	 *            the eMail to set
	 */
	public void seteMail(String eMail) {
		this.eMail = eMail;
	}
	
}
