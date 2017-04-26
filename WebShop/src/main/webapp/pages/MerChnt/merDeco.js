var basepath=null; /*根目录*/
var user_id = null ;/*用户编号*/
var shop_id =null;

var startpagenum =1;
var offset =3;

var setAllDomain = function(){
	basepath=getRootPath();	
	shop_id=GetQueryString("shop_id");
	user_id =$("#LoginUser").attr('loginUserId');
	//user_id =GetQueryString("user_id");
}

function updateShopImages(resData,shopType,imgType){
	var imgUrl = resData.url;
	var fileNm = resData.newFileNm;
	var param = {
			"shopId":shop_id,
			"shopType":shopType,
			"imgType":imgType,
			"imgUrl":imgUrl,
			"fileNm":fileNm,
			"keyId":shop_id,
			};
//	alert(JSON.stringify(param));
	var url = basepath+'Shop/UpdateShopImages.action?userId='+user_id;
    $.post(url,param,function(data){
//		alert(JSON.stringify(data));
		if(data.rspCode=="000000"){
		}else{
		}
    },"json");
}

//获取logo
function getShopLogo(){ 
	var param = {"shopId":shop_id};
	//alert(JSON.stringify(param));
    $.post(basepath+'Shop/GetShopInfo.action',param,function(data){
	//alert(JSON.stringify(data));
	if(data.rspCode=="000002"||data.rspCode=="000001"){
	}else{
		var logourl =data.objs[0].logourl;
		var shopsign = data.objs[0].shopsign;
		$('#shopLogo>div').css('background-image', 'none').addClass('have-banner');
        $('#shopLogo .upload-image-name').html('<img src="'+logourl + '"/>');
        
        $('#shopCover>div').css('background-image', 'none').addClass('have-banner');
        $('#shopCover .upload-image-name').html('<img src="'+shopsign + '"/>');
	}
	
    },"json");
}



function tip(message) {
    if(message === ''||message === undefined||message.length === 0||typeof (message)!='string')return false;
    var tip = '<div id="error_tip" class="error-tip"></div>';
    if (!$('#error_tip')[0]) {
        $('body').append(tip);
    }
    var h = $('#error_tip').width();
    $('#error_tip').css('margin-left', -h / 2).html(message).show();
    setTimeout(function() {
        $('#error_tip').hide().html('');
    }, 3000);
};

String.prototype.template = function() {
    var args = arguments,
        k = -1;
    return this.replace(/\{(\w+)\}/g, function() {
        k++;
        return args[k];
    });
};

String.prototype.trim = function() {
    return this.replace(/(^\s+)|(\s+$)/g, '');
};


var getGoodsLists = function(pagenumber,offsize,value){
	var GoodsList='';
	var map={
		shopId:shop_id,
		keyword:value
	};
	var param = {
		start:pagenumber,
		offset:offsize,			
		conditions:map
	};
//	alert(JSON.stringify(param));
    $.post(basepath+'Search/serGoodsShortInfListByKeyword.action',param,function(data){
//	alert(JSON.stringify(data));
	var tem_position = $('#mainContent tbody');
	if(data.rspCode=="000002"||data.rspCode=="000001"){
		
		tem_position.empty().append('<tr><td colspan="6" style="padding:20px 0;">没有关联商品</td></tr>');
		
	}else{
		 var total = data.result.length;
         var list = data.result,
         pTemp = $('#productTemp').val(),
         pList = [];
         
         if (total) {
             for (var i = 0; i < list.length; i++) {
                 var p = list[i];                //timeFormatStr()
                 pList.push(pTemp.template(p.mainPicUrl, p.goodsNm, p.goodsId, p.amount == 0 ? '面议' : (p.amount/100).toFixed(2) ));
             }
        }
        tem_position.empty().append(pList.join(''));
		$("#J_bottomPage").empty();
		$("#J_bottomPage").pager({ pagenumber: pagenumber, pagecount:data.pageCount,totalcount:data.total, buttonClickCallback: PageClick});  
        }
   },"json");
}

function getGoodsShortInfo(goodsId)
{
	var param = {"goodsId":goodsId};
//	alert(JSON.stringify(param));
    $.post(basepath+'Goods/GetGoodsShortInfo.action',param,function(data){
//	alert(JSON.stringify(data));
		if(data.rspCode=="000000"){
			var picurl=data.objs[0].mainPicUrl;
			var goodsName = data.objs[0].goodsNm;
			var goodsId = data.objs[0].goodsId;
			var joinproduct = '<h3>' + goodsName + '</h3><p pid="' + goodsId + '">ID：' + goodsId + '</p>';
			$("#"+goodsId+ " .join-info").html(joinproduct);
			var imgprduct = '<img src="'+picurl+'" />';
			$("#"+goodsId+ " .image-box").html(imgprduct);
		}else{
			
		}
    },"json");
	
}
function getKey(pageID) {

    var key = $('#mainContent .select-search:eq(0)').attr('key'),
        value = $('#productCondition').val().trim();
    if (key === 'name') {
        var reg1 = /^[A-Za-z0-9\u4e00-\u9fa5]+$/;
        if (!reg1.test(value) && value.length != 0) {
            tip('请输入合法的商品名称！');
            return false;
        }
        getGoodsLists(startpagenum,offset,value);
    } else {

        var reg2 = /^[0-9]+$/;
        if (!reg2.test(value) && value.length != 0) {
            tip('请输入正确的商品ID！');
            return false;
        }
        getGoodsLists(startpagenum,offset,value);
    }

}
//回调函数  
PageClick = function(pageclickednumber) {  
	//getGoodsLists(pageclickednumber,offset);  
	var key = $('#mainContent .select-search:eq(0)').attr('key'),
    value = $('#productCondition').val().trim();
	if (key === 'name') {
	    var reg1 = /^[A-Za-z0-9\u4e00-\u9fa5]+$/;
	    if (!reg1.test(value) && value.length != 0) {
	        tip('请输入合法的商品名称！');
	        return false;
	    }
	    getGoodsLists(pageclickednumber,offset,value);
	} else {
	
	    var reg2 = /^[0-9]+$/;
	    if (!reg2.test(value) && value.length != 0) {
	        tip('请输入正确的商品ID！');
	        return false;
	    }
	    getGoodsLists(pageclickednumber,offset,value);
	}
}  


$(function() {
	
	setAllDomain();
    getMerMenu(basepath,shop_id,user_id);
    getShopLogo();
    
    var merchant_user_id =shop_id;
    var nextPage = 1; 
    var totalCount = 1;
    var pageNum = 1;
    var spuIds = []; 
    var num = 0;

    var dialog = {},
    banner = {};
    var uploadImgUrl = '', $uploadObj = $('#shopCover');
    var imgType='';
    
    //装修类型：1：web 2：app
    var shopType= $('.tabs').find('.active').attr('type') === 'web'? 1 : 2;
    banner.url = {
            head: basepath,
           // getList: '/company/merchant/banner/list.html?_merchant_user_id_='+merchant_user_id,
           getList: 'ShopBanner/GetShopBannerInfo.action',
           add: 'ShopBanner/SaveShopBanner.action',
           update: 'ShopBanner/UpdateShopBanner.action',
          // check: '/company/merchant/banner/approval/check.html?_merchant_user_id_='+merchant_user_id,
           //uploadImg: '/qiniu/image/upload.html?_merchant_user_id_='+merchant_user_id,
         //  uploadImg: 'File/ImagesUpload.action',
           // logo: '/company/merchant/shop/logo/update.html?_merchant_user_id_='+merchant_user_id, //标识
//           logo: '/cooperatorShop/decoration/updateShopImg.html?_merchant_user_id_='+merchant_user_id, //标识
//           cover: '/cooperatorShop/decoration/updateShopImg.html?_merchant_user_id_='+merchant_user_id, //封面 
           del: 'ShopBanner/DelShopBanner.action',
//           shStatus : '/cooperatorShop/decoration/getShopLogoApply.html?_merchant_user_id_='+merchant_user_id
       };
   

    var userAgent = navigator.userAgent.toLowerCase(); 
    var browser = { 
        version: (userAgent.match( /.+(?:rv|it|ra|ie)[\/: ]([\d.]+)/ ) || [])[1], 
        safari: /webkit/.test( userAgent ), 
        opera: /opera/.test( userAgent ), 
        msie: /msie/.test( userAgent ) && !/opera/.test( userAgent ), 
        mozilla: /mozilla/.test( userAgent ) && !/(compatible|webkit)/.test( userAgent ) 
    };
   
    dialog.setPosition = function(obj) {
        if (!obj) return false;
        var height = obj.height();
        obj.css('margin-top', -height / 2);
    };

    dialog.open = function(obj) {
        $(obj).find('.dialog-search').find('input').val('');
        $(obj).find('tbody').html('');
        dialog.setPosition(obj);
        obj.show();
        $('.shadow:eq(0)').show();
    };

    dialog.close = function(obj) {
        obj.hide();
        $('.shadow:eq(0)').hide();
    };
    
    var uploadImgUrl = '', $uploadObj = $('#shopCover');
    var userAgent = navigator.userAgent.toLowerCase(); 
    var browser = { 
        version: (userAgent.match( /.+(?:rv|it|ra|ie)[\/: ]([\d.]+)/ ) || [])[1], 
        safari: /webkit/.test( userAgent ), 
        opera: /opera/.test( userAgent ), 
        msie: /msie/.test( userAgent ) && !/opera/.test( userAgent ), 
        mozilla: /mozilla/.test( userAgent ) && !/(compatible|webkit)/.test( userAgent ) 
    };

    function uploadImages(o, file, progress, fn) {
        var iframe = false;
        if(browser.msie  && browser.version < 10){
            iframe = true;
        }
        o.fileupload({
            url: basepath+'File/ImagesUpload.action',
            dataType: 'json',
            iframe: iframe,
            formData: {
                name: file
            }
        }).on('fileuploadprogressall', function(e, data) {

            progress.call(this, arguments);

        }).on('fileuploaddone', function(e, data) {
        	//alert(JSON.stringify(data.result));
            if ( data.result ) {
                if (data.result) {
                    fn.call(this, data.result);
                } else {
                    tip(data.result.rspMsg);
                    $uploadObj.find('.upload-image-name').html('<img src="' + uploadImgUrl + '" />');
                }

            } else {
                tip('上传错误!');
            }
            //console.log(getNaturalWidth(uploadImgUrl));

        }).on('fileuploadfail', function(e, data) {
            tip('上传错误!');
        });
    };
    
    function uploadBannerImg(o, file) {
        var iframe = false;
        if(browser.msie  && browser.version < 10){
            iframe = true;
        }
        o.fileupload({
        	url: basepath+'File/ImagesUpload.action',
        	 //url: banner.url.head + banner.url.uploadImg,
            dataType: 'json',
            iframe: iframe,
            dataType: 'json',
            formData: {
                name: file
            }
        }).on('fileuploadprogressall', function(e, data) {
            var p = $(this).parents('tr');

            if ( p.find('.upload-image-name img').length === 0 ) {
            } else {
                uploadImgUrl = p.find('.upload-image-name').find('img')[0].src;
            }

            p.find('.upload-wrap').css('background', 'url(/images/load.gif) center center no-repeat');
            p.find('.upload-image-name').html('').attr('key', 0);

        }).on('fileuploaddone', function(e, data) {
            if ( data.result ) {
            	//var imgUrl = data.objs.url;
                if (!data.result.rspCode!="000000") {
                    var p = $(this).parents('tr');
                    p.find('.upload-image-name').html('<img src="' + uploadImgUrl + '" />').attr('key', 1);
                    tip(data.result.rspMsg);
                } else {
                    var p = $(this).parents('tr'),
                        d = data.result,
                        key = Number(p.find('.join-product').attr('key')),
                        havaRecode = p.attr('have'),
                        btn = '';
                    if (p.find('.empty-upload')) {
                        p.find('.empty-upload').remove();
                    }
                    p.find('.upload-wrap').css('background-image', 'none');
                    p.find('.upload-image-name').html('<img src="' + d.objs.url + '" file-name="' + d.objs.newFileNm + '" />').attr('key', 1);
                    p.find('.upload-wrap').addClass('have-banner');
                    if (havaRecode === 'ok') {
                        btn = banner.option.btn.template('use-btn save-btn', '', '保存');
                    } else {
                        if (key) {
                            btn = banner.option.btn.template('use-btn save-btn', '', '保存');
                        } else {
                            btn = banner.option.btn.template('save-btn', 'disabled', '保存');
                        }
                    }
                    p.find('td:eq(4)').html(btn);
                }

            } else {
                tip('上传错误!');
            }
            

        }).on('fileuploadfail', function(e, data) {
            tip('上传错误!');
        });
    };
    
    //商家logo
    uploadImages($('#shop-logo'), 'file', function() {
        if ($('#shopLogo .upload-image-name img').length === 0) {
        } else {
            uploadImgUrl = $('#shopLogo .upload-image-name img')[0].src;
        }
        $('#shopLogo .upload-image-name img')[0].height;
        $uploadObj = $('#shopLogo');
        $('#shopLogo .upload-image-name').html('');
        $('#shopLogo>div').css('background-image', 'url(../../images/load.gif)');

    }, function(data) {
        var imgUrl = data.objs.url;
        $(this).remove();
        $('#shopLogo>div').css('background-image', 'none').addClass('have-banner');
        $('#shopLogo .upload-image-name').html('<img src="' + imgUrl + '" />');
        imgType='05';
        updateShopImages(data.objs,shopType,imgType);
    });
    

    uploadImages($('#reshop-logo'), 'file', function() {
        if ($('#shopLogo .upload-image-name img').length === 0) {
        } else {
            uploadImgUrl = $('#shopLogo .upload-image-name img')[0].src;
        }
        $uploadObj = $('#shopLogo');
        $('#shopLogo .upload-image-name').html('');
        $('#shopLogo>div').css('background-image', 'url(/images/load.gif)');

    }, function(data) {
        var imgUrl = data.objs.url;
        $('#shopLogo>div').css('background-image', 'none').addClass('have-banner');
        $('#shopLogo .upload-image-name').html('<img src="' + imgUrl + '" />');
        imgType='05';
        updateShopImages(data.objs,shopType,imgType);
    });
    
  //商家封面
    uploadImages($('#cov'), 'file', function() {
        // $('#shopCover .upload-image-name').html('');
        if ($('#shopCover .upload-image-name img').length === 0) {
        } else {
            uploadImgUrl = $('#shopCover .upload-image-name img')[0].src;
        }
        $uploadObj = $('#shopCover');
        $('#shopCover .upload-image-name').html('');
        $('#shopCover>div').css('background-image', 'url(../../images/load.gif)');

    }, function(data) {
    	var imgUrl = data.objs.url;
        $(this).remove();
        $('#shopCover>div').css('background-image', 'none').addClass('have-banner');
        $('#shopCover .upload-image-name').html('<img src="' + imgUrl + '" />');
        imgType='03';
        updateShopImages(data.objs,shopType,imgType);
    });

    uploadImages($('#recov'), 'file', function() {
        if ($('#shopCover .upload-image-name img').length === 0) {
        } else {
            uploadImgUrl = $('#shopCover .upload-image-name img')[0].src;
        }
        $uploadObj = $('#shopCover');
        $('#shopCover .upload-image-name').html('');
        $('#shopCover>div').css('background-image', 'url(../../images/load.gif)');

    }, function(data) {
    	var imgUrl = data.objs.url;
        $('#shopCover>div').css('background-image', 'none').addClass('have-banner');
        $('#shopCover .upload-image-name').html('<img src="' + imgUrl + '" />');
        imgType='03';
        updateShopImages(data.objs,shopType,imgType);
    });
    
//    function getNaturalWidth(img) {
//        var image = new Image();
//        image.src = img.src;
//        var naturalWidth = image.width;
//        var naturalHeight= image.height;
//        return {
//            height:naturalWidth,
//            width:naturalHeight
//        };
//    }

    $('#mainContent .dialog-search').find('span').hover(function() {
        $('>dl', $(this)).show();
    }, function() {
        $('>dl', $(this)).hide();
    });

    $('#mainContent dd').bind('click', function() {
        $('.select-search').eq(0).html($(this).html()).attr('key', $(this).attr('value'));
        $(this).parent().hide();
    });

    $('#mainContent').delegate('input[type="radio"]', 'change', function() {

        var index = $(this).parents('tr').index(),
            value = [];
        value.push($(this).parents('tr').find('.image-box>img').attr('src'));
        value.push($(this).parents('tr').find('.product-detail>h4').html());
        value.push($(this).parents('tr').find('.product-id>span').html());
        $('#bannerSelect').val(value.join(','));

    });
    
    $('#confirmBtn').bind('click', function() {
        var v = $('#bannerSelect').val().trim().split(','),
            dialogBox = $('#contanPro'),
            index = $('#bannerSelect').attr('bannerID');
        if ($('#bannerSelect').val().trim().length >0) {

            var o = $('#bannerList tbody tr').eq(index),
                key = Number(o.find('.upload-image-name').attr('key')),
                havaRecode = o.attr('have'),
                btn = '';
            o.find('.join-image>div').html("<div class='imgbox'><img src='" + v[0] + "' /></div>");
            o.find('.join-btn').val('替换');
            o.find('.join-info>h3').html(v[1]);
            o.find('.join-info>p').html('ID:' + v[2]).attr('pid', v[2]);
            $('#bannerSelect').val('').attr('bannerID', '');
            o.find('.join-product').attr('key', 1);
            if (havaRecode === 'ok') {
                btn = banner.option.btn.template('use-btn save-btn', '', '保存');
            } else {
                if (key) {
                    btn = banner.option.btn.template('use-btn save-btn', '', '保存');
                } else {
                    btn = banner.option.btn.template('use-btn save-btn', 'disabled', '保存');
                }
            }
            o.find('td:eq(4)').html(btn);
            dialog.close(dialogBox);

        } else {
            tip('请选择商品！');
        }

    });

    function timeFormat(time) {

        var d = new Date(time),
            day = [d.getFullYear(), d.getMonth() + 1, d.getDate()],
            times = [d.getHours(), d.getMinutes(), d.getSeconds()];
        return day.join('-') + ' ' + times.join(':');

    }
    
    $('#searchBtn').bind('click', function() {
        getKey(1);
    });

    function tabsReload(){
        banner.option.getList();
    }
    
    $('#addBannerBtn').bind('click', function() {
    	 var bannernum = $('#addBannerBtn').attr('bannernum');
    	 if(parseInt(bannernum) > 5)
         {
    		 tip("最多添加5条数据!");
    		 return;
         }
    	 /*如果没有数据，就先删除空*/
    	 if(parseInt(bannernum)==1)
    	 {
    		 var bannerlist = $('#bannerList tbody');
    		 bannerlist.empty();
 		 }
 		
    	 var empty = $('#nullBanner').val();
    	 $('#bannerList tbody').append(empty.template(bannernum , bannernum, bannernum));
    	 $('#addBannerBtn').attr('bannernum',parseInt(bannernum)+1);  
    	 
    	 uploadBannerImg($('#BannerUpload'+bannernum),'file');
    	 uploadBannerImg($('#reBannerUpload'+bannernum),'file');
    	 
    });

    banner.option = {
        btn: '<input class="tool-btn {optionbtn}" {disabled} type="button" name="" value="{toolbtn}" />',
        getList: function() {
            $('#bannerList tbody').children().remove();
            var temp = $('#addBanner').val(),
                empty = $('#nullBanner').val();
            
            var param = {
            		"shopId":shop_id,
            		"type":shopType
            		};
            //alert(JSON.stringify(param));
            var url= banner.url.head + banner.url.getList;
            $.post(url,param,function(data){
//            	alert(JSON.stringify(data));
            	if(data.rspCode=="000002"||data.rspCode=="000001"){
            		var bannerlist = $('#bannerList tbody');
            		bannerlist.empty().append('<tr><td colspan="4" style="padding:20px 0;">没有banner</td></tr>');
            		$('#addBannerBtn').attr('bannernum',1); 
            	}else{
            	 var c = data,
                   d = c.objs,
                   len = d.length,
                   tem = '',
                   j = 0;
            	 var goodsName='',
            	 goodsId='',
            	 goodsImg='',
            	 bannerImg = '';
               for (var i = 0; i < len; i++) {
                	   var id = i+1;
                	   goodsName=' ';
                	  // alert(len);
                	   goodsId = GetValueByNameFromUrl(d[i].url,"goods_id");
//                	   alert(goodsId);
                	   goodsImg ='#';
                	   //bannerImg = basepath+d[i].imgurl;
                	   bannerImg = d[i].imgurl;
                	   imgResId = d[i].resid;
//                	   alert(bannerImg);
                       var joinBtn = '',
                           joinproduct = '<h3>' + goodsName + '</h3><p pid="' + goodsId + '">ID：' + goodsId + '</p>';
                       if (1) {
                           joinBtn = banner.option.btn.template('use-btn join-btn', '', '替换');
                           //status(d[i].checkStatus)['desc'].template(d[i].checkTime) , status(d[i].checkStatus)['btn']
                          // tem = temp.template(i + 1, d[i].bid, 'have-banner', bannerImg, i + 1, i + 1,goodsId, goodsImg, joinBtn, joinproduct);
                           tem = temp.template(i + 1, d[i].bid, 'have-banner',imgResId, bannerImg, i + 1,goodsId, goodsImg, joinBtn, joinproduct);
                         } 
//                           else {
//                           joinBtn = banner.option.btn.template('join-btn', 'disabled', '替换');
//                           tem = temp.template(i + 1, d[i].id, '', d[i].imgPath, i, goodsImg, joinBtn, joinproduct, status(d[i].checkStatus)['desc'].template(d[i].checkTime), status(d[i].checkStatus)['btn']);
//                       }
                       $('#bannerList tbody').append(tem);
                       /*设置下一个banner序号*/
                       $('#addBannerBtn').attr('bannernum',i+1+1);  
                       j=i+1;
                       uploadBannerImg($('#reBannerUpload'+j),'file');
                   //uploadImg($('#bannerList .reupload').eq(i+1), 'bannerUpload' + i+1);
               }

	               $('.deleteBtn').on('click', function() {
	                   var _this = $(this);
	                   var bannerId = _this.parents('tr').find('td').eq(1).text();
	                   
	                   var p = $(this).parents('tr'),
	                   imgResId  = p.find('.upload-image-name').attr('img-res-id');
	                   
	                   if(confirm('是否删除？')){
	                       var url = banner.url.head + banner.url.del;
	                       var param = {
	                    		   bid:bannerId,
	                    		   resId : imgResId,
	                    		   shopId :shop_id
	                      };
	//                   	alert(JSON.stringify(param));
	                       $.post(url,param,function(data){
	//                   	alert(JSON.stringify(data));
			                   	if(data.rspCode=="000000"){
			                   		banner.option.getList();
			                   	}else{
			                   		tip(data.rspCode);
			                   	}
	                       },"json");
	                   }
	               });
            	}
            	
            	 for (var i = 0; i < len; i++) {
            		 var goodsId = GetValueByNameFromUrl(d[i].url,"goods_id");
            		 getGoodsShortInfo(goodsId);
            	 }
            	
             },"json");
        },

        add: function(imgUrl, goodsID,p,imgFileNm) {
        	
        	var url = banner.url.head + banner.url.add;
            var param = {
            		"imgUrl":imgUrl,
            		"shopId":shop_id,
            		"fileNm":imgFileNm,
            		"imgType":'04',
            		"bannerType":'1',
            		"url":'pages/Goods/goodsInfo.jsp?goods_id='+goodsID
            };
//        	alert(JSON.stringify(param));
            $.post(url,param,function(data){
//        	alert(JSON.stringify(data));
	        	if(data.rspCode=="000000"){
	        		banner.option.getList();
	        	}else{
	        		tip(data.rspCode);
	        	}
            },"json");
        },

        update: function(bannerId, imgUrl, goodsID,imgResId, p,imgFileNm) {
        	var param = {
                    "bid":bannerId,
                    "imgUrl":imgUrl,
            		"shopId":shop_id,
            		"fileNm":imgFileNm,
            		"imgType":'04',
            		"bannerType":'1',
                    "resId":imgResId,
                    "url":'pages/Goods/goodsInfo.jsp?goods_id='+goodsID
                }
//        	alert(JSON.stringify(param));
                var url= banner.url.head + banner.url.update;
                $.post(url,param,function(data){
                	//alert(JSON.stringify(data));
                	if(data.rspCode=="000000"){
    	        		banner.option.getList();
    	        	}else{
    	        		tip(data.rspCode);
    	        	}
                },"json");
        },

//        check: function(id, fn) {
//            $.ajax({
//                type: 'POST',
//                url: banner.url.head + banner.url.check,
//                dataType: 'json',
//                async:false,
//                data: {
//                    id: id
//                },
//                success: function(data) {
//                    if (data.success) {
//                        fn.call(this, data);
//                    }
//                },
//                error: function(message) {
//                    tip(message);
//                }
//            });
//        },

        ckType: function(status) {
            if (status.toString().length === 0) return false;
            var desc = '',
                btn = banner.option.btn,
                reason = '<p>很抱歉，您上传的banner不符合规范，无法通过审核，请您重新上传。<i></i></p>';
            switch (status) {
                case 0:
                    desc = '';
                    btn = btn.template('use-btn check-btn', '', '提交审核');
                    break;
                case 1:
                    desc = '<div class="upload-check">审核中</div>';
                    btn = btn.template('check-btn', 'disabled', '提交审核');
                    break;
                case 2:
                    desc = '<div class="upload-check">审核通过</div><div class="check-time">{time}</div>';
                    btn = btn.template('check-btn', 'disabled', '提交审核');
                    break;
                case 3:
                    desc = '<div class="upload-check">审核未通过' + reason + '</div><div class="check-time">{time}</div>';
                    btn = btn.template('check-btn', 'disabled', '提交审核');
                    break;
                default:
                    desc = '';
                    btn = btn.template('use-btn check-btn', '', '提交审核');
                    break;
            }
            return {
                desc: desc,
                btn: btn
            };
        },

//        updateImg: function(url, option) {
//            $.ajax({
//                type: 'POST',
//                url: banner.url.head + url,
//                dataType: 'json',
//                async:false,
//                data: option,
//                success: function(data) {
//                    if (data.success) {
//                        getShStatus();
//                    }
//                },
//                error: function(message) {
//                    tip(message);
//                }
//            });
//        }
    };

    //初始化
    banner.option.getList();
    //商家标识
    
    
    function getNaturalWidth(img) {
        var image = new Image();
        image.src = img.src;
        var naturalWidth = image.width;
        var naturalHeight= image.height;
        return {
            height:naturalWidth,
            width:naturalHeight
        };
    }

    document.onkeydown=function(event){
        var e = event || window.event || arguments.callee.caller.arguments[0];
        if(e.keyCode === 9){
            var a=$('.tabs').find('.active');
            if($(a).hasClass('app')){
                $('.tabs').find('.pc').addClass('active');
                $('.tabs').find('.app').removeClass('active');
            }else{
                $('.tabs').find('.pc').removeClass('active');
                $('.tabs').find('.app').addClass('active');
            }
            shopType=$('.tabs .active').attr('type') === 'web'?1:2;
            //初始化
            if(shopType === 1){
                $('#app-size').hide();
                $('#pc-size').show();
                $('#disable-logo').hide();
                //  橱窗商品展示
               // cwindow(shopType);
            }else{

                $('#app-size').show();
                $('#pc-size').hide();
                $('#disable-logo').show();

                //  橱窗商品展示
                //cwindow(shopType);
            }

            var d=$('.dialog').eq(0);
            dialog.close(d);
            var dialogBox = $(".dialog-shops").eq(0);
            dialog.close(dialogBox);
            banner.option.getList();
            var len=$('#shy').find('tbody').find('tr').length;

            if(len>=8||shopType === 2){
                //tip('关联朋友圈不能超过11个');
                $('#addshy').hide();
                return false;
            }else{
                $('#addshy').show();
            }
            return false;
        }
    };

    $('#bannerList').delegate('.save-btn', 'click', function() {
        var p = $(this).parents('tr'),
            goodsID = p.find('.join-info>p').attr('pid'),
            imgUrl = p.find('.upload-image-name>img').attr('src'),
            imgFileNm = p.find('.upload-image-name>img').attr('file-name'),
            imgResId  = p.find('.upload-image-name').attr('img-res-id'),
            havaRecode = p.attr('have');
        //alert(bannerUrl);
        if (havaRecode === 'ok') {
            banner.option.update(p.find('td:eq(1)').html(), imgUrl, goodsID, imgResId,p,imgFileNm);
        } else {
            banner.option.add(imgUrl, goodsID,p,imgFileNm);
        }

    });

    $('#bannerList').delegate('.check-btn', 'click', function() {
        var p = $(this).parents('tr'),
            id = p.find('td:eq(1)').html(),
            ck = banner.option.ckType(1);
        banner.option.check(id, function(data) {
            banner.option.getList();
        });

    });

    //关联商品 
    $('#bannerList').delegate('.join-btn', 'click', function() {
        var dialogBox = $('#contanPro');
        dialog.setPosition(dialogBox);
        dialog.open(dialogBox);
        $('#mainContent input[type="radio"]').attr('checked', false);
        
        $('#bannerSelect').attr('bannerID', $(this).parents('tr').index());

    });
    $('.dialog-close,.cancle-btn').bind('click', function() {
        var dialogBox = $('#contanPro');
        dialog.close(dialogBox);

    });

    

    function timeFormatStr(time) {
        return time.split(' ')[0] + ' ' + time.split(' ')[1];
    }

    //   两个tab 标签切换
    $('.tabs').delegate('.menu','click',function(){
          $('.tabs li').removeClass('active');
          $(this).addClass('active');
          shopType=$(this).attr('type') ==='web'?1:2;
        if(shopType === 1){
            $('#app-size').hide();
            $('#pc-size').show();
            $('#disable-logo').hide();
        }else{
            $('#app-size').show();
            $('#pc-size').hide();
            $('#disable-logo').show();
        }
        //初始化banner
        banner.option.getList();
    });

 
    var supId = '';
    var supName= '';


    // 删除数组中某一个返回原数组 
    Array.prototype.del=function(n) {
    	if(n<0){
       return this;
          }else{
              return this.slice(0,n).concat(this.slice(n+1,this.length));
          }
    }


//    function Lchecked(_this){
//        var attr = $(_this).attr('state');
//
//        if(attr === 'true'){
//
//            $(_this).attr('state','false');
//            $(_this).attr('src','http://enterprise.hbaicai.com/business-center/images/quit.jpg');
//
//            var thisId = $(_this).data('id');
//            // spuIds = spuIds.del(thisId);
//            // alert(spuIds);
//            for(var i=0; i<spuIds.length; i++){
//                if(spuIds[i] == thisId){
//                    spuIds = spuIds.del(i);
//                    // alert(spuIds);
//                }
//            }
//        }else{
//
//            $(_this).attr('state','true');
//            $(_this).attr('src','http://enterprise.hbaicai.com/business-center/images/srSelect.jpg');
//
//            var thisId = $(_this).data('id');
//            spuIds.push(thisId);
//            
//
//            // if(spuIds.length != 0){
//            //     for(var i=0; i<spuIds.length; i++){
//            //         if(spuIds[i] != thisId){
//            //             spuIds.push(thisId);
//            //             alert(spuIds);
//            //         }
//            //     }
//            // }else{
//            //     spuIds.push(thisId);
//            // }
//            
//
//        }
//    }
//
//    $('.tbody').on('click','.checked',function(){
//        Lchecked(this);
//    });


});


