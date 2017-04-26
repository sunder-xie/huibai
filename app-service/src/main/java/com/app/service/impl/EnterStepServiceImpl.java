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
import com.app.service.EnterStepService;
import com.app.bean.TblEnterStepInfo;

@Service
public class EnterStepServiceImpl implements EnterStepService {
	private Logger log = LoggerFactory.getLogger(this.getClass());
	@Resource
	private BaseDao baseDaoImpl;
	
	@Override
	@Transactional
	public Message getEnterStepInfo(Map<String, String> params) {
		log.info("获取enter信息:");
		Message msg = new Message();
		try {
			String tempkey= "";
			String hql = "from TblEnterStepInfo t where 1=1 ";
			String contion = "";
			
			if(!params.get("userId").equals("")){
				tempkey=params.get("userId");
				log.info("关键字是userId：［{}]",tempkey);
				contion += "and t.userId = '"+ tempkey + "'";			
			}
			hql += contion;
			
			List infos = baseDaoImpl.queryByHQL(hql, null);
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
			log.error("enter获取失败",e);
		}
		
		return msg;
	}
	
	@SuppressWarnings("static-access")
	@Override
	@Transactional
	public Message saveEnterStepInfo(Map<String, String> params) {
		
		log.info("进行店铺信息的注册");
		Message msg = new Message();
		UUID uuid =new UUID();
		try {
			TblEnterStepInfo enterinfo = new TblEnterStepInfo();
			String enterId=uuid.getUUID();
			enterinfo.setEnterId(enterId);
			enterinfo.setRegDt(DateUtil.getCurrentDate(DateUtil.DATE_FORMAT_14));
			enterinfo.setUserId(params.get("userId"));
			enterinfo.setEnterType(params.get("entryType"));
			enterinfo.setStepId(params.get("stepId"));
			enterinfo.setStepDesc(params.get("stepDesc"));
			enterinfo.setEnterSta("0");
			
			baseDaoImpl.save(enterinfo);
			msg.setRspCode("000000").setRspMsg("增加个人商家进驻进度成功！");
			msg.setObjs(enterinfo);
		} catch (DBException e) {
			msg.setRspCode("000001").setRspMsg("数据库异常");
			log.error("店铺信息注册失败，userId为[{}]",params.get("userId"),e);
		}
		
		return msg;
	}
}	
