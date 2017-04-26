package com.app.common.model;

import java.util.List;
import java.util.Map;

/**
 * 分页的类
 * */
public class Pager {
	private int start;//开始页面
	private int offset;//页容量
	private Map<String, String> conditions;// 查询条件 key是字段名 value 条件的值
	
	private String rspCode;// 返回码
	private String rspMsg;// 返回结果
	private List<? extends Object> result;//返回查询结果
	private int pageCount; //总页数
	private int total;//数据总量
	
	public int getStart() {
		return start;
	}
	public void setStart(int start) {
		this.start = start;
	}
	public int getOffset() {
		return offset;
	}
	public void setOffset(int offset) {
		this.offset = offset;
	}
	public Map<String, String> getConditions() {
		return conditions;
	}
	public void setConditions(Map<String, String> conditions) {
		this.conditions = conditions;
	}
	public String getRspCode() {
		return rspCode;
	}
	public void setRspCode(String rspCode) {
		this.rspCode = rspCode;
	}
	public String getRspMsg() {
		return rspMsg;
	}
	public void setRspMsg(String rspMsg) {
		this.rspMsg = rspMsg;
	}
	public List<? extends Object> getResult() {
		return result;
	}
	public void setResult(List<? extends Object> result) {
		this.result = result;
	}
	public int getPageCount() {
		return pageCount;
	}
	public void setPageCount(int pageCount) {
		this.pageCount = pageCount;
	}
	public int getTotal() {
		return total;
	}
	public void setTotal(int total) {
		this.total = total;
	}
}
