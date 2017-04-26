package com.app.service.impl;

import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.List;

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
import com.app.model.BuyCarInfoModel;
import com.app.model.GoodsInfoModel;
import com.hlb.utils.date.DateUtil;
import com.hlb.utils.security.UUID;
import com.app.service.BuyCarService;
import com.app.service.SeqService;
import com.app.ReqModel.BuyCarOpertionModel;
import com.app.ReqModel.BuyCarOrder;
import com.app.ReqModel.CarIdListModel;
import com.app.ReqModel.ChangeBuyCarNum;
import com.app.bean.TblBuyCarInfo;
import com.hlb.utils.*;
@Service
public class BuyCarServiceImpl implements BuyCarService {
	private Logger log = LoggerFactory.getLogger(this.getClass());
	@Resource
	private BaseDao baseDaoImpl;
	
	@Resource
	private SeqService seqServiceImpl;
	
	@Override
	public Pager getBuyCarList(Pager pages, String userId) {
		
		log.info("获取购物车信息，UserId为［{}]",userId);
		String tempkey= "";
		String condition_sql="";
		String countsql = "";
		
		try {
			
			String sql  = "select t.goods_id ,b.goods_nm,b.amount,c.url as mainPicUrl,t.shop_id,s.shop_nm, t.buy_num ,t.type_id,p.type_nm ,t.seq_id ";
			String csql = " from tbl_buy_car_info t "
					+ " left join tbl_goods_info b on t.goods_id=b.goods_id "
					+ " left join tbl_shop_info s on t.shop_id=s.shop_id "
					+ " left join tbl_goods_type_info p on t.type_id=p.type_id "
					+ " left join tbl_resources_info c on c.keyid=t.goods_id and c.type='01' where t.user_id = ? ";
			
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
					condition_sql= "and b.goods_nm like '%"
									+ tempkey
									+ "%' ";
				}
			}
			
			condition_sql+=" order by t.shop_id ";
			
			countsql = "select count(*) " + csql +condition_sql;
			sql += csql +condition_sql;
			/*开始记录数*/
			int start = (pages.getStart() -1) * pages.getOffset();
			
			List count = baseDaoImpl.queryBySQL(countsql, new String[]{userId});
			Object objTotal=count.get(0);//记录总数
			Integer  num = Integer.parseInt(objTotal.toString());
			Integer pagecount = (num % pages.getOffset() == 0) ? num/pages.getOffset():num/pages.getOffset() + 1;
			
			List infos = baseDaoImpl.queryBySQL(sql,  new String[]{userId},start ,pages.getOffset());
			
			if(infos.size()<1)
			{
				log.info("未查询到记录");
				pages.setRspCode("000002");
				pages.setRspMsg("未找到相关记录!");
			}
			else
			{
				List<BuyCarInfoModel> models = new ArrayList<BuyCarInfoModel>();
				for(Object object : infos){
					Object[] strs = (Object[])object;
					BuyCarInfoModel model = new BuyCarInfoModel();
					model.setGoodsId(strs[0]+"");
					model.setGoodsNm(strs[1]+"");
					model.setAmount(strs[2]+"");
					model.setMainPicUrl(strs[3]+"");
					model.setShopId(strs[4]+"");
					model.setShopNm(strs[5]+"");
					model.setBuyNum((Integer)strs[6]);
					model.setTypeId(strs[7]+"");
					model.setTypeNm(strs[8]+"");
					model.setSeqId(strs[9]+"");
					models.add(model);
				}
				pages.setResult(models);
				pages.setPageCount(pagecount);
				pages.setTotal(num);
				pages.setRspCode("000000");
				pages.setRspMsg("成功!");
			}
			
		} catch (DBException e) {
			pages.setRspCode("000001");
			pages.setRspMsg("数据库异常");
			log.error("enter获取失败",e);
		}
		
		return pages;
	}
	
	@Override
	@Transactional
	public Message saveBuyCarInfo(BuyCarOpertionModel model, String userId) {

		Message msg = new Message();
		try {
			TblBuyCarInfo car = new TblBuyCarInfo();
			String seqId ="";
			String timeDt=DateUtil.getCurrentDate(DateUtil.DATE_FORMAT_14);
			seqId +=timeDt+seqServiceImpl.getSeqNo("seq_id");
			car.setSeqId(seqId);
			car.setInstDt(timeDt);
			car.setUserId(userId);
			car.setShopId(model.getShopId());
			car.setGoodsId(model.getGoodsId());
			car.setTypeId(model.getTypeId());
			car.setBuyNum(model.getBuyNum());
			baseDaoImpl.save(car);
			msg.setRspCode("000000").setRspMsg("添加购物车成功！");
		} catch (DBException e) {
			msg.setRspCode("000001").setRspMsg("数据库异常");
			log.error("添加购物车失败",e);
		}
		
		return msg;
	}
	
	
	@Override
	@Transactional
	public Message delBuyCarInfo(BuyCarOpertionModel model, String userId) {
		
		log.info("删除购物车商品开始");
		Message msg = new Message();
		try {
			String sql  = "delete from  tbl_buy_car_info where goods_id = ? and type_id=? and user_id =? ";
			
			baseDaoImpl.excuteSql(sql, new String[]{model.getGoodsId(),model.getTypeId(),userId});
			
			msg.setRspCode("000000").setRspMsg("删除购物车商品成功！");
		} catch (DBException e) {
			msg.setRspCode("000001").setRspMsg("数据库异常");
			log.error("删除购物车商品失败",e);
		}
		log.info("删除购物车商品结束");
		return msg;
	}

	@Override
	@Transactional
	public Message changeBuyCarNum(ChangeBuyCarNum model, String userId) {
		log.info("更新购物车商品数量开始");
		Message msg = new Message();
		try {
			
			String hql="";
			List infos =null;
			String seqList="";
			JSONArray jsonArray = new JSONArray(model.getBuyCarOrder());
			int iSize = jsonArray.length();
			log.info("选中购物车数量为［{}]", iSize);
			for (int i = 0; i < iSize; i++) {
				JSONObject jsonObj = jsonArray.getJSONObject(i);
				TblBuyCarInfo car = new TblBuyCarInfo();
				car.setSeqId(jsonObj.getString("seqId"));
				hql = "from TblBuyCarInfo t where t.seqId= ? and t.userId= ? ";
				infos = baseDaoImpl.queryByHQL(hql, new String[]{car.getSeqId(),userId});
				if(infos.size()==1)
				{
					car=(TblBuyCarInfo)infos.get(0);
					car.setBuyNum(jsonObj.getInt("buyNum"));
					baseDaoImpl.save(car);
					msg.setRspCode("000000").setRspMsg("成功!");
					seqList+=car.getSeqId()+",";
				}else{
					msg.setRspCode("000002").setRspMsg("数据异常!");
					return msg;
				}
			}
			seqList = seqList.substring(0,seqList.length()-1);
			msg.setObjs(seqList);
		} catch (DBException e) {
			msg.setRspCode("000001").setRspMsg("数据库异常");
			log.error("删除购物车商品失败",e);
		}
		log.info("更新购物车商品数量结束");
		
		return msg;
	}

	@Override
	public Message getBuyCarListByCarId(CarIdListModel car) {
		
		Message msg = new Message();
		log.info("获取购物车信息，carId为［{}]",car.getCarIdList());
		String condition_sql="";
		try {
			
			String[] aa = car.getCarIdList().split(",");
			String seqList ="";
			for (int i = 0 ; i <aa.length ; i++ ) {
				seqList+= "'"+aa[i]+"',"; 
		    } 
			seqList = seqList.substring(0, seqList.length()-1);
			String sql  = "select t.goods_id ,b.goods_nm,b.amount,c.url as mainPicUrl,t.shop_id,s.shop_nm, t.buy_num ,t.type_id,p.type_nm ,t.seq_id ";
			String csql = " from tbl_buy_car_info t "
					+ " left join tbl_goods_info b on t.goods_id=b.goods_id "
					+ " left join tbl_shop_info s on t.shop_id=s.shop_id "
					+ " left join tbl_goods_type_info p on t.type_id=p.type_id "
					+ " left join tbl_resources_info c on c.keyid=t.goods_id and c.type='01' where t.seq_id in ( "+seqList+" )";
			
			condition_sql+=" order by t.shop_id ";
			
			sql += csql +condition_sql;
			
			List infos = baseDaoImpl.queryBySQL(sql,  null);
			
			if(infos.size()<1)
			{
				log.info("未查询到记录");
				msg.setRspCode("000002");
				msg.setRspMsg("未找到相关记录!");
			}
			else
			{
				List<BuyCarInfoModel> models = new ArrayList<BuyCarInfoModel>();
				for(Object object : infos){
					Object[] strs = (Object[])object;
					BuyCarInfoModel model = new BuyCarInfoModel();
					model.setGoodsId(strs[0]+"");
					model.setGoodsNm(strs[1]+"");
					model.setAmount(strs[2]+"");
					model.setMainPicUrl(strs[3]+"");
					model.setShopId(strs[4]+"");
					model.setShopNm(strs[5]+"");
					model.setBuyNum((Integer)strs[6]);
					model.setTypeId(strs[7]+"");
					model.setTypeNm(strs[8]+"");
					model.setSeqId(strs[9]+"");
					models.add(model);
				}
				msg.setRspCode("000000");
				msg.setRspMsg("成功!");
				msg.setObjs(models);
			}
			
		} catch (DBException e) {
			msg.setRspCode("000001");
			msg.setRspMsg("数据库异常");
			log.error("enter获取失败",e);
		}
		
		return msg;
	}
}
