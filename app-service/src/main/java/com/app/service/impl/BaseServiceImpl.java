package com.app.service.impl;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.transaction.Transactional;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.app.bean.SysFuncInfo;
import com.app.common.dao.BaseDao;
import com.app.common.exception.DBException;
import com.app.service.BaseService;
import com.app.common.utils.LTConstant;

@Service
public class BaseServiceImpl implements BaseService {
	private Logger log = LoggerFactory.getLogger(this.getClass());
	
	@Resource
	private BaseDao baseDaoImpl;
		
	@SuppressWarnings("unchecked")
	@Transactional
	public List<SysFuncInfo> getMenuNavInfo(SysFuncInfo sysfuncinfo) {
		log.info("获取nav列表，sysid为［{},{}]",sysfuncinfo.getSysId(),sysfuncinfo.getType());
		String hql ="from SysFuncInfo t where t.sysId = ? and t.type = ? and t.status = ? order by t.level,t.seq ";
		try {
			return (List<SysFuncInfo>) baseDaoImpl.queryByHQL(hql, new String[]{sysfuncinfo.getSysId(),sysfuncinfo.getType(),LTConstant.valid_data});
		} catch (DBException e) {
			log.error("进行导航菜单的查询失败，异常为，",e);
			return new ArrayList<SysFuncInfo>();
		}
	}
	
}
