package com.app.service.impl;

import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.app.common.dao.BaseDao;
import com.app.common.exception.DBException;
import com.app.common.model.Pager;
import com.app.service.SearchService;
import com.app.model.GoodsInfoModel;
import com.app.model.ShopInfoModel;
@Service
public class SearchServiceImpl implements SearchService {
	private Logger log = LoggerFactory.getLogger(this.getClass());
	@Resource
	private BaseDao baseDaoImpl;

	
	@Override
	public Pager getMerInf(Pager pages) {
		String tempkey=null;
		//tempkey=URLDecoder.decode(key.getConditions().get("keyword"),"utf-8");//对中文参数进行解码
		try{
			tempkey=URLDecoder.decode(pages.getConditions().get("keyword"),"utf-8");//对中文参数进行解码
		}catch(Exception e){
		     e.printStackTrace();
		}
		log.info("关键字是：［{}]",tempkey);
		pages.getConditions().put("keyword", tempkey);
		/*开始记录数*/
		int start = (pages.getStart() -1) * pages.getOffset();
		try {
			
			String counthql = "select count(*) "
					+ "from tbl_shop_info t"
					+ " left join tbl_resources_info c on c.resid=t.logo "
					+ " where t.shop_nm like '%"
					+ tempkey
					+ "%'";
			List count = baseDaoImpl.queryBySQL(counthql, null);
			Object objTotal=count.get(0);//记录总数
			Integer  num = Integer.parseInt(objTotal.toString());
			Integer pagecount = (num % pages.getOffset() == 0) ? num/pages.getOffset():num/pages.getOffset() + 1;
			
			String hql = "select t.shop_id ,t.shop_nm,t.sales,t.address, c.url "
					+ "from tbl_shop_info t"
					+ " left join tbl_resources_info c on c.resid=t.logo  "
					+ " where t.shop_nm like '%"
					+ tempkey
					+ "%'";
			List infos = baseDaoImpl.queryBySQL(hql, null,start ,pages.getOffset());
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
				List<ShopInfoModel> models = new ArrayList<ShopInfoModel>();
				for(Object object : infos){
					Object[] strs = (Object[])object;
					ShopInfoModel shopInfoModel = new ShopInfoModel();
					shopInfoModel.setShopId(strs[0]+"");
					shopInfoModel.setShopNm(strs[1]+"");
					shopInfoModel.setSales(strs[2]+"");
					shopInfoModel.setAddress(strs[3]+"");
					shopInfoModel.setLogourl(strs[4]+"");
					models.add(shopInfoModel);
				}
				
				pages.setResult(models);
				pages.setPageCount(pagecount);
				pages.setTotal(num);
			}
		}catch (DBException e) {
			pages.setRspCode("000001");
			pages.setRspMsg("数据库异常");
		}
		return pages;
	}
	
}
