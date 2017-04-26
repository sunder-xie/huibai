package com.app.model;

public class FloorInfoModel {
	private String FId;
	private String FNm;
	private String FType;
	private String tab1;
	private String tab2;
	private String classify;
	private String keyword;
	private Object FloorAdInfo;
	public String getFId() {
		return FId;
	}
	public void setFId(String fId) {
		FId = fId;
	}
	public String getFNm() {
		return FNm;
	}
	public void setFNm(String fNm) {
		FNm = fNm;
	}
	public String getFType() {
		return FType;
	}
	public void setFType(String fType) {
		FType = fType;
	}
	public String getTab1() {
		return tab1;
	}
	public void setTab1(String tab1) {
		this.tab1 = tab1;
	}
	public String getTab2() {
		return tab2;
	}
	public void setTab2(String tab2) {
		this.tab2 = tab2;
	}
	public String getClassify() {
		return classify;
	}
	public void setClassify(String classify) {
		this.classify = classify;
	}
	public String getKeyword() {
		return keyword;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	public Object getFloorAdInfo() {
		return FloorAdInfo;
	}
	public void setFloorAdInfo(Object floorAdInfo) {
		FloorAdInfo = floorAdInfo;
	}
	
	
}
