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
import com.app.service.FloorAdService;
import com.app.bean.TblFloorAdInfo;
import com.app.model.BannerInfoModel;
import com.app.model.FloorAdInfoModel;

@Service
public class FloorAdServiceImpl implements FloorAdService {
	private Logger log = LoggerFactory.getLogger(this.getClass());
	@Resource
	private BaseDao baseDaoImpl;
	
	@Override
	@Transactional
	public Message getFloorAdInfo(TblFloorAdInfo flooradInfo) {
		log.info("获取ad内容，id为［{}]",flooradInfo.getFId());
		Message msg = new Message();
		try {
			String sql  = "select t.f_ad_id ,t.f_type,t.f_id,t.ad_type,t.title,t.res_id,c.url as resUrl, t.url ";
			String csql =sql+ "from tbl_floor_ad_info t"
					+ " left join tbl_resources_info c on c.resid=t.res_id where t.f_type = ? and t.status = '0' and t.f_id=? ";
			
			List infos = baseDaoImpl.queryBySQL(csql, new String[]{flooradInfo.getFType(),flooradInfo.getFId()});
			if(infos.size()<1)
			{
				log.info("未查询到记录");
				msg.setRspCode("000002").setRspMsg("未找到相关记录!");
			}
			else
			{
				
				List<FloorAdInfoModel> models = new ArrayList<FloorAdInfoModel>();
				for(Object object : infos){
					Object[] strs = (Object[])object;
					FloorAdInfoModel adModel = new FloorAdInfoModel();
					adModel.setFAdId(strs[0]+"");
					adModel.setTitle(strs[1]+"");
					adModel.setFId(strs[2]+"");
					adModel.setAdType(strs[3]+"");
					adModel.setTitle(strs[4]+"");
					adModel.setResId(strs[5]+"");
					adModel.setResUrl(strs[6]+"");
					adModel.setUrl(strs[7]+"");
					models.add(adModel);
				}
				msg.setObjs(models);
				msg.setRspCode("000000").setRspMsg("成功!");
			}
			
		} catch (DBException e) {
			msg.setRspCode("000001").setRspMsg("数据库异常");
			log.error("floorad获取失败",e);
		}
		
		
		return msg;
	}
	
}
