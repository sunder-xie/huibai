package com.app.UnionPay.tencent.service;
import com.app.common.model.Message;

import freemarker.template.TemplateException;

import javax.xml.parsers.ParserConfigurationException;

import org.xml.sax.SAXException;

import com.app.bean.TblPayDtl;
public interface WeiXinPayService {

	public Message UnifiedOrder(TblPayDtl pay, String openId) throws IllegalAccessException, ParserConfigurationException, SAXException, TemplateException;

	public Message H5PayApi(String PrepayId) throws IllegalAccessException;
}
