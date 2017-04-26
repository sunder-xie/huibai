package com.app.UnionPay.tencent.common;

import com.app.bean.TblPayDtl;
import com.app.UnionPay.tencent.model.WxNoticeReslutReq;
import com.app.UnionPay.tencent.model.WxUnifiedOrderRsp;
import com.app.UnionPay.tencent.protocol.refund_query_protocol.RefundOrderData;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * User: rizenguo
 * Date: 2014/11/1
 * Time: 14:06
 */
public class XMLParser {

    /**
     * 从RefunQueryResponseString里面解析出退款订单数据
     * @param refundQueryResponseString RefundQuery API返回的数据
     * @return 因为订单数据有可能是多个，所以返回一个列表
     */
    public static List<RefundOrderData> getRefundOrderList(String refundQueryResponseString) throws IOException, SAXException, ParserConfigurationException {
        List list = new ArrayList();

        Map<String,Object> map = XMLParser.getMapFromXML(refundQueryResponseString);

       int count = Integer.parseInt((String) map.get("refund_count"));
       Util.log("count:" + count);

        if(count<1){
            return list;
        }

        RefundOrderData refundOrderData;

        for(int i=0;i<count;i++){
            refundOrderData = new RefundOrderData();

            refundOrderData.setOutRefundNo(Util.getStringFromMap(map,"out_refund_no_" + i,""));
            refundOrderData.setRefundID(Util.getStringFromMap(map,"refund_id_" + i,""));
            refundOrderData.setRefundChannel(Util.getStringFromMap(map,"refund_channel_" + i,""));
            refundOrderData.setRefundFee(Util.getIntFromMap(map,"refund_fee_" + i));
            refundOrderData.setCouponRefundFee(Util.getIntFromMap(map,"coupon_refund_fee_" + i));
            refundOrderData.setRefundStatus(Util.getStringFromMap(map,"refund_status_" + i,""));
            list.add(refundOrderData);
        }

        return list;
    }
    
    /**
     * 从UnifiedOrderResponseString里面解析出微信生成二维码数据
     * @param refundQueryResponseString RefundQuery API返回的数据
     * @return 因为订单数据有可能是多个，所以返回一个列表
     */
    public static List<TblPayDtl> getUnifiedOrderInfo(String UnifiedOrderResponseString) throws IOException, SAXException, ParserConfigurationException {
        List list = new ArrayList();

        Map<String,Object> map = XMLParser.getMapFromXML(UnifiedOrderResponseString);

        TblPayDtl payDtlData;

        for(int i=0;i<1;i++){
        	payDtlData = new TblPayDtl();
        	payDtlData.setReturnCode(Util.getStringFromMap(map,"return_code",""));
        	payDtlData.setReturnMsg(Util.getStringFromMap(map,"return_msg",""));
        	payDtlData.setResultCode(Util.getStringFromMap(map,"result_code",""));
        	payDtlData.setErrCode(Util.getStringFromMap(map,"err_code",""));
        	payDtlData.setErrCodeDes(Util.getStringFromMap(map,"err_code_des",""));
        	payDtlData.setCodeUrl(Util.getStringFromMap(map,"code_url",""));
        	payDtlData.setPrepayId(Util.getStringFromMap(map,"prepay_id" ,""));
            list.add(payDtlData);
        }

        return list;
    }
    
    /**
     * 从UnifiedOrderResponseString里面解析出微信生成二维码数据
     * @param refundQueryResponseString RefundQuery API返回的数据
     * @return 因为订单数据有可能是多个，所以返回一个列表
     */
    public static List<WxUnifiedOrderRsp> getUnifiedOrder(String UnifiedOrderResponseString) throws IOException, SAXException, ParserConfigurationException {
        List list = new ArrayList();

        Map<String,Object> map = XMLParser.getMapFromXML(UnifiedOrderResponseString);

        WxUnifiedOrderRsp orderData;

        for(int i=0;i<1;i++){
        	orderData = new WxUnifiedOrderRsp();
        	orderData.setReturn_code(Util.getStringFromMap(map,"return_code",""));
        	orderData.setReturn_msg(Util.getStringFromMap(map,"return_msg",""));
        	orderData.setAppid(Util.getStringFromMap(map,"appid",""));
        	orderData.setMch_id(Util.getStringFromMap(map,"mch_id",""));
        	orderData.setDevice_info(Util.getStringFromMap(map,"device_info",""));
        	orderData.setNonce_str(Util.getStringFromMap(map,"nonce_str",""));
        	orderData.setSign(Util.getStringFromMap(map,"sign" ,""));
        	orderData.setResult_code(Util.getStringFromMap(map,"result_code",""));
        	orderData.setErr_code(Util.getStringFromMap(map,"err_code",""));
        	orderData.setErr_code_des(Util.getStringFromMap(map,"err_code_des",""));
        	orderData.setTrade_type(Util.getStringFromMap(map,"trade_type",""));
        	orderData.setPrepay_id(Util.getStringFromMap(map,"prepay_id" ,""));
        	orderData.setCode_url(Util.getStringFromMap(map,"code_url",""));
        	
            list.add(orderData);
        }

        return list;
    }
    
    /**
     * 从ResultNoticeString里面解析出结果通知
     * @param refundQueryResponseString RefundQuery API返回的数据
     * @return 因为订单数据有可能是多个，所以返回一个列表
     */
    public static List<WxNoticeReslutReq> getWxResultNotice(String ResultNoticeString) throws IOException, SAXException, ParserConfigurationException {
        List list = new ArrayList();

        Map<String,Object> map = XMLParser.getMapFromXML(ResultNoticeString);

        WxNoticeReslutReq restltData;

        for(int i=0;i<1;i++){
        	restltData = new WxNoticeReslutReq();
        	restltData.setReturn_code(Util.getStringFromMap(map,"return_code",""));
        	restltData.setReturn_msg(Util.getStringFromMap(map,"return_msg",""));
        	restltData.setAppid(Util.getStringFromMap(map,"appid",""));
        	restltData.setMch_id(Util.getStringFromMap(map,"mch_id",""));
        	restltData.setDevice_info(Util.getStringFromMap(map,"device_info",""));
        	restltData.setNonce_str(Util.getStringFromMap(map,"nonce_str",""));
        	restltData.setSign(Util.getStringFromMap(map,"sign" ,""));
        	restltData.setSign_type(Util.getStringFromMap(map,"sign_type" ,""));
        	
        	restltData.setResult_code(Util.getStringFromMap(map,"result_code",""));
        	restltData.setErr_code(Util.getStringFromMap(map,"err_code",""));
        	restltData.setErr_code_des(Util.getStringFromMap(map,"err_code_des",""));
        	restltData.setOpenid(Util.getStringFromMap(map,"openid",""));
        	restltData.setIs_subscribe(Util.getStringFromMap(map,"is_subscribe",""));
        	restltData.setTrade_type(Util.getStringFromMap(map,"trade_type",""));
        	restltData.setBank_type(Util.getStringFromMap(map,"bank_type",""));
        	
        	restltData.setTotal_fee(Util.getIntFromMap(map, "total_fee"));
        	restltData.setSettlement_total_fee(Util.getIntFromMap(map, "settlement_total_fee"));
        	restltData.setAttach(Util.getStringFromMap(map,"attach",""));
        	restltData.setFee_type(Util.getStringFromMap(map,"fee_type",""));
        	restltData.setCash_fee(Util.getIntFromMap(map, "cash_fee"));
        	restltData.setCash_fee_type(Util.getStringFromMap(map,"cash_fee_type",""));
        	
        	restltData.setTransaction_id(Util.getStringFromMap(map,"transaction_id",""));
        	restltData.setOut_trade_no(Util.getStringFromMap(map,"out_trade_no",""));
        	
        	restltData.setTime_end(Util.getStringFromMap(map,"time_end",""));
        	
            list.add(restltData);
        }

        return list;
    }

    public static Map<String,Object> getMapFromXML(String xmlString) throws ParserConfigurationException, IOException, SAXException {

        //这里用Dom的方式解析回包的最主要目的是防止API新增回包字段
        DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
        DocumentBuilder builder = factory.newDocumentBuilder();
        InputStream is =  Util.getStringStream(xmlString);
        Document document = builder.parse(is);

        //获取到document里面的全部结点
        NodeList allNodes = document.getFirstChild().getChildNodes();
        Node node;
        Map<String, Object> map = new HashMap<String, Object>();
        int i=0;
        while (i < allNodes.getLength()) {
            node = allNodes.item(i);
            if(node instanceof Element){
                map.put(node.getNodeName(),node.getTextContent());
            }
            i++;
        }
        return map;

    }


}
