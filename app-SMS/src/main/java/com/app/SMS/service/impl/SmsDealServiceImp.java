package com.app.SMS.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.app.SMS.model.CheckSmsValidModel;
import com.app.SMS.service.SmsDealService;
import com.app.bean.TblSmsInfo;
import com.app.common.dao.BaseDao;
import com.app.common.exception.DBException;
import com.app.common.model.Message;
import com.hlb.utils.date.DateUtil;
import com.hlb.utils.string.StringUtils;
import com.app.SMS.service.SmsSeqService;;

@Service
public class SmsDealServiceImp implements SmsDealService{

	private Logger log = LoggerFactory.getLogger(this.getClass());
	@Resource
	private BaseDao baseDaoImpl;
	
	@Resource
	private SmsSeqService smsseqServiceImpl;
	
	@Override
	@Transactional
	public Message saveSendSms(TblSmsInfo sms) {
		
		Message msg = new Message();
		String sndDt = DateUtil.getCurrentDate(DateUtil.DATE_FORMAT_14);
		
		String smsId=sndDt+smsseqServiceImpl.getSeqNo("seq_id");
		sms.setSmsId(smsId);
		sms.setSndTm(sndDt);
		try {
			baseDaoImpl.save(sms);
			msg.setRspCode("000000").setRspMsg("增加成功！");
			msg.setObjs(sms);
		} catch (DBException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			msg.setRspCode("000001").setRspMsg("数据库异常");
		}
		
		return msg;
	}
	
	@Override
	@Transactional
	public Message checkSmsVaild(CheckSmsValidModel sms) {
		
		Message msg = new Message();
		try {
			String hql = "from TblSmsInfo t where t.smsId = ? ";
			
			List infos = baseDaoImpl.queryByHQL(hql, new String[]{sms.getSmsId()});
			if(infos.size() > 0){
				
				String nowDt = DateUtil.getCurrentDate(DateUtil.DATE_FORMAT_14);
				TblSmsInfo smsinfo = (TblSmsInfo)infos.get(0);
				if(smsinfo.getErrNum()>3)
				{
					msg.setRspCode("000066").setRspMsg("错误次数超限！");
					return msg;
				}
				if(!smsinfo.getSmsCode().equals(sms.getSmsCode()))
				{
					smsinfo.setErrNum(smsinfo.getErrNum()+1);
					baseDaoImpl.saveOrUpdate(smsinfo);
					msg.setRspCode("000066").setRspMsg("验证码错误！");
					return msg;
				}
				
				log.info(smsinfo.getSndTm()+","+nowDt+","+DateUtil.get_second_space(smsinfo.getSndTm(), nowDt)+","+smsinfo.getExpires());
				if(DateUtil.get_second_space(smsinfo.getSndTm(), nowDt)>smsinfo.getExpires())
				{
					smsinfo.setErrNum(smsinfo.getErrNum()+1);
					baseDaoImpl.saveOrUpdate(smsinfo);
					msg.setRspCode("000066").setRspMsg("超过有效期！");
					return msg;
				}
				msg.setRspCode("000000").setRspMsg("校验成功！");
			}
			else
			{
				msg.setRspCode("000001").setRspMsg("用户不存在");
			};
		} catch (DBException e) {
			msg.setRspCode("000001").setRspMsg("数据库异常");
		}
		
		return msg;
	}

}
