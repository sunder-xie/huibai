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
import com.app.service.EpriseService;
import com.app.bean.TblBindInfo;
import com.app.bean.TblEpriseInfo;
import com.app.bean.TblShopInfo;
import com.app.model.ShopInfoModel;

@Service
public class EpriseServiceImpl implements EpriseService {
	private Logger log = LoggerFactory.getLogger(this.getClass());
	@Resource
	private BaseDao baseDaoImpl;
	
	@Override
	@Transactional
	public Message getEpriseInfo(TblEpriseInfo epriseInfo) {
		log.info("获取eprise信息，epriseid为［{}]",epriseInfo.getEpriseId());
		Message msg = new Message();
		try {
			String sql = "select t.eprise_id ,t.eprise_nm,t.sales,t.address, c.url as logo,t.totalscore,t.eprisescore ,t.serverscore,t.expresscore ,d.url as eprisesign,t.server "
					+ "from tbl_eprise_info t "
					+ " left join tbl_resources_info c on c.resid=t.logo "
					+ " left join tbl_resources_info d on d.resid=t.eprisesign "
					+ " where t.eprise_id = ? ";
					
			List infos = baseDaoImpl.queryBySQL(sql, new String[]{epriseInfo.getEpriseId()});
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
			log.error("eprise获取失败",e);
		}
		
		return msg;
	}
	
	@Override
	@Transactional
	public Message getEpriseInfoByShopId(TblEpriseInfo epriseInfo) {
		log.info("获取eprise信息，shopid为［{}]",epriseInfo.getEpriseId());
		Message msg = new Message();
		try {
			String sql1 = "select t.keyB "
					+ "from tbl_bind_info t "
					+ " where t.keyA = ? and t.mode='03' ";
			List mode = baseDaoImpl.queryBySQL(sql1, new String[]{epriseInfo.getEpriseId()});

			String epriseid = "";
			if(mode.size() > 0){
				epriseid =  mode.get(0).toString();
				log.info("获取eprise信息，epriseid为[{}]",epriseid);
				String hql="";
				List infos =null;
				/*企业*/
				hql = "from TblEpriseInfo t where t.status = '0' and t.epriseId = ? ";
				infos = baseDaoImpl.queryByHQL(hql, new String[]{epriseid.toString()});
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
			log.error("eprise获取失败",e);
		}
		
		return msg;
	}
	
	@Override
	@Transactional
	public Message getEpriseInfoByUserId(String userId,String status) {
		log.info("获取企业信息，user_id为［{}]",userId);
		Message msg = new Message();
		try {
			/*查找店铺编号*/
			String sql1 = "select t.keyB "
					+ "from tbl_bind_info t "
					+ " where t.keyA = ? and t.mode='02' ";
			List mode = baseDaoImpl.queryBySQL(sql1, new String[]{userId});
			
			String shopId = "";
			String epriseId = "";
			if(mode.size() > 0){
				shopId =  mode.get(0).toString();
				log.info("获取企业信息，shopId为[{}]",shopId);
				String hql="";
				List infos =null;
				
				sql1 = "select t.keyB "
						+ "from tbl_bind_info t "
						+ " where t.keyA = ? and t.mode='03' ";
				List mode2 = baseDaoImpl.queryBySQL(sql1, new String[]{shopId});
				
				epriseId =mode2.get(0).toString();
				log.info("获取企业信息，epriseId为[{}]",epriseId);
				
				hql = "from TblEpriseInfo t where t.epriseId = ? and status= ? ";
				
				infos = baseDaoImpl.queryByHQL(hql, new String[]{epriseId.toString(),status});
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
			log.error("shop获取失败",e);
		}
		
		return msg;
	}
	
	@SuppressWarnings("static-access")
	@Override
	@Transactional
	public Message saveEpriseInfo(TblEpriseInfo epriseInfo,String uid,String shopId) {
		
		log.info("进行企业信息的注册，店铺名为［{}]",epriseInfo.getEpriseNm());
		Message msg = new Message();
		UUID uuid =new UUID();
		TblBindInfo bindinfo =new TblBindInfo();
		try {
			String epriseId=uuid.getUUID();
			epriseInfo.setEpriseId(epriseId);
			epriseInfo.setStatus("0");
			epriseInfo.setInstDt(DateUtil.getCurrentDate(DateUtil.DATE_FORMAT_14));
			
			String bindid=uuid.getUUID();
			bindinfo.setBindNo(bindid);
			bindinfo.setKeyA(shopId);
			bindinfo.setKeyB(epriseId);
			bindinfo.setBindSta("0");
			bindinfo.setMode("03");
			bindinfo.setBindDt(DateUtil.getCurrentDate(DateUtil.DATE_FORMAT_14));
			
			String sql = "update tbl_enter_step_info set step_id ='5',step_desc ='进驻完成',enter_sta='2' where user_id = ? ";
			baseDaoImpl.excuteSql(sql, new Object[]{uid});
			
			
			String shopsql = "update tbl_shop_info set type='1',status='0' where shop_id = ? ";
			baseDaoImpl.excuteSql(shopsql, new Object[]{shopId});
			
			baseDaoImpl.save(epriseInfo);
			baseDaoImpl.save(bindinfo);
			msg.setRspCode("000000").setRspMsg("登录成功！");
		} catch (DBException e) {
			msg.setRspCode("000001").setRspMsg("数据库异常");
			log.error("店铺信息注册失败，店铺名为[{}]",epriseInfo.getEpriseNm(),e);
		}
		
		return msg;
	}
	
	@SuppressWarnings("static-access")
	@Override
	@Transactional
	public Message updateEpriseInfo(TblEpriseInfo epriseInfo,String userId,String shopId) {
		
		log.info("进行企业信息的更新，企业编号名为［{}][{}]",epriseInfo.getEpriseId(),epriseInfo.getEpriseNm());
		Message msg = new Message();
		
		try {
			
			String sql = "update tbl_eprise_info set eprise_nm = ? , lic_no = ? ,  "
					+ "build_dt = ? ,busi_dt = ? ,"
					+ "legal= ? ,eprise_tel=? ,business = ? ,status='0' "
					+ "where eprise_id = ? ";
			
			baseDaoImpl.excuteSql(sql, new String[]{epriseInfo.getEpriseNm(),epriseInfo.getLicNo(),
					epriseInfo.getBuildDt(),epriseInfo.getBusiDt(),
					epriseInfo.getLegal(),epriseInfo.getEpriseTel(),epriseInfo.getBusiness(),
					epriseInfo.getEpriseId()});
			
			log.info("进行企业进驻进度的更新，userId名为［{}]",userId);
			
			sql = "update tbl_enter_step_info set step_id ='5',step_desc ='进驻完成',enter_sta='2' where user_id = ? ";
			baseDaoImpl.excuteSql(sql, new String[]{userId});
			
			if(shopId.equals(""))
			{
				String sql1 = "select t.keyB "
						+ "from tbl_bind_info t "
						+ " where t.keyA = ? and t.mode='02' ";
				List mode = baseDaoImpl.queryBySQL(sql1, new String[]{userId});
				shopId =  mode.get(0).toString();
				log.info("获取店铺信息，shopId为[{}]",shopId);
			}
			
			log.info("进行商铺信息的更新，shopId名为［{}]",shopId);
		    sql = "update tbl_shop_info set type='1',status='0' where shop_id = ? ";
			baseDaoImpl.excuteSql(sql, new String[]{shopId});
			
			msg.setRspCode("000000").setRspMsg("更新用户信息成功！");
		} catch (DBException e) {
			msg.setRspCode("000001").setRspMsg("更新用户信息失败");
			e.printStackTrace();
		}
		
		return msg;
	}
}
