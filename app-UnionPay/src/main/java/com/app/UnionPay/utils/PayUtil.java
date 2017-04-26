package com.app.UnionPay.utils;

import com.hlb.utils.date.DateUtil;

public class PayUtil {
	public static String genPaySeqId(){
		String paySeqId = DateUtil.getCurrentDate(DateUtil.DATE_FORMAT_14);
		int random1 = (int) (Math.random()*9000+1000);
		int random2 = (int) (Math.random()*9000+1000);
		return paySeqId+random1+random2;
	}
}
