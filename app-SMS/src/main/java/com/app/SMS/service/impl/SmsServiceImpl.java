package com.app.SMS.service.impl;

import org.json.JSONArray;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.app.SMS.alidayu.Utils.alidayu;
import com.app.SMS.service.SmsService;
import com.app.common.model.Message;
import com.taobao.api.ApiException;
import com.taobao.api.DefaultTaobaoClient;
import com.taobao.api.TaobaoClient;
import com.taobao.api.request.AlibabaAliqinFcSmsNumSendRequest;
import com.taobao.api.response.AlibabaAliqinFcSmsNumSendResponse;

@Service
public class SmsServiceImpl implements SmsService{

	private Logger log = LoggerFactory.getLogger(this.getClass());
	
	@Override
	public Message send_reg_user_code(String telphone,String smscode)
	{
		Message msg =new Message();
		String rspMsg = "";
		TaobaoClient client = new DefaultTaobaoClient(alidayu.url, alidayu.appKey, alidayu.appSecret);
		AlibabaAliqinFcSmsNumSendRequest req = new AlibabaAliqinFcSmsNumSendRequest();
		req.setExtend("123456");
		req.setSmsType("normal");
		req.setSmsFreeSignName("乐汇百材");
		req.setSmsParamString("{\"code\":\""+smscode+"\"}");
		req.setRecNum(telphone);
		req.setSmsTemplateCode("SMS_66960059");
		AlibabaAliqinFcSmsNumSendResponse rsp = null;
		try {
			rsp = client.execute(req);
			rspMsg = "["+rsp.getBody()+"]";
			log.info("返回数据为："+ rspMsg);
			
			rspMsg= "[{\"alibaba_aliqin_fc_sms_num_send_response\":{\"result\":{\"err_code\":\"0\",\"model\":\"107437380028^1110011073193\",\"success\":true},\"request_id\":\"3g3f6ahnl69n\"}}]";

			JSONArray jsonArray = new JSONArray(rspMsg);
			int iSize = jsonArray.length();
			for (int i = 0; i < iSize; i++) {
				JSONObject jsonObj = jsonArray.getJSONObject(i);
				if(jsonObj.has("alibaba_aliqin_fc_sms_num_send_response"))
				{
					JSONObject result = jsonObj.getJSONObject("alibaba_aliqin_fc_sms_num_send_response").getJSONObject("result");
					String smsResult = result.getString("err_code");
					if(smsResult.equals("0"))
					{
						msg.setRspCode("000000").setRspMsg("发送成功！");
					}
					else{
						msg.setRspCode(smsResult).setRspMsg("发送短信失败，请重试！");
					}
				}
				else if(jsonObj.has("error_response"))//返回的是boolean类型的
				{
					JSONObject result = jsonObj.getJSONObject("error_response");
					int errcode = result.getInt("code");
					String errmsg = result.getString("msg");
					msg.setRspCode(errcode+"").setRspMsg("发送短信失败，请重试！");
				}else{
					msg.setRspCode("000003").setRspMsg("发送短信失败，请重试！");
					return msg;
				}
			}
			
		} catch (ApiException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			msg.setRspCode("000003").setRspMsg("发送短信失败，请重试！");
		}
		return msg;
	}
	
}
