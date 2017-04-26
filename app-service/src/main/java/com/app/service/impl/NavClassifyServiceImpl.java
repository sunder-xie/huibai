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
import com.hlb.utils.date.DateUtil;
import com.hlb.utils.string.StringUtils;
import com.app.service.NavClassifyService;
import com.app.bean.TblNavClassifyInfo;
import com.app.model.NavClassifyModel;

@Service
public class NavClassifyServiceImpl implements NavClassifyService {
	private Logger log = LoggerFactory.getLogger(this.getClass());
	@Resource
	private BaseDao baseDaoImpl;
	
	@Override
	@Transactional
	public Message getTopNavClassifyInfo(TblNavClassifyInfo classifyInfo) {
		log.info("获取classify列表");
		Message msg = new Message();
		try {
			String hql = "from TblNavClassifyInfo t where 1=1 and t.status='0' ";
			
			if(!StringUtils.isEmpty(classifyInfo.getPclassify()))
			{
				hql+= "and t.pclassify = '"+classifyInfo.getPclassify()+"' ";
			}
			
			if(!StringUtils.isEmpty(classifyInfo.getCtype()))
			{
				hql+= "and t.ctype = '"+classifyInfo.getCtype()+"' ";
			}
			
			if(!StringUtils.isEmpty(classifyInfo.getClevel()))
			{
				hql+= "and t.clevel = '"+classifyInfo.getClevel()+"' ";
			}
			
			hql+= " order by t.clevel,t.cseq ";
			
			log.info("查询sql语句为："+hql);
			List infos = baseDaoImpl.queryByHQL(hql, null);
			if(infos.size()<1)
			{
				log.info("未查询到记录");
				msg.setRspCode("000002").setRspMsg("未找到相关记录!");
			}
			else
			{
				List<NavClassifyModel> models = new ArrayList<NavClassifyModel>();
				for(Object object : infos){
					NavClassifyModel navModel =new NavClassifyModel();
					TblNavClassifyInfo navinfo = new TblNavClassifyInfo();
					navinfo =(TblNavClassifyInfo)object;
					int cflag =  navinfo.getCflag();
					navModel.setClassify(navinfo.getClassify());
					navModel.setCtype(navinfo.getCtype());
					navModel.setCname(navinfo.getCname());
					navModel.setClevel(navinfo.getClevel());
					navModel.setCflag(cflag);
					navModel.setPclassify(navinfo.getPclassify());
					
					if(cflag==1)
					{
						hql = "from TblNavClassifyChildInfo t "
								+ "where t.classify = ? and t.status='0' and t.ctype=? ";
						List childinfos = baseDaoImpl.queryByHQL(hql, new String[]{navinfo.getClassify(),navinfo.getCtype()});
						if(childinfos.size()>0)
						{
							navModel.setChildNavClassify(childinfos);
						}
					}
					
					models.add(navModel);
				}
				msg.setRspCode("000000").setRspMsg("成功!");
				msg.setObjs(models);
			}
			
		} catch (DBException e) {
			msg.setRspCode("000001").setRspMsg("数据库异常");
			log.error("classify获取失败",e);
		}
		
		return msg;
	}
	
	@Override
	@Transactional
	public Message getLastNavClassifyInfo(TblNavClassifyInfo classifyInfo) {
		log.info("获取classify列表");
		Message msg = new Message();
		try {
			String hql = "from TblNavClassifyInfo t where 1=1 and status='0' ";
			
			if(!StringUtils.isEmpty(classifyInfo.getPclassify()))
			{
				hql+= "and t.pclassify = '"+classifyInfo.getPclassify()+"' ";
			}
			
			if(!StringUtils.isEmpty(classifyInfo.getCtype()))
			{
				hql+= "and t.ctype = '"+classifyInfo.getCtype()+"' ";
			}
			
			hql+= " order by clevel,cseq ";
			
			log.info("查询sql语句为："+hql);
			List infos = baseDaoImpl.queryByHQL(hql, null);
			if(infos.size()<1)
			{
				log.info("未查询到记录");
				msg.setRspCode("000002").setRspMsg("未找到相关记录!");
			}
			else
			{
				List<NavClassifyModel> models = new ArrayList<NavClassifyModel>();
				for(Object object : infos){
					NavClassifyModel navModel =new NavClassifyModel();
					TblNavClassifyInfo navinfo = new TblNavClassifyInfo();
					navinfo =(TblNavClassifyInfo)object;
					int cflag =  navinfo.getCflag();
					navModel.setClassify(navinfo.getClassify());
					navModel.setCtype(navinfo.getCtype());
					navModel.setCname(navinfo.getCname());
					navModel.setClevel(navinfo.getClevel());
					navModel.setCflag(cflag);
					navModel.setPclassify(navinfo.getPclassify());
					
					hql = "from TblNavClassifyInfo t "
							+ "where t.pclassify = ? and t.status='0' and t.ctype=? ";
					List childinfos = baseDaoImpl.queryByHQL(hql, new String[]{navinfo.getClassify(),navinfo.getCtype()});
					log.info("查询到记录:"+childinfos.size()+"条");
					if(childinfos.size()>0)
					{
						navModel.setChildNavClassify(childinfos);
					}
					
					models.add(navModel);
				}
				msg.setRspCode("000000").setRspMsg("成功!");
				msg.setObjs(models);
			}
			
		} catch (DBException e) {
			msg.setRspCode("000001").setRspMsg("数据库异常");
			log.error("classify获取失败",e);
		}
		
		return msg;
	}
	
}
