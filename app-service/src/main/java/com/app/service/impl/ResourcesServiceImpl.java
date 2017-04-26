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
import com.app.service.ResourcesService;
import com.app.bean.TblResourcesInfo;

@Service
public class ResourcesServiceImpl implements ResourcesService {
	private Logger log = LoggerFactory.getLogger(this.getClass());
	@Resource
	private BaseDao baseDaoImpl;
	
	@Override
	@Transactional
	public Message getResourcesInfo(TblResourcesInfo resInfo) {
		log.info("获取res列表，type为［{}{}]",resInfo.getKeyid(),resInfo.getType());
		Message msg = new Message();
		try {
			String hql = "from TblResourcesInfo t where t.keyid=? and t.status = '0' ";
			List infos = baseDaoImpl.queryByHQL(hql, new String[]{resInfo.getKeyid()});
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
			log.error("res获取失败",e);
		}
		
		return msg;
	}
	
	@Override
	@Transactional
	public Message getGoodsPicInfo(TblResourcesInfo resInfo) {
		log.info("获取商品图片列表，keyid［{}{}]",resInfo.getKeyid());
		Message msg = new Message();
		try {
			String hql = "from TblResourcesInfo t where t.keyid=? and t.status = '0' and t.type in ('01','02') ";
			List infos = baseDaoImpl.queryByHQL(hql, new String[]{resInfo.getKeyid()});
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
			log.error("res获取失败",e);
		}
		
		return msg;
	}
	
	@Override
	@Transactional
	public Message saveResources(TblResourcesInfo resInfo) {
		log.info("获取res列表，type为［{}{}]",resInfo.getKeyid(),resInfo.getType());
		Message msg = new Message();
		try {
			baseDaoImpl.save(resInfo);
			msg.setObjs(resInfo);
			msg.setRspCode("000000").setRspMsg("增加成功！");
		} catch (DBException e) {
			msg.setRspCode("000001").setRspMsg("数据库异常");
			log.error("资源添加失败，[{}]",resInfo.getKeyid(),e);
		}
		
		return msg;
	}
	
}
