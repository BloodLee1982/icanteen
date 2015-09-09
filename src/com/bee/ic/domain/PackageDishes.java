/**
 * 
 */
package com.bee.ic.domain;

import javax.persistence.Entity;
import javax.persistence.Table;

/**
 * 套餐包含的菜品实体
 * 
 * @author BloodLee
 * 
 */
@Entity
@Table(name = "t_package_dishes")
public class PackageDishes extends BaseDomain {

	private static final long serialVersionUID = -323491773329140714L;

	private String name;// 菜名称
	private String code;// 菜品代码
	private Integer pid;// 所属套餐id
	private Integer calorie;// 卡路里

	/**
	 * @return the calorie
	 */
	public Integer getCalorie() {
		return calorie;
	}

	/**
	 * @param calorie the calorie to set
	 */
	public void setCalorie(Integer calorie) {
		this.calorie = calorie;
	}

	/**
	 * @return the pid
	 */
	public Integer getPid() {
		return pid;
	}

	/**
	 * @param pid the pid to set
	 */
	public void setPid(Integer pid) {
		this.pid = pid;
	}

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

}
