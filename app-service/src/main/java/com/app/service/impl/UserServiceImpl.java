package com.app.service.impl;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.app.common.dao.BaseDao;
import com.app.common.exception.DBException;
import com.app.common.model.Message;
import com.hlb.utils.date.DateUtil;
import com.hlb.utils.security.UUID;
import com.app.service.UserService;
import com.app.bean.TblOauth2UserInfo;
import com.app.bean.TblUserInfo;
import com.app.common.utils.LTConstant;

@Service
public class UserServiceImpl implements UserService {
	private Logger log = LoggerFactory.getLogger(this.getClass());
	@Resource
	private BaseDao baseDaoImpl;
	
	@Override
	@Transactional
	public Message saveUser(TblUserInfo userInfo,HttpSession session) {
		log.info("获取用户信息进行用户信息的注册，用户名为［{}]",userInfo.getUsername());
		Message msg = new Message();
		if(validUser(userInfo)){
			try {
				String hql = "from TblUserInfo t where t.username = ?";
				List infos = baseDaoImpl.queryByHQL(hql, new String[]{userInfo.getUsername()});
				if(infos.size() > 0){
					msg.setRspCode("000001").setRspMsg("用户已存在！");
					return msg;
				}
				UUID uuid =new UUID();
				userInfo.setId(uuid.getUUID());
				BCryptPasswordEncoder encoder =new BCryptPasswordEncoder();
				userInfo.setPassword(encoder.encode(userInfo.getPassword()));
				userInfo.setRegDt(DateUtil.getCurrentDate(DateUtil.DATE_FORMAT_14));
				userInfo.setUpdDt(userInfo.getRegDt());
				baseDaoImpl.save(userInfo);
				session.setAttribute(LTConstant.userInfo, userInfo);
				msg.setRspCode("000000").setRspMsg("登录成功！");
			} catch (DBException e) {
				msg.setRspCode("000001").setRspMsg("数据库异常");
				log.error("用户信息注册失败，用户名为[{}]",userInfo.getUsername(),e);
			}
		}else{
			msg.setRspCode("100001").setRspMsg("用户校验失败");
		}
		return msg;
	}
	
	@Override
	@Transactional
	public Message LoginUser(TblUserInfo userInfo,HttpSession session) {
		log.info("获取用户信息进行用户信息的注册，用户名为［{}]",userInfo.getUsername());
		Message msg = new Message();
		if(validUser(userInfo)){
			try {
				String hql = "from TblUserInfo t where t.username = ?";
				
				BCryptPasswordEncoder encoder =new BCryptPasswordEncoder();
				
			//	System.out.println(encoder.encode(userInfo.getPassword()));
				
				List infos = baseDaoImpl.queryByHQL(hql, new String[]{userInfo.getUsername()});
				if(infos.size() > 0){
					TblUserInfo usertemp =(TblUserInfo)infos.get(0);
					//if(encpassword.equals(usertemp.getPassword()))
					if(encoder.matches(userInfo.getPassword(), usertemp.getPassword()))
					{
						//usertemp.setPassword("");
						userInfo = usertemp;
						session.setAttribute(LTConstant.userInfo, usertemp);
						session.setAttribute(LTConstant.loginKey, "success");
						msg.setRspCode("000000").setRspMsg("登录成功！");
						msg.setObjs(usertemp);
					}					
					else
					{
						msg.setRspCode("000002").setRspMsg("密码错误！");
						return msg;
					}
					
				}
				else
				{
					msg.setRspCode("000001").setRspMsg("用户不存在");
					log.error("用户信息获取失败，用户名为[{}]",userInfo.getUsername());
				};
			} catch (DBException e) {
				msg.setRspCode("000001").setRspMsg("数据库异常");
				log.error("用户信息获取失败，用户名为[{}]",userInfo.getUsername(),e);
			}
		}else{
			msg.setRspCode("000001").setRspMsg("用户校验失败");
		}
		
		
		return msg;
	}

	private boolean validUser(TblUserInfo userInfo){
		/*if(userInfo==null){
			return false;
		}else if(!ValidateUtil.matchFromProperty(userInfo.getUserEmail(), ValidateUtil.isEmail)){
			return false;
		}*/
		return true;
	} 

	@Override
	@Transactional
	public Message LoginoutUser(HttpSession session) {
		Message msg = new Message();
		session.removeAttribute(LTConstant.userInfo);  
		session.removeAttribute(LTConstant.loginKey);
		msg.setRspCode("000000").setRspMsg("退出成功！");
		return msg;
	}

	@Override
	public Message updateUserInfo(String username, String nickname, String useremail, String usertell, HttpSession session) {
		Message msg = new Message();
		String sql = "update TBL_USER_INFO set nickName = ? , userEmail = ? ,  userTel = ? where username = ?";
		try {
			System.out.println();
			baseDaoImpl.excuteSql(sql, new Object[]{nickname, useremail, usertell, username});
		} catch (DBException e) {
			msg.setRspCode("01").setRspMsg("更新用户信心失败");
			e.printStackTrace();
		}
		TblUserInfo temp = (TblUserInfo) session.getAttribute(LTConstant.userInfo);
		temp.setNickName(nickname);
		temp.setUserEmail(useremail);
		temp.setUserTel(usertell);
		session.setAttribute(LTConstant.userInfo, temp);
		msg.setRspCode("00").setRspMsg("更新用户信心成功");
		return msg;
	}
	
	@Override
	public Message updateUserPwd(String username,String oldpwd,String newpwd,HttpSession session){
		Message msg = new Message();
		
		try {
			String hql = "from TblUserInfo t where t.username = ?";
			BCryptPasswordEncoder encoder =new BCryptPasswordEncoder();
		//	System.out.println(encoder.encode(userInfo.getPassword()));
			List infos = baseDaoImpl.queryByHQL(hql, new String[]{username});
			if(infos.size() > 0){
				TblUserInfo usertemp =(TblUserInfo)infos.get(0);
				if(encoder.matches(oldpwd, usertemp.getPassword()))
				{
					String sql1 = "update TBL_USER_INFO set password = ? where username = ?";
					String password =encoder.encode(newpwd);
					baseDaoImpl.excuteSql(sql1, new Object[]{password,username});
					usertemp.setPassword(password);
					session.removeAttribute(LTConstant.userInfo);
					session.setAttribute(LTConstant.userInfo, usertemp);
					msg.setRspCode("000000").setRspMsg("修改成功！");
					msg.setObjs(usertemp);
				}					
				else
				{
					msg.setRspCode("000002").setRspMsg("密码错误！");
					return msg;
				}
				
			}
			else
			{
				msg.setRspCode("000001").setRspMsg("用户不存在");
				log.error("用户信息获取失败，用户名为[{}]",username);
			};
		} catch (DBException e) {
			msg.setRspCode("000001").setRspMsg("数据库异常");
			log.error("用户信息获取失败，用户名为[{}]",username,e);
		}

		return msg;
	}

	@Override
	@Transactional
	public Message saveOAuth2User(TblUserInfo userInfo, TblOauth2UserInfo oauth2user,HttpSession session) {
		log.info("获取第三方用户信息进行用户信息的注册，用户名为［{}]",userInfo.getUsername());
		Message msg = new Message();
		if(validUser(userInfo)){
			try {
				String hql = "from TblOauth2UserInfo t where t.openid = ? and t.channel= ? ";
				List infos = baseDaoImpl.queryByHQL(hql, new String[]{oauth2user.getOpenid(),oauth2user.getChannel()});
				if(infos.size() > 0){
					TblOauth2UserInfo oauth2temp =(TblOauth2UserInfo)infos.get(0);
					
					oauth2temp.setAccessToken(oauth2user.getAccessToken());
					oauth2temp.setExpires(oauth2user.getExpires());
					oauth2temp.setHeadimgurl(oauth2user.getHeadimgurl());
					baseDaoImpl.update(oauth2temp);
					
					hql = "from TblUserInfo t where t.id = ?";
					infos = baseDaoImpl.queryByHQL(hql, new String[]{oauth2temp.getUserId()});
					if(infos.size() > 0){
						TblUserInfo userTemp = new TblUserInfo();
						userTemp = (TblUserInfo)infos.get(0);
						userTemp.setNickName(userInfo.getNickName());
						userTemp.setPortrait(userInfo.getPortrait());
						session.setAttribute(LTConstant.userInfo, userTemp);
					}
					msg.setRspCode("000000").setRspMsg("登录成功！");
					log.info("用户信息更新成功，opendid为[{}]",oauth2temp.getOpenid());
					return msg;
				}
				
				hql = "from TblUserInfo t where t.username = ?";
				infos = baseDaoImpl.queryByHQL(hql, new String[]{userInfo.getUsername()});
				if(infos.size() > 0){
					msg.setRspCode("000001").setRspMsg("用户已存在！");
					return msg;
				}
				UUID uuid =new UUID();
				String user_id = uuid.getUUID();
				userInfo.setId(user_id);
				BCryptPasswordEncoder encoder =new BCryptPasswordEncoder();
				userInfo.setPwdErrorNum(0);
				userInfo.setPassword(encoder.encode(userInfo.getPassword()));
				userInfo.setRegDt(DateUtil.getCurrentDate(DateUtil.DATE_FORMAT_14));
				userInfo.setUpdDt(userInfo.getRegDt());
				
				oauth2user.setOauth2Id(user_id);
				oauth2user.setUserId(user_id);
				
				baseDaoImpl.save(userInfo);
				baseDaoImpl.save(oauth2user);
				
				session.setAttribute(LTConstant.userInfo, userInfo);
				
				msg.setRspCode("000000").setRspMsg("登录成功！");
				log.info("用户信息注册成功，用户名为[{}]",userInfo.getUsername());
			} catch (DBException e) {
				msg.setRspCode("000001").setRspMsg("数据库异常");
				log.error("用户信息注册失败，用户名为[{}]",userInfo.getUsername(),e);
			}
		}else{
			msg.setRspCode("100001").setRspMsg("用户校验失败");
		}
		return msg;
	}
	
	@Override
	@Transactional
	public Message GetOAuth2UserInfo(String userId,String Channle) {
		log.info("获取用户信息进行用户信息的注册，用户名为［{}]",userId);
		Message msg = new Message();
		
		try {
				String hql = "from TblOauth2UserInfo t where t.userId = ? and t.channel= ? ";
				
				List infos = baseDaoImpl.queryByHQL(hql, new String[]{userId,Channle});
				if(infos.size() > 0){
					TblOauth2UserInfo usertemp =(TblOauth2UserInfo)infos.get(0);
					msg.setRspCode("000000").setRspMsg("登录成功！");
					msg.setObjs(usertemp);
				}
				else
				{
					msg.setRspCode("000001").setRspMsg("用户不存在");
					log.error("用户信息获取失败，用户名为[{}]",userId);
				};
			} catch (DBException e) {
				msg.setRspCode("000001").setRspMsg("数据库异常");
				log.error("用户信息获取失败，用户名为[{}]",userId);
			}
		
		return msg;
	}
	
}
