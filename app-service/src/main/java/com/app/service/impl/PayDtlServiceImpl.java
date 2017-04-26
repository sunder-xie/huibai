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
import com.hlb.utils.date.DateUtil;
import com.hlb.utils.validate.ValidateUtil;
import com.app.service.PayDtlService;
import com.app.bean.TblPayDtl;

@Service
public class PayDtlServiceImpl implements PayDtlService {
	private Logger log = LoggerFactory.getLogger(this.getClass());
	@Resource
	private BaseDao baseDaoImpl;
	
	@Override
	@Transactional
	public Message checkStaPayDtl(TblPayDtl paydtl) {
		log.info("检查支付流水支付状态");
		Message msg = new Message();
		try {
			
			/*查找是否存在已支付的支付流水*/
			String hql = "from TblPayDtl t where t.orderId = ? and t.paySta = '02' ";
			List infos = baseDaoImpl.queryByHQL(hql, new String[]{paydtl.getOrderId()});
			if(infos.size()<1)
			{
				msg.setRspCode("000000").setRspMsg("成功!");
			}
			else
			{
				paydtl = (TblPayDtl)infos.get(0);
				msg.setRspCode("000011").setRspMsg("该笔交易以支付，请勿重复支付!");
				msg.setObjs(paydtl);
			}
		} catch (DBException e) {
			msg.setRspCode("000001").setRspMsg("数据库异常");
			log.error("floor获取失败",e);
		}
		
		return msg;
	}
	
	@Override
	@Transactional
	public Message checkPayDtlSta(String OrderId) {
		log.info("检查支付流水支付状态");
		Message msg = new Message();
		try {
			TblPayDtl paydtl = new TblPayDtl();
			/*查找是否存在已支付的支付流水*/
			String hql = "from TblPayDtl t where t.orderId = ? and t.paySta = '02' ";
			List infos = baseDaoImpl.queryByHQL(hql, new String[]{OrderId});
			if(infos.size()<1)
			{
				msg.setRspCode("000000").setRspMsg("成功!");
			}
			else
			{
				paydtl = (TblPayDtl)infos.get(0);
				msg.setRspCode("000011").setRspMsg("该笔交易以支付，请勿重复支付!");
				msg.setObjs(paydtl);
			}
		} catch (DBException e) {
			msg.setRspCode("000001").setRspMsg("数据库异常");
			log.error("floor获取失败",e);
		}
		
		return msg;
	}
	
	@Override
	@Transactional
	public Message savePayDtl(TblPayDtl paydtl) {
		log.info("保存支付流水信息");
		Message msg = new Message();
		try {
				baseDaoImpl.save(paydtl);
				msg.setRspCode("000000").setRspMsg("成功!");
				msg.setObjs(paydtl);
			
		} catch (DBException e) {
			msg.setRspCode("000001").setRspMsg("数据库异常");
			log.error("floor获取失败",e);
		}
		
		return msg;
	}
	
	@Override
	@Transactional
	public Message updatePayDtl(TblPayDtl paydtl) {
		log.info("更新支付流水表流水号为[{}]",paydtl.getPaySeq());
		Message msg = new Message();
		try {
			/*查找为已支付的支付流水*/
			String hql = "from TblPayDtl t where t.paySeq = ? and t.payChannle = ? ";
			List infos = baseDaoImpl.queryByHQL(hql, new String[]{paydtl.getPaySeq(),paydtl.getPayChannle()});
			if(infos.size()<1)
			{
				msg.setRspCode("000023").setRspMsg("查找支付流水失败!");
				return msg;
			}
			TblPayDtl payinfo  = new TblPayDtl();
			payinfo = (TblPayDtl)infos.get(0);
			if(payinfo.getPaySta().equals("02"))
			{
				msg.setRspCode("000000").setRspMsg("已支付!");
				return msg;
			}
			if(!payinfo.getTotalAmt().equals(paydtl.getTotalAmt()))
			{
				log.info("返回金额为[{}]，原金额为[{}]",paydtl.getTotalAmt(),payinfo.getTotalAmt());
				msg.setRspCode("000024").setRspMsg("支付金额不符合!");
				return msg;
			}
			
			if(!payinfo.getOrderId().equals(paydtl.getOrderId()))
			{
				log.info("返回订单号为[{}]，原订单号为[{}]",paydtl.getOrderId(),payinfo.getOrderId());
				msg.setRspCode("000025").setRspMsg("支付订单号不符合!");
				return msg;
			}
			
			String autoDt = DateUtil.getOffSizeDateTime(paydtl.getPayTimeEnd(),"10");
			String sql = "update tbl_pay_dtl set pay_sta= '02', transaction_id =? ,pay_time_end =? where pay_seq =? ";
			baseDaoImpl.excuteSql(sql, new String[]{paydtl.getTransactionId(),paydtl.getPayTimeEnd(),paydtl.getPaySeq()});
			
			sql = "update tbl_order_info set ord_sta= '02', pay_sta= '02', pay_seq =? ,pay_dt =? ,auto_dt=? ,pay_channle= '01' where order_id =? ";
			baseDaoImpl.excuteSql(sql, new String[]{paydtl.getPaySeq(),paydtl.getPayTimeEnd(),autoDt,paydtl.getOrderId()});
			
			msg.setRspCode("000000").setRspMsg("成功!");
			msg.setObjs(paydtl);
			
		} catch (DBException e) {
			msg.setRspCode("000001").setRspMsg("数据库异常");
			log.error("floor获取失败",e);
		}
		
		return msg;
	}
	
}
