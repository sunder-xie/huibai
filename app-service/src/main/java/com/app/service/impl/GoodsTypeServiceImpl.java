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
import com.app.common.model.Pager;
import com.hlb.utils.date.DateUtil;
import com.hlb.utils.validate.ValidateUtil;
import com.app.service.GoodsTypeService;
import com.app.bean.TblGoodsTypeInfo;
import com.app.model.GoodsTypeModel;

@Service
public class GoodsTypeServiceImpl implements GoodsTypeService {
	private Logger log = LoggerFactory.getLogger(this.getClass());
	@Resource
	private BaseDao baseDaoImpl;
	
	@Override
	@Transactional
	public Message getGoodsTypeInfo(TblGoodsTypeInfo gtypeInfo) {
		log.info("获取gtype列表，type为［{}]",gtypeInfo.getGoodsId());
		Message msg = new Message();
		try {
			
			//String sql  = "select t.type_id,t.goods_id ,t.type_nm,t.kind,CAST(t.price/100 as DECIMAL(12,2)),t.store ";
			String sql  = "select t.type_id,t.goods_id ,t.type_nm,t.kind,t.price,t.store ";
			String csql =sql+ "from tbl_goods_type_info t"
					+ " where t.goods_id = ? ";
			
			List infos =null;
			
			if(gtypeInfo.getTypeId()!=null&&!gtypeInfo.getTypeId().equals(""))
			{
				csql+="and t.type_id =? ";
			    infos = baseDaoImpl.queryBySQL(csql, new String[]{gtypeInfo.getGoodsId(),gtypeInfo.getTypeId()});
			}	
			else
			{
			   infos = baseDaoImpl.queryBySQL(csql, new String[]{gtypeInfo.getGoodsId()});
			}
			
			
//			String hql = "from TblGoodsTypeInfo t where t.goodsId=?  ";
//			List infos = baseDaoImpl.queryByHQL(hql, new String[]{gtypeInfo.getGoodsId()});
			if(infos.size()<1)
			{
				log.info("未查询到记录");
				msg.setRspCode("000002").setRspMsg("未找到相关记录!");
			}
			else
			{
				msg.setRspCode("000000").setRspMsg("成功!");
				List<GoodsTypeModel> models = new ArrayList<GoodsTypeModel>();
				for(Object object : infos){
					Object[] strs = (Object[])object;
					GoodsTypeModel goodstypeModel = new GoodsTypeModel();
					goodstypeModel.setTypeId(strs[0]+"");
					goodstypeModel.setGoodsId(strs[1]+"");
					goodstypeModel.setTypeNm(strs[2]+"");
					goodstypeModel.setKind(strs[3]+"");
					goodstypeModel.setPrice(strs[4]+"");
					goodstypeModel.setStore( Integer.parseInt(strs[5]+""));
					models.add(goodstypeModel);
				}
				msg.setObjs(models);
//				msg.setObjs(infos);
			}
			
		} catch (DBException e) {
			msg.setRspCode("000001").setRspMsg("数据库异常");
			log.error("gtype获取失败",e);
		}
		
		return msg;
	}
	
	@Override
	@Transactional
	public Message getGoodsTypeInfoByTypeId(String TypeId) {
		log.info("获取gtype信息，TypeId为［{}]",TypeId);
		Message msg = new Message();
		try {
			String hql = "from TblGoodsTypeInfo t where t.typeId=?  ";
			List infos = baseDaoImpl.queryByHQL(hql, new String[]{TypeId});
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
			log.error("gtype获取失败",e);
		}
		
		return msg;
	}
	
}
