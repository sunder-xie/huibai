package com.app.service.impl;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.json.JSONArray;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.app.common.dao.BaseDao;
import com.app.common.exception.DBException;
import com.app.common.model.Message;
import com.app.common.model.Pager;
import com.hlb.utils.date.DateUtil;
import com.hlb.utils.security.UUID;
import com.hlb.utils.validate.ValidateUtil;
import com.app.service.GoodsService;
import com.app.bean.TblGoodsInfo;
import com.app.bean.TblGoodsTypeInfo;
import com.app.bean.TblResourcesInfo;
import com.app.model.GoodsInfoModel;
import com.app.common.utils.LTConstant;
import com.hlb.utils.*;
@Service
public class GoodsServiceImpl implements GoodsService {
	private Logger log = LoggerFactory.getLogger(this.getClass());
	@Resource
	private BaseDao baseDaoImpl;
	
	@Override
	@Transactional
	public Message getGoodsInfo(TblGoodsInfo goodsInfo) {
		log.info("获取goods信息，goodsid为［{}]",goodsInfo.getGoodsId());
		Message msg = new Message();
		try {
			String hql = "from TblGoodsInfo t where t.goodsId = ?";
			List infos = baseDaoImpl.queryByHQL(hql, new String[]{goodsInfo.getGoodsId()});
			if(infos.size()<1)
			{
				log.info("未查询到记录");
				msg.setRspCode("000002").setRspMsg("未找到相关记录!");
			}
			else
			{
				msg.setRspCode("000000").setRspMsg("成功!");
				msg.setObjs(infos.get(0));
			}
			
		} catch (DBException e) {
			msg.setRspCode("000001").setRspMsg("数据库异常");
			log.error("goods获取失败",e);
		}
		
		return msg;
	}
	
	@Override
	@Transactional
	public Message updateGoodsStatus(Map <String ,String> params) {
		log.info("需要更新goods列表信息，goodsid为［{}]",params.get("goodsIdList"));
		log.info("需要更新goods列表信息，goodsid为［{}]",params.get("status"));
		Message msg = new Message();
		try {
			String goodsIdList = params.get("goodsIdList");
			goodsIdList = goodsIdList.replaceAll(",", "','");
			goodsIdList = "'"+goodsIdList+"'";
			String sql = "update tbl_goods_info t set t.status = ? where t.shop_id =? and t.goods_id in ( "+goodsIdList+" )";
			baseDaoImpl.excuteSql(sql, new Object[]{params.get("status"),params.get("shopId")});
			
			msg.setRspCode("000000").setRspMsg("成功!");
			
			
		} catch (DBException e) {
			msg.setRspCode("000001").setRspMsg("数据库异常");
			log.error("goods获取失败",e);
		}
		
		return msg;
	}
	
	@Override
	@Transactional
	public Message deleteGoodsInfo(Map <String ,String> params) {
		log.info("需要删除goods列表信息，goodsid为［{}]",params.get("goodsIdList"));
		log.info("需要删除goods列表信息，shop_id为［{}]",params.get("shopId"));
		Message msg = new Message();
		try {
			String goodsIdList = params.get("goodsIdList");
			goodsIdList = goodsIdList.replaceAll(",", "','");
			goodsIdList = "'"+goodsIdList+"'";
			String sql = "delete from tbl_goods_info where shop_id =? and goods_id in ( "+goodsIdList+" )";
			baseDaoImpl.excuteSql(sql, new Object[]{params.get("shopId")});
			
		    sql = "delete from tbl_goods_type_info where goods_id in ( "+goodsIdList+" )";
			baseDaoImpl.excuteSql(sql, null);
			
			sql = "delete from tbl_resources_info where keyid in ( "+goodsIdList+" )";
			baseDaoImpl.excuteSql(sql, null);
			
			msg.setRspCode("000000").setRspMsg("成功!");
			
			
		} catch (DBException e) {
			msg.setRspCode("000001").setRspMsg("数据库异常");
			log.error("goods获取失败",e);
		}
		
		return msg;
	}
	
	@Override
	@Transactional
	public Message getGoodsShortInfo(TblGoodsInfo goodsInfo) {
		log.info("获取goods信息，goodsid为［{}]",goodsInfo.getGoodsId());
		Message msg = new Message();
		try {
			String sql  = "select t.goods_id ,t.goods_nm,t.amount,t.classify,t.shop_id, c.url as mainPicUrl,b.shop_nm ";
			String csql =sql+ "from tbl_goods_info t"
					+ " left join tbl_shop_info b on t.shop_id=b.shop_id "
					+ " left join tbl_resources_info c on c.keyid=t.goods_id and c.type='01' where t.goods_id = ? ";
			
			List infos = baseDaoImpl.queryBySQL(csql, new String[]{goodsInfo.getGoodsId()});
			if(infos.size()<1)
			{
				log.info("未查询到记录");
				msg.setRspCode("000002").setRspMsg("未找到相关记录!");
			}
			else
			{
				msg.setRspCode("000000").setRspMsg("成功!");
				List<GoodsInfoModel> models = new ArrayList<GoodsInfoModel>();
				for(Object object : infos){
					Object[] strs = (Object[])object;
					GoodsInfoModel goodsInfoModel = new GoodsInfoModel();
					goodsInfoModel.setGoodsId(strs[0]+"");
					goodsInfoModel.setGoodsNm(strs[1]+"");
					goodsInfoModel.setAmount(strs[2]+"");
					goodsInfoModel.setClassify(strs[3]+"");
					goodsInfoModel.setShopId(strs[4]+"");
					goodsInfoModel.setMainPicUrl(strs[5]+"");
					goodsInfoModel.setShopNm(strs[6]+"");
					models.add(goodsInfoModel);
				}
				msg.setObjs(models);
			}
			
		} catch (DBException e) {
			msg.setRspCode("000001").setRspMsg("数据库异常");
			log.error("goods获取失败",e);
		}
		
		return msg;
	}
	
	@Override
	@Transactional
	public Message getShopGoodsShortInfo(TblGoodsInfo goodsInfo) {
		log.info("获取goods信息，goodsid为［{}]",goodsInfo.getGoodsId());
		Message msg = new Message();
		try {
			String sql  = "select t.goods_id ,t.goods_nm,CAST(t.AMOUNT/100 as DECIMAL(12,2)), c.url  ";
			String csql =sql+ "from tbl_goods_info t"
					+ " left join tbl_resources_info c on c.keyid=t.goods_id and c.type='01' where t.goods_id = ? and t.shop_id = ? ";
			
			List infos = baseDaoImpl.queryBySQL(csql, new String[]{goodsInfo.getGoodsId(),goodsInfo.getShopId()});
			if(infos.size()<1)
			{
				log.info("未查询到记录");
				msg.setRspCode("000002").setRspMsg("未找到相关记录!");
			}
			else
			{
				msg.setRspCode("000000").setRspMsg("成功!");
				List<GoodsInfoModel> models = new ArrayList<GoodsInfoModel>();
				for(Object object : infos){
					Object[] strs = (Object[])object;
					GoodsInfoModel goodsInfoModel = new GoodsInfoModel();
					goodsInfoModel.setGoodsId(strs[0]+"");
					goodsInfoModel.setGoodsNm(strs[1]+"");
					goodsInfoModel.setAmount(strs[2]+"");
					goodsInfoModel.setMainPicUrl(strs[3]+"");
					models.add(goodsInfoModel);
				}
				msg.setObjs(models);
			}
			
		} catch (DBException e) {
			msg.setRspCode("000001").setRspMsg("数据库异常");
			log.error("goods获取失败",e);
		}
		
		return msg;
	}
	
	@Override
	public Pager getGoodsShortInfoList(Pager pages) {
		String tempkey= "";
		String condition_sql="";
		String countsql = "";
		//String sql  = "select t.goods_id ,t.goods_nm,CAST(t.AMOUNT/100 as DECIMAL(12,2)),t.classify,t.shop_id,b.shop_nm, c.url ";
		String sql  = "select t.goods_id ,t.goods_nm,t.amount,t.classify,t.shop_id,b.shop_nm, c.url, t.status,t.inst_dt ,t.store ,t.reason ";
		String csql = "from tbl_goods_info t"
				+ " left join tbl_shop_info b on t.shop_id=b.shop_id "
				+ " left join tbl_resources_info c on c.keyid=t.goods_id and c.type='01' where 1=1 ";
				
		//读取查找条件
		if(pages.getConditions().containsKey("keyword"))
		{
			try{
				tempkey=URLDecoder.decode(pages.getConditions().get("keyword"),"utf-8");//对中文参数进行解码
			}catch(Exception e){
			     e.printStackTrace();
			}
			if(!tempkey.equals(""))
			{
				log.info("关键字是keyword：［{}]",tempkey);
				pages.getConditions().put("keyword", tempkey);
				condition_sql= "and t.goods_nm like '%"
								+ tempkey
								+ "%' ";
			}
		}
	    if(pages.getConditions().containsKey("shopId")){
			tempkey=pages.getConditions().get("shopId");
//			pages.getConditions().put("shopId", tempkey);
			log.info("关键字是shopid：［{}]",tempkey);
			condition_sql += "and t.shop_id = '"+ tempkey + "'";			
		}
	    
	    if(pages.getConditions().containsKey("status")){
			tempkey=pages.getConditions().get("status");
//			pages.getConditions().put("shopId", tempkey);
			log.info("关键字是status：［{}]",tempkey);
			/*如果为9 则查询不等于上架状态的所有商品*/
			if(tempkey.equals("9"))
			{
				condition_sql += "and t.status <> '0' ";		
			}
			else{
				condition_sql += "and t.status = '"+ tempkey + "'";	
			}
		}else{
			condition_sql += "and t.status = '0' ";
		}
	    
	    countsql = "select count(*) " + csql +condition_sql;
		sql += csql +condition_sql;
		/*开始记录数*/
		int start = (pages.getStart() -1) * pages.getOffset();
		try {
			List count = baseDaoImpl.queryBySQL(countsql, null);
			Object objTotal=count.get(0);//记录总数
			Integer  num = Integer.parseInt(objTotal.toString());
			Integer pagecount = (num % pages.getOffset() == 0) ? num/pages.getOffset():num/pages.getOffset() + 1;
			
			List infos = baseDaoImpl.queryBySQL(sql, null,start ,pages.getOffset());
			if(infos.size()<1)
			{
				log.info("未查询到记录");
				pages.setRspCode("000002");
				pages.setRspMsg("未找到相关记录!");
			}
			else
			{
				List<GoodsInfoModel> models = new ArrayList<GoodsInfoModel>();
				for(Object object : infos){
					Object[] strs = (Object[])object;
					GoodsInfoModel goodsInfoModel = new GoodsInfoModel();
					goodsInfoModel.setGoodsId(strs[0]+"");
					goodsInfoModel.setGoodsNm(strs[1]+"");
					goodsInfoModel.setAmount(strs[2]+"");
					goodsInfoModel.setClassify(strs[3]+"");
					goodsInfoModel.setShopId(strs[4]+"");
					goodsInfoModel.setShopNm(strs[5]+"");
					goodsInfoModel.setMainPicUrl(strs[6]+"");
					goodsInfoModel.setStatus(strs[7]+"");
					goodsInfoModel.setInstDt(strs[8]+"");
					goodsInfoModel.setStore(strs[9]+"");
					goodsInfoModel.setReason(strs[10]+"");
					models.add(goodsInfoModel);
				}
				
				pages.setResult(models);
				pages.setPageCount(pagecount);
				pages.setTotal(num);
				pages.setRspCode("000000");
				pages.setRspMsg("成功!");
			}
		}catch (DBException e) {
			pages.setRspCode("000001");
			pages.setRspMsg("数据库异常");
		}
		return pages;
	}
	
	@Override
	@Transactional
	public Message addGoodsInfo(Map <String ,String> params) {
		log.info("开始保存商品信息，店铺编号为："+params.get("shopId"));
		Message msg = new Message();
		try {
			TblGoodsInfo goodsInfo =new TblGoodsInfo();
			UUID uuid =new UUID();
			String instDt =DateUtil.getCurrentDate(DateUtil.DATE_FORMAT_14);
	        String goodsId= uuid.getUUID();
	        String standardType = params.get("standardType");
	        log.info("商品编号为：[{}]",goodsId);
	        if(standardType.equals("0"))
			{
	        	log.info("商品规格类型为[默认]");
	        	}
	        else{
	        	log.info("商品规格类型为［单层]");
	        }
			
	        goodsInfo.setGoodsId(goodsId);
			goodsInfo.setGoodsNm(params.get("spuName"));
			goodsInfo.setShopId(params.get("shopId"));
			goodsInfo.setSpecial(params.get("advertorial"));
			goodsInfo.setClassify(params.get("dirId"));
			goodsInfo.setTypeId(standardType);
			goodsInfo.setContent(params.get("detailDesc"));
			goodsInfo.setYfId(params.get("tmpId"));
			goodsInfo.setStatus("0");
			goodsInfo.setInstDt(instDt);
			String filmPhotos = params.get("filmPhotos");
			
			JSONArray jsonArray = new JSONArray(filmPhotos);
			int iSize = jsonArray.length();
			log.info("商品图片数量为［{}]", iSize);
			for (int i = 0; i < iSize; i++) {
				JSONObject jsonObj = jsonArray.getJSONObject(i);
				TblResourcesInfo res = new TblResourcesInfo();
				res.setResid(uuid.getUUID());
				res.setKeyid(goodsId);
				if(jsonObj.getString("imgType").equals("1"))
				res.setType("01");
				else
				res.setType("02");
				res.setResnm(jsonObj.getString("orgFileNm"));
				res.setUrl(jsonObj.getString("filePath"));
				res.setNewFileNm(jsonObj.getString("fileNm"));
				res.setStatus("0");
				res.setInstDt(instDt);
				baseDaoImpl.save(res);
			}
			
			String skuList = params.get("skuList");
			
			JSONArray skuListArray = new JSONArray(skuList);
			iSize = skuListArray.length();
			log.info("商品型号数量为［{}]", iSize);
			//System.out.println("Size:" + iSize);
			int totalstore = 0;
			for (int i = 0; i < iSize; i++) {
				JSONObject jsonObj = skuListArray.getJSONObject(i);
				TblGoodsTypeInfo goodsType =new TblGoodsTypeInfo();
				goodsType.setTypeId(uuid.getUUID());
				goodsType.setGoodsId(goodsId);
				if(standardType.equals("0"))
				{
					goodsType.setTypeNm("默认");
				}
				else
				{
					goodsType.setTypeNm(jsonObj.getString("specification"));
				}
				goodsType.setKind("0");
				goodsType.setPrice(jsonObj.getString("skuPriceYuan"));
				goodsType.setStore(Integer.parseInt(jsonObj.getString("stockNum")));
				baseDaoImpl.save(goodsType);
				goodsInfo.setAmount(jsonObj.getString("skuPriceYuan"));
				totalstore+=Integer.parseInt(jsonObj.getString("stockNum"));
			}
			goodsInfo.setStore(totalstore);
			baseDaoImpl.save(goodsInfo);
			msg.setRspCode("000000").setRspMsg("成功!");
		} catch (DBException e) {
			msg.setRspCode("000001").setRspMsg("数据库异常");
			log.error("goods获取失败",e);
		} 
		log.info("保存商品信息结束，店铺编号为："+params.get("shopId"));
		return msg;
	}
	
	@Override
	@Transactional
	public Message editGoodsInfo(Map <String ,String> params) {
		log.info("开始编辑商品信息，店铺编号为：["+params.get("shopId")+"] 商品编号为：["+params.get("spuId")+"]");
		Message msg = new Message();
		try {
			TblGoodsInfo goodsInfo =new TblGoodsInfo();
			String goodsId =params.get("spuId");
			goodsInfo.setGoodsId(goodsId);
			String hql = "from TblGoodsInfo t where t.goodsId = ?";
			List infos = baseDaoImpl.queryByHQL(hql, new String[]{goodsInfo.getGoodsId()});
			if(infos.size()<1)
			{
				log.info("未查询到记录");
				msg.setRspCode("000002").setRspMsg("未找到相关记录!");
				return msg;
			}
			else
			{
				goodsInfo = (TblGoodsInfo)infos.get(0);
			}
			
			log.info("商品编号为［{}]", goodsInfo.getGoodsId());
			UUID uuid =new UUID();
			String standardType = params.get("standardType");
			if(standardType.equals("0"))
			{
	        	log.info("商品规格类型为[默认]");
	        	}
	        else{
	        	log.info("商品规格类型为［单层]");
	        }
			String modiDt =DateUtil.getCurrentDate(DateUtil.DATE_FORMAT_14);
			goodsInfo.setGoodsNm(params.get("spuName"));
			goodsInfo.setShopId(params.get("shopId"));
			goodsInfo.setSpecial(params.get("advertorial"));
			goodsInfo.setClassify(params.get("dirId"));
			goodsInfo.setTypeId(standardType);
			goodsInfo.setContent(params.get("detailDesc"));
			goodsInfo.setYfId(params.get("tmpId"));
			goodsInfo.setStatus("0");
			goodsInfo.setModiDt(modiDt);
			
			String filmPhotos = params.get("filmPhotos");
			
			/*删除商品图片*/
			String picsql = "delete from tbl_resources_info where keyid = '"+goodsId+"' and type in ('01','02')";
			baseDaoImpl.excuteSql(picsql, null);
			
			JSONArray jsonArray = new JSONArray(filmPhotos);
			int iSize = jsonArray.length();
			log.info("商品图片数量为［{}]", iSize);
			for (int i = 0; i < iSize; i++) {
				JSONObject jsonObj = jsonArray.getJSONObject(i);
				TblResourcesInfo res = new TblResourcesInfo();
				String resid = jsonObj.getString("fileResid");
				log.info("资源编号为［{}]", resid);
				if(resid.equals("")||resid.equals(null))
				{
					res.setResid(uuid.getUUID());
				}
				else
				{
					res.setResid(resid);
				}
				
				res.setKeyid(goodsId);
				if(jsonObj.getString("imgType").equals("1"))
				res.setType("01");
				else
				res.setType("02");
				res.setStatus("0");
				res.setResnm(jsonObj.getString("orgFileNm"));
				res.setNewFileNm(jsonObj.getString("fileNm"));
				res.setUrl(jsonObj.getString("filePath"));
				res.setModiDt(modiDt);
				baseDaoImpl.saveOrUpdate(res);
			}
			
			String sql = "delete from tbl_goods_type_info where goods_id = '"+goodsId+"' ";
			baseDaoImpl.excuteSql(sql, null);
			
			log.info("开始获取skuList");
			String skuList = params.get("skuList");
			//log.info("开始获取[{}]",skuList);
			JSONArray skuListArray = new JSONArray(skuList);
			iSize = skuListArray.length();
			log.info("商品型号数量为［{}]", iSize);
			//System.out.println("Size:" + iSize);
			int totalstore = 0;
			for (int i = 0; i < iSize; i++) {
				JSONObject jsonObj = skuListArray.getJSONObject(i);
				TblGoodsTypeInfo goodsType =new TblGoodsTypeInfo();
				goodsType.setTypeId(uuid.getUUID());
				goodsType.setGoodsId(goodsId);
				if(standardType.equals("0"))
				{
					goodsType.setTypeNm("默认");
				}
				else
				{
					goodsType.setTypeNm(jsonObj.getString("specification"));
				}
				goodsType.setKind("0");
				goodsType.setPrice(jsonObj.getString("skuPriceYuan"));
				goodsType.setStore(Integer.parseInt(jsonObj.getString("stockNum")));
				baseDaoImpl.save(goodsType);
				goodsInfo.setAmount(jsonObj.getString("skuPriceYuan"));
				totalstore+=Integer.parseInt(jsonObj.getString("stockNum"));
			}
			goodsInfo.setStore(totalstore);
			baseDaoImpl.saveOrUpdate(goodsInfo);
			msg.setRspCode("000000").setRspMsg("成功!");
		} catch (DBException e) {
			msg.setRspCode("000001").setRspMsg("数据库异常");
			log.error("goods获取失败",e);
		} 
		log.info("保存商品信息结束，店铺编号为：["+params.get("shopId")+"] 商品编号为：["+params.get("spuId")+"]");
		return msg;
	}
}
