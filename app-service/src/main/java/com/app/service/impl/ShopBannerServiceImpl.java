package com.app.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

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
import com.app.service.ShopBannerService;
import com.app.bean.TblResourcesInfo;
import com.app.bean.TblShopBannerInfo;
import com.app.model.ShopBannerModel;

@Service
public class ShopBannerServiceImpl implements ShopBannerService {
	private Logger log = LoggerFactory.getLogger(this.getClass());
	@Resource
	private BaseDao baseDaoImpl;
	
	@Override
	@Transactional
	public Message getShopBannerInfo(TblShopBannerInfo shopbannerInfo) {
		log.info("获取shopbanner信息，shopid为［{}]",shopbannerInfo.getShopId());
		Message msg = new Message();
		try {
			String sql = "select t.bid,t.shop_id,t.title, c.url as imgurl,t.url ,t.resid "
					+ " from tbl_shop_banner_info t "
					+ " left join tbl_resources_info c on c.resid=t.resid and t.status= 0 "
					+ " where t.shop_id = ? and t.type = ? ";
					
			List infos = baseDaoImpl.queryBySQL(sql, new String[]{shopbannerInfo.getShopId(),shopbannerInfo.getType()});
			if(infos.size()<1)
			{
				log.info("未查询到记录");
				msg.setRspCode("000002").setRspMsg("未找到相关记录!");
			}
			else
			{
				msg.setRspCode("000000").setRspMsg("成功!");
				List<ShopBannerModel> models = new ArrayList<ShopBannerModel>();
				for(Object object : infos){
					Object[] strs = (Object[])object;
					ShopBannerModel shopbannerModel = new ShopBannerModel();
					shopbannerModel.setBid(strs[0]+"");
					shopbannerModel.setShopId(strs[1]+"");
					shopbannerModel.setTitle(strs[2]+"");
					shopbannerModel.setImgurl(strs[3]+"");
					shopbannerModel.setUrl(strs[4]+"");
					shopbannerModel.setResid(strs[5]+"");
					models.add(shopbannerModel);
				}
				msg.setObjs(models);
			}
			
		} catch (DBException e) {
			msg.setRspCode("000001").setRspMsg("数据库异常");
			log.error("shopbanner获取失败",e);
		}
		
		return msg;
	}
	
	@Override
	@Transactional
	public Message saveShopBanner(Map<String, String> params) {
		log.info("开始新增shopbanner信息，店铺编号为："+params.get("shopId"));
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
			
			TblShopBannerInfo shopbannerInfo = new TblShopBannerInfo();
			String bid=uuid.getUUID();
			shopbannerInfo.setBid(bid);
			shopbannerInfo.setShopId(ShopId);
			shopbannerInfo.setTitle("商家banner");
			shopbannerInfo.setResid(resId);
			shopbannerInfo.setType(params.get("bannerType"));
			shopbannerInfo.setUrl(params.get("url"));
			shopbannerInfo.setStatus(0);
			//shopbannerInfo.setInstDt(instDt);
			baseDaoImpl.save(resInfo);
			baseDaoImpl.save(shopbannerInfo);
		    msg.setRspCode("000000").setRspMsg("成功!");
				
		} catch (DBException e) {
			msg.setRspCode("000001").setRspMsg("数据库异常");
			log.error("shopbanner获取失败",e);
		}
		log.info("新增shopbanner信息结束");
		return msg;
	}
	
	@Override
	@Transactional
	public Message delShopBanner(Map<String, String> params) {
		log.info("开始删除shopbanner信息，店铺编号为："+params.get("shopId"));
		Message msg = new Message();
		try {
			
			String bid = params.get("bid");
			String resId = params.get("resId");
			String delsql = "delete from tbl_shop_banner_info "
					+ " where bid = ? ";
			baseDaoImpl.excuteSql(delsql,new String[]{bid});
			
			delsql = "delete from tbl_resources_info "
					+ " where resid = ? ";
			baseDaoImpl.excuteSql(delsql,new String[]{resId});
			msg.setRspCode("000000").setRspMsg("成功!");
			
		} catch (DBException e) {
			msg.setRspCode("000001").setRspMsg("数据库异常");
			log.error("shopbanner获取失败",e);
		}
		log.info("删除shopbanner信息结束");
		return msg;
	}
	
	@Override
	@Transactional
	public Message updateShopBanner(Map<String, String> params) {
		log.info("更新shopbanner信息，店铺编号为［{}]",params.get("shopId"));
		Message msg = new Message();
		try {
			
			String modiDt = DateUtil.getCurrentDate(DateUtil.DATE_FORMAT_14);
			String ShopId = params.get("shopId");
			String resId = params.get("resId");
			String imgType = params.get("imgType");
			String fileNm = params.get("fileNm");
			String imgUrl = params.get("imgUrl");
			String goodsUrl = params.get("url");
			String bid = params.get("bid");
			String sql = "";
			sql = "update tbl_resources_info t "
					+ "set t.keyid = ? , t.url = ? ,t.newFileNm =? ,modi_dt =? "
					+ " where t.resid = ? ";
			baseDaoImpl.excuteSql(sql,new String[]{ShopId,imgUrl,fileNm,modiDt,resId});
			
			sql = "update  tbl_shop_banner_info t "
					+ "set t.url = ? ,t.resid =?  "
					+ " where t.bid = ? ";
					
			baseDaoImpl.excuteSql(sql, new String[]{goodsUrl,resId,bid});
			msg.setRspCode("000000").setRspMsg("成功!");
				
			
		} catch (DBException e) {
			msg.setRspCode("000001").setRspMsg("数据库异常");
			log.error("shopbanner获取失败",e);
		}
		
		log.info("更新shopbanner信息结束，店铺编号为［{}]",params.get("shopId"));
		return msg;
	}
	
}
