package com.app.common.model;

/**
 * 映射到前台菜单的一个Bean，和后台数据库无关
 * 后台可能需要转换
 * */
public class MenuBean {
	private String _icon;
	private String _name;
	private String _id;
	private String _url;
	private String _target;
	private int _level;
	private String _parentId;
	private String _subTxn;
	
	public String get_icon() {
		return _icon;
	}
	public void set_icon(String _icon) {
		this._icon = _icon;
	}
	public String get_name() {
		return _name;
	}
	public void set_name(String _name) {
		this._name = _name;
	}
	public String get_id() {
		return _id;
	}
	public void set_id(String _id) {
		this._id = _id;
	}
	public String get_url() {
		return _url;
	}
	public void set_url(String _url) {
		this._url = _url;
	}
	public String get_target() {
		return _target;
	}
	public void set_target(String _target) {
		this._target = _target;
	}
	public int get_level() {
		return _level;
	}
	public void set_level(int _level) {
		this._level = _level;
	}
	public String get_parentId() {
		return _parentId;
	}
	public void set_parentId(String _parentId) {
		this._parentId = _parentId;
	}
	public String get_subTxn() {
		return _subTxn;
	}
	public void set_subTxn(String _subTxn) {
		this._subTxn = _subTxn;
	}
}
