package com.app.service.impl;

import java.util.ArrayList;
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
import com.app.common.utils.LTConstant;
import com.hlb.utils.date.DateUtil;
import com.hlb.utils.security.UUID;
import com.app.service.OrderService;
import com.app.service.SeqService;
import com.app.ReqModel.BuyCarOrder;
import com.app.ReqModel.BuyOrderReqModel;
import com.app.RspModel.OrderPayInfo;
import com.app.bean.TblBuyCarInfo;
import com.app.bean.TblOrderGoodsInfo;
import com.app.bean.TblOrderInfo;
import com.app.model.OrderGoodsModel;
import com.app.model.OrderListModel;
@Service
public class OrderServiceImpl implements OrderService {
	private Logger log = LoggerFactory.getLogger(this.getClass());
	@Resource
	private BaseDao baseDaoImpl;
	
	@Resource
	private SeqService seqServiceImpl;
	
	@SuppressWarnings("unchecked")
	@Override
	@Transactional
	public Pager getUserOrderListInfo(Pager pages,String uid) {
		log.info("获取order所有信息");
		
		try {
			
			String countsql = "select count(*) from TblOrderInfo t where 1=1 and t.userId = ? and ordSta <>'99' ";
			String hql = "from TblOrderInfo t where t.userId = ? and ordSta <>'99' order by t.applyDt desc";
			
			/*开始记录数*/
			int start = (pages.getStart() -1) * pages.getOffset();
			List count = baseDaoImpl.queryByHQL(countsql, new Object[]{uid});
			Object objTotal=count.get(0);//记录总数
			Integer  num = Integer.parseInt(objTotal.toString());
			Integer pagecount = (num % pages.getOffset() == 0) ? num/pages.getOffset():num/pages.getOffset() + 1;
			
			List infos = baseDaoImpl.queryByHQL(hql, new Object[]{uid},start ,pages.getOffset());
			if(infos.size()<1)
			{
				log.info("未查询到记录");
				pages.setRspCode("000002");
				pages.setRspMsg("未找到相关记录!");
			}
			else
			{
				pages.setRspCode("000000");
				pages.setRspMsg("成功!");
				pages.setResult(infos);
				pages.setPageCount(pagecount);
				pages.setTotal(num);
			}
			
		} catch (DBException e) {
			pages.setRspCode("000001");
			pages.setRspMsg("数据库异常");
		}
		
		return pages;
	}
	
	@SuppressWarnings("unchecked")
	@Override
	@Transactional
	public Pager getMerOrderListInfo(Pager pages) {
		log.info("获取order所有信息");
		
		try {
			String tempkey= "";
			String countsql = "select count(*) from TblOrderInfo t where 1=1 ";
			String hql = "from TblOrderInfo t where 1=1 ";
			String contion = "";
			
			if(pages.getConditions().containsKey("shopId")){
				tempkey=pages.getConditions().get("shopId");
//					pages.getConditions().put("shopId", tempkey);
				log.info("关键字是shopid：［{}]",tempkey);
				contion += "and t.shopId = '"+ tempkey + "'";			
			}
			contion += " order by t.applyDt desc";
			countsql += contion;
			hql += contion;
			/*开始记录数*/
			int start = (pages.getStart() -1) * pages.getOffset();
			List count = baseDaoImpl.queryByHQL(countsql, null);
			Object objTotal=count.get(0);//记录总数
			Integer  num = Integer.parseInt(objTotal.toString());
			Integer pagecount = (num % pages.getOffset() == 0) ? num/pages.getOffset():num/pages.getOffset() + 1;
			
			List infos = baseDaoImpl.queryByHQL(hql, null,start ,pages.getOffset());
			if(infos.size()<1)
			{
				log.info("未查询到记录");
				pages.setRspCode("000002");
				pages.setRspMsg("未找到相关记录!");
			}
			else
			{
				pages.setRspCode("000000");
				pages.setRspMsg("成功!");
				pages.setResult(infos);
				pages.setPageCount(pagecount);
				pages.setTotal(num);
			}
			
		} catch (DBException e) {
			pages.setRspCode("000001");
			pages.setRspMsg("数据库异常");
		}
		
		return pages;
	}
	
	@SuppressWarnings("static-access")
	@Override
	@Transactional
	public Message getOrderGoodsByOrderId(Map <String ,String> params) {
		log.info("订单信息：为［{}]",params.get("orderId"));
		Message msg = new Message();
		
		try {
			String hql = "from TblOrderGoodsInfo t where t.orderId = ? ";
			List infos = baseDaoImpl.queryByHQL(hql, new Object[]{params.get("orderId")});
			if(infos.size()<1)
			{
				log.info("未查询到记录");
				msg.setRspCode("000002");
				msg.setRspMsg("未找到相关记录!");
			}
			else
			{
				msg.setRspCode("000000");
				msg.setRspMsg("成功!");
				msg.setObjs(infos);
			}
			
		} catch (DBException e) {
			msg.setRspCode("000001");
			msg.setRspMsg("数据库异常");
		}
		return msg;
	}
	
	@SuppressWarnings("static-access")
	@Override
	@Transactional
	public Message getOrderGoodsShortInfoByOrderId(String orderId) {
		log.info("订单信息：为［{}]",orderId);
		Message msg = new Message();
		
		try {
			String sql2  = "select t.order_id,t.goods_id,t.goods_nm,c.url,t.type_id,t.type_nm,t.buynum,t.price,t.total_amt ,t.shop_id,t.shop_nm ";
			String csql2 = "from tbl_order_goods_info t "
					+ " left join tbl_resources_info c on c.keyid=t.goods_id and c.type='01' where t.order_id=? ";
			sql2 += csql2;
			
			List childinfos = baseDaoImpl.queryBySQL(sql2, new String[]{orderId});
			if(childinfos.size()>0)
			{
				List<OrderGoodsModel> models2 = new ArrayList<OrderGoodsModel>();
				for(Object object2 : childinfos){
					Object[] strs = (Object[])object2;
					OrderGoodsModel orderGoodsModel = new OrderGoodsModel();
					orderGoodsModel.setOrderId(strs[0]+"");
					orderGoodsModel.setGoodsId(strs[1]+"");
					orderGoodsModel.setGoodsNm(strs[2]+"");
					orderGoodsModel.setMainPicUrl(strs[3]+"");
					orderGoodsModel.setTypeId(strs[4]+"");
					orderGoodsModel.setTypeNm(strs[5]+"");
					orderGoodsModel.setBuynum(strs[6]+"");
					orderGoodsModel.setPrice(strs[7]+"");
					orderGoodsModel.setTotalAmt(strs[8]+"");
					orderGoodsModel.setShopId(strs[9]+"");
					orderGoodsModel.setShopNm(strs[10]+"");
					models2.add(orderGoodsModel);
				}
				msg.setRspCode("000000").setRspMsg("成功!");
				msg.setObjs(models2);
			}
		} catch (DBException e) {
			msg.setRspCode("000001");
			msg.setRspMsg("数据库异常");
		}
		return msg;
	}
	
	@SuppressWarnings("static-access")
	@Override
	@Transactional
	public Message getOrderInfoByOrderId(TblOrderInfo orderInfo) {
		
		//log.info("获取订单信息：orderid为［{}]",orderInfo.getOrderId());
		Message msg = new Message();
		try {
			
			String hql = "from TblOrderInfo t where t.orderId=? ";
			List infos = baseDaoImpl.queryByHQL(hql, new Object[]{orderInfo.getOrderId()});
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
			log.error("获取订单信息失败，订单为[{}]",orderInfo.getOrderId(),e);
		}
		
		return msg;
	}
	
	@SuppressWarnings("static-access")
	@Override
	@Transactional
	public Message saveOrderInfo(Map <String ,String> params) {
		
		log.info("增加订单信息：为［{}]");
		Message msg = new Message();
		
		
		UUID uuid =new UUID();		
		try {
			
			String orderShopList = params.get("orderShop");
			log.info("orderShopList为［{}]", orderShopList);
			
			TblOrderInfo orderInfo =new TblOrderInfo();
			String orderId=uuid.getUUID();
			String orderDt = DateUtil.getCurrentDate(DateUtil.DATE_FORMAT_14);
			
			JSONArray jsonArray = new JSONArray(orderShopList);
			int iSize = jsonArray.length();
			log.info("店铺数量为［{}]", iSize);
			for (int i = 0; i < iSize; i++) {
				JSONObject shopObj = jsonArray.getJSONObject(i);
				
				orderInfo.setOrderId(orderId);
				orderInfo.setUserId(params.get("userId"));
				orderInfo.setUserNm(params.get("username"));
				
				orderInfo.setShopId(shopObj.getString("shopId"));
				orderInfo.setShopNm(shopObj.getString("shopNm"));
				orderInfo.setTotalNum(shopObj.getString("totalNum"));
				orderInfo.setGoodsAmt(shopObj.getString("goodsAmt"));
				orderInfo.setYfAmt(shopObj.getString("yfAmt"));
				orderInfo.setTotalAmt(shopObj.getString("totalAmt"));
				orderInfo.setPayAmt(shopObj.getString("payAmt"));
				orderInfo.setBuyerMsg(shopObj.getString("buyerMsg"));
				
				orderInfo.setApplyDt(orderDt);
				orderInfo.setAutoDt(DateUtil.getOffSizeDateTime(orderDt,"1"));
				orderInfo.setAddrs(params.get("addrs"));
				orderInfo.setPerson(params.get("person"));
				orderInfo.setMobile(params.get("mobile"));
				orderInfo.setOrdSta("01");
				orderInfo.setPaySta("01");
				orderInfo.setInstDt(orderDt);
				
			}
			
			baseDaoImpl.save(orderInfo);
			
			String orderGoodsList = params.get("orderGoods");
			JSONArray goodsArray = new JSONArray(orderGoodsList);
			int GoodsSize = goodsArray.length();
			log.info("商品数量为［{}]", GoodsSize);
			log.info("orderGoodsList为［{}]", orderGoodsList);
			for (int j = 0; j < iSize; j++) {
				JSONObject goodsObj = goodsArray.getJSONObject(j);
				TblOrderGoodsInfo orderGoods =new TblOrderGoodsInfo();
				orderGoods.setSeqId(uuid.getUUID());
				orderGoods.setOrderId(orderId);
				orderGoods.setShopId(goodsObj.getString("shopId"));
				orderGoods.setShopNm(goodsObj.getString("shopNm"));
				orderGoods.setGoodsId(goodsObj.getString("goodsId"));
				orderGoods.setGoodsNm(goodsObj.getString("goodsNm"));
				orderGoods.setTypeId(goodsObj.getString("typeId"));
				orderGoods.setTypeNm(goodsObj.getString("typeNm"));
				orderGoods.setBuynum(goodsObj.getString("buyNum"));
				orderGoods.setPrice(goodsObj.getString("goodsPrice"));
				orderGoods.setTotalAmt(goodsObj.getString("goodsTotalAmt"));
				orderGoods.setInstDt(orderDt);
				baseDaoImpl.save(orderGoods);
			}
			
			msg.setRspCode("000000").setRspMsg("增加成功！");
			msg.setObjs(orderInfo);
		} catch (DBException e) {
			msg.setRspCode("000001").setRspMsg("数据库异常");
		//	log.error("订单信息提交失败，店铺名为[{}]",orderInfo.getShopId(),e);
		}
		
		return msg;
	}
	
	@SuppressWarnings("static-access")
	@Override
	@Transactional
	public Message updateOrderInfo(TblOrderInfo orderInfo,String uid) {
		
		log.info("更新地址信息：orderid为［{}]",orderInfo.getOrderId());
		Message msg = new Message();
//		try {
//			
////			 String sql = "update tbl_orderess_info set "
////			 		+ "provice = ? , city = ? ,  zone = ? ,orderess =? ,consignee =?, mobile=?, isMain =? "
////			 		+ "where order_id = ? and user_id =? ";
////				
////			
////			
////			baseDaoImpl.excuteSql(sql, new Object[]{orderInfo.getProvice(),orderInfo.getCity(),orderInfo.getZone(),
////					orderInfo.getOrder(),orderInfo.getConsignee(),orderInfo.getMobile(),orderInfo.getIsMain(),orderInfo.getOrderId(),uid});
////	
////			
//		} catch (DBException e) {
//			msg.setRspCode("000001").setRspMsg("更新用户信息失败");
//			e.printStackTrace();
//		}
		msg.setRspCode("000000").setRspMsg("更新用户信息成功！");
		
		return msg;
	}
	
	@SuppressWarnings("static-access")
	@Override
	@Transactional
	public void updateOrderInfoBySetTime() {
		
		log.info("开始扫描订单表数据，包含未支付、未确认订单数据...");
		
		String orderId = "";
		String ordSta = "";
		String autoDt = "";
		try {
			String sql = "select t.order_id,t.ord_sta, t.auto_dt from tbl_order_info t where t.ord_sta in ('01','03') ";
			List<Object> infos = baseDaoImpl.queryBySQL(sql,null);
			if(infos.size()<1)
			{
				log.info("没有要处理的订单...");
				return;
			}
			for(Object object : infos){
				Object[] strs = (Object[])object;
				orderId=strs[0]+"";
				ordSta=strs[1]+"";
				autoDt=strs[2]+"";
				String nowDt =DateUtil.getCurrentDate(DateUtil.DATE_FORMAT_14);
				log.info("目前处理信息为：［{}][{}]",orderId,nowDt);
//				DateUtil.compare_date(nowDt, autoDt);
				
				if(DateUtil.compare_date(nowDt, autoDt)<0)
				{
					log.info("订单未超时［{}][{}]",nowDt,autoDt);
					continue;
				}
				
				if(ordSta.equals("01"))
				{
					String sql1 = "update tbl_order_info t set "
					 		+ "t.close_dt=? , t.ord_sta = '05' where t.order_id = ?";
					baseDaoImpl.excuteSql(sql1, new Object[]{nowDt,orderId});
				}
				else if(ordSta.equals("03"))
				{
					String sql1 = "update tbl_order_info t set "
					 		+ "t.confirm_dt=? , t.ord_sta = '04' where t.order_id = ?";
					baseDaoImpl.excuteSql(sql1, new Object[]{nowDt,orderId});
				}else
				{
					continue;
				}
			}
//			String sql = "update tbl_orderess_info set "
//			 		+ "provice = ? , city = ? ,  zone = ? ,orderess =? ,consignee =?, mobile=?, isMain =? "
//			 		+ "where order_id = ? and user_id =? ";
//				
		} catch (DBException e) {
			
			e.printStackTrace();
		}
		
		return ;
	}

	@Override
	public Pager getUserOrderList(Pager pages, String userId) {
		
		log.info("获取order所有信息");
		
		try {
			
			String tempkey= "";
			String condition_sql="";
			String countsql = "";
			String sql  = " ";
			String csql = " from TblOrderInfo t where t.userId =? ";
			
			//读取查找条件
			if(pages.getConditions().containsKey("ordSta"))
			{
				tempkey=pages.getConditions().get("ordSta");
				if(!tempkey.equals(""))
				{
					log.info("订单状态为：［{}]",tempkey);
					condition_sql= "and t.ordSta = '" + tempkey + "' ";
				}
			}
			
			condition_sql += "and t.delFlag <> '" + LTConstant.ORDER_BUYER_DEL + "' ";
			
			condition_sql += " order by t.applyDt desc";
			
			countsql = "select count(*) " + csql +condition_sql;
			sql += csql +condition_sql;
			
			/*开始记录数*/
			int start = (pages.getStart() -1) * pages.getOffset();
			List count = baseDaoImpl.queryByHQL(countsql, new Object[]{userId});
			Object objTotal=count.get(0);//记录总数
			Integer  num = Integer.parseInt(objTotal.toString());
			Integer pagecount = (num % pages.getOffset() == 0) ? num/pages.getOffset():num/pages.getOffset() + 1;
			
			List infos = baseDaoImpl.queryByHQL(sql, new Object[]{userId},start ,pages.getOffset());
			if(infos.size()<1)
			{
				log.info("未查询到记录");
				pages.setRspCode("000002");
				pages.setRspMsg("未找到相关记录!");
			}
			else
			{
				List<OrderListModel> models = new ArrayList<OrderListModel>();
				for(Object object : infos){
					OrderListModel model = new OrderListModel();
					TblOrderInfo order = new TblOrderInfo();
					order=(TblOrderInfo)object;
					model.setOrderId(order.getOrderId());
					model.setApplyDt(order.getApplyDt());
					model.setPayDt(order.getPayDt());
					model.setOutDt(order.getOutDt());
					model.setConfirmDt(order.getConfirmDt());
					model.setCloseDt(order.getCloseDt());
					model.setAutoDt(order.getAutoDt());
					model.setUserId(order.getUserId());
					model.setUserNm(order.getUserNm());
					model.setShopId(order.getShopId());
					model.setShopNm(order.getShopNm());
					model.setTotalNum(order.getTotalNum());
					model.setGoodsAmt(order.getGoodsAmt());
					model.setYfAmt(order.getYfAmt());
					model.setTotalAmt(order.getTotalAmt());
					model.setBuyerMsg(order.getBuyerMsg());
					model.setSalerMsg(order.getSalerMsg());
					model.setPayAmt(order.getPayAmt());
					model.setAddrs(order.getAddrs());
					model.setPerson(order.getPerson());
					model.setMobile(order.getMobile());
					model.setOrdSta(order.getOrdSta());
					model.setPaySta(order.getPaySta());
					model.setPaySeq(order.getPaySeq());
					model.setPayChannle(order.getPayChannle());
					model.setExpress(order.getExpress());
					model.setExpressNo(order.getExpressNo());
					
					String sql2  = "select t.order_id,t.goods_id,t.goods_nm,c.url,t.type_id,t.type_nm,t.buynum,t.price,t.total_amt ";
					String csql2 = "from tbl_order_goods_info t "
							+ " left join tbl_resources_info c on c.keyid=t.goods_id and c.type='01' where t.order_id=? ";
					sql2 += csql2;
					
					List childinfos = baseDaoImpl.queryBySQL(sql2, new String[]{order.getOrderId()});
					if(childinfos.size()>0)
					{
						List<OrderGoodsModel> models2 = new ArrayList<OrderGoodsModel>();
						for(Object object2 : childinfos){
							Object[] strs = (Object[])object2;
							OrderGoodsModel orderGoodsModel = new OrderGoodsModel();
							orderGoodsModel.setOrderId(strs[0]+"");
							orderGoodsModel.setGoodsId(strs[1]+"");
							orderGoodsModel.setGoodsNm(strs[2]+"");
							orderGoodsModel.setMainPicUrl(strs[3]+"");
							orderGoodsModel.setTypeId(strs[4]+"");
							orderGoodsModel.setTypeNm(strs[5]+"");
							orderGoodsModel.setBuynum(strs[6]+"");
							orderGoodsModel.setPrice(strs[7]+"");
							orderGoodsModel.setTotalAmt(strs[8]+"");
							models2.add(orderGoodsModel);
						}
						
						model.setGoodsList(models2);;
					}
					
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
		}
		
		return pages;
	}
	
	@Override
	public Pager getMerOrderList(Pager pages) {
		
		log.info("获取商家order所有信息");
		
		try {
			
			String tempkey= "";
			String condition_sql="";
			String countsql = "";
			String sql  = " ";
			String csql = " from TblOrderInfo t where 1=1 ";
			
			//读取查找条件
			if(pages.getConditions().containsKey("ordSta"))
			{
				tempkey=pages.getConditions().get("ordSta");
				if(!tempkey.equals("99"))
				{
					log.info("订单状态为：［{}]",tempkey);
					condition_sql= "and t.ordSta = '" + tempkey + "' ";
				}
			}
			
			if(pages.getConditions().containsKey("shopId")){
				tempkey=pages.getConditions().get("shopId");
				log.info("关键字是shopid：［{}]",tempkey);
				condition_sql += "and t.shopId = '"+ tempkey + "'";			
			}
			
			condition_sql += "and t.delFlag <> '" + LTConstant.ORDER_SALER_DEL + "' ";
			
			condition_sql += " order by t.applyDt desc";
			
			countsql = "select count(*) " + csql +condition_sql;
			sql += csql +condition_sql;
			
			/*开始记录数*/
			int start = (pages.getStart() -1) * pages.getOffset();
			List count = baseDaoImpl.queryByHQL(countsql, null);
			Object objTotal=count.get(0);//记录总数
			Integer  num = Integer.parseInt(objTotal.toString());
			Integer pagecount = (num % pages.getOffset() == 0) ? num/pages.getOffset():num/pages.getOffset() + 1;
			
			List infos = baseDaoImpl.queryByHQL(sql, null,start ,pages.getOffset());
			if(infos.size()<1)
			{
				log.info("未查询到记录");
				pages.setRspCode("000002");
				pages.setRspMsg("未找到相关记录!");
			}
			else
			{
				List<OrderListModel> models = new ArrayList<OrderListModel>();
				for(Object object : infos){
					OrderListModel model = new OrderListModel();
					TblOrderInfo order = new TblOrderInfo();
					order=(TblOrderInfo)object;
					model.setOrderId(order.getOrderId());
					model.setApplyDt(order.getApplyDt());
					model.setPayDt(order.getPayDt());
					model.setOutDt(order.getOutDt());
					model.setConfirmDt(order.getConfirmDt());
					model.setCloseDt(order.getCloseDt());
					model.setAutoDt(order.getAutoDt());
					model.setUserId(order.getUserId());
					model.setUserNm(order.getUserNm());
					model.setShopId(order.getShopId());
					model.setShopNm(order.getShopNm());
					model.setTotalNum(order.getTotalNum());
					model.setGoodsAmt(order.getGoodsAmt());
					model.setYfAmt(order.getYfAmt());
					model.setTotalAmt(order.getTotalAmt());
					model.setBuyerMsg(order.getBuyerMsg());
					model.setSalerMsg(order.getSalerMsg());
					model.setPayAmt(order.getPayAmt());
					model.setAddrs(order.getAddrs());
					model.setPerson(order.getPerson());
					model.setMobile(order.getMobile());
					model.setOrdSta(order.getOrdSta());
					model.setPaySta(order.getPaySta());
					model.setPaySeq(order.getPaySeq());
					model.setPayChannle(order.getPayChannle());
					model.setExpress(order.getExpress());
					model.setExpressNo(order.getExpressNo());
					
					String sql2  = "select t.order_id,t.goods_id,t.goods_nm,c.url,t.type_id,t.type_nm,t.buynum,t.price,t.total_amt ";
					String csql2 = "from tbl_order_goods_info t "
							+ " left join tbl_resources_info c on c.keyid=t.goods_id and c.type='01' where t.order_id=? ";
					sql2 += csql2;
					
					List childinfos = baseDaoImpl.queryBySQL(sql2, new String[]{order.getOrderId()});
					if(childinfos.size()>0)
					{
						List<OrderGoodsModel> models2 = new ArrayList<OrderGoodsModel>();
						for(Object object2 : childinfos){
							Object[] strs = (Object[])object2;
							OrderGoodsModel orderGoodsModel = new OrderGoodsModel();
							orderGoodsModel.setOrderId(strs[0]+"");
							orderGoodsModel.setGoodsId(strs[1]+"");
							orderGoodsModel.setGoodsNm(strs[2]+"");
							orderGoodsModel.setMainPicUrl(strs[3]+"");
							orderGoodsModel.setTypeId(strs[4]+"");
							orderGoodsModel.setTypeNm(strs[5]+"");
							orderGoodsModel.setBuynum(strs[6]+"");
							orderGoodsModel.setPrice(strs[7]+"");
							orderGoodsModel.setTotalAmt(strs[8]+"");
							models2.add(orderGoodsModel);
						}
						
						model.setGoodsList(models2);
					}
					
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
		}
		
		return pages;
	}

	@Override
	@Transactional
	public Message saveOrderInfoByCar(BuyCarOrder model, String userId,String userNm) {
		Message msg = new Message();
		try {
			log.info("增加订单信息:CarIdList为［{}]", model.getCarIdList());
			String[] CarIdList = model.getCarIdList().split(",");
			String CarId ="";
			TblOrderInfo orderInfo =new TblOrderInfo();
			String orderDt = DateUtil.getCurrentDate(DateUtil.DATE_FORMAT_14);
			String orderId=orderDt+seqServiceImpl.getSeqNo("seq_id");
			orderInfo.setOrderId(orderId);
			orderInfo.setSendChannle(model.getSendChannel());
			orderInfo.setUserId(userId);
			orderInfo.setUserNm(userNm);
			orderInfo.setShopId(model.getShopId());
			orderInfo.setShopNm(model.getShopNm());
			orderInfo.setYfAmt(model.getYfAmt());
			orderInfo.setTotalAmt(model.getTotalAmt());
			orderInfo.setPayAmt(model.getPayAmt());
			orderInfo.setBuyerMsg(model.getBuyMsg());
			orderInfo.setApplyDt(orderDt);
			orderInfo.setAutoDt(DateUtil.getOffSizeDateTime(orderDt,"1"));
			
			orderInfo.setAddrs(model.getAddress());
			orderInfo.setPerson(model.getPerson());
			orderInfo.setMobile(model.getMobile());
			orderInfo.setOrdSta(LTConstant.ORDER_WAIT_PAY);
			orderInfo.setPaySta(LTConstant.PAY_ING);
			orderInfo.setInstDt(orderDt);
			orderInfo.setDelFlag("0");
			int buyNum =0;
			int googsAmt=0;
			for (int i = 0 ; i <CarIdList.length ; i++ ) {
				CarId= CarIdList[i]; 
				
				String hql = "from TblBuyCarInfo t where t.seqId=? ";
				List infos = baseDaoImpl.queryByHQL(hql, new Object[]{CarId});
				if(infos.size()==1)
				{
					TblBuyCarInfo car = new TblBuyCarInfo();
					car = (TblBuyCarInfo)infos.get(0);
					TblOrderGoodsInfo orderGoods =new TblOrderGoodsInfo();
					String sql  = "select t.goods_id ,t.goods_nm,t.shop_id,b.shop_nm, t.type_id,c.type_nm ,c.price ";
					String csql =sql+ "from tbl_goods_info t"
							+ " left join tbl_shop_info b on t.shop_id=b.shop_id "
							+ " left join tbl_goods_type_info c on t.goods_id=c.goods_id where t.goods_id = ? and c.type_id =? ";
					
					List infos2 = baseDaoImpl.queryBySQL(csql, new String[]{car.getGoodsId(),car.getTypeId()});
					if(infos2.size()==1)
					{	
						for(Object object : infos2){
							Object[] strs = (Object[])object;
							orderGoods.setGoodsNm(strs[1]+"");
							orderGoods.setShopNm(strs[3]+"");
							orderGoods.setTypeNm(strs[5]+"");
							orderGoods.setPrice(strs[6]+"");
							Integer totalAmt = car.getBuyNum()*Integer.parseInt(strs[6]+"");
							orderGoods.setTotalAmt(totalAmt+"");
							googsAmt+=totalAmt;
						}
					}else{
						throw new DBException("");
					}
					orderGoods.setSeqId(UUID.getUUID());
					orderGoods.setOrderId(orderId);
					orderGoods.setShopId(model.getShopId());
					orderGoods.setGoodsId(car.getGoodsId());
					orderGoods.setTypeId(car.getTypeId());
					orderGoods.setBuynum(car.getBuyNum().toString());
					orderGoods.setInstDt(orderDt);
					baseDaoImpl.save(orderGoods);
					buyNum +=car.getBuyNum();
				}else{
					throw new DBException("");
				}
		    } 
			
			orderInfo.setTotalNum(buyNum+"");
			orderInfo.setGoodsAmt(googsAmt+"");
			baseDaoImpl.save(orderInfo);
			
			String seqList ="";
			for (int i = 0 ; i <CarIdList.length ; i++ ) {
				seqList+= "'"+CarIdList[i]+"',"; 
		    } 
			seqList = seqList.substring(0, seqList.length()-1);
			
			String sql1 = "delete from tbl_buy_car_info where seq_id in ("+seqList+") ";
			
			baseDaoImpl.excuteSql(sql1, null);
			
			msg.setRspCode("000000").setRspMsg("提交订单成功！");
			msg.setObjs(orderInfo);
		} catch (DBException e) {
			msg.setRspCode("000001").setRspMsg("数据库异常");
		}
		
		return msg;
	}


	@Override
	public Message getOrderPayInfo(String orderId, String userId) {
		
		Message msg = new Message();
		try {
			
			String hql = "from TblOrderInfo t where t.orderId=? ";
			List infos = baseDaoImpl.queryByHQL(hql, new Object[]{orderId});
			if(infos.size()==1)
			{
				OrderPayInfo pay = new OrderPayInfo();
				TblOrderInfo order = new TblOrderInfo();
				order =(TblOrderInfo)infos.get(0);
				pay.setOrderId(orderId);
				pay.setShopId(order.getShopId());
				pay.setShopNm(order.getShopNm());
				pay.setPayAmt(order.getPayAmt());
				pay.setOrderDesc("购买商品");
				pay.setOrderDt(order.getApplyDt());
				msg.setRspCode("000000").setRspMsg("成功!");
				msg.setObjs(pay);
			}
			else
			{
				throw new DBException("");
			}
		} catch (DBException e) {
			msg.setRspCode("000001").setRspMsg("数据库异常");
			log.error("获取订单信息失败，订单为[{}]",orderId,e);
		}
		return msg;
	}
	
	@SuppressWarnings("static-access")
	@Override
	@Transactional
	public Message saveNewOrder(BuyOrderReqModel model, String userId,String userNm) {
		
		log.info("增加订单信息：");
		Message msg = new Message();
		
		try {
			
			TblOrderInfo orderInfo =new TblOrderInfo();
			String orderDt = DateUtil.getCurrentDate(DateUtil.DATE_FORMAT_14);
			String orderId=orderDt+seqServiceImpl.getSeqNo("seq_id");
			orderInfo.setOrderId(orderId);
			orderInfo.setSendChannle(model.getSendChannel());
			orderInfo.setUserId(userId);
			orderInfo.setUserNm(userNm);
			orderInfo.setShopId(model.getShopId());
			orderInfo.setShopNm(model.getShopNm());
			orderInfo.setYfAmt(model.getYfAmt());
			orderInfo.setTotalAmt(model.getTotalAmt());
			orderInfo.setPayAmt(model.getPayAmt());
			orderInfo.setBuyerMsg(model.getBuyMsg());
			orderInfo.setApplyDt(orderDt);
			orderInfo.setAutoDt(DateUtil.getOffSizeDateTime(orderDt,"1"));
			
			orderInfo.setAddrs(model.getAddress());
			orderInfo.setPerson(model.getPerson());
			orderInfo.setMobile(model.getMobile());
			orderInfo.setOrdSta(LTConstant.ORDER_WAIT_PAY);
			orderInfo.setPaySta(LTConstant.PAY_ING);
			orderInfo.setInstDt(orderDt);
			orderInfo.setTotalNum(model.getTotalNum()+"");
			orderInfo.setDelFlag("0");
			String googsAmt = Integer.parseInt(model.getPrice())*model.getBuyNum()+"";
			orderInfo.setGoodsAmt(googsAmt);
			
			
			TblOrderGoodsInfo orderGoods =new TblOrderGoodsInfo();
			orderGoods.setSeqId(UUID.getUUID());
			orderGoods.setOrderId(orderId);
			orderGoods.setShopId(model.getShopId());
			orderGoods.setShopNm(model.getShopNm());
			orderGoods.setGoodsId(model.getGoodsId());
			orderGoods.setGoodsNm(model.getGoodsNm());
			orderGoods.setTypeId(model.getTypeId());
			orderGoods.setTypeNm(model.getTypeNm());
			orderGoods.setBuynum(model.getBuyNum()+"");
			orderGoods.setPrice(model.getPrice());
			orderGoods.setTotalAmt(googsAmt);
			orderGoods.setInstDt(orderDt);
			
			baseDaoImpl.save(orderInfo);
			baseDaoImpl.save(orderGoods);
			
			msg.setRspCode("000000").setRspMsg("增加成功！");
			msg.setObjs(orderInfo);
		} catch (DBException e) {
			msg.setRspCode("000001").setRspMsg("数据库异常");
		//	log.error("订单信息提交失败，店铺名为[{}]",orderInfo.getShopId(),e);
		}
		
		return msg;
	}

	@Override
	@Transactional
	public Message delOrderInfo(String orderId,String ordSta) {
		Message msg = new Message();
		try {
			
			TblOrderInfo orderInfo =new TblOrderInfo();
			orderInfo.setOrderId(orderId);
			
			String hql = "from TblOrderInfo t where t.orderId=? ";
			List infos = baseDaoImpl.queryByHQL(hql, new Object[]{orderInfo.getOrderId()});
			if(infos.size()<1)
			{
				log.info("未查询到记录");
				msg.setRspCode("000002").setRspMsg("未找到相关记录!");
			}
			else
			{
				orderInfo = (TblOrderInfo)infos.get(0);
				orderInfo.setDelFlag(ordSta);
				baseDaoImpl.update(orderInfo);
				msg.setRspCode("000000").setRspMsg("成功!");
			}
		} catch (DBException e) {
			msg.setRspCode("000001").setRspMsg("数据库异常");
			log.error("取消关注商品失败",e);
		}
		
		return msg;
	}
}
