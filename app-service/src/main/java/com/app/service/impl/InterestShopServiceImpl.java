package com.app.service.impl;

import java.net.URLDecoder;
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
import com.app.common.model.Pager;
import com.app.model.ShopInfoModel;
import com.hlb.utils.date.DateUtil;
import com.hlb.utils.security.UUID;
import com.app.service.InterestShopService;
import com.app.bean.TblInterestShopInfo;

@Service
public class InterestShopServiceImpl implements InterestShopService {
	private Logger log = LoggerFactory.getLogger(this.getClass());
	@Resource
	private BaseDao baseDaoImpl;
	
	@Override
	@Transactional
	public Pager getInterestShopInfo(String UserId, Pager pages) {
		log.info("获取Interestgoods信息，UserId为［{}]",UserId);
		String tempkey= "";
		String condition_sql="";
		String countsql = "";
		
		try {
			
			String sql  = "select t.shop_id, b.shop_nm,c.url as logoUrl ";
			String csql = " from tbl_interest_shop_info t "
					+ " left join tbl_shop_info b on t.shop_id=b.shop_id "
					+ " left join tbl_resources_info c on c.resid=b.logo and c.type='05' where t.user_id = ? ";
			
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
					condition_sql= "and b.shop_nm like '%"
									+ tempkey
									+ "%' ";
				}
			}
			
			countsql = "select count(*) " + csql +condition_sql;
			sql += csql +condition_sql;
			/*开始记录数*/
			int start = (pages.getStart() -1) * pages.getOffset();
			
			List count = baseDaoImpl.queryBySQL(countsql, new String[]{UserId});
			Object objTotal=count.get(0);//记录总数
			Integer  num = Integer.parseInt(objTotal.toString());
			Integer pagecount = (num % pages.getOffset() == 0) ? num/pages.getOffset():num/pages.getOffset() + 1;
			
			List infos = baseDaoImpl.queryBySQL(sql,  new String[]{UserId},start ,pages.getOffset());
			
			if(infos.size()<1)
			{
				log.info("未查询到记录");
				pages.setRspCode("000002");
				pages.setRspMsg("未找到相关记录!");
			}
			else
			{
				List<ShopInfoModel> models = new ArrayList<ShopInfoModel>();
				for(Object object : infos){
					Object[] strs = (Object[])object;
					ShopInfoModel shopModel = new ShopInfoModel();
					shopModel.setShopId(strs[0]+"");
					shopModel.setShopNm(strs[1]+"");
					shopModel.setLogourl(strs[2]+"");
					models.add(shopModel);
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
	
	@SuppressWarnings("static-access")
	@Override
	@Transactional
	public Message saveInterestShopInfo(TblInterestShopInfo shop) {
		
		log.info("开始添加关注店铺");
		Message msg = new Message();
		UUID uuid =new UUID();
		try {
			String enterId=uuid.getUUID();
			shop.setInteId(enterId);
			shop.setActType("0");
			shop.setStatus("0");
			shop.setInstDt(DateUtil.getCurrentDate(DateUtil.DATE_FORMAT_14));
			baseDaoImpl.save(shop);
			msg.setRspCode("000000").setRspMsg("添加关注店铺成功！");
		} catch (DBException e) {
			msg.setRspCode("000001").setRspMsg("数据库异常");
			log.error("添加关注店铺失败",e);
		}
		return msg;
	}

	@Override
	public Message delInterestShopInfo(TblInterestShopInfo inter) {
		// TODO Auto-generated method stub
		log.info("开始取消关注商品");
		Message msg = new Message();
		try {
			String sql  = "delete from  tbl_interest_shop_info where shop_id = ? ";
			
			baseDaoImpl.excuteSql(sql, new String[]{inter.getShopId()});
			
			msg.setRspCode("000000").setRspMsg("取消关注商品成功！");
		} catch (DBException e) {
			msg.setRspCode("000001").setRspMsg("数据库异常");
			log.error("取消关注商品失败",e);
		}
		
		return msg;
	}
}	
