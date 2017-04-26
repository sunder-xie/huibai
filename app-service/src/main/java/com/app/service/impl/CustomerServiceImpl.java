package com.app.service.impl;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.app.common.dao.BaseDao;
import com.app.common.exception.DBException;
import com.app.common.model.Message;
import com.hlb.utils.date.DateUtil;
import com.hlb.utils.security.UUID;
import com.hlb.utils.validate.ValidateUtil;
import com.app.service.CustomerService;
import com.app.bean.TblBindInfo;
import com.app.bean.TblCustomerInfo;
import com.app.bean.TblShopInfo;
import com.app.model.ShopInfoModel;

@Service
public class CustomerServiceImpl implements CustomerService {
	private Logger log = LoggerFactory.getLogger(this.getClass());
	@Resource
	private BaseDao baseDaoImpl;
	
	@Override
	@Transactional
	public Message getCustomerInfo(TblCustomerInfo custInfo) {
		log.info("获取cust信息，custid为［{}]",custInfo.getCustId());
		Message msg = new Message();
		try {
			String hql = "from TblCustomerInfo "
					+ " where t.custId = ? ";
					
			List infos = baseDaoImpl.queryBySQL(hql, new String[]{custInfo.getCustId()});
			if(infos.size()<1)
			{
				log.info("未查询到记录");
				msg.setRspCode("000002").setRspMsg("未找到相关记录!");
			}
			else
			{
				msg.setRspCode("000000").setRspMsg("成功!");
				msg.setObjs(infos);
			}
			
		} catch (DBException e) {
			msg.setRspCode("000001").setRspMsg("数据库异常");
			log.error("cust获取失败",e);
		}
		
		return msg;
	}
	
	@Override
	@Transactional
	public Message getCustomerInfoByShopId(String shopId) {
		log.info("获取cust信息，shopid为［{}]",shopId);
		Message msg = new Message();
		try {
			String sql1 = "select t.keyB "
					+ "from tbl_bind_info t "
					+ " where t.keyA = ? and t.mode='03' ";
			List mode = baseDaoImpl.queryBySQL(sql1, new String[]{shopId});

			String custId = "";
			if(mode.size() > 0){
				custId =  mode.get(0).toString();
				log.info("获取cust信息，custId为[{}]",custId);
				String hql="";
				List infos =null;
				/*个人*/
				hql = "from TblCustomerInfo t where t.custSta = '0' and t.custId = ? ";
				infos = baseDaoImpl.queryByHQL(hql, new String[]{custId.toString()});
				if(infos.size()<1)
				{
					log.info("未查询到记录");
					msg.setRspCode("000002").setRspMsg("未找到相关记录!");
				}
				else
				{
					msg.setRspCode("000000").setRspMsg("成功!");
					msg.setObjs(infos);
				}
			}
			else
			{
				log.info("未查询到记录");
				msg.setRspCode("000002").setRspMsg("未找到相关记录!");
			}
			
			
		} catch (DBException e) {
			msg.setRspCode("000001").setRspMsg("数据库异常");
			log.error("cust获取失败",e);
		}
		
		return msg;
	}
	
	@Override
	@Transactional
	public Message getCustomerInfoByUserId(String userId,String status,String bindType) {
		log.info("获取企业信息，user_id为［{}]",userId);
		Message msg = new Message();
		try {
			if(bindType.equals("01"))/*通过userId查找客户信息*/
			{
				/*查找店铺编号*/
				String sql1 = "select t.keyB "
						+ "from tbl_bind_info t "
						+ " where t.keyA = ? and t.mode='01' ";
				List mode = baseDaoImpl.queryBySQL(sql1, new String[]{userId});
				
				String custId = "";
				String hql="";
				List infos =null;
				if(mode.size() > 0){
					custId =  mode.get(0).toString();
					log.info("获取客户信息，custId为[{}]",custId);
					hql = "from TblCustomerInfo t where t.custId = ? and custSta= ? ";
					infos = baseDaoImpl.queryByHQL(hql, new String[]{custId.toString(),status});
					if(infos.size()<1)
					{
						log.info("未查询到记录");
						msg.setRspCode("000002").setRspMsg("未找到相关记录!");
					}
					else
					{
						msg.setRspCode("000000").setRspMsg("成功!");
						msg.setObjs(infos);
					}
				}
				else{
					log.info("未查询到记录");
					msg.setRspCode("000002").setRspMsg("未找到相关记录!");
				}
			}else
			{
				/*查找店铺编号*/
				String sql1 = "select t.keyB "
						+ "from tbl_bind_info t "
						+ " where t.keyA = ? and t.mode='02' ";
				List mode = baseDaoImpl.queryBySQL(sql1, new String[]{userId});
				
				String shopId = "";
				String custId = "";
				if(mode.size() > 0){
					shopId =  mode.get(0).toString();
					log.info("获取店铺信息，shopId为[{}]",shopId);
					String hql="";
					List infos =null;
					
					/* 查找店铺对应客户编号*/
					sql1 = "select t.keyB "
							+ "from tbl_bind_info t "
							+ " where t.keyA = ? and t.mode='03' ";
					List mode2 = baseDaoImpl.queryBySQL(sql1, new String[]{shopId});
					
					custId =mode2.get(0).toString();
					log.info("获取企业信息，custId为[{}]",custId);
					
					hql = "from TblCustomerInfo t where t.custId = ? and custSta= ? ";
					
					infos = baseDaoImpl.queryByHQL(hql, new String[]{custId.toString(),status});
					if(infos.size()<1)
					{
						log.info("未查询到记录");
						msg.setRspCode("000002").setRspMsg("未找到相关记录!");
					}
					else
					{
						msg.setRspCode("000000").setRspMsg("成功!");
						msg.setObjs(infos);
					}
				
				}
				else
				{
					log.info("未查询到记录");
					msg.setRspCode("000002").setRspMsg("未找到相关记录!");
				}
			}
		} catch (DBException e) {
			msg.setRspCode("000001").setRspMsg("数据库异常");
			log.error("shop获取失败",e);
		}
		
		return msg;
	}
	
	@SuppressWarnings("static-access")
	@Override
	@Transactional
	public Message saveCustomerInfo(TblCustomerInfo custInfo,String userId,String shopId,String bindType) {
		
		log.info("进行客户信息的注册，userId为[{}]客户名为［{}]",userId,custInfo.getCustNm());
		Message msg = new Message();
		
		try {
				
				if(bindType.equals("01"))/*通过userId查找绑定客户信息*/
				{
					UUID uuid =new UUID();
					String custId = uuid.getUUID();
					String regDt=DateUtil.getCurrentDate(DateUtil.DATE_FORMAT_14);
					
					TblBindInfo bindinfo =new TblBindInfo();
					custInfo.setCustId(custId);
					custInfo.setRegDt(regDt);
					custInfo.setCustSta("0");
					bindinfo.setBindNo(uuid.getUUID());
					bindinfo.setKeyA(userId);
					bindinfo.setKeyB(custId);
					bindinfo.setBindSta("0");
					bindinfo.setMode("01");
					bindinfo.setBindDt(regDt);
					
					baseDaoImpl.save(bindinfo);
					baseDaoImpl.save(custInfo);
					msg.setRspCode("000000").setRspMsg("成功!");
					msg.setObjs(custInfo);
				}
				else
				{
					msg.setRspCode("000001").setRspMsg("保存客户信息失败！");
				}
			
			
		} catch (DBException e) {
			msg.setRspCode("000001").setRspMsg("数据库异常");
			log.error("店铺信息注册失败，店铺名为[{}]",custInfo.getCustNm(),e);
		}
		
		return msg;
	}
	
	@SuppressWarnings("static-access")
	@Override
	@Transactional
	public Message updateCustomerInfo(TblCustomerInfo custInfo,String userId,String shopId,String bindType) {
		
		log.info("进行客户信息的更新，编号名为［{}][{}]",custInfo.getCustId(),custInfo.getCustNm());
		Message msg = new Message();
		
		try {
			
			if(bindType.equals("01"))/*通过userId查找绑定客户信息*/
			{
				String sql = "update tbl_customer_info set custNm = ? , certNo = ?  "
						+ "where custId = ? ";
				
				baseDaoImpl.excuteSql(sql, new String[]{custInfo.getCustNm(),
						custInfo.getCertNo(),
						custInfo.getCustId()});
				msg.setObjs(custInfo);
				msg.setRspCode("000000").setRspMsg("更新客户信息成功！");
			}
			else
			{
				msg.setRspCode("000001").setRspMsg("更新客户信息失败！");
			}
		} catch (DBException e) {
			msg.setRspCode("000001").setRspMsg("更新用户信息失败");
			e.printStackTrace();
		}
		
		return msg;
	}
}
