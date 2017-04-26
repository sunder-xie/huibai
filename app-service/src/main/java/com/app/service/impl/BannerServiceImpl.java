package com.app.service.impl;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.app.bean.TblBannerInfo;
import com.app.common.dao.BaseDao;
import com.app.common.exception.DBException;
import com.app.common.model.Message;
import com.app.common.model.Pager;
import com.hlb.utils.date.DateUtil;
import com.hlb.utils.validate.ValidateUtil;
import com.app.service.BannerService;
import com.app.model.BannerInfoModel;

@Service
public class BannerServiceImpl implements BannerService {
	private Logger log = LoggerFactory.getLogger(this.getClass());
	@Resource
	private BaseDao baseDaoImpl;
	
	@Override
	@Transactional
	public Message getBannerInfo(TblBannerInfo bannerInfo) {
		log.info("获取banner列表，type为［{}]",bannerInfo.getType());
		Message msg = new Message();
		try {
			
			String sql  = "select t.banner_id ,t.title,t.res_id,c.url as picUrl,t.background, t.url ";
			String csql =sql+ "from tbl_banner_info t"
					+ " left join tbl_resources_info c on c.resid=t.res_id where t.type = ? and t.status = '0' ";
			
			List infos = baseDaoImpl.queryBySQL(csql, new String[]{bannerInfo.getType()});
			if(infos.size()<1)
			{
				log.info("未查询到记录");
				msg.setRspCode("000002").setRspMsg("未找到相关记录!");
			}
			else
			{
				msg.setRspCode("000000").setRspMsg("成功!");
				List<BannerInfoModel> models = new ArrayList<BannerInfoModel>();
				for(Object object : infos){
					Object[] strs = (Object[])object;
					BannerInfoModel bannerModel = new BannerInfoModel();
					bannerModel.setBannerId(strs[0]+"");
					bannerModel.setTitle(strs[1]+"");
					bannerModel.setResId(strs[2]+"");
					bannerModel.setImgUrl(strs[3]+"");
					bannerModel.setBackground(strs[4]+"");
					bannerModel.setUrl(strs[5]+"");
					models.add(bannerModel);
				}
				msg.setObjs(models);
			}
			
		} catch (DBException e) {
			msg.setRspCode("000001").setRspMsg("数据库异常");
			log.error("banner获取失败",e);
		}
		
		return msg;
	}
	
}
