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
import com.hlb.utils.date.DateUtil;
import com.hlb.utils.validate.ValidateUtil;
import com.app.service.MyClassifyService;
import com.app.bean.TblMyClassifyInfo;;

@Service
public class MyClassifyServiceImpl implements MyClassifyService {
	private Logger log = LoggerFactory.getLogger(this.getClass());
	@Resource
	private BaseDao baseDaoImpl;
	
	@Override
	@Transactional
	public Message getMyClassifyInfo(TblMyClassifyInfo myClassify) {
		log.info("获取classify列表");
		Message msg = new Message();
		try {
			String hql = "from TblMyClassifyInfo t where 1=1 and t.shopId = ? ";
			
			List infos = baseDaoImpl.queryByHQL(hql, new String[]{myClassify.getShopId()});
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
			log.error("classify获取失败",e);
		}
		
		return msg;
	}
	
}
