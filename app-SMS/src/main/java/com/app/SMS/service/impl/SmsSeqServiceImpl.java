package com.app.SMS.service.impl;

import java.util.List;
import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.app.common.dao.BaseDao;
import com.app.common.exception.DBException;
import com.app.SMS.service.SmsSeqService;

@Service
public class SmsSeqServiceImpl implements SmsSeqService {
	private Logger log = LoggerFactory.getLogger(this.getClass());
	@Resource
	private BaseDao baseDaoImpl;
	
	@Override
	@Transactional
	public int getSeqNo(String SeqNm) {
		log.info("获取seq，编号为［{}]",SeqNm);
		int SeqNo=0;
		int random1 = (int) (Math.random()*9000+1000);
		try {
			String hql = "select nextval('"+SeqNm+"') ";
			List infos = baseDaoImpl.queryBySQL(hql, null);
			SeqNo=(Integer)infos.get(0)+10000000;
			if(SeqNo>99999999)
			{
				SeqNo=10000001;
			}
		} catch (DBException e) {
			
			SeqNo=10000001;
		}
		SeqNo=10000001+random1;
		return SeqNo;
	}
}
