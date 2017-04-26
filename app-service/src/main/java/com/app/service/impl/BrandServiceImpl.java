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
import com.app.common.model.Pager;
import com.hlb.utils.date.DateUtil;
import com.hlb.utils.validate.ValidateUtil;
import com.app.service.BrandService;
import com.app.model.BrandInfoModel;

@Service
public class BrandServiceImpl implements BrandService {
	private Logger log = LoggerFactory.getLogger(this.getClass());
	@Resource
	private BaseDao baseDaoImpl;
	
	@Override
	@Transactional
	public Message getBrandInfo(Pager pages) {
		log.info("获取品牌信息");
		Message msg = new Message();
		try {
			String tempkey= "";
			String condition_sql="";
			String countsql = "";
			
			String sql  = " select t.brand_id ,t.brand_nm,t.res_id,c.url as resUrl ";
			String csql = " from tbl_brand_info t"
					+ " left join tbl_resources_info c on c.resid=t.res_id where t.status = '0' ";
			
			countsql = "select count(*) " + csql +condition_sql;
			sql += csql +condition_sql;
			/*开始记录数*/
			int start = (pages.getStart() -1) * pages.getOffset();
			
			List count = baseDaoImpl.queryBySQL(countsql, null);
			Object objTotal=count.get(0);//记录总数
			Integer  num = Integer.parseInt(objTotal.toString());
			Integer pagecount = (num % pages.getOffset() == 0) ? num/pages.getOffset():num/pages.getOffset() + 1;
			
			List infos = baseDaoImpl.queryBySQL(sql, null,start ,pages.getOffset());
			
			if(infos.size()<1)
			{
				log.info("未查询到记录");
				msg.setRspCode("000002").setRspMsg("未找到相关记录!");
			}
			else
			{
				List<BrandInfoModel> models = new ArrayList<BrandInfoModel>();
				for(Object object : infos){
					Object[] strs = (Object[])object;
					BrandInfoModel adModel = new BrandInfoModel();
					adModel.setBrandId(strs[0]+"");
					adModel.setBrandNm(strs[1]+"");
					adModel.setResId(strs[2]+"");
					adModel.setResUrl(strs[3]+"");
					models.add(adModel);
				}
				msg.setObjs(models);
				msg.setRspCode("000000").setRspMsg("成功!");
			}
			
		} catch (DBException e) {
			msg.setRspCode("000001").setRspMsg("数据库异常");
			log.error("brand获取失败",e);
		}
		
		return msg;
	}
	
}
