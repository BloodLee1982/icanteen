package com.bee.ic.domain;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.MappedSuperclass;

import org.apache.commons.lang.builder.ToStringBuilder;

/**
 * 
 * <br>
 * <b>类描�?:</b>
 * 
 * <pre>
 * �?示PO的父�?
 * </pre>
 * 
 * @see
 * @since
 */
@MappedSuperclass
public abstract class BaseDomain implements Serializable {

	public String toString() {
		return ToStringBuilder.reflectionToString(this);
	}
	
	
	private Integer id;

	/** 创建时间 */
	//本属性只在save时有�?,update时无�?
	private Date createDate = new Date();
	
	/** 更新时间 */
	//本属性只在update时有�?,save时无�?
	private Date updateDate = new Date(); 
	
	/**
	 * @return the id
	 */
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	public Integer getId() {
		return id;
	}

	/**
	 * @param id the id to set
	 */
	public void setId(Integer id) {
		this.id = id;
	}

	/**
	 * @return the createDate
	 */
	@Column(updatable = false)
	public Date getCreateDate() {
		return createDate;
	}

	/**
	 * @param createDate the createDate to set
	 */
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	/**
	 * @return the updateDate
	 */
	@Column(insertable = false)
	public Date getUpdateDate() {
		return updateDate;
	}

	/**
	 * @param updateDate the updateDate to set
	 */
	public void setUpdateDate(Date updateDate) {
		this.updateDate = updateDate;
	}
	
}
