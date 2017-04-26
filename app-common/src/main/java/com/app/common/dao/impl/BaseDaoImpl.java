package com.app.common.dao.impl;

import java.io.Serializable;
import java.util.List;

import javax.annotation.Resource;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.dao.DataAccessException;
import org.springframework.orm.hibernate4.HibernateCallback;
import org.springframework.orm.hibernate4.support.HibernateDaoSupport;
import org.springframework.stereotype.Repository;

import com.app.common.exception.DBException;
import com.app.common.dao.BaseDao;

@Repository
public class BaseDaoImpl extends HibernateDaoSupport implements BaseDao{
	private Logger log= LoggerFactory.getLogger(getClass());

	//@Transactional
	public void save(Object domain) throws DBException {
		log.debug("开始进行数据的保存");
		try{
			super.getHibernateTemplate().save(domain);
		}catch(DataAccessException ex){
			log.error("["+domain+"]数据保存到数据库中报错",ex);
			throw new DBException("保存数据失败",ex);
		}
		log.debug("数据保存完毕");
	}

	public void saveOrUpdate(Object domain) throws DBException {
		log.debug("开始进行数据的保存或更新");
		try{
			super.getHibernateTemplate().saveOrUpdate(domain);
		}catch(DataAccessException ex){
			log.error("数据保存或者更新失败",ex);
			throw new DBException("["+domain+"]数据保存或者更新失败",ex);
		}
	}

	public void delete(Object domain) throws DBException {
		log.debug("开始进行数据的删除");
		try{
			super.getHibernateTemplate().delete(domain);
		}catch(DataAccessException ex){
			log.error("删除数据失败",ex);
			throw new DBException("["+domain+"]删除数据失败",ex);
		}
	}

	public void update(Object domain) throws DBException {
		log.info("开始进行数据的更新");
		try{
			super.getHibernateTemplate().update(domain);
		}catch(DataAccessException ex){
			log.error("更新数据失败");
			throw new DBException("["+domain+"]更新数据失败", ex);
		}
	}

	public Object get(Class<? extends Object> className, Serializable pk)
			throws DBException {
		log.debug("开始获取数据");
		try{
			return super.getHibernateTemplate().get(className, pk);
		}catch(DataAccessException ex){
			log.error("获取数据失败",ex);
			throw new DBException("获取数据失败", ex);
		}
	}

	public Object load(Class<? extends Object> className, Serializable pk)
			throws DBException {
		log.debug("开始获取数据");
		try{
			return super.getHibernateTemplate().load(className, pk);
		}catch(DataAccessException ex){
			log.error("获取数据失败");
			throw new DBException("获取数据失败", ex);
		}
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	public List<? extends Object> queryByHQL(final String hql,final Object[] conditions)
			throws DBException {
		//log.debug("执行的hql语句为[{}]",hql);
		try{
			return super.getHibernateTemplate().execute(new HibernateCallback<List>() {
				public List doInHibernate(Session session) throws HibernateException {
					Query query = session.createQuery(hql);
					int num=0;
					if(conditions!=null){
						for(Object param:conditions){
							query.setParameter(num, param);
							num++;
						}
//						log.debug("查询条件的个数为{}",num);
					}
					return query.list();
				}
			});
		}catch(DataAccessException ex){
			log.error("查询失败",ex);
			throw new DBException("查询失败", ex);
		}
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	public List<? extends Object> queryByHQL( final String hql, final Object[] conditions ,final int start,final int offset)
			throws DBException {
		log.debug("执行的hql语句为[{}]",hql);
		try{
			return super.getHibernateTemplate().execute(new HibernateCallback<List>() {
				public List doInHibernate(Session session) throws HibernateException {
					Query query = session.createQuery(hql);
					query.setFirstResult(start);
					query.setMaxResults(offset);
					int num=0;
					if(conditions!=null){
						for(Object param:conditions){
							query.setParameter(num, param);
							num++;
						}
					}
					log.debug("查询条件的个数为{}",num);
					return query.list();
				}
			});
		}catch(DataAccessException ex){
			log.error("查询失败");
			throw new DBException("查询失败", ex);
		}
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<Object> queryBySQL(final String sql,final Object[] conditions)
			throws DBException {
		log.debug("执行查询的sql语句为[{}]",sql);
		try{
			return (List<Object>) super.getHibernateTemplate().execute(new HibernateCallback(){
				public Object doInHibernate(Session session)
						throws HibernateException {
					SQLQuery query = session.createSQLQuery(sql);
					int num=0;
					if(conditions!=null){
						for(Object param:conditions){
							query.setParameter(num, param);
							num++;
						}
						log.debug("查询的条件个数为{}",num);
					}
					return query.list();
				}
			});	
		}catch(DataAccessException ex){
			log.error("查询失败");
			throw new DBException("查询失败", ex);
		}
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	public List<Object> queryBySQL(final String sql,final Object[] conditions,
			final int start,final int offset) throws DBException {
		try{
			return (List<Object>) super.getHibernateTemplate().execute(new HibernateCallback(){
				public Object doInHibernate(Session session)
						throws HibernateException {
					log.debug("执行查询的sql条件为[{}]",sql);
					SQLQuery query = session.createSQLQuery(sql);
					query.setFirstResult(start);
					query.setMaxResults(offset);
					int num=0;
					if(conditions!=null){
						for(Object param:conditions){
							query.setParameter(num, param);
							num++;
						}
						log.debug("查询条件的个数为{}",num);
					}
					return query.list();
				}
			});
		}catch(DataAccessException ex){
			log.error("查询失败");
			throw new DBException("查询失败", ex);
		}
		
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	public int excuteSql(final String sql,final Object[] conditions) throws DBException {
		int num=0;
		log.debug("执行的sql为[{}]",sql);
		try{
			Object obj = super.getHibernateTemplate().execute(new HibernateCallback(){
				public Object doInHibernate(Session session)
						throws HibernateException {
					SQLQuery query = session.createSQLQuery(sql);
					int num=0;
					if(conditions!=null){
						for(Object param:conditions){
							query.setParameter(num, param);
							num++;
						}
						log.debug("条件个数为{}",num);
					}
					return query.executeUpdate();
				}
			});
			num= Integer.parseInt(obj.toString());
			return num;
		}catch(DataAccessException ex){
			log.error("执行失败");
			throw new DBException("执行失败",ex);
		}	
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	public int excuteHql(final String hql,final Object[] conditions) throws DBException {
		int num=0;
		log.debug("执行的hql为[{}]",hql);
		try{
			Object obj =  super.getHibernateTemplate().execute(new HibernateCallback() {
				public Object doInHibernate(Session session)
						throws HibernateException {
					Query query = session.createQuery(hql);
					if(conditions!=null){
						int num=0;
						for(Object param:conditions){
							query.setParameter(num, param);
							num++;
						}
						log.debug("条件个数为{}",num);
					}
					return query.executeUpdate();
				}
			});
			num= Integer.parseInt(obj.toString());
			return num;
		}catch(DataAccessException ex){
			log.error("执行失败");
			throw new DBException("执行失败",ex);
		}
	}
	
	@Resource(name="sessionFactory")
	public void setSuperSessionFactory(SessionFactory sessionFactory) {
		super.setSessionFactory(sessionFactory);
	}
	
}
