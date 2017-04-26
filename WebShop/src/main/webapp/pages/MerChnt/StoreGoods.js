var basepath=null; /*根目录*/
var shop_id =null;
var user_id = null ;
var startpagenum =1;
var offset =10;

var keys = [
            {text: "全部", auditValue: "-1", publishValue:"-1"},
            {text: "待审核", auditValue: "1", publishValue:"-1"},
            {text: "已上架", auditValue: "2", publishValue:"1"},
            {text: "待上架", auditValue: "2", publishValue:"2"},
            {text: "审核不通过", auditValue: "3", publishValue:"2"},
            {text: "违规下架", auditValue: "5", publishValue:"2"},
            {text: "强制下架", auditValue: "6", publishValue:"2"}
            ];

//显示按钮
function showOptionBtn() {
//todo
$(".batchOperation").addClass('state');
}
// 隐藏按钮
function hideOptionBtn() {
//todo
$(".batchOperation").removeClass('state');
}

var setAllDomain = function(){
	basepath=getRootPath();	
	shop_id=GetQueryString("shop_id");
	user_id =GetQueryString("user_id");
	/*审核状态*/
    $(".select_btn").on('click', function () {
	    $("#goodsManageSelectAuditUl").empty();
	    $.each(keys, function (index, key) {
	    $("<li></li>").text(key.text).appendTo("#goodsManageSelectAuditUl").on('mousedown', function () {
	    var _thisText = $(this).text();
	    $("#goodsManageAudit").val(_thisText);
	    $.each(keys, function (index, key) {
	    if (key.text == _thisText) {
	    $("#auditState").val(key.auditValue);
	    $("#publishState").val(key.publishValue);
	    }
	    });
	    $("#goodsManageSelectAuditUl").hide();
	    });
	    });
	
	    if($("#goodsManageSelectAuditUl").is(":visible")){
	        $("#goodsManageSelectAuditUl").hide();
	    }else{
	        $("#goodsManageSelectAuditUl").show();
	        }
    });
    
    var time1=$('#startTime').val();
    var time2=$('#endTime').val();
    $('#goodsManagereset').click(function(){
        $('.goodsname').val('');
        $('#goodsManageAudit').val('全部');
        $('#auditState').val(-1);
        $('#publishState').val(-1);
        $('#startTime').val(time1);
        $('#endTime').val(time2);
    })

    $("#goodsManageSearchBtn").on('click', function (e) {
        $("#goodsForm").submit()
    })
    
    $("body").on('click', function (e) {
        var target = e.target;
        if (target.id != "goodsManageSelectAuditBtn") {
            $("#goodsManageSelectAuditUl").hide();
        }
    })
}


/*#初始化出来label标签*/
function init() {
	updateSelectAuditState('-1','-1');
	
	$("input[name='ck1']").prop("checked", false);
	
	hideOptionBtn();
	$("input[name='ckAll']").prop("checked", false);
	
	if ($("input[name='ck1']").length == 0) {
		$("input[name='ckAll']").prop("disabled", true);
	    }
	else{$("input[name='ckAll']").prop("disabled", false);}
	
}

//通过审核状态值重置审核状态
function updateSelectAuditState(auditValue,publishValue) {
	if ((keys.length > 0) && (typeof(auditValue) != "undefined")) 
	{
		$.each(keys, function (index, key) {
		if (key.auditValue == auditValue && key.publishValue == publishValue) 
		{
			$("#goodsManageAudit").val(key.text);
		}
		})
	}
}

var getGoodsLists = function(pagenumber,offsize){
	var GoodsList='';
	var key ; //关键词
	//alert(window.location.href);
	key=GetQueryString("shop_id");
	var map={
		shopId:key,
		keyword:'',
		status:'9'
	};
	var param = {
		start:pagenumber,
		offset:offsize,			
		conditions:map
	};
//	alert(JSON.stringify(param));
    $.post(basepath+'Search/serGoodsShortInfListByKeyword.action',param,function(data){
//	alert(JSON.stringify(data));
	if(data.rspCode=="000002"||data.rspCode=="000001"){
		GoodsList+='<tr><td colspan="2" style="padding:20px 0;">没有商品,请发布商品</td></tr>';
		$("#goodsList").append(GoodsList);
	}else{
		var len = data.result.length;
		var num= data.result.length < data.offset ? data.result.length :data.offset;
		
		for(var j=0;j<num;j++){
		var goodsid = data.result[j].goodsId,
		goodsnm = data.result[j].goodsNm,
		amount=AmtToDecimal2(data.result[j].amount),
		shop_id = data.result[j].shopId,
		shopnm = data.result[j].shopNm,
		imgurl = data.result[j].mainPicUrl,
		goods_url = basepath+'pages/Goods/goodsInfo.jsp?goods_id='+goodsid + '&shop_id='+shop_id,
		status = data.result[j].status,
		instDt = formatStringyyyyMMddToyyyy_MM_ddhh_mm_ss(data.result[j].instDt),
		totalstore =  data.result[j].store,
		reason = data.result[j].reason;
		
		if(status == '0')
		{
			var checkboxflag = '<input type="checkbox" name="ck1" />';
			var statusDesc = '已上架';
			var opertion = '          <a href="javascript:void(0)" class="edit">编辑</a>';
			opertion +='          <a href="javascript:void(0)" class="xj">下架</a>';
		}else if(status == '2'){
			var checkboxflag = '<input type="checkbox" name="ck1" />';
			//var checkboxflag = '<input type="checkbox" name="ckDisabled" disabled="true" />';
			var statusDesc = '审核不通过';
			var opertion = '          <a href="javascript:void(0)" class="edit">编辑</a>';
			opertion +='          <a href="javascript:void(0)" class="reason" reason="'+reason+'" reasontit="'+status+'">查看原因</a>';
			opertion +='          <a href="javascript:void(0)" class="sc">删除</a>';
		}else if(status == '3'){
			var checkboxflag = '<input type="checkbox" name="ck1" />';
			//var checkboxflag = '<input type="checkbox" name="ckDisabled" disabled="true" />';
			var statusDesc = '强制下架';
			var opertion = '          <a href="javascript:void(0)" class="edit">编辑</a>';
			opertion +='          <a href="javascript:void(0)" class="reason" reason="'+reason+'" reasontit="'+status+'">查看原因</a>';
			opertion +='          <a href="javascript:void(0)" class="sc">删除</a>';
		}else if(status == '4'){
			var checkboxflag = '<input type="checkbox" name="ck1" />';
			//var checkboxflag = '<input type="checkbox" name="ckDisabled" disabled="true" />';
			var statusDesc = '违规下架';
			var opertion = '          <a href="javascript:void(0)" class="edit">编辑</a>';
			opertion +='          <a href="javascript:void(0)" class="reason" reason="'+reason+'" reasontit="'+status+'">查看原因</a>';
			opertion +='          <a href="javascript:void(0)" class="sc">删除</a>';
		}
		else {
			var checkboxflag = '<input type="checkbox" name="ck1" />';
			//var checkboxflag = '<input type="checkbox" name="ckDisabled" disabled="true" />';
			var statusDesc = '待上架';
			var opertion = '          <a href="javascript:void(0)" class="edit">编辑</a>';
			opertion +='          <a href="javascript:void(0)" class="sj">上架</a>';
		}
		GoodsList+=' <li class="clearfix" id="'+goodsid+'">';
		GoodsList+='  <div class="w88 check">';
		GoodsList+= checkboxflag;
		GoodsList+='  </div>';
		GoodsList+='  <div class="w115 img goodsImg fl">';
		GoodsList+='          <span> <img src="'+imgurl+'" alt="'+goodsnm+'"/> </span>';
		GoodsList+='  </div>';
		GoodsList+='      <div class="w200 goodsname fl">';
		GoodsList+='      <h3><a href="'+goods_url+'" target="_blank">'+goodsnm+'</a></h3>';
//		GoodsList+='      <span>ID：4613931';
//		
//		GoodsList+='      </span>';
		GoodsList+='  </div>';
		GoodsList+='  <div class="w115 price fl">'+amount+'</div>';
		GoodsList+='  <div class="w115 stock fl">';
		GoodsList+='      <em>'+totalstore+'</em><span>(已售0)</span>';
		GoodsList+='  </div>';
		GoodsList+= '  <div class="w115 stock state fl">';
		GoodsList+='          <em>'+statusDesc+'</em>';
		GoodsList+='          <span>'+instDt+'</span>';
		GoodsList+='  </div>';
		GoodsList+='  <div class="w172 operation fl">';
		GoodsList+='      <em>';
		GoodsList+= opertion;
		GoodsList+='      </em>';
		GoodsList+=' </div>';
		GoodsList+=' </li>';
	    }
		
		$("#J_bottomPage").empty();
		$("#goodsList").html(GoodsList);
		$("#J_bottomPage").pager({ pagenumber: pagenumber, pagecount:data.pageCount,totalcount:data.total, buttonClickCallback: PageClick});  
		
		//商品列表间隔背景
		$("#goodsList > li:odd").css("background-color", "#f6f6f6");
		
		$(".edit").click(function(){
	    	var goodsId;
	    goodsId=$(this).parents("li").attr("id");
	    turnToEditPage(goodsId);
	    });
		
		 //上架弹出窗口 ，批量/单个
	    $("#putaway,.sj").on('click', function (e) {
		    if ($(this).hasClass('state') || $(this).hasClass('sj')) {
		        showTips(".sj_tips_box");
		    e.preventDefault();
		
		    if ($(this).hasClass('state')) {
		    var id = getProductID();
		    $(".sj_tips_box .confirm").prop("rel", id.join(","));
		    } else {
		    var id = $(this).parents("li").prop("id");
		    $(".sj_tips_box .confirm").prop("rel", id)
		    }
		    }
	    });


	    //下架弹出窗口	，批量
	    $("#soldout").on('click', function (e) {
	        if ($(this).hasClass('state')) {
	            showTips(".xj_tips_box");
	            e.preventDefault();
	            if ($(this).hasClass('state')) {
	                var id = getProductID();
	                $(".xj_tips_box .confirm").prop("rel", id.join(","));
	            } else {
	                var id = $(this).parents("li").prop("id");
	                $(".xj_tips_box .confirm").prop("rel", id)
	            }
	        }
	    });

	    /*下架弹出窗口  单个*/
	    $(".xj").click(function(){
	    	var goodsId;
		    goodsId=$(this).parents("li").attr("id");
		    showTips(".xj_tips_box");
		    $(".xj_tips_box .confirm").prop("rel", goodsId);
	    });
	    
//	    function soldOutXHR(){
//	        $.ajax({
//	        url:"#/user/task/checkGoods",
//	        type:"post",
//	        dataType:"jsonp",
//	        data:{"id":goodsId,"userId":_merchant_user_id_},
//	        jsonp:"jsonpCallback",
//	        jsonpCallback:"editFunction",
//	        success:function(res){
//	        if(res.success){
//	            if(res.data==true){
//	            showTips(".fx_tips_box");
//	            $(".fx_tips_box .confirm").prop("rel", goodsId);
//	            }else{
//	            showTips(".xj_tips_box");
//	            $(".xj_tips_box .confirm").prop("rel", goodsId);
//	        }
//	        }else{
//	        alert(res.message);
//	        }
//	        },
//	        error:function(){
//	        alert("服务器异常");
//	        }
//	        })
//	        }
	    //删除弹出窗口，单个
	    $(".sc").on('click', function (e) {
	        var id = $(this).parents("li").prop("id");
	        if(!isInactivity(id)){
	        	alert('dd');
	        	return false;
	        }
	        showTips(".delete_tips_box");
	        e.preventDefault();
	        $(".delete_tips_box .confirm").prop("rel", id);
	    });

	    //查看原因弹出窗口 reason_tips_box
	    $(".reason").on("click",function(e){
	        showTips(".reason_tips_box");
	        var reasonStr = '';
	        if( $(this).attr("reasonTit") == "2" ){
	            reasonStr = "审核不通过原因";
	        }else if( $(this).attr("reasonTit") == "4" ){
	            reasonStr = "违规下架原因";
	        }else if($(this).attr("reasonTit") == "3" ){
	            reasonStr = "强制下架原因";
	        }
	        $(".reason_tips_box .fl").text( reasonStr );
	        if($(this).attr("reasonTit") == "5") {
	            $(".reason_tips_box .notice").html("<p>"+ $(this).attr("reason")+"</p><p>您可以编辑后再上架或者删除商品。</p>" );
	        } else {
	            $(".reason_tips_box .notice").html("<p>"+ $(this).attr("reason")+"</p>" );
	        }
	    })
	    $(".reason_tips_box .confirm").on('click', function (e) {
	        hideTips(".reason_tips_box");
	    });

	    //上架确定
	    $(".sj_tips_box .confirm").on('click', function (e) {
	        hideTips(".sj_tips_box");
	        e.preventDefault();
	        var ids = $(this).prop("rel");
	        var param = {
	    			goodsIdList: ids,
	    			status : "0"
	    	};
	    	
//	        alert(JSON.stringify(param));
	    	var url = basepath+'Goods/UpdateGoodsStatus.action?shopId='+shop_id;
	    	$.post(url,param,function(data){
	//	    	alert(JSON.stringify(data));
		    	if(data.rspCode=="000000"){
		    		location.reload();
		    	}
		    	else
		    	{
		    	}	
		    },"json");
	    });

	    //下架确定
	    $(".xj_tips_box .confirm").on('click', function (e) {
	        hideTips(".tips_box");
	        e.preventDefault();
	        var ids = $(this).prop("rel");
	        var param = {
	    			goodsIdList: ids,
	    			status : "1"
	    	};
	    	
	       // alert(JSON.stringify(param));
	    	var url = basepath+'Goods/UpdateGoodsStatus.action?shopId='+shop_id;
	    	$.post(url,param,function(data){
	//	    	alert(JSON.stringify(data));
		    	if(data.rspCode=="000000"){
		    		location.reload();
		    	}
		    	else
		    	{
		    	}	
		    },"json");
	    });

	    //删除确定
	    $(".delete_tips_box .confirm").on('click', function (e) {
		    hideTips(".delete_tips_box");
		    e.preventDefault();
		    var ids = $(this).prop("rel");
		    var param = {
	    			goodsIdList: ids,
	    	};
	    	
//	        alert(JSON.stringify(param));
	    	var url = basepath+'Goods/DeleteGoodsInfo.action?shopId='+shop_id;
	    	$.post(url,param,function(data){
	//	    	alert(JSON.stringify(data));
		    	if(data.rspCode=="000000"){
		    		location.reload();
		    	}
		    	else
		    	{
		    	}	
		    },"json");
	    	
	    });

	    $(".clear_btn,.cancel").on('click', function () {
	    	hideTips(".tips_box");
	    });

	    //下架操作成功后刷新列表
	    $("#tiplock .okBtn").on('click', function (e) {
	    	location.reload();
	    });

	    //二维码
	    $(".code").on('click', function () {
		    var obj = $(this);
		    //alert(obj.data("name"));
		    $("#code_product_name").text(obj.data("name"));
		    $("#code_product_code_1").attr("src", obj.data("code"));
		    showPopWin($("#tip_code"));
	    });

	    optionAll();
	    optionSingle();
	    init();
	}
	
},"json");
    
   
}

//回调函数  
PageClick = function(pageclickednumber) {  
	getGoodsLists(pageclickednumber,offset);  
}  

//全选/取消
function optionAll() {
    $("#all").on('change', function () {
        if ($(this).prop("checked")) {
            //alert($("input[name='ck1']").length)
            if ($("input[name='ck1']").length > 0) {
                $("input[name='ck1']").prop("checked", true);
                showOptionBtn();
            }
            else {
                // $("input[name='ckAll']").prop("checked",false);
                hideOptionBtn();
            }
        } else {
            $("input[name='ck1']").prop("checked", false);
            hideOptionBtn();
        }
    });
}


//单选
function optionSingle() {
    if ($("input[name='ck1']:checked").length) {
    showOptionBtn();
    }
    $("input[name='ck1']").on('change', function () {
    var o = $("input[name='ck1']:checked");
    if (o.length) {
    showOptionBtn();
    } else {
    hideOptionBtn();
    }
    if (!$(this).prop("checked")) {
    $("#all").prop("checked", false);
    }
    });
}

//批量操作获取 id列表
function getProductID() {
	var list = $("input[name=ck1]:checked");
	id = [];
	for (var i = 0; i < list.length; i++) {
	id.push(list.eq(i).parents("li").prop("id"));
	}
	return id;
}

function showTips(id){
    var x=$("body").width()+"px";
    var y=$("body").height()+"px";
    $(id+",.over_layer").fadeIn(500);
    $(".over_layer").css({"width":x,"height":y});
}

function hideTips(id){
	$(id+",.over_layer,#user_shadow").fadeOut(500);
}

function turnToEditPage(id) {
	 if(id == 0){
    	window.location.href = basepath + 'pages/MerChnt/pubGoods.jsp?shop_id='+shop_id+'&user_id='+user_id;
    }else{
	    if(!isInactivity(id)){
	    return false;
	    }
	    window.location.href = basepath + 'pages/MerChnt/pubGoods.jsp?goods_id='+id+'&shop_id='+shop_id+'&user_id='+user_id;
    }
}

function isInactivity(goods_id){
    var flag = true;
//    $.ajax({
//    url: basepath+'/goodsManage/isInActivity.html',
//    dataType: 'json',
//    timeout: 30000,
//    async : false,
//    data: {ids:spuId},
//    type: 'POST',
//    success: function(data){
//    if (!data.success) {
//    alert("当前用户或者商品在活动中不能编辑或下架删除");
//    flag = false;
//    }
//    }
//    });
    return flag;
}

function showTips(id){
    var x=$("body").width()+"px";
    var y=$("body").height()+"px";
    $(id+",.over_layer").fadeIn(500);
    $(".over_layer").css({"width":x,"height":y});
    }
function hideTips(id){
    $(id+",.over_layer").fadeOut(500);
    }

$(function() {
	setAllDomain();
	getMerMenu(basepath,shop_id,user_id);
    getGoodsLists(startpagenum,offset);
    
});
