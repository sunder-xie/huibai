<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta content="yes" name="apple-mobile-web-app-capable">
<meta content="yes" name="apple-touch-fullscreen">
<meta content="telephone=no" name="format-detection">
<meta content="black" name="apple-mobile-web-app-status-bar-style">
<meta name="viewport" content="width=device-width, minimum-scale=1, maximum-scale=1;user-scalable=no;">
<%@ include file="../common/base.jsp" %>
<base href="<%=tBasePath%>"></base>
<link rel="stylesheet" href="css/bootstrap.css?v=01291">
<link rel="stylesheet" href="css/style.css?v=1?v=01291">
<link rel="stylesheet" href="css/member.css?v=01291">
<link rel="stylesheet" href="css/order3.css?v=01291">

    <link href="css/layout.min.css" rel="stylesheet" />
    <link href="css/scs.min.css" rel="stylesheet" />

<script charset="utf-8" src="js/global.js?v=01291"></script>
<script charset="utf-8" src="js/bootstrap.min.js?v=01291"></script>
<script charset="utf-8" src="js/template.js?v=01291"></script>
<script src="js/jquery.scs.min.js"></script>
<script src="js/CNAddrArr.min.js"></script>
<title>添加新地址</title>
</head>
<body>
<div class="fanhui_cou">
	<div class="fanhui_1"></div>
	<div class="fanhui_ding">顶部</div>
</div>
 <header class="header header_1">
    <div class="fix_nav">
        <div class="nav_inner">
            <a class="nav-left back-icon" href="javascript:history.back();">返回</a>
            <div class="tit">添加新地址</div>
        </div>
    </div>
</header>
<div class="maincontainer">
	<div class="container" style="max-width:768px;margin:0 auto;">
		<div class="row">
			<div class="list-group mb10">
			    <div class="list-group-item">
					收货人
					<input id="consignee" class="text" type="text" value="" >
				</div>
				<div class="list-group-item">
					联系电话
					<input id="phoneNum" class="text" type="text" value="">
				</div>
				<a>
				<div class="list-group-item tip">
					所在地区
					<input type="text" readonly placeholder="请选择" id="myAddrs" name="addr" data-key="" value=""/>
				</div>
				</a>
				<div class="list-group-item addAddr">
				     <textarea id="myAddrs2" maxlength="100" placeholder="建议您如实填写详细收货地址，例如街道名称，门牌号码，楼层和房间号等信息"></textarea>
				</div>
				<div class="list-group-item Addr-defalt">
					<input id="isDefault" type="checkbox" checked /> 设为默认
				</div> 
				
				<div class="clear"></div>
				<div class="p0 mt10">
					<button type="button" class="btn btn-info btn-block"
						onclick="saveAddr();" tabindex="5">保存</button>
				</div>
			</div> 
		</div>
	</div>
</div>

<script type="text/javascript">
var CarIdList='';
var chooseflag =0;/*存放跳转类型*/
$(function(){
	
	setAllDomain();
	/**
     * 通过数组id获取地址列表数组
     *
     * @param {Number} id
     * @return {Array} 
     */ 
    function getAddrsArrayById(id) {
        var results = [];
        if (addr_arr[id] != undefined)
            addr_arr[id].forEach(function(subArr) {
                results.push({
                    key: subArr[0],
                    val: subArr[1]
                });
            });
        else {
            return;
        }
        return results;
    }
    /**
     * 通过开始的key获取开始时应该选中开始数组中哪个元素
     *
     * @param {Array} StartArr
     * @param {Number|String} key
     * @return {Number} 
     */         
    function getStartIndexByKeyFromStartArr(startArr, key) {
        var result = 0;
        if (startArr != undefined)
            startArr.forEach(function(obj, index) {
                if (obj.key == key) {
                    result = index;
                    return false;
                }
            });
        return result;
    }

    //bind the click event for 'input' element
    $("#myAddrs").click(function() {
        var PROVINCES = [],
            startCities = [],
            startDists = [];
        //Province data，shall never change.
        addr_arr[0].forEach(function(prov) {
            PROVINCES.push({
                key: prov[0],
                val: prov[1]
            });
        });
        //init other data.
        var $input = $(this),
            dataKey = $input.attr("data-key"),
            provKey = 1, //default province 北京
            cityKey = 36, //default city 北京
            distKey = 37, //default district 北京东城区
            distStartIndex = 0, //default 0
            cityStartIndex = 0, //default 0
            provStartIndex = 0; //default 0

        if (dataKey != "" && dataKey != undefined) {
            var sArr = dataKey.split("-");
            if (sArr.length == 3) {
                provKey = sArr[0];
                cityKey = sArr[1];
                distKey = sArr[2];

            } else if (sArr.length == 2) { //such as 台湾，香港 and the like.
                provKey = sArr[0];
                cityKey = sArr[1];
            }
            startCities = getAddrsArrayById(provKey);
            startDists = getAddrsArrayById(cityKey);
            provStartIndex = getStartIndexByKeyFromStartArr(PROVINCES, provKey);
            cityStartIndex = getStartIndexByKeyFromStartArr(startCities, cityKey);
            distStartIndex = getStartIndexByKeyFromStartArr(startDists, distKey);
        }
        var navArr = [{//3 scrollers, and the title and id will be as follows:
            title: "省",
            id: "scs_items_prov"
        }, {
            title: "市",
            id: "scs_items_city"
        }, {
            title: "区",
            id: "scs_items_dist"
        }];
        SCS.init({
            navArr: navArr,
            onOk: function(selectedKey, selectedValue) {
                $input.val(selectedValue).attr("data-key", selectedKey);
            }
        });
        var distScroller = new SCS.scrollCascadeSelect({
            el: "#" + navArr[2].id,
            dataArr: startDists,
            startIndex: distStartIndex
        });
        var cityScroller = new SCS.scrollCascadeSelect({
            el: "#" + navArr[1].id,
            dataArr: startCities,
            startIndex: cityStartIndex,
            onChange: function(selectedItem, selectedIndex) {
                distScroller.render(getAddrsArrayById(selectedItem.key), 0); //re-render distScroller when cityScroller change
            }
        });
        var provScroller = new SCS.scrollCascadeSelect({
            el: "#" + navArr[0].id,
            dataArr: PROVINCES,
            startIndex: provStartIndex,
            onChange: function(selectedItem, selectedIndex) { //re-render both cityScroller and distScroller when provScroller change
                cityScroller.render(getAddrsArrayById(selectedItem.key), 0);
                distScroller.render(getAddrsArrayById(cityScroller.getSelectedItem().key), 0);
            }
        });
    });
});

var setAllDomain = function(){
	basepath='';
	$("#curPageNO").val(1);
	chooseflag = getQueryStringByName("flag");
	if(chooseflag==1)
	{
		CarIdList = getQueryStringByName('seqList');
	}
	if(chooseflag==1)
	{
		
	}
}

function saveAddr(){
	var addr1 = $('#myAddrs').val();
		if(addr1==''){
	    floatNotify.simple("请选择所在地区！");
		return;
	}
	
	var strs= new Array(); //定义一数组
	strs=addr1.split(" "); //字符分割 
	var prov = strs[0];
	var city=strs[1];
    var dist = strs[2];
	var addr = $('#myAddrs2').val();
	if(addr=='')
	{	
		floatNotify.simple("请输入详细地址！");
		$("#addr").focus;
		return;
	}
	var person = $('#consignee').val();
	if(person=='')
	{	
		floatNotify.simple("请输入收件人！");
		$("#person").focus;
		return;
	}
	var mobil=  $('#phoneNum').val();
	if(mobil=='')
	{	floatNotify.simple("请输入联系电话！");
		$("#mobil").focus;
		return;
	}
	
	var ismain =document.getElementById('isDefault');
	var mainFlag ='';
	if(ismain.checked)
	{
		mainFlag='Y';
	}
	else
	{
		mainFlag='N';
	}
	
	var url =''+ "Address/AddressAdd.action";
	var param = {
			provice:prov,
			city:city,
			zone:dist,
			address:addr,
			consignee:person,
			mobile :mobil,
			isMain:mainFlag
			};
	$.post(url,param,function(data){
		if("000000"==data.rspCode) {
			//alert(JSON.stringify(data));
			floatNotify.simple("添加成功");
			var addrId= data.objs.addrId;
			//alert(addrId);
			chooseAddr(addrId);
		} else {
			alert(data.rspMsg);
		}
	},"json"); 
}

function chooseAddr(addrId){
	if(chooseflag==1)
	{
		var param ='seqList='+CarIdList+'&&addrId='+addrId;
		var url= 'pages/Order/orderByCar.jsp?'+param;
		window.location = url;
	}
}
</script>
</body>
</html>
