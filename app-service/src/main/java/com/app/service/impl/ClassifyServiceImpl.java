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
import com.app.service.ClassifyService;
import com.app.bean.TblClassifyInfo;

@Service
public class ClassifyServiceImpl implements ClassifyService {
	private Logger log = LoggerFactory.getLogger(this.getClass());
	@Resource
	private BaseDao baseDaoImpl;
	
	@Override
	@Transactional
	public Message getClassifyInfo(TblClassifyInfo classifyInfo) {
		log.info("获取classify列表");
		Message msg = new Message();
		try {
			String hql = "from TblClassifyInfo t where 1=1 ";
			if(classifyInfo.getPclassify()!=null|| classifyInfo.getPclassify() !="")
			{
				hql+= "and t.pclassify = '"+classifyInfo.getPclassify()+"'";
			}
			hql+= " order by clevel,cseq ";
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
			log.error("classify获取失败",e);
		}
		
		return msg;
	}
	
	@Override
	@Transactional
	public Message getClassifyPath(TblClassifyInfo classifyInfo) {
		log.info("获取classify列表");
		Message msg = new Message();
		try {
			String sql = "{ CALL pro_show_parentLst('"+classifyInfo.getClassify()+"') }";
			List infos = baseDaoImpl.queryBySQL(sql, null);
			if(infos.size()<1)
			{
				log.info("未查询到记录");
				msg.setRspCode("000002").setRspMsg("未找到相关记录!");
			}
			else
			{
				msg.setRspCode("000000").setRspMsg("成功!");
				msg.setObjs(infos.get(0));
			}
			
		} catch (DBException e) {
			msg.setRspCode("000001").setRspMsg("数据库异常");
			log.error("classify获取失败",e);
		}
		
		return msg;
	}
	
}
