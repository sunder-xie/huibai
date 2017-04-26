package com.app.common.exception;

/**
 * 对于数据库保存对象造成的一个异常
 * */
public class DBException extends Exception {
	private static final long serialVersionUID = 4221240389818933693L;

	public DBException(String msg) {
		super(msg);
	}

	public DBException(String msg,Throwable throwable) {
		super(msg,throwable);
	}
	
}
