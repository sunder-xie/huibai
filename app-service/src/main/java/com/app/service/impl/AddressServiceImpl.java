package com.app.service.impl;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.app.common.dao.BaseDao;
import com.app.common.exception.DBException;
import com.app.common.model.Message;
import com.app.common.model.Pager;
import com.hlb.utils.date.DateUtil;
import com.hlb.utils.security.UUID;
import com.hlb.utils.validate.ValidateUtil;
import com.app.service.AddressService;
import com.app.bean.TblBindInfo;
import com.app.bean.TblAddressInfo;
import com.app.common.utils.LTConstant;
import com.app.common.utils.ResCodeConstant;
import com.hlb.utils.*;
@Service
public class AddressServiceImpl implements AddressService {
	private Logger log = LoggerFactory.getLogger(this.getClass());
	@Resource
	private BaseDao baseDaoImpl;
	
	@Override
	@Transactional
	public Pager getAddressInfo(Pager pages,String uid) {
		log.info("获取addr所有信息");
		
		try {
			String countsql = "select count(*) from TblAddressInfo t where t.userId = ?";
			String hql = "from TblAddressInfo t where t.userId = ? order by t.isMain desc";
			/*开始记录数*/
			int start = (pages.getStart() -1) * pages.getOffset();
			List count = baseDaoImpl.queryByHQL(countsql, new Object[]{uid});
			Object objTotal=count.get(0);//记录总数
			Integer  num = Integer.parseInt(objTotal.toString());
			Integer pagecount = (num % pages.getOffset() == 0) ? num/pages.getOffset():num/pages.getOffset() + 1;
			
			List infos = baseDaoImpl.queryByHQL(hql, new Object[]{uid},start ,pages.getOffset());
			if(infos.size()<1)
			{
				log.info("未查询到记录");
				pages.setRspCode("000002");
				pages.setRspMsg("未找到相关记录!");
			}
			else
			{
				pages.setRspCode("000000");
				pages.setRspMsg("成功!");
				pages.setResult(infos);
				pages.setPageCount(pagecount);
				pages.setTotal(num);
			}
			
		} catch (DBException e) {
			pages.setRspCode("000001");
			pages.setRspMsg("数据库异常");
		}
		
		return pages;
	}
	
	@SuppressWarnings("static-access")
	@Override
	@Transactional
	public Message getAddressInfoByAddrId(TblAddressInfo addrInfo,String uid) {
		
		log.info("获取地址信息：addrid为［{}]",addrInfo.getAddrId());
		Message msg = new Message();
		try {
			
			String hql = "from TblAddressInfo t where t.addrId=? and t.userId = ?";
			List infos = baseDaoImpl.queryByHQL(hql, new Object[]{addrInfo.getAddrId(),uid});
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
			log.error("店铺信息注册失败，店铺名为[{}]",addrInfo.getProvice(),e);
		}
		
		return msg;
	}
	
	@SuppressWarnings("static-access")
	@Override
	@Transactional
	public Message saveAddressInfo(TblAddressInfo addrInfo,String uid) {
		
		log.info("增加地址信息：省份为［{}]",addrInfo.getProvice());
		Message msg = new Message();
		UUID uuid =new UUID();		
		try {
			String addrid=uuid.getUUID();
			addrInfo.setAddrId(addrid);
			addrInfo.setUserId(uid);
			addrInfo.setAddrNm("");
			addrInfo.setTel("");	
			if(addrInfo.getIsMain().equals("Y"))
			{
				String uql = "update tbl_address_info set isMain = 'N' where isMain='Y' and user_id = ? ";
				baseDaoImpl.excuteSql(uql, new Object[]{uid});
			}
			baseDaoImpl.save(addrInfo);
			msg.setRspCode("000000").setRspMsg("增加成功！");
			msg.setObjs(addrInfo);
		} catch (DBException e) {
			msg.setRspCode("000001").setRspMsg("数据库异常");
			log.error("店铺信息注册失败，店铺名为[{}]",addrInfo.getProvice(),e);
		}
		
		return msg;
	}
	
	@SuppressWarnings("static-access")
	@Override
	@Transactional
	public Message deleteAddressInfo(TblAddressInfo addrInfo,String uid) {
		
		log.info("删除地址信息：addrid为［{}]",addrInfo.getAddrId());
		Message msg = new Message();
		try {
			
			String uql = "delete from tbl_address_info where addr_id=? and user_id = ? ";
			baseDaoImpl.excuteSql(uql, new Object[]{addrInfo.getAddrId(),uid});
			msg.setRspCode("000000").setRspMsg("增加成功！");
		} catch (DBException e) {
			msg.setRspCode("000001").setRspMsg("数据库异常");
			log.error("店铺信息注册失败，店铺名为[{}]",addrInfo.getProvice(),e);
		}
		
		return msg;
	}
	
	@SuppressWarnings("static-access")
	@Override
	@Transactional
	public Message setDefaultAddr(TblAddressInfo addrInfo,String uid) {
		
		log.info("设置默认地址信息：addrid为［{}]",addrInfo.getAddrId());
		Message msg = new Message();
		try {
			
			String sql1 = "update tbl_address_info set isMain = 'N' where isMain='Y' and user_id = ? ";
			String sql2 = "update tbl_address_info set isMain = 'Y' where addr_id=? and user_id = ? ";
			baseDaoImpl.excuteSql(sql1, new Object[]{uid});
			baseDaoImpl.excuteSql(sql2, new Object[]{addrInfo.getAddrId(),uid});
			msg.setRspCode("000000").setRspMsg("增加成功！");
		} catch (DBException e) {
			msg.setRspCode("000001").setRspMsg("数据库异常");
			log.error("店铺信息注册失败，店铺名为[{}]",addrInfo.getProvice(),e);
		}
		
		return msg;
	}
	
	@SuppressWarnings("static-access")
	@Override
	@Transactional
	public Message updateAddressInfo(TblAddressInfo addrInfo,String uid) {
		
		log.info("更新地址信息：addrid为［{}]",addrInfo.getAddrId());
		Message msg = new Message();
		try {
			
			 String sql = "update tbl_address_info set "
			 		+ "provice = ? , city = ? ,  zone = ? ,address =? ,consignee =?, mobile=?, isMain =? "
			 		+ "where addr_id = ? and user_id =? ";
				
			if(addrInfo.getIsMain()=="Y")
			{
				String uql = "update tbl_address_info set isMain = 'N' where isMain='Y' and user_id =? ";
				baseDaoImpl.excuteSql(sql, new Object[]{addrInfo.getProvice(),addrInfo.getCity(),addrInfo.getZone(), 
						addrInfo.getAddress(),addrInfo.getConsignee(),addrInfo.getMobile(),addrInfo.getIsMain(),addrInfo.getAddrId(),uid});
				baseDaoImpl.excuteSql(uql, new Object[]{uid});
			}	
			else
			{
				baseDaoImpl.excuteSql(sql, new Object[]{addrInfo.getProvice(),addrInfo.getCity(),addrInfo.getZone(),
						addrInfo.getAddress(),addrInfo.getConsignee(),addrInfo.getMobile(),addrInfo.getIsMain(),addrInfo.getAddrId(),uid});
			}
			
		} catch (DBException e) {
			msg.setRspCode("000001").setRspMsg("更新用户信息失败");
			e.printStackTrace();
		}
		msg.setRspCode("000000").setRspMsg("更新用户信息成功！");
		
		return msg;
	}

	@Override
	public Message getDefaultAddr(TblAddressInfo addrInfo, String uid) {
		
		log.info("获取地址信息：addrid为［{}]",addrInfo.getIsMain());
		Message msg = new Message();
		try {
			
			String hql = "from TblAddressInfo t where t.userId = ? and t.isMain =? ";
			List infos = baseDaoImpl.queryByHQL(hql, new Object[]{uid,addrInfo.getIsMain()});
			if(infos.size()<1)
			{
				log.info("未查询到记录");
				msg.setRspCode(ResCodeConstant.MSG_NOT_FOUND);
				msg.setRspMsg(ResCodeConstant.MSG_NOT_FOUND_DESC);
			}
			else
			{
				msg.setRspCode("000000").setRspMsg("成功!");
				msg.setObjs(infos);
			}
		} catch (DBException e) {
			msg.setRspCode("000001").setRspMsg("数据库异常");
			log.error("店铺信息注册失败，店铺名为[{}]",addrInfo.getProvice(),e);
		}
		
		return msg;
	}
}
