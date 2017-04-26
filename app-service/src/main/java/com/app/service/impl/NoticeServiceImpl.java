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
import com.app.service.NoticeService;
import com.app.bean.TblNoticeInfo;

@Service
public class NoticeServiceImpl implements NoticeService {
	private Logger log = LoggerFactory.getLogger(this.getClass());
	@Resource
	private BaseDao baseDaoImpl;
//	@Resource
//	private IPublicService publicService;
	
	@Override
	@Transactional
	public Message getNoticeDetail(TblNoticeInfo noticeInfo) {
		log.info("获取公告内容，编号为［{}]",noticeInfo.getNoteId());
		Message msg = new Message();
		try {
			String hql = "from TblNoticeInfo t where t.noteId = ?";
			List infos = baseDaoImpl.queryByHQL(hql, new String[]{noticeInfo.getNoteId()});
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
			log.error("公告内容获取失败，id为[{}]",noticeInfo.getNoteId(),e);
		}
		
		return msg;
	}
	
	@Override
	public Pager getNoticeAll(Pager pages) {
		log.info("获取公告列表.");
		Pager pager = new Pager();
		pager.setStart(pages.getStart());
		pager.setOffset(pages.getOffset());
		/*开始记录数*/
		int start = (pages.getStart() -1) * pages.getOffset();
		try {
			String counthql = "select count(*) from TblNoticeInfo t ";
			List count = baseDaoImpl.queryByHQL(counthql, null);
			Object objTotal=count.get(0);//记录总数
			Integer  num = Integer.parseInt(objTotal.toString());
			Integer pagecount = (num % pages.getOffset() == 0) ? num/pages.getOffset():num/pages.getOffset() + 1;
			String hql = "from TblNoticeInfo t where 1=1 ";			
			List infos = baseDaoImpl.queryByHQL(hql, null,start ,pages.getOffset());
			if(infos.size()<1)
			{
				log.info("未查询到记录");
				pager.setRspCode("000002");
				pager.setRspMsg("未找到相关记录!");
			}
			else
			{
				pager.setRspCode("000000");
				pager.setRspMsg("成功!");
				pager.setResult(infos);
				pager.setPageCount(pagecount);
				pager.setTotal(num);
			}
			
		} catch (DBException e) {
			pager.setRspCode("000001");
			pager.setRspMsg("数据库异常!");
		}
		
		return pager;
	}
	
	
}
