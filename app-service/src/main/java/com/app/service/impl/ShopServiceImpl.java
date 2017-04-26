package com.app.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.app.common.dao.BaseDao;
import com.app.common.exception.DBException;
import com.app.common.model.Message;
import com.hlb.utils.date.DateUtil;
import com.hlb.utils.security.UUID;
import com.hlb.utils.validate.ValidateUtil;
import com.app.service.ShopService;
import com.app.bean.TblBindInfo;
import com.app.bean.TblResourcesInfo;
import com.app.bean.TblShopInfo;
import com.app.model.ShopInfoModel;
import com.app.common.utils.LTConstant;
import com.hlb.utils.*;
@Service
public class ShopServiceImpl implements ShopService {
	private Logger log = LoggerFactory.getLogger(this.getClass());
	@Resource
	private BaseDao baseDaoImpl;
	
	@Override
	@Transactional
	public Message getShopInfo(TblShopInfo shopInfo) {
		log.info("获取shop信息，shop_id为［{}]",shopInfo.getShopId());
		Message msg = new Message();
		try {
			String sql = "select t.shop_id ,t.shop_nm,t.sales,t.address, c.url as logo,t.totalscore,t.shopscore ,t.serverscore,t.expresscore ,d.url as shopsign,t.server,t.shop_tel,t.type,t.content "
					+ "from tbl_shop_info t "
					+ " left join tbl_resources_info c on c.resid=t.logo "
					+ " left join tbl_resources_info d on d.resid=t.shopsign "
					+ " where t.shop_id = ? ";
					
			List infos = baseDaoImpl.queryBySQL(sql, new String[]{shopInfo.getShopId()});
			if(infos.size()<1)
			{
				log.info("未查询到记录");
				msg.setRspCode("000002").setRspMsg("未找到相关记录!");
			}
			else
			{
				msg.setRspCode("000000").setRspMsg("成功!");
				List<ShopInfoModel> models = new ArrayList<ShopInfoModel>();
				for(Object object : infos){
					Object[] strs = (Object[])object;
					ShopInfoModel shopInfoModel = new ShopInfoModel();
					shopInfoModel.setShopId(strs[0]+"");
					shopInfoModel.setShopNm(strs[1]+"");
					shopInfoModel.setSales(strs[2]+"");
					shopInfoModel.setAddress(strs[3]+"");
					shopInfoModel.setLogourl(strs[4]+"");
					shopInfoModel.setTotalscore(strs[5]+"");
					shopInfoModel.setShopscore(strs[6]+"");
					shopInfoModel.setServerscore(strs[7]+"");
					shopInfoModel.setExpresscore(strs[8]+"");
					shopInfoModel.setShopsign(strs[9]+"");
					shopInfoModel.setServer(strs[10]+"");
					shopInfoModel.setShopTel(strs[11]+"");
					shopInfoModel.setType(strs[12]+"");
					shopInfoModel.setContent(strs[13]+"");
					models.add(shopInfoModel);
				}
				msg.setObjs(models);
			}
			
		} catch (DBException e) {
			msg.setRspCode("000001").setRspMsg("数据库异常");
			log.error("shop获取失败",e);
		}
		
		return msg;
	}
	
	@Override
	@Transactional
	public Message getShopInfoByUserId(String userId,String status) {
		log.info("获取shop信息，user_id为［{}]",userId);
		Message msg = new Message();
		try {
			String sql = "select t.shop_id ,t.shop_nm,t.sales,t.address, c.url as logo,t.totalscore,t.shopscore ,t.serverscore,t.expresscore ,d.url as shopsign,t.server,t.shop_tel,t.type,t.content "
					+ "from tbl_shop_info t "
					+ " left join tbl_resources_info c on c.resid=t.logo "
					+ " left join tbl_resources_info d on d.resid=t.shopsign "
					+ " where t.shop_id = (select keyB from tbl_bind_info where keyA = ? and mode='02' ) and t.status=? ";
					
			List infos = baseDaoImpl.queryBySQL(sql, new String[]{userId,status});
			if(infos.size()<1)
			{
				log.info("未查询到记录");
				msg.setRspCode("000002").setRspMsg("未找到相关记录!");
			}
			else
			{
				msg.setRspCode("000000").setRspMsg("成功!");
				List<ShopInfoModel> models = new ArrayList<ShopInfoModel>();
				for(Object object : infos){
					Object[] strs = (Object[])object;
					ShopInfoModel shopInfoModel = new ShopInfoModel();
					shopInfoModel.setShopId(strs[0]+"");
					shopInfoModel.setShopNm(strs[1]+"");
					shopInfoModel.setSales(strs[2]+"");
					shopInfoModel.setAddress(strs[3]+"");
					shopInfoModel.setLogourl(strs[4]+"");
					shopInfoModel.setTotalscore(strs[5]+"");
					shopInfoModel.setShopscore(strs[6]+"");
					shopInfoModel.setServerscore(strs[7]+"");
					shopInfoModel.setExpresscore(strs[8]+"");
					shopInfoModel.setShopsign(strs[9]+"");
					shopInfoModel.setServer(strs[10]+"");
					shopInfoModel.setShopTel(strs[11]+"");
					shopInfoModel.setType(strs[12]+"");
					shopInfoModel.setContent(strs[13]+"");
					models.add(shopInfoModel);
				}
				msg.setObjs(models);
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
	public Message saveShopInfoForEprise(TblShopInfo shopInfo,Map<String, String> params) {
		
		log.info("进行店铺信息的注册，店铺名为［{}]",shopInfo.getShopNm());
		Message msg = new Message();
		try {
			UUID uuid =new UUID();
			String UserId = params.get("userId");
			String EnterId = params.get("enterId");
			TblBindInfo bindinfo =new TblBindInfo();
			String shopid=uuid.getUUID();
			String RegDt = DateUtil.getCurrentDate(DateUtil.DATE_FORMAT_14);
			
			shopInfo.setShopId(shopid);
			shopInfo.setType("1");
			shopInfo.setStatus("1");
			shopInfo.setRegDt(RegDt);
			shopInfo.setServerscore("5.00");
			shopInfo.setTotalscore("5.00");
			shopInfo.setExpresscore("5.00");
			shopInfo.setShopscore("5.00");
			
			String bindid=uuid.getUUID();
			bindinfo.setBindNo(bindid);
			bindinfo.setKeyA(UserId);
			bindinfo.setKeyB(shopid);
			bindinfo.setBindSta("0");
			bindinfo.setMode("02");
			bindinfo.setBindDt(RegDt);
			
			String sql = "update tbl_enter_step_info set step_id ='3',step_desc ='提交企业信息' where enter_id = ? ";
				baseDaoImpl.excuteSql(sql, new String[]{EnterId});
			
			baseDaoImpl.save(shopInfo);
			baseDaoImpl.save(bindinfo);
			msg.setRspCode("000000").setRspMsg("企业店铺信息添加成功！");
			msg.setObjs(shopInfo);
		} catch (DBException e) {
			msg.setRspCode("000001").setRspMsg("数据库异常");
			log.error("店铺信息注册失败，店铺名为[{}]",shopInfo.getShopNm(),e);
		}
		
		return msg;
	}
	
	@SuppressWarnings("static-access")
	@Override
	@Transactional
	public Message saveShopInfoForPerson(TblShopInfo shopInfo,Map<String, String> params) {
		
		log.info("进行店铺信息的注册，店铺名为［{}]",shopInfo.getShopNm());
		Message msg = new Message();
		
		try {
			UUID uuid =new UUID();
			String RegDt = DateUtil.getCurrentDate(DateUtil.DATE_FORMAT_14);
			String UserId = params.get("userId");
			String EnterId = params.get("enterId");
			TblBindInfo bindinfo =new TblBindInfo();
			String shopid=uuid.getUUID();
			shopInfo.setShopId(shopid);
			shopInfo.setType("2");
			shopInfo.setStatus("0");
			shopInfo.setRegDt(RegDt);
			shopInfo.setServerscore("5.00");
			shopInfo.setTotalscore("5.00");
			shopInfo.setExpresscore("5.00");
			shopInfo.setShopscore("5.00");
			
			String bindid=uuid.getUUID();
			bindinfo.setBindNo(bindid);
			bindinfo.setKeyA(UserId);
			bindinfo.setKeyB(shopid);
			bindinfo.setBindSta("0");
			bindinfo.setMode("02");
			bindinfo.setBindDt(RegDt);
			
			//String sql = "update tbl_enter_step_info set step_id ='3',step_desc ='提交企业信息' where user_id = ? ";
			String sql = "update tbl_enter_step_info set step_id ='5',step_desc ='进驻完成',enter_sta='2' where enter_id = ? ";
				baseDaoImpl.excuteSql(sql, new String[]{EnterId});
			
			baseDaoImpl.save(shopInfo);
			baseDaoImpl.save(bindinfo);
			msg.setRspCode("000000").setRspMsg("店铺注册成功！");
			msg.setObjs(shopInfo);
		} catch (DBException e) {
			msg.setRspCode("000001").setRspMsg("数据库异常");
			log.error("店铺信息注册失败，店铺名为[{}]",shopInfo.getShopNm(),e);
		}
		
		return msg;
	}
	
	@SuppressWarnings("static-access")
	@Override
	@Transactional
	public Message updateShopInfo(TblShopInfo shopInfo,Map<String, String> params) {
		
		log.info("进行个人店铺信息的更新，店铺名为[{}]［{}]",shopInfo.getShopId(),shopInfo.getShopNm());
		Message msg = new Message();
		
		try {
			String sql = "update tbl_shop_info set shop_nm = ? , sales = ? ,  content = ? ,shop_tel =? ,address =? where shop_id = ? ";
			baseDaoImpl.excuteSql(sql, new String[]{shopInfo.getShopNm(),shopInfo.getSales(),shopInfo.getContent(), shopInfo.getShopTel(),shopInfo.getAddress(),shopInfo.getShopId()});
		
			msg.setRspCode("000000").setRspMsg("更新个人店铺信息成功！");
			msg.setObjs(shopInfo);
		} catch (DBException e) {
			msg.setRspCode("000001").setRspMsg("更新个人店铺信息失败");
			e.printStackTrace();
		}
		
		return msg;
	}
	
	@SuppressWarnings("static-access")
	@Override
	@Transactional
	public Message updateShopInfoForEprise(TblShopInfo shopInfo,Map<String, String> params) {
		
		log.info("进行企业店铺信息的更新，店铺名为[{}]［{}]",shopInfo.getShopId(),shopInfo.getShopNm());
		Message msg = new Message();
		
		try {
			
			String EnterId = params.get("enterId");
			
			String sql = "update tbl_shop_info set shop_nm = ? , sales = ? ,  content = ? ,shop_tel =? ,address =? where shop_id = ? ";
			baseDaoImpl.excuteSql(sql, new String[]{shopInfo.getShopNm(),shopInfo.getSales(),shopInfo.getContent(), shopInfo.getShopTel(),shopInfo.getAddress(),shopInfo.getShopId()});
		
		    sql = "update tbl_enter_step_info set step_id ='3',step_desc ='请提交企业信息' where enter_id = ? ";
			baseDaoImpl.excuteSql(sql, new String[]{EnterId});
			msg.setRspCode("000000").setRspMsg("更新用户信息成功！");
			msg.setObjs(shopInfo);
		} catch (DBException e) {
			msg.setRspCode("000001").setRspMsg("更新用户信息失败");
			e.printStackTrace();
		}
		
		return msg;
	}
	
	@SuppressWarnings("static-access")
	@Override
	@Transactional
	public Message updateShopInfoForPerson(TblShopInfo shopInfo,Map<String, String> params) {
		
		log.info("进行个人店铺信息的更新，店铺名为[{}]［{}]",shopInfo.getShopId(),shopInfo.getShopNm());
		Message msg = new Message();
		
		try {
			String userId = params.get("userId");
			String EnterId = params.get("enterId");
			String sql = "update tbl_shop_info set shop_nm = ? , sales = ? ,  content = ? ,shop_tel =? ,address =? where shop_id = ? ";
			baseDaoImpl.excuteSql(sql, new String[]{shopInfo.getShopNm(),shopInfo.getSales(),shopInfo.getContent(), shopInfo.getShopTel(),shopInfo.getAddress(),shopInfo.getShopId()});
		
		    sql = "update tbl_enter_step_info set step_id ='5',step_desc ='进驻完成',enter_sta='2' where enter_id = ? ";
			baseDaoImpl.excuteSql(sql, new String[]{EnterId});
			msg.setRspCode("000000").setRspMsg("更新个人店铺信息成功！");
			msg.setObjs(shopInfo);
		} catch (DBException e) {
			msg.setRspCode("000001").setRspMsg("更新个人店铺信息失败");
			e.printStackTrace();
		}
		
		return msg;
	}
	
	@SuppressWarnings("static-access")
	@Override
	@Transactional
	public Message updateShopImages(Map<String, String> params) {
		
		log.info("开始更新店铺相关图片信息");
		Message msg = new Message();
		try {
			UUID uuid =new UUID();
			String instDt = DateUtil.getCurrentDate(DateUtil.DATE_FORMAT_14);
			String ShopId = params.get("shopId");
			String resId ="";
			TblResourcesInfo resInfo = new TblResourcesInfo();
			resId=uuid.getUUID();
			resInfo.setResid(resId);
			resInfo.setKeyid(ShopId);
			resInfo.setType(params.get("imgType"));
			resInfo.setNewFileNm(params.get("fileNm"));
			resInfo.setUrl(params.get("imgUrl"));
			resInfo.setStatus("0");
			resInfo.setInstDt(instDt);
			 
			String sql ="";
			if(params.get("imgType").equals("05"))//店铺logo
			{
				sql="update tbl_shop_info set  logo = '"+resId+"' where shop_id =? ";
			}else if(params.get("imgType").equals("03"))//店铺招牌
			{
				sql="update tbl_shop_info set shopsign = '"+resId+"' where shop_id =? ";
			}else{
				msg.setRspCode("000005").setRspMsg("图片类型错误");
				return msg;
			}
			baseDaoImpl.save(resInfo);
			baseDaoImpl.excuteSql(sql,new String[]{ShopId});
		} catch (DBException e) {
			msg.setRspCode("000001").setRspMsg("更新店铺相关图片信息失败");
			e.printStackTrace();
		}
		msg.setRspCode("000000").setRspMsg("更新店铺相关图片信息成功！");
		log.info("更新店铺相关图片信息结束");
		return msg;
	}
	
}
