package com.app.service.impl;

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
import com.app.common.utils.ResCodeConstant;
import com.hlb.utils.date.DateUtil;
import com.hlb.utils.validate.ValidateUtil;
import com.app.service.BindService;
import com.app.bean.TblBindInfo;

@Service
public class BindServiceImpl implements BindService {
	private Logger log = LoggerFactory.getLogger(this.getClass());
	@Resource
	private BaseDao baseDaoImpl;
	
	@Override
	@Transactional
	public Message getBindInfo(TblBindInfo bindInfo,String uid) {
		log.info("获取bind列表，type为［{}]",bindInfo.getMode());
		Message msg = new Message();
		try {
			String hql = "from TblBindInfo t where t.keyA=? and t.mode=? and t.bindSta = '0' ";
			List infos = baseDaoImpl.queryByHQL(hql, new String[]{uid,bindInfo.getMode()});
			if(infos.size()<1)
			{
				log.info("未查询到记录");
				msg.setRspCode(ResCodeConstant.MSG_NOT_FOUND).setRspMsg(ResCodeConstant.MSG_NOT_FOUND_DESC);
			}
			else
			{
				bindInfo=(TblBindInfo)infos.get(0);
				msg.setRspCode("000000").setRspMsg("成功!");
				msg.setObjs(infos);
			}
			
		} catch (DBException e) {
			msg.setRspCode("000001").setRspMsg("数据库异常");
			log.error("bind获取失败",e);
		}
		
		return msg;
	}
	
}
