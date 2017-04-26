package com.app.bean;
// Generated 2016-10-30 20:05:50 by Hibernate Tools 3.5.0.Final

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * TblEnterStepInfo generated by hbm2java
 */
@Entity
@Table(name = "tbl_enter_step_info", catalog = "shopdata")
public class TblEnterStepInfo implements java.io.Serializable {

	private String enterId;
	private String regDt;
	private String userId;
	private String enterType;
	private String stepId;
	private String stepDesc;
	private String enterSta;
	private String modiDt;

	public TblEnterStepInfo() {
	}

	public TblEnterStepInfo(String enterId) {
		this.enterId = enterId;
	}

	public TblEnterStepInfo(String enterId, String regDt, String userId, String enterType, String stepId,
			String stepDesc, String enterSta, String modiDt) {
		this.enterId = enterId;
		this.regDt = regDt;
		this.userId = userId;
		this.enterType = enterType;
		this.stepId = stepId;
		this.stepDesc = stepDesc;
		this.enterSta = enterSta;
		this.modiDt = modiDt;
	}

	@Id

	@Column(name = "enter_id", unique = true, nullable = false, length = 32)
	public String getEnterId() {
		return this.enterId;
	}

	public void setEnterId(String enterId) {
		this.enterId = enterId;
	}

	@Column(name = "reg_dt", length = 14)
	public String getRegDt() {
		return this.regDt;
	}

	public void setRegDt(String regDt) {
		this.regDt = regDt;
	}

	@Column(name = "user_id", length = 32)
	public String getUserId() {
		return this.userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	@Column(name = "enter_type", length = 1)
	public String getEnterType() {
		return this.enterType;
	}

	public void setEnterType(String enterType) {
		this.enterType = enterType;
	}

	@Column(name = "step_id", length = 1)
	public String getStepId() {
		return this.stepId;
	}

	public void setStepId(String stepId) {
		this.stepId = stepId;
	}

	@Column(name = "step_desc", length = 100)
	public String getStepDesc() {
		return this.stepDesc;
	}

	public void setStepDesc(String stepDesc) {
		this.stepDesc = stepDesc;
	}

	@Column(name = "enter_sta", length = 1)
	public String getEnterSta() {
		return this.enterSta;
	}

	public void setEnterSta(String enterSta) {
		this.enterSta = enterSta;
	}

	@Column(name = "modi_dt", length = 14)
	public String getModiDt() {
		return this.modiDt;
	}

	public void setModiDt(String modiDt) {
		this.modiDt = modiDt;
	}

}