package com.app.common.dao;

import java.io.Serializable;
import java.util.List;

import com.app.common.exception.DBException;

public interface BaseDao {
	
	/**
	 * save 一个对象
	 * @desc 保存失败抛出异常
	 * */
	public void save(Object domain) throws DBException;
	public void saveOrUpdate(Object domain) throws DBException;
	
	/**
	 * delete 一个对象
	 * @return 返回删除时受影响的行数，删除失败抛出异常
	 * */
	public void delete(Object domain) throws DBException;
	
	/**
	 * update 一个对象
	 * @return 返回受影响的行数，更新失败抛出异常
	 * */
	public void update(Object object) throws DBException;
	
	/**
	 * get 一个对象,根据对象的key值,如果获取不到返回 null 
	 * */
	public Object get(Class<? extends Object> className,Serializable pk) throws DBException;
	public Object load(Class<? extends Object> className,Serializable pk) throws DBException;//lazy modal
	
	
	/**
	 * 根据HQL查询数据返回结果集，如果查询不到，返回一个空的LIST
	 * */
	public List<? extends Object> queryByHQL(String hql,Object[] conditions) throws DBException;
	public List<? extends Object> queryByHQL(String hql,Object[] conditions,int start,int offset) throws DBException;
	
	
	/**
	 * 根据HQL查询数据返回结果集，如果查询不到，返回一个空的LIST
	 */
	public List<Object> queryBySQL(String sql,Object[] conditions) throws DBException;
	public List<Object> queryBySQL(String sql,Object[] conditions,int start ,int offset) throws DBException;
	
	/**
	 * 执行一个sql语句，返回影响数据
	 * */
	public int excuteSql(String sql,Object[] conditions) throws DBException;
	
	/**
	 * 执行一个hql语句，返回影响的数据
	 * */
	public int excuteHql(String hql,Object[] conditions) throws DBException;
	
}
