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
import com.app.service.FloorService;
import com.app.bean.TblFloorInfo;
import com.app.model.FloorAdInfoModel;
import com.app.model.FloorInfoModel;

@Service
public class FloorServiceImpl implements FloorService {
	private Logger log = LoggerFactory.getLogger(this.getClass());
	@Resource
	private BaseDao baseDaoImpl;
	
	@Override
	@Transactional
	public Message getFloorInfo(TblFloorInfo floorInfo) {
		log.info("获取floor列表");
		Message msg = new Message();
		try {
			String hql = "from TblFloorInfo t where t.status='0' "
					+ "and t.FType= ? ";
			
			hql	+="order by CAST(f_id as SIGNED) ";
			List infos = baseDaoImpl.queryByHQL(hql, new String[]{floorInfo.getFType()});
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
			log.error("floor获取失败",e);
		}
		
		return msg;
	}
	
	@Override
	@Transactional
	public Message getAllFloorInfo(String type) {
		log.info("获取floor列表");
		Message msg = new Message();
		try {
			String hql = "from TblFloorInfo t where t.status='0' "
					+ "and t.FType= ? ";
			
			hql	+="order by CAST(f_id as SIGNED) ";
			List floorList = baseDaoImpl.queryByHQL(hql, new String[]{type});
			if(floorList.size()<1)
			{
				log.info("未查询到记录");
				msg.setRspCode("000002").setRspMsg("未找到相关记录!");
			}
			else
			{
				List<FloorInfoModel> models = new ArrayList<FloorInfoModel>();
				for(Object object : floorList){
					TblFloorInfo floorInfo = new TblFloorInfo();
					FloorInfoModel floorModel = new FloorInfoModel();
					floorInfo=(TblFloorInfo)object;
					floorModel.setFId(floorInfo.getFId());
					floorModel.setFNm(floorInfo.getFNm());
					floorModel.setFType(floorInfo.getFType());
					floorModel.setTab1(floorInfo.getTab1());
					floorModel.setTab2(floorInfo.getTab2());
					floorModel.setClassify(floorInfo.getClassify());
					floorModel.setKeyword(floorInfo.getKeyword());
					
					String sql  = "select t.f_ad_id ,t.f_type,t.f_id,t.ad_type,t.title,t.res_id,c.url as resUrl, t.url ";
					String csql =sql+ "from tbl_floor_ad_info t"
							+ " left join tbl_resources_info c on c.resid=t.res_id where t.f_type = ? and t.status = '0' and t.f_id=? ";
					
					List infos = baseDaoImpl.queryBySQL(csql, new String[]{type,floorInfo.getFId()});
					if(infos.size()>0)
					{
						List<FloorAdInfoModel> fadmodels = new ArrayList<FloorAdInfoModel>();
						for(Object object2 : infos){
							Object[] strs = (Object[])object2;
							FloorAdInfoModel adModel = new FloorAdInfoModel();
							adModel.setFAdId(strs[0]+"");
							adModel.setTitle(strs[1]+"");
							adModel.setFId(strs[2]+"");
							adModel.setAdType(strs[3]+"");
							adModel.setTitle(strs[4]+"");
							adModel.setResId(strs[5]+"");
							adModel.setResUrl(strs[6]+"");
							adModel.setUrl(strs[7]+"");
							fadmodels.add(adModel);
						}
						floorModel.setFloorAdInfo(fadmodels);
					}
					models.add(floorModel);
				}
				msg.setRspCode("000000").setRspMsg("成功!");
				msg.setObjs(models);
			}
			
		} catch (DBException e) {
			msg.setRspCode("000001").setRspMsg("数据库异常");
			log.error("floor获取失败",e);
		}
		
		return msg;
	}
	
}
