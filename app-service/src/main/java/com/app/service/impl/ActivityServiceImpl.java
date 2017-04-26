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
import com.app.service.ActivityService;
import com.app.bean.TblActivityInfo;
import com.app.model.ActivityInfoModel;

@Service
public class ActivityServiceImpl implements ActivityService {
	private Logger log = LoggerFactory.getLogger(this.getClass());
	@Resource
	private BaseDao baseDaoImpl;
	
	@Override
	@Transactional
	public Message getActivityInfo(TblActivityInfo activityInfo) {
		log.info("获取activity列表");
		Message msg = new Message();
		try {
			String hql = "select t.act_id ,t.act_type,t.sub_type,t.act_title,t.s_title,t.act_desc,t.res_id,c.url,t.act_url ";
			
			hql+=" from tbl_activity_info t ";
			hql+= "left join tbl_resources_info c on c.resid=t.res_id where 1=1 and t.status='0' ";
			
			hql += "and t.act_type = '"+ activityInfo.getActType() +"'";
			
			List infos = baseDaoImpl.queryBySQL(hql, null);
			if(infos.size()<1)
			{
				log.info("未查询到记录");
				msg.setRspCode("000002").setRspMsg("未找到相关记录!");
			}
			else
			{
				List<ActivityInfoModel> models = new ArrayList<ActivityInfoModel>();
				for(Object object : infos){
					Object[] strs = (Object[])object;
					ActivityInfoModel activityModel = new ActivityInfoModel();
					activityModel.setActId(strs[0]+"");
					activityModel.setActType(strs[1]+"");
					activityModel.setSubType(strs[2]+"");
					activityModel.setActTitle(strs[3]+"");
					activityModel.setsTitle(strs[4]+"");
					activityModel.setActDesc(strs[5]+"");
					activityModel.setResId(strs[6]+"");
					activityModel.setResUrl(strs[7]+"");
					activityModel.setActUrl(strs[8]+"");
					models.add(activityModel);
				}
				msg.setRspCode("000000").setRspMsg("成功!");
				msg.setObjs(models);
			}
			
		} catch (DBException e) {
			msg.setRspCode("000001").setRspMsg("数据库异常");
			log.error("activity获取失败",e);
		}
		
		return msg;
	}
	
}
