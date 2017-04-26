var basepath=null; /*根目录*/
var user_id = null ;/*用户编号*/
var shop_id =null;

var setAllDomain = function(){
	basepath=getRootPath();	
	shop_id=getQueryStringByName("shop_id");
	user_id =$("#LoginUser").attr('loginUserId');
//	user_id =getQueryStringByName("user_id");
}
$(function(){
	
	setAllDomain();
    getMerMenu(basepath,shop_id,user_id);
    var merchant_id = shop_id;
    var ajaxUrl = {
        head: basepath,
        grUrl: "Classify/GetClassifyInfo.action",
        myGrUrl: "Classify/GetMyClassifyLatest.action",
        chooseSpe:"#",  /*根据类目编号获取对应的规格名称*/
        //fpiSubUrl:"/goodsWeb/publishGoods.html?_merchant_user_id_="+merchant_id,/*发布商品*/
        fpiSubUrl:"Goods/PublicGoods.action?shopId="+shop_id,/*发布商品*/
//        getHotTip: "/goodsLabel/getSys.html?_merchant_user_id_="+merchant_id,
//        add: "/goodsLabel/addUserLabel.html?_merchant_user_id_="+merchant_id,
//        search: "/goodsLabel/getLabelByKey.html?_merchant_user_id_="+merchant_id,
        getFee: "#",
       // upload: "File/FileUpload.action",
        upload: "File/ImagesUpload.action",
//        addprodcut: "/goodsProduct/doSubmit.html?_merchant_user_id_="+merchant_id,
//        getProduct: "/goodsWeb/info.html?_merchant_user_id_="+merchant_id,
       // xhedit: "/photo/xhEditorUpload.html?_merchant_user_id_="+merchant_id,
        xhedit: "File/ProImgUpload.action",
        getMainInfo:"/Goods/GetGoodsInfo.action?shopId="+shop_id,
        getMainPic:"/Goods/GetGoodsPicInfo.action?shopId="+shop_id,
        getSpeInfo:"/Goods/GetGoodsTypeInfo.action?shopId="+shop_id,
       // editGetFee:"/postage/listPostageTmpName.html?_merchant_user_id_="+merchant_id, 运费模板
        editGetFee:"#",
        editGetClass: "/Classify/GetClassifyPath.action?shopId="+shop_id,
        publishCheck:"Goods/PublicGoodsCheck.action?shop_id="+shop_id,
        //publishCheck:"/goodsWeb/publishCheck.html?_merchant_user_id_="+merchant_id+"&spuId="+getQueryStringByName("spuId"),/*发布商品*/
        getRemaining:"/goodsWeb/getRemaining.html?_merchant_user_id_="+merchant_id,
        spuId:getQueryStringByName("goods_id")
    };
    
    //simple replace
    String.prototype.template = function() {
        var args = arguments,
            k = -1;
        return this.replace(/\{(\w+)\}/g, function() {
            k++;
            return args[k];
        });
    };

    String.prototype.trim = function() {
        return this.replace(/(^\s+)|(\s+$)/g, "");
    };

    Array.prototype.myUnique = function(){
        var res = [];
        var json = {};
        for(var i = 0; i < this.length; i++){
            if(!json[this[i]]){
                res.push(this[i]);
                json[this[i]] = 1;
             }
        }
        return res;
    }
    Array.prototype.delNum = function(num){
        var res = [];
        for( var i=0;i<this.length;i++ ){
            if ( this[i] != num ) {
                res.push( this[i] )
            }
        }
        return res;
    }
    Array.prototype.arrRemove=function(n) {
    　if(n<0){
    　　  return this;
        }else{
            return this.slice(0,n).concat(this.slice(n+1,this.length));
        }
    }
    function getQueryStringByName(name) {
        var result = location.search.match(new RegExp("[\?\&]" + name + "=([^\&]+)", "i"));
        if (result == null || result.length < 1) {
            return "";
        }
        return result[1];
    };

    $(".fpi-rightNav").on("click",'a',function(){
        $(".fpi-rightNav").find('a').removeClass('fpi-rightNavActive');
        $(this).addClass('fpi-rightNavActive');
    })

    //~~~~~~~~~~page one~~~~~~~~~~~~
    var pageOneBol = {
        qrNoticeBol: false,
        grGetListTar:'',
        getListData: "",
        hisDirid:"",
        isOldGoods:0
    };
    $(".grCategoryList").jScrollPane({autoReinitialise: true});

    var pageOne = {
        pageOneInit: function(){
           // pageOne.grAjax( "000000000000" );
            pageOne.grAjax( "00000000" ,"grGetListOne");
            pageOne.myGrUrl();
            //pageOne.grGetList( pageOneBol.getListData,"grGetListOne" );
            pageOne.qrNotice();
            pageOne.qrReleaseBtn();
            pageOne.grCategoryList();
            pageOne.grFilterSubCate();
        },
        myGrUrl: function(){
        	var param = {
                    "shopId":shop_id
                }
                var url = ajaxUrl.head + ajaxUrl.myGrUrl;
                $.post(url,param,function(data){
                	//alert(JSON.stringify(data));
                	if(data.rspCode!="000000")
                	{
                		//tool.errortip("我的类目请求错误！");
                	}
                	else{
                		pageOne.getMyListData(data);
                	}
             },"json");
        },
        grAjax: function( pid ,ListNum){
        	 var param = {
                     "pclassify":pid,
                     "keyword":""
                 }
                 var url = ajaxUrl.head + ajaxUrl.grUrl;
                 $.post(url,param,function(data){
                 	//alert(JSON.stringify(data));
                 	if(data.rspCode=="000000"){
                 		pageOneBol.getListData = data;
                 		pageOne.grGetList( pageOneBol.getListData,ListNum );
                 	}else{
                 		tool.errortip("请求错误！");
                 	}
              },"json");
        },
        getMyListData: function(data){
            var d = data.objs;
           
            if (d) {
                var str = "",len = data.objs.length;
                $(".gr-recentUse-class").on("click","div",function(e){
                    e.stopPropagation();
                    $(".gr-recentUse-main > ul").slideToggle();
                });
                $(document).on("click",function(){
                    $(".gr-recentUse-main > ul").slideUp();
                });
                $(".gr-recentUse-main > ul").on("click","li",function(){
                    var arr = [];
                    $(".gr-recentUse-class div").find("p").text( $(this).text() );
                    arr.push( $(this).text().split( ">" ) );
                    $(".gr-category-one").text( arr[0][0] );
                    $(".gr-category-two").prev("span").show();
                    $(".gr-category-two").text( arr[0][1] );
                    $(".gr-category-three").prev("span").show();
                    $(".gr-category-three").text( arr[0][2] );
                    $(".gr-category-four").prev("span").show();
                    $(".gr-category-four").text( arr[0][3] );

                    $.cookie("grCategoryOne",$(".gr-category-one").text());
                    $.cookie("grCategoryTwo",$(".gr-category-two").text());
                    $.cookie("grCategoryThree",$(".gr-category-three").text());
                    $.cookie("grCategoryFour",$(".gr-category-four").text());
                    pageOneBol.hisDirid = $(this).attr("dirId");
                   // alert(pageOneBol.hisDirid);
                    pageTwo.getSpeList(pageOneBol.hisDirid);/*根据类目编号获取相应规格名称*/
                    
                    if ( ajaxUrl.spuId != "" ) {
                        pageOneBol.isOldGoods = 1; /*没有旧商品类型*/
                        if ( (pageTwoData.getSpeListData[0].specElement != null) && (pageTwoData.getSpeListData.length == 1) ) {
                            $(".fpi-sl-infoContent").remove();
                            getSpeName(true);
                            pageTwoData.editOrSub = 1;
                        }else if ( pageTwoData.getSpeListData.length == 2 ) {
                            getSpeName(false);
                        }
                    }else{
                        getSpeName(true);
                    }
                });
                for( var i=0;i<len;i++ ){
                    str += '<li dirId="'+ d[i].classify +'">'+ d[i].cname +'</li>'
                }
                $(".gr-recentUse-main > ul").empty();
                $(".gr-recentUse-main > ul").append( str );

            };
        },
        grGetList: function(data,obj){
        	if ( data.objs ) {
            	var ListNum = obj;
                var obj = $("."+obj), str01 = "", len01 = data.objs.length;
                obj.empty();
                for( var i=0;i<len01;i++ ){
                	if(ListNum=="grGetListFour")
                    {
                		str01 += '<li dirId='+ data.objs[i].classify +'>'+
                                '<p title="'+ data.objs[i].cname +'">'+ data.objs[i].cname +'</p>'+
                            '</li>';
                	}
                	else
                	{
                		str01 += '<li dirId='+ data.objs[i].classify +'>'+
                        '<p title="'+ data.objs[i].cname +'">'+ data.objs[i].cname +'</p>'+
                        '<span>&gt;</span>'+
                        '</li>';
                	}
                };
                obj.append( str01 );
            };
        },
        grCategoryList: function(obj1,obj2,obj3){
            $(".grGetListOne").on("click","li",function(e){
            	pageOne.grAjax( $(this).attr("dirId") ,"grGetListTwo" );
                  //  pageOne.grGetList( pageOneBol.getListData,"grGetListTwo" );
                var thisText = $(this).find("p").text();
                $(this).siblings("li").removeClass("grCategoryListActive");
                $(this).addClass("grCategoryListActive");
                $(".gr-category-one").text( thisText );
                $(".grGetListThree").empty();
                $(".grGetListFour").empty();
                $(".gr-category-two").text( "" );
                $(".gr-category-two").prev("span").hide();
                $(".gr-category-three").text( "" );
                $(".gr-category-three").prev("span").hide();
                $(".gr-category-four").text( "" );
                $(".gr-category-four").prev("span").hide();
                $.cookie("grCategoryOne",$(".gr-category-one").text());
            });
            $(".grGetListTwo").on("click","li",function(e){
            	 pageOne.grAjax( $(this).attr("dirId"),"grGetListThree" );
                 //  pageOne.grGetList( pageOneBol.getListData,"grGetListThree" );
                var thisText = $(this).find("p").text();
                $(this).siblings("li").removeClass("grCategoryListActive");
                $(this).addClass("grCategoryListActive");
                $(".gr-category-two").text( thisText );
                $(".grGetListFour").empty();
                $(".gr-category-two").prev("span").show();
                $(".gr-category-three").text( "" );
                $(".gr-category-three").prev("span").hide();
                $(".gr-category-four").text( "" );
                $(".gr-category-four").prev("span").hide();
                $.cookie("grCategoryTwo",$(".gr-category-two").text());
            });
            $(".grGetListThree").on("click","li",function(e){
            	 pageOne.grAjax( $(this).attr("dirId") ,"grGetListFour");
                 // pageOne.grGetList( pageOneBol.getListData,"grGetListFour" );
                var thisText = $(this).find("p").text();
                $(this).siblings("li").removeClass("grCategoryListActive");
                $(this).addClass("grCategoryListActive");
                $(".gr-category-three").text( thisText );
                $(".gr-category-three").prev("span").show();
                $(".gr-category-four").text( "" );
                $(".gr-category-four").prev("span").hide();
                $.cookie("grCategoryThree",$(".gr-category-three").text());
            });
            
            $(".grGetListFour").on("click","li",function(e){
                var thisText = $(this).find("p").text();
                $(this).siblings("li").removeClass("grCategoryListActive");
                $(this).addClass("grCategoryListActive");
                $(".grGetListFour").find("li").attr("lastChoose",false);
                $(this).attr("lastChoose",true);
                $(".gr-category-four").text( thisText );
                $(".gr-category-four").prev("span").show();
                $.cookie("grCategoryFour",$(".gr-category-four").text());
                var dirId = $(this).attr("dirid");
                pageTwo.getSpeList(dirId);
                
                getSpeName(true);
//                if ( ajaxUrl.spuId != "" ) {
//                    pageOneBol.isOldGoods = 1;
//                    if ( (pageTwoData.getSpeListData[0].specElement != null) && (pageTwoData.getSpeListData.length == 1) ) {
//                        $(".fpi-sl-infoContent").remove();
//                        getSpeName(true);
//                        pageTwoData.editOrSub = 1;
//                    }else if ( pageTwoData.getSpeListData.length == 2 ) {
//                        getSpeName(false);
//                    }
//                }else{
//                    getSpeName(true);
//                }
            });
        },
        grFilterSubCate: function(){
            $(".gr-filterMain").on("keyup keypress","input",function(e){
                $dom = $(e.target).parents(".gr-filterMain").siblings(".grCategoryListMain").find(".grCategoryList").eq( $(this).parent(".gr-filter").index() ).find("li");
                $dom.hide();
                $(e.target).parents(".gr-filterMain").siblings(".grCategoryListMain").find(".grCategoryList").eq( $(this).parent(".gr-filter").index() ).find('li:contains('+ $(e.target).val() +')').show();
            })
        },
        qrNotice: function(){
            $(".qr-notice").on("click","img",function(){
                if ( pageOneBol.qrNoticeBol ) {
                    $(".qr-notice img").attr("src","../../images/qr-chooseCheckbox.png");
                    $(".qr-release-btn").css({
                        background: "#ff4200"
                    });

                    pageOneBol.qrNoticeBol = false;
                }else{
                    $(".qr-notice img").attr("src","../../images/qr-quitCheckbox.png");
                    $(".qr-release-btn").css({
                        background: "#666666"
                    });
                    pageOneBol.qrNoticeBol = true;
                }
            })
        },
        qrReleaseBtn: function(){
            $(".qr-release-btn").on("click",function(){
                if ( $(".gr-category-four").text() == '' ) {
                    tool.errortip("请选择四个类目！")
                    return;
                }else if( pageOneBol.qrNoticeBol ){
                    return;
                }else{
                    $(".goodsRelease-main").hide();
                    $(".fillProInfo-main").show();
                    $.cookie("pageOption","pageTwo");
                    pageTwo.fpiCategoryNav();
                    var acLen = $(".fpi-mulLayer-name.areaAdd").find(".fpi-slActive").length;
                    $(".fpi-multiLayer .fpi-mul-spe").css({
                        height: acLen<2?100:$($(".fpi-multiLayer .fpi-mul-secSpe:visible")[0]).height() * acLen-20
                    });
                }
            })
        }
    }

    //~~~~~~~~~~page two~~~~~~~~~~~~
    var fee = {},
//        form = {},
        dialog = {};

    dialog.setPosition = function(obj) {
        if (!obj) return false;
        var height = obj.height();
        obj.css("margin-top", -height / 2);
    };

    dialog.open = function(obj) {
        dialog.setPosition(obj);
        obj.show();
        $(".shadow:eq(0)").show();
    };
    dialog.close = function(obj) {
        obj.hide();
        $(".shadow:eq(0)").hide();
    };

//    form.temp = {
//        "deleteTemp": "<div tipID='{id}' class='tag-name tag-delete'><span><b>{tagName}</b><em></em></span></div>",
//        "temp": "<div id='{id}' class='tag-name {option}'><span><i></i><b>{tagName}</b></span></div>"
//    };
//    form.time = null;
//    form.tip = {
//        addTip: function(tipName, id, temp) {
//            return temp.template(id, tipName);
//        },
//        deleteTip: function(id, tipIdList) {
//            var len = tipIdList.length;
//            for (var i = 0; i < len; i++) {
//                if (tipIdList[i] == id) {
//                    return true;
//                }
//            }
//            return false;
//        },
//        recommendTip: function(labels) {
//            var tipArr = [],
//                tipId = [];
//            $.ajax({
//                type: "POST",
//                url: ajaxUrl.head + ajaxUrl.getHotTip,
//                dataType: "json",
//                success: function(data) {
//                    if (data.data) {
//                        var d = data.data,
//                            len = d.length;
//
//                        if (!labels) {
//                            for (var i = 0; i < len; i++) {
//                                tipArr.push(form.temp.temp.template(d[i].id, "option-add", d[i].labelName));
//                                tipId.push(d[i].id);
//                            }
//                        } else {
//                            var k = labels.split(","),
//                                kLen = k.length;
//
//                            for (var i = 0; i < len; i++) {
//                                for (var h = 0; h < kLen; h++) {
//                                    if (k[h] == d[i].id) {
//                                        tipArr.push(form.temp.temp.template(d[i].id, "option-complete", d[i].labelName));
//                                        break;
//                                    }
//                                }
//                                if (!tipArr[i]) {
//                                    tipArr.push(form.temp.temp.template(d[i].id, kLen >= 3 ? "option-disabled" : "option-add", d[i].labelName));
//                                }
//
//                                tipId.push(d[i].id);
//                            }
//                        }
//                        $(".tagList:eq(0)").append(tipArr.join(""));
//                        $("#tipListId").val(tipId.join("-"));
//                    }
//                }
//            });
//        },
//        addedTip: function() {
//            var pid = [];
//            $("#addTag").find(".tag-delete").each(function(i) {
//                pid.push($(this).attr("tipID"));
//            });
//            return pid;
//        },
//        add: function(name, fn) {
//            $.ajax({
//                type: "POST",
//                url: ajaxUrl.head + ajaxUrl.add,
//                dataType: "json",
//                data: {
//                    labelName: name
//                },
//                success: function(data) {
//                    if (data.data) {
//                        fn.call(this, data.data);
//                    } else {
//                        tool.errortip(data.message);
//                    }
//                }
//            });
//        },
//        search: function(key, fn) {
//            $.ajax({
//                type: "POST",
//                url: ajaxUrl.head + ajaxUrl.search,
//                dataType: "json",
//                data: {
//                    key: key
//                },
//                success: function(data) {
//                    if (data.data) {
//                        fn.call(this, data.data);
//                    } else {
//                        tool.errortip(data.message);
//                    }
//                }
//            });
//        }
//    };

    var pageTwoData = {
        getSpeListData:"",
        guigeJson: "",
        feeJson: "",
        fpiSpeActiveNum: 0,
        fpiSpeActiveData: -1,
        standardReListData: [],
        standardReListData0: [],
        standardReListData01: [],
        standardReListData1: [],
        standardReListData11: [],
        standardReListData2: [],
        fpiSpeData: "",
        editOrSub:"",
        standard1List: [],
        standard2List: [],
        subNum:1,
        slDelData:[],
        slDelDataArr:[],
        mulDelData:[],
        mulDelDataArr:[]
    };

    //编辑时获取商品图片
    function editGoodsPic(){
    	var param = {
    			"goodsId": getQueryStringByName("goods_id")
    	};
//    	alert(JSON.stringify(param));
    	var url = ajaxUrl.head + ajaxUrl.getMainPic;
        $.post(url,param,function(data){
//    	alert(JSON.stringify(data));
    	if(data.rspCode=="000000"){
    		//图片列表
    		//var photoList = d["photos"],str = '';
            var photoList = data.objs,str = '';
            var imgType = null;
            var filePath = null;
            var fileNm = null;
            var orgFileNm = null;
            for (var v = 0; v < photoList.length; v++) {
            	imgType = photoList[v].type;
            	if(imgType=="01")
            	{
            		imgType= "1";
            	}
            	else
            	{
            		imgType= "0";
            	}
            	filePath = photoList[v].url;
            	fileResid = photoList[v].resid;
            	fileNm = photoList[v].newFileNm;
            	orgFileNm = photoList[v].resnm;
                str += '<li class="have-banner imglist" type="'+ imgType +'">'+
                            '<div class="product-image">'+
                                '<img alt="'+orgFileNm+'" src="'+ filePath +'" file-name ="'+ fileNm +'" file-resid ="'+ fileResid +'">'+
                            '</div>'+
                            '<div class="upload-shadow product-shadow"></div>'+
                            '<div class="upload-image-option product-option">'+
                                '<span>删除</span>'+
                                '<em>设为封面</em>'+
                            '</div>'+
                            '<div class="upload-hot hide"></div>'+
                            '<img src="../../images/hotTip.png" class="fpi-setCoverPic" />'+
                        '</li>';
            }
            $(".product-list").append( str );
            for( var i=0;i<$(".imglist").length;i++ ){
                if ( $(".imglist").eq(i).attr("type") == 1 ) {
                    $(".imglist").eq(i).find(".fpi-setCoverPic").show();
                }
            }
            if ( $(".imglist").length > 8 ) {
                $(".fpi-pic-btn").hide();
            }else{
                $(".fpi-pic-btn").show();
            }
    	}else{
    		tool.errortip("商品图片请求错误!");
    	}
        },"json");
    	
    }
    //编辑时获取商品规格
    function editGetSpe(typeId){
    	
    	var param = {
    			"goodsId": getQueryStringByName("goods_id")
    	};
 //   	alert(typeId);
//    	alert(JSON.stringify(param));
    	var url = ajaxUrl.head + ajaxUrl.getSpeInfo;
        $.post(url,param,function(data){
    	//alert(JSON.stringify(data));
    	if(data.rspCode=="000000"){
            var d = data.objs;
            //pageTwoData.fpiSpeActiveData = d.standardType;
            pageTwoData.fpiSpeActiveData = typeId;
            pageTwoData.fpiSpeData = d;
          //  alert(typeId);
            if ( typeId == 0 ) {    //默认
                $(".fpi-specifications ul").find("li").eq(0).trigger("click");
                for( var i=0;i<d.length;i++ ) {
                    $(".fpi-singleLayer-name").find("input").val( d[i].typeNm );
                    //$(".fpi-singleLayer-name").find(".fpi-sl-add").trigger("click");
                    $(".fpi-price").find("input[defval='price']").val( AmtToDecimal2(d[i].price));
                    $(".fpi-stock").find("input[defval='stock']").val( d[i].store );
                }
                for( var j=0;j<d.length;j++ ){
                    pageTwoData.standardReListData0.push( '"'+ d[0].typeNm + '"',d[0].typeId );
                }
                for( var j=0;j<d.length;j++ ){
                    pageTwoData.standardReListData01.push( '"'+ pageTwoData.fpiSpeData.standard1List[j].typeNm + '"' );
                }
            }else if ( typeId == 1 ) {  //单层
                var arr0 = [],arr1=[],arr2=[],arr3=[],arr4=[],arr5=[],
                arr6=[],arr7=[],arr8=[],arr9=[],arr10=[],arr11=[],
                standardStr='',standardStrArr=[],skuid="",img = '',specification='',
                skuPriceYuan='',stockNum='',enabled='',
              //  hLen = d.skuList.length,nlen=d.standard1List.length,reg = [];
                hLen = d.length,nlen=d.length,reg = [];
                $(".fpi-specifications ul").find("li").eq(1).trigger("click");
                for( var j=0;j<nlen;j++ ){
                    var bol = false,hhh = '';
                    reg.push( new RegExp( d[j].typeNm ) );
//                    for(var h=0;h<hLen;h++){
//                        if ( reg[j].test( d[j].typeNm ) ) {
//                            bol = true;
//                            hhh = d[h];
//                        }
//                    }
                    bol = true;
                    hhh = d[j];
                    if ( bol ) {
                        arr0[j] = {
                            standardStr:hhh.typeNm,
                            skuid:hhh.typeId,
                            skuPriceYuan:AmtToDecimal2(hhh.price),
                            stockNum:hhh.store
                        }
                    }else{
                        arr0[j] = {
                            standardStr:d[j].typeNm+"_2-0",
                            skuid:"",
                            skuPriceYuan:"",
                            stockNum:""
                        }
                    }
                    arr11[j] = {
                        //img:(d.standard1List[j].img == "" || d.standard1List[j].img == null || d.standard1List[j].img == "undefined" || d.standard1List[j].img == undefined )?"../../images/default-pic.png":d.standard1List[j].img,
                        img:"../../images/default-pic.png",
                        specification:d[j].typeNm,
                        enabled:'1'
                    }
                }

                var str = '',str01 = '';
                for( var i=0;i<d.length;i++ ) {
                    if ( 0 ) {
                        str += '<div class="fpi-sl-btn">' +
                                d[i].typeNm +
                                '<img src="../../images/fpi-guige-choose.png">'+
                                '<img src="../../images/im-cancel14-2.png" class="fpi_slDelSpePic">'+
                            '</div>';
                    }else if( 1 ){
                    	//alert('aaaa');
                        str += '<div class="fpi-sl-btn fpi-slActive">' +
                                d[i].typeNm +
                                '<img src="../../images/fpi-guige-choose.png">'+
                                '<img src="../../images/im-cancel14-2.png" class="fpi_slDelSpePic">'+
                            '</div>';
                    }
                    $(".fpi-sl-btn").remove();
                    $( str ).insertBefore( $(".fpi-sl-input") );
                    var showOrhide = '';
                    showOrhide = arr11[i].enabled == 0?'none':'block';
                    str01 += '<div class="fpi-sl-infoContent" style="display:'+ showOrhide +
                    '" slInfo='+ arr0[i].standardStr +','+arr0[i].skuid +' slInfo01="">'+
                                '<div class="fpi-sl-spe">'+
                                    '<div class ="hide">'+
                                        '<img src="'+ arr11[i].img +'" class="fpi-sl-pic" />'+
                                        '<p class="fpi-sl-delPic">删除图片</p>'+
                                    '</div>'+
                                    '<div>'+
                                        '<p class="fpi-sl-speName">'+ arr11[i].specification +'</p>'+
                                        '<div class="fpi-sl-speBtn hide">'+
                                            '本地上传'+
                                            '<input type="file" name="file" class="fpi-speUploadPic" />'+
                                        '</div>'+
                                    '</div>'+
                                '</div>'+
                                '<div class="fpi-sl-price">'+
                                    '<div>'+
                                        '<input type="text" defVal="price" value="'+ arr0[i].skuPriceYuan +'" />'+
                                    '</div>'+
                                '</div>'+
                                '<div class="fpi-sl-stock">'+
                                    '<input type="text" placeholder="0-9999" defVal="stock" value="'+ arr0[i].stockNum +'" />'+
                                '</div>'+
                            '</div>';
                }
                $(".fpi-sl-info").show();
                $(".fpi-sl-infoTit").after(str01);

                for( var j=0;j<$(".fpi-sl-btn").length;j++ ){
                    $(".fpi-sl-btn").eq(j).data("d", d[j] );
                }

                for( var k=0;k<d.length;k++ ){
                    arr5.push( pageTwoData.fpiSpeData[k].price );
                    arr6.push( "'" + pageTwoData.fpiSpeData[k].typeNm+ "'" );
                    arr7.push( pageTwoData.fpiSpeData[k].store );
                    arr8.push( "'" + "aaa" + "'" );
                    arr9.push( pageTwoData.fpiSpeData[k].typeId );
                    pageTwoData.standardReListData11.push( arr5,arr6,arr7,arr8,arr9 );
                }
                $(".fpi-sl-spe").on("click",".fpi-sl-delPic",function(){
                    $(this).siblings('img').attr("src","../../images/default-pic.png");
                });
                pageTwo.fpiSpeUploadPic();
            }
    	}else{
    		 tool.errortip("获取商品类型错误!");
    	}
        },"json");
    }

    //获取规格名称
    function getSpeName(bol) {
        if ( bol ) {
            $(".fpi-sl-btn").remove();
            $(".fpi-mul-first-btn").remove();
            $(".fpi-mul-second-btn").remove();
            $(".fpi-sl-infoContent").remove();
            $(".fpi-mul-infoContent").remove();
        }
        
        if ( pageTwoData.getSpeListData.length == 0){
            $(".fpi-specifications ul").find("li").eq(0).trigger("click");
        }else if( pageTwoData.getSpeListData.length == 1 ) {
            $(".fpi-specifications ul").find("li").eq(1).trigger("click");

            $(".fpi-singleLayer-name>p").text( pageTwoData.getSpeListData[0].goodsSpec.specName );
            var str = '',str01 = "";
            for( var i=0;i<pageTwoData.getSpeListData[0].specElement.length;i++ ){
                str += '<div class="fpi-sl-btn">'+ pageTwoData.getSpeListData[0].specElement[i] +'<img src="../../images/fpi-guige-choose.png"><img src="../../images/im-cancel14-2.png" class="fpi_slDelSpePic"></div>';
                str01 += '<div class="fpi-sl-infoContent" slInfo01="1--'+ i +'" style="display:none">'+
                                    '<div class="fpi-sl-spe">'+
                                        '<div>'+
                                            '<img src="../../images/default-pic.png" class="fpi-sl-pic" />'+
                                            '<p class="fpi-sl-delPic">删除图片</p>'+
                                        '</div>'+
                                        '<div>'+
                                            '<p class="fpi-sl-speName">'+ pageTwoData.getSpeListData[0].specElement[i] +'</p>'+
                                            '<div class="fpi-sl-speBtn">'+
                                                '本地上传'+
                                                '<input type="file" name="filedata" class="fpi-speUploadPic" />'+
                                            '</div>'+
                                        '</div>'+
                                    '</div>'+
                                    '<div class="fpi-sl-price">'+
                                        '<div>'+
                                            '<input type="text" defVal="price" value="" />'+
                                        '</div>'+
                                    '</div>'+
                                    '<div class="fpi-sl-stock">'+
                                        '<input type="text" placeholder="0-9999" defVal="stock" value="" />'+
                                    '</div>'+
                                '</div>';
            }
            
            $(str).insertBefore( ".fpi-sl-input" );
            $(".fpi-sl-info").show();
            $(".fpi-sl-infoTit").after(str01);
        }
    }

    //富文本框
    var toolArr = [
        'Blocktag', 'Fontface',
        'FontSize', 'Bold', 'Italic', 'Underline', 'Strikethrough',
        'FontColor', 'BackColor', 'SelectAll', 'Removeformat', 'Align',
        'List', 'Outdent', 'Indent', 'Img'
    ];
    
    var editor = $("#description").xheditor({
        height: 200,
        tools: toolArr.join(','),
        skin: 'default',
        upMultiple: true,
        cleanPaste: 3,
        upImgUrl: ajaxUrl.head + ajaxUrl.xhedit,
        upImgExt: 'jpg,jpeg,gif,bmp,png,JPG,JPEG,GIF,BMP,PNG',
//        onUpload: function(msg) {
//            //console.warn(msg);
//        	//tool.errortip(msg);
//        	insertUpload(msg);
//        },
        html5Upload: false
    });
    editor.getSource();

    var s = {
        mytar:'',
        mytarNum: '',
        arr3: [],
        getMainInfoData: ""
    };
    
    var userAgent = navigator.userAgent.toLowerCase(); 
    var browser = { 
        version: (userAgent.match( /.+(?:rv|it|ra|ie)[\/: ]([\d.]+)/ ) || [])[1], 
        safari: /webkit/.test( userAgent ), 
        opera: /opera/.test( userAgent ), 
        msie: /msie/.test( userAgent ) && !/opera/.test( userAgent ), 
        mozilla: /mozilla/.test( userAgent ) && !/(compatible|webkit)/.test( userAgent ) 
    };

    var pageTwo = {
        pageTwoInit: function(){
            pageTwo.fpiEdit();
            pageTwo.brandChooseOption();
            pageTwo.specificationsChoose();
            pageTwo.fpiSingleLayer();
            pageTwo.fpiProName();
            pageTwo.fpiProPoint();
            pageTwo.fpiStock();
            pageTwo.fpiPrice();
            pageTwo.fpiWeight();
            pageTwo.fpiVolume();
            pageTwo.fpiFreight();
            pageTwo.fpiTextBox();
            pageTwo.fpiSubBtn();
            pageTwo.fpiPreview();
            pageTwo.fpiPicBtn();
            pageTwo.even();
        },
        /*根据类目编号获取对应商品规格名称，暂时不获取*/
        getSpeList:function(dirId){
            var jsonData = {
                "dirId":dirId,
            }
            /*规格返回数据暂定这样*/
            var tempdata = {"rspCode":"000000","rspMsg":"成功!","goodsSpec":[{"specElement":"黑色"}]};
            pageTwoData.getSpeListData = tempdata.goodsSpec;
//            $.ajax({
//                url: ajaxUrl.head + ajaxUrl.chooseSpe,
//                type: "POST",
//                dataType: "json",
//                data: jsonData,
//                async: false,
//                success: function(data) {
//                    if ( data.success ) {
//                        pageTwoData.getSpeListData = data.data;
//                    };
//                },
//                error: function() {
//                    tool.errortip("请求错误！");
//                }
//            });
        },
        fpiCategoryNav: function(){ //商品类目
            if (  $.trim( $.cookie("grCategoryOne") ) != '' ) {
                $(".fpi-nav-one").text( $.cookie("grCategoryOne") );
                $(".fpi-nav-one").prev("span").show();
            };
            if (  $.trim( $.cookie("grCategoryTwo") ) != '' ) {
                $(".fpi-nav-two").text( $.cookie("grCategoryTwo") );
                $(".fpi-nav-two").prev("span").show();
            };
            if (  $.trim( $.cookie("grCategoryThree") ) != '' ) {
                $(".fpi-nav-three").text( $.cookie("grCategoryThree") );
                $(".fpi-nav-three").prev("span").show();
            };
            if (  $.trim( $.cookie("grCategoryFour") ) != '' ) {
                $(".fpi-nav-four").text( $.cookie("grCategoryFour") );
                $(".fpi-nav-four").prev("span").show();
            };
        },
        fpiEdit: function(){    //编辑
            $(".fpi-category-nav").on("click",".fpi-edit",function(){
                $(".goodsRelease-main").show();
                $(".fillProInfo-main").hide();
                $.cookie("pageOption","pageOne");
            })
        },
        fpiProName: function(){     //商品名称
            $('.fpi-proName div').on("keyup keypress","input",function(){
                if ( 30-$(this).val().length < 1 ) {
                    $(this).parent("div").siblings(".fpi-tip").find("span").text(0)
                }else{
                    $(this).parent("div").siblings(".fpi-tip").find("span").text( 30-$(this).val().length );
                }
            })
        },
        fpiProPoint: function(){    //商品卖点
            $('.fpi-proPoint').on("keyup keypress","textarea",function(){
                if ( 60-$(this).val().length < 1 ) {
                    $(this).siblings(".fpi-tip").find("span").text(0);
                    $(this).val( $(this).val().substring(0,60) );   //限制60字
                }else{
                    $(this).siblings(".fpi-tip").find("span").text( 60-$(this).val().length );
                }
            });
        },
        brandChooseOption: function(){  //品牌
            tool.dropDownList("fpi-brand");
        },
        fpiPic: function(){ //上传图片
        	var iframe = false;
            if(browser.msie  && browser.version < 10){
                iframe = true;
            }
        	$("#filedata").fileupload({
                url: ajaxUrl.head + ajaxUrl.upload,
                dataType: 'json',
                iframe: iframe,
                formData: {
                    name: 'file'
                }
            }).on('fileuploadprogressall', function(e, data) {
                //todo
            }).on('fileuploaddone', function(e, data) {
//            	alert(JSON.stringify(data));
                if (data.result.rspCode=="000000") {
                	var d = data.result;
                	var img = d.objs.url;
    				//var fileResid = d.objs.resid;
    				var fileNm = d.objs.newFileNm;
    				var orgFileNm = d.objs.resnm;
                    var str = '';
                    str = '<li class="have-banner imglist" type="0">'+
                                '<div class="product-image">'+
                                    '<img alt="'+orgFileNm+'" src="'+ img +'" file-name ="'+ fileNm +'">'+
                                '</div>'+
                                '<div class="upload-shadow product-shadow"></div>'+
                                '<div class="upload-image-option product-option">'+
                                    '<span>删除</span>'+
                                    '<em>设为封面</em>'+
                                '</div>'+
                                '<div class="upload-hot hide"></div>'+
                                '<img src="../../images/hotTip.png" class="fpi-setCoverPic" />'
                            '</li>';
                    $(".product-list").append( str );
                    if ( $(".product-list").find("li").length > 8 ) {
                        $(".fpi-pic-btn").hide();
                    }
                } else {
                    tool.errortip("上传错误!");
                }
            }).on('fileuploadfail', function(e, data) {
                tool.errortip("上传错误!");
            });
        },
        fpiPicBtn: function(){  //操作图片
            pageTwo.fpiPic();
            $(".product-list").on("click","span",function(){
                $(this).parents("li").remove();
                if ( $(".product-list").find("li").length < 9 ) {
                    $(".fpi-pic-btn").show();
                }
            });
            $(".product-list").on("click","em",function(){
                $(this).parents('li').siblings("li").attr("type",0);
                $(this).parents('li').attr("type",1);
                $(this).parents('li').siblings("li").find('.fpi-setCoverPic').hide();
                $(this).parents('li').find('.fpi-setCoverPic').show();
            });
        },
        specificationsChoose: function(){ //商品规格
            $(".fpi-specifications ul").on("click","li",function(){
                $(".fpi-specifications ul").find("li").removeClass("fpi-speActive");
                $(this).addClass("fpi-speActive");
                pageTwoData.fpiSpeActiveNum = $(this).index();
                if ( $(this).index() == 0 ) {
                    $(".fpi-defaultLayer").show();
                    $(".fpi-singleLayer").hide();
                    $(".fpi-multiLayer").hide();
                }else if ( $(this).index() == 1 ) {
                    $(".fpi-defaultLayer").hide();
                    $(".fpi-singleLayer").show();
                    $(".fpi-multiLayer").hide();
                };
            });
        },
        fpiSpeUploadPic:function(){ //商品规格上传图片
        	var iframe = false;
            if(browser.msie  && browser.version < 10){
                iframe = true;
            }
            
            $(".fpi-speUploadPic").fileupload({
                url: ajaxUrl.head + ajaxUrl.upload,
                dataType: 'json',
                iframe: iframe,
                formData: {
                    name: 'file'
                }
            }).on('fileuploadprogressall', function(e, data) {
                //todo
            }).on('fileuploaddone', function(e, data) {
            	if (data.result.rspCode=="000000") {
                	var d = data.result;
                	var img = d.objs.url;
    				var fileResid = d.objs.resid;
    				var fileNm = d.objs.newFileNm;
    				var orgFileNm = d.objs.resnm;
                    $(e.target).parent("div").parent("div").siblings('div').find('img').attr("src",img);
                    $(e.target).parent("div").parent("div").siblings('div').find('img').attr("alt",orgFileNm);
                    $(e.target).parent("div").parent("div").siblings('div').find('img').attr("file-name",fileNm);
                    $(".fpi-sl-spe").on("click",".fpi-sl-delPic",function(){
                        $(this).siblings('img').attr("src","../../images/default-pic.png");
                    });
                    $(".fpi-mul-spe").on("click",".fpi-sl-delPic",function(){
                        $(this).siblings('img').attr("src","../../images/default-pic.png");
                    });
                } else {
                    tool.errortip("上传错误!~~~~");
                }
            }).on('fileuploadfail', function(e, data) {
                tool.errortip("上传错误!");
            });
        },
        fpiSingleLayer: function(){ //单层规格
            getSpeName();
            $(".fpi-singleLayer-name").on("blur","input",function(e){
                tool.limitSpeLess( $(e.target) );
            })
            $(".fpi-singleLayer-name").on("click",".fpi-sl-btn",function(){
                $(this).toggleClass("fpi-slActive");
                var num = $(this).index();
                if ( $(this).hasClass('fpi-slActive') ) {
                    $(".fpi-sl-info").show();
                    $(".fpi-sl-infoContent").eq( num ).show();
                }else{
                    $(".fpi-sl-infoContent").eq( num ).hide();
                }
                pageTwo.fpiSpeUploadPic();
            });
            $(".fpi-singleLayer-name").on("click",".fpi_slDelSpePic",function(e){
                e.stopPropagation();
                var tNum = $(this).parent(".fpi-sl-btn").index(),str1 = "",str2 = "";
                $(this).parent(".fpi-sl-btn").remove();
                if ( $(".fpi-sl-infoContent").eq( tNum ).attr("slInfo") != undefined && $(".fpi-sl-infoContent").eq( tNum ).attr("slInfo") != "" ) {
                    str1 = $(".fpi-sl-infoContent").eq( tNum ).attr("slInfo").split(",")[0];
                    str1 = str1.substring(0,str1.length-4);
                    pageTwoData.slDelData.push( '{ "standardStr" :"'+ str1 +'"}' );
                    pageTwoData.slDelDataArr.push( str1 );
                }
                if ( $(".fpi-sl-infoContent").eq( tNum ).attr("slInfo01") != undefined && $(".fpi-sl-infoContent").eq( tNum ).attr("slInfo01") != "" ) {
                    str2 = $(".fpi-sl-infoContent").eq( tNum ).attr("slInfo01");
                    pageTwoData.slDelData.push( '{ "standardStr" :"'+ str2 +'"}' );
                    pageTwoData.slDelDataArr.push( str2 );
                }
                $(".fpi-sl-infoContent").eq( tNum ).remove();
            })
            $(".fpi-singleLayer-name").on("click",".fpi-sl-add",function(e){
                var str = "",
                    val = $(this).parent("div").find(".fpi-sl-input").find('input').val().trim(),
                    $dom = $(this).parent("div").find(".fpi-sl-input");
                for( var i=0;i<$(this).parent().find(".fpi-sl-btn").length;i++ ){
                    if ( $(this).parent().find(".fpi-sl-btn").eq(i).text() == val ) {
                        tool.errortip("规格名称重复！");
                        return false;
                    }
                }
                if ( $(e.target).parent("div").find(".fpi-sl-btn").length < 24 ) {
                    if ( $.trim( val ) != '' ) {
                        str += '<div class="fpi-sl-btn fpi-slActive">' +
                                    val +
                                    '<img src="../../images/fpi-guige-choose.png">'+
                                    '<img src="../../images/im-cancel14-2.png" class="fpi_slDelSpePic">'+
                                '</div>';
                        $( str ).insertBefore( $dom );
                    }else{
                        tool.errortip("请填写规格名称内容!");
                        return false;
                    }
                }else{
                    tool.errortip("最多添加24个规格!");
                    return false;
                }
                var str01 = '';
                for( var i=0;i<$(this).parent().find(".fpi-slActive").length;i++ ){
                    str01 = '<div class="fpi-sl-infoContent" slInfo="" slInfo01="">'+
                                '<div class="fpi-sl-spe">'+
                                    '<div class="hide">'+
                                        '<img src="../../images/default-pic.png" class="fpi-sl-pic" />'+
                                        '<p class="fpi-sl-delPic">删除图片</p>'+
                                    '</div>'+
                                    '<div>'+
                                        '<p class="fpi-sl-speName">'+ $(this).parent().find(".fpi-slActive").eq( $(this).parent().find(".fpi-slActive").length-1 ).text() +'</p>'+
                                        '<div class="fpi-sl-speBtn hide">'+
                                            '本地上传'+
                                            '<input type="file" name="file" class="fpi-speUploadPic" />'+
                                        '</div>'+
                                    '</div>'+
                                '</div>'+
                                '<div class="fpi-sl-price">'+
                                    '<div>'+
                                        '<input type="text" defVal="price" />'+
                                    '</div>'+
                                '</div>'+
                                '<div class="fpi-sl-stock">'+
                                    '<input type="text" placeholder="0-9999" defVal="stock" />'+
                                '</div>'+
                            '</div>';
                }
                if ( $(".fpi-sl-infoContent").length == 0 ) {
                    $(".fpi-sl-info").show();
                    $(".fpi-sl-infoTit").after(str01);
                }else{
                    $(".fpi-sl-infoContent:last").after(str01);
                }
                pageTwo.fpiSpeUploadPic();
                $(this).siblings('.fpi-sl-input').find("input").val("");
            });

            $(".fpi-singleLayer").on("keyup keypress","input[defVal='stock']",function(){
                var This = $(this),
                    $dom = This.parents(".fpi-sl-oneKey").siblings('.fpi-sl-infoContent').find("input[defVal='stock']");
                tool.limitNum( "9999",This );
                $dom.val( This.val()?parseInt(This.val(),"10"):"" );
                This.val( This.val()?parseInt(This.val(),"10"):"" );
            })
            $(".fpi-singleLayer").on("keyup keypress","input[defVal='price']",function(e){
                var This = $(this),
                    $dom = This.parents(".fpi-sl-oneKey").siblings('.fpi-sl-infoContent').find("input[defVal='price']");
                tool.limitNumTwo( "999999999.99",e.target );
                $dom.val( This.val()?parseFloat(This.val(),"10"):"" );
            })
        },
       
        fpiStock: function(){   //库存
            $(".fpi-stock").on("keyup keypress","input[defVal='stock']",function(e){
                tool.limitNum( "9999",e.target );
            });
        },
        fpiPrice: function(){   //价格
            $(".fpi-price").on("keyup keypress","input[defVal='price']",function(e){
                if ( $(this).val()*1 > 999999999 ) {
                    var This = $(this);
                    $(this).parent("div").parent("div").siblings(".fpi-errorTip").css("display","inline-block");
                    setTimeout(function(){
                        This.parent("div").parent("div").siblings(".fpi-errorTip").hide();
                    },3000);
                }
                tool.limitNumTwo( "999999999.99",e.target );
            });
        },
        fpiWeight: function(){  //重量
            $(".fpi-weight div").on("keyup keypress","input",function(e){
                tool.limitNum( "9999.999",e.target,true );
            });
        },
        fpiVolume: function(){  //体积
            $(".fpi-volume div").on("keyup keypress","input",function(e){
                tool.limitNum( "9999.999",e.target,true );
            });
        },
        fpiFreight: function(){ //运费模板
        	fee.getList　=　function(){
        		var postage={"rspCode":"000000","rspMsg":"成功!","objs":[{"id":"01000000","templateName":"包邮"}]};
        		var d = postage.objs,str = '';
	              for( var i=0;i<d.length;i++ ){
	                  str += '<li feeid="false" id="'+ d[i].id +'">'+ d[i].templateName +'</li>';
	              }
	              $(".fpi-freight").siblings("ul").empty();
	              $(".fpi-freight").siblings("ul").append( str );
	
	              var dd = $(".fpi-freight-btn p").data();
	              if(JSON.stringify(dd) == "{}"){
	              } else {
	                  var k = dd.id;
	                  for(var i = 0; i < d.length; i ++){
	                      if($(".fpi-freight").siblings("ul").find("li").eq(i).attr("id") == k){
	                          $(".fpi-freight").siblings("ul").find("li").eq(i).attr( "feeid","true" );
	                      } else {
	                          $(".fpi-freight").siblings("ul").find("li").eq(i).attr( "feeid","false" );
	                      }
	                  }
	                  
	              }
        	}
            $(".fpi-freight").on("click",".fpi-freight-btn",function(e){
                e.stopPropagation();
                $(".fpi-freight-main").find("ul").slideToggle(300);
                //fee.getList();
            });
            $(document).on("click",function(){
                $(".fpi-freight-main").find("ul").slideUp();
            });
            $('.fpi-freight-main ul').on("click","li",function(){
                $('.fpi-freight-btn p').text( $(this).text() );
                $(this).siblings('li').attr( "feeid","false" );
                $(this).attr( "feeid","true" );
            });
            //新增运费模板
            $(".fpi-freight").on('click',".fpi-freight-addBtn", function(e) {
                window.open( '＃'+merchant_id )
            });

            //刷新运费模板
            $(".fpi-freight").on('click',".fpi-freight-reload", function(e) {
                $('.fpi-freight-btn p').text("新增运费模板");
                fee.getList();
            });
        },
        fpiTextBox: function(){ //富文本框
        },
        fpiRequiredError: function(){
            var fpiSpeActiveNum = 0;
            for( var i=0;i<$(".fpi-specifications>ul").find("li").length;i++ ){
                if( $(".fpi-specifications>ul").find("li").eq(i).hasClass("fpi-speActive") ){
                    fpiSpeActiveNum = i;
                }
            }
            if( $(".fpi-proName").find("input").val() == "" ) {
                tool.errortip("请填写商品名称！")
                return false;
            }
            if( $(".imglist").length < 1 ){
                tool.errortip("请上传商品图片！");
                return false;
            }
            
            for( var i=0;i<$(".product-list").find("li").length;i++ ){
                var mainPic = $(".product-list").find("li").eq(i).attr("type");
                if(mainPic == 1)
                break;
                if(i==$(".product-list").find("li").length-1)
                {
                  tool.errortip("请设置一张图片为封面图片！");
                  return false;
                }
            }
            
            if( $(".fpi-freight-btn").find('p').text() == "请选择运费模板" ){
                tool.errortip("请选择运费模板！")
                return false;
            }
            if ( fpiSpeActiveNum == 0 ) {
                if (  $.trim( $(".fpi-stock").find("input").val() ) == "" ) {
                    tool.errortip("请填写商品库存！")
                    return false;
                }else if ( $.trim( $(".fpi-price").find("input").val() ) == "" ) {
                    tool.errortip("请填写商品价格！")
                    return false;
                }
                if (  $.trim( $(".fpi-stock").find("input").val() ) == "0" ) {
                    tool.errortip("商品库存不可以为0！")
                    return false;
                }else if ( $.trim( $(".fpi-price").find("input").val() ) == "0" ) {
                    tool.errortip("商品价格不可以为0！")
                    return false;
                }
            }
            if ( fpiSpeActiveNum == 1 ) {
                if ( $(".fpi-sl-infoContent:visible").length == 0 ) {
                    tool.errortip("请选择单层商品规格！")
                    return false;
                }
                var stockAA = $(".fpi-sl-infoContent:visible").find("input[defval='stock']"),stockBB = $(".fpi-sl-infoContent:visible").find("input[defval='price']"),len02 = stockAA.length;
                for( var m=0;m<len02;m++ ){
                    if (   $.trim( $(stockAA[m]).val() ) == "" ) {
                        tool.errortip("请填写商品库存！")
                        return false;
                    }else if (  $.trim( $(stockBB[m]).val() ) == "" ) {
                        tool.errortip("请填写商品价格！")
                        return false;
                    }
                }
                var allStockNum1 = 0;
                for( var i=0;i<$(".fpi-sl-infoContent:visible").find("input[defval='stock']").length;i++ ){
                    allStockNum1 +=  parseInt($(".fpi-sl-infoContent:visible").find("input[defval='stock']").eq(i).val());
                }
                if (  allStockNum1 == "0" || allStockNum1 == 0 ) {
                    tool.errortip("商品库存总和不能为0！")
                    return false;
                }
                if ( $.trim( $(".fpi-sl-infoContent:visible").find("input[defval='price']").val() ) == "0" ) {
                    tool.errortip("商品价格不可以为0！")
                    return false;
                }
            }
           
            if ( $.trim($("#description").val()) == '' ) {
                tool.errortip("请填写商品描述！")
                return false;
            };
            if ($("#description").val().length > 5000) {
                tool.errortip("超过最大限制5000！");
                return false;
            }
            return true;
        },
        fpiSubBtn: function(){  //提交审核
            $(".fpi-describe-main").on("click",".fpi-examine-btn",function(){
                var fpiSpeActiveNum = 0;
                /*获取类型标志：0:默认 1:单层规格*/
                for( var i=0;i<$(".fpi-specifications>ul").find("li").length;i++ ){
                    if( $(".fpi-specifications>ul").find("li").eq(i).hasClass("fpi-speActive") ){
                        fpiSpeActiveNum = i;
                    }
                }
                if ( pageTwo.fpiRequiredError() ) {
                	/*提交数量*/
                    if ( pageTwoData.subNum == 1 ) {
                    	/*editOrSub  1:新增  2:编辑*/
                        if ( pageTwoData.editOrSub == 1 ) {
                            pageTwo.fpiSubmitData( true );
                        }else{
                            /*if ( pageOneBol.isOldGoods == 1 && fpiSpeActiveNum == 2 ) {
                                pageTwo.fpiSubmitData( true );
                            }else {
                                pageTwo.fpiEditSubmitData( true,true );
                            }*/
                            pageTwo.fpiEditSubmitData( true,true );
                        }
                        pageTwoData.subNum++
                    }else{
                        return false;
                    }
                }
            })
        },
        fpiPreview:function(){  //预览
            $(".fpi-describe-main").on("click",".fpi-preview-btn",function(){
                var fpiSpeActiveNum = 0;
                for( var i=0;i<$(".fpi-specifications>ul").find("li").length;i++ ){
                    if( $(".fpi-specifications>ul").find("li").eq(i).hasClass("fpi-speActive") ){
                        fpiSpeActiveNum = i;
                    }
                }
                if ( pageTwo.fpiRequiredError() ) {
                    if ( pageTwoData.editOrSub == 1 ) {
                        pageTwo.fpiSubmitData( false );
                    }else{
                       /* if ( pageOneBol.isOldGoods == 1 && fpiSpeActiveNum == 2 ) {
                            pageTwo.fpiSubmitData( true );
                        }else{
                            pageTwo.fpiEditSubmitData( false,false );
                        }*/
                        pageTwo.fpiEditSubmitData( false,false );
                    }
                }else{
                    return false;
                }
            })
        },
        fpiSubmitData:function( bol1,bol2 ){
            var photos = [];
            $(".product-list > .imglist").each(function(i) {
                photos[i] = {
                    "sortNum": i,
                    "filePath": $(this).find("img").attr("src"),
                    "imgType": Number($(this).attr("type"))
                }
            });

            var filmPhotosArr = [];
            for( var i=0;i<$(".product-list").find("li").length;i++ ){
                filmPhotosArr.push( '{"sortNum":"'+ i +
                		'","filePath":"'+ $(".product-list").find("li").eq(i).find(".product-image").find("img").attr("src") +
                		'","fileNm":"'+ $(".product-list").find("li").eq(i).find(".product-image").find("img").attr("file-name") +
                		'","fileResid":"'+ $(".product-list").find("li").eq(i).find(".product-image").find("img").attr("file-resid") +
                		'","orgFileNm":"'+ $(".product-list").find("li").eq(i).find(".product-image").find("img").attr("alt") +
                		'","imgType":"'+ $(".product-list").find("li").eq(i).attr("type") +'"}' )
            }
            filmPhotosArr = filmPhotosArr.join(",");

            var fpiSpeActiveNum = 0;
            for( var i=0;i<$(".fpi-specifications>ul").find("li").length;i++ ){
                if( $(".fpi-specifications>ul").find("li").eq(i).hasClass("fpi-speActive") ){
                    fpiSpeActiveNum = i;
                }
            }
            var standardUpListData = '';
            var skuListData = '';
            var spuId = '';
            var speName = [],standard1List = [],standard2List= [];

            if ( fpiSpeActiveNum == 0 ) { //默认
                var str01 = ""; standardStr = '',standardStr01 = '';
                if ( pageTwoData.standardReListData0.length == 0 ) {
                    standardStr = "1--1_2-0" ;
                }else{
                    standardStr = pageTwoData.standardReListData0[0] ;
                }
                if ( pageTwoData.standardReListData01.length == 0 ) {
                    standardStr01 = "1--1" ;
                }else{
                    standardStr01 = pageTwoData.standardReListData01[0] ;
                }
                standardUpListData = "[{'enabled':1,'sort':1,'standardStr':'"+ standardStr01 +"'},{'enabled':1,'sort':1,'standardStr':'2-0'}]";
                var bbbb=pageTwoData.standardReListData0 != ''?pageTwoData.standardReListData0[1]:'"'+'"';
                var amt = Decimal2ToAmt($(".fpi-price").find("input[defval='price']").val());
                //alert(amt);
                skuListData = '[{"skuPriceYuan":"'+ amt +'","skuStandard":"'+ standardStr +'","stockNum":"'+ $(".fpi-stock").find("input[defval='stock']").val() +'","skuId":'+ bbbb +'}]';
                standard1List = "[]";
                standard2List = "[]";
            }else if ( fpiSpeActiveNum == 1 ) { //单层
                var len01 = $(".fpi-sl-infoContent").length,
                    len02 = $(".fpi-sl-infoContent:visible").length,
                    str = '',str01 = '',img = [],enabledNum = [],skuStandard = [],standardStr = [],preStr = '',
                    num1 = 0,num2 = 0,arr = [];

                for( var z=0;z<len01;z++ ){
                    if ( $(".fpi-sl-infoContent").eq(z).is(":visible") ) {
                        num = z+1;
                    }else{
                        num = 100;
                    }
                    arr.push( num );
                }
                arr = arr.delNum(100);
                for( var m=0;m<len02;m++ ){
                    if ( $(".fpi-sl-infoContent:visible").eq(m).attr("slInfo01") != "" ) {
                        skuStandard.push( $(".fpi-sl-infoContent:visible").eq(m).attr("slInfo01")+'_2-0' )
                    }else{
                        num1++;
                        skuStandard.push( '1--'+ (100+num1) +'_2-0' );
                    }
                    var amt = Decimal2ToAmt($(".fpi-sl-infoContent:visible").eq(m).find("input[defVal='price']").val());
                    str01 +=  '{"skuPriceYuan":"'+ amt +'","skuStandard":"'+ skuStandard[m] +'","stockNum":"'+ $(".fpi-sl-infoContent:visible").eq(m).find("input[defVal='stock']").val() +'","specification":"'+ $(".fpi-sl-infoContent:visible").eq(m).find(".fpi-sl-speName").text() +'","skuId":""},';
                }
                for( var n=0;n<len01;n++ ){
                    if ( $(".fpi-sl-infoContent").eq(n).attr("slInfo01") != "" ) {
                        standardStr.push( $(".fpi-sl-infoContent").eq(n).attr("slInfo01") )
                    }else{
                        num2++;
                        standardStr.push( '1--'+ (100+num2) );
                    }

                    img.push( $(".fpi-sl-infoContent").eq(n).find(".fpi-sl-pic").attr("src") == 'undefined'?"":$(".fpi-sl-infoContent").eq(n).find(".fpi-sl-pic").attr("src") );
                    if ( $(".fpi-singleLayer").find(".fpi-sl-btn").eq(n).hasClass("fpi-slActive") ) {
                        enabledNum[n] = "1";
                    }else{
                        enabledNum[n] = "0";
                    }
                    str += "{'enabled':"+ enabledNum[n] +",'img':'"+ img[n] +"','sort':"+ n +",'standardStr':'"+ standardStr[n] +"','standardName':'"+ $(".fpi-sl-infoContent").eq(n).find(".fpi-sl-speName").text() +"'},";
                    preStr += '{"enabled":'+ enabledNum[n] +',"img":"'+ img[n] +'","sort":'+ n +',"standardStr":"'+ standardStr[n] +'","standardName":"'+ $('.fpi-sl-infoContent').eq(n).find('.fpi-sl-speName').text() +'"},';
                }
                
                standardUpListData = "["+ str +"{'enabled':1,'sort':1,'standardStr':'2-0'}]";
                skuListData = "["+ str01 +"]";
                skuListData = skuListData.substring(0,skuListData.length-2)+"]";
                speName[0] = $(".fpi-singleLayer-name>p").text();
                
                standard1List = "["+ preStr +"]";
                standard1List = standard1List.substring(0,standard1List.length-2)+"]";
                standard2List = "[]";
            }
            
            var dirId = '';
            /*whb */
            
            /*if ( s.getMainInfoData.dirId == undefined || s.getMainInfoData.dirId == '' ) {
                dirId = pageOneBol.hisDirid != ""?pageOneBol.hisDirid:$("li[lastChoose='true']").attr("dirid")
            }else{
                dirId = s.getMainInfoData.dirId;
            }*/
            
            if ( s.getMainInfoData.classify == undefined || s.getMainInfoData.classify == '' ) {
                dirId = pageOneBol.hisDirid != ""?pageOneBol.hisDirid:$("li[lastChoose='true']").attr("dirid")
            }else{
                dirId = s.getMainInfoData.classify;
            }

            var dataJson = {
                "spuName": $("input[name=spuName]").val(),
                "advertorial": $("textarea[name=fpiadvertorial]").val(),
                "detailDesc": $("#description").val(),
                "tmpId": $("li[feeid='true']").attr("id"),
                "weight": $(".fpi-weight div").find("input").val(),
                "volume": $(".fpi-volume div").find("input").val(),
                "filmPhotos": "[" +filmPhotosArr+ "]",
                "dirId": dirId,
                "standardType": fpiSpeActiveNum.toString(),
                "standardUpList": standardUpListData,
                "skuList": skuListData,
                "standardReList": "["+ pageTwoData.standardReListData +"]",
                "spuId": ajaxUrl.spuId
            };
            //alert(JSON.stringify(dataJson));
            if ( bol1 ) {
                bol2?pageTwo.fpiSubUrls(dataJson):pageTwo.fpiPackages(dataJson);
                /*$.ajax({
                    url: ajaxUrl.head + ajaxUrl.fpiSubUrl,
                    type: "POST",
                    dataType: "json",
                    data: dataJson,
                    success: function(msg) {
                        if ( msg.success ) {
                            $(".fpi-examine-btn").on("click",function(){
                                return false;
                            })
                            // console.log('提交成功')
                            window.location.href = ajaxUrl.head + "/goodsProduct/toResult.html?_merchant_user_id_="+merchant_id+"&auditStatus=" + msg.data;
                        }else{
                            tool.errortip( msg.message );
                            pageTwoData.subNum = 1;
                            return false;
                        }
                    },
                    error: function() {
                        tool.errortip("请求错误!");
                        pageTwoData.subNum = 1;
                        return false;
                    }
                });*/
            }else{
                var preHref = basepath+ 'pages/Goods/goodsPreview.jsp?shop_id='+shop_id+'&data='+
                    '{"spuId":"",'+
                    '"channel":"",'+
                    '"bizId":"",'+
                    '"refId":"",'+
                    '"spuName":"'+ dataJson.spuName.replace(/\"/g,'\\"') +
                    '","advertorial":"'+ dataJson.advertorial.replace(/\"/g,'\\"') +
                    '","detailDesc":"'+ $("#description").val().replace(/\"/g,"\\'") +
                    '","tmpId":"'+ dataJson.tmpId +
                    '","weight":"'+ dataJson.weight +
                    '","volume":"'+ dataJson.volume +
                    '","filmPhotos":'+ dataJson.filmPhotos +
                    ',"dirId":"'+ dataJson.dirId +
                    '","standardType":"'+ dataJson.standardType +
                    '","standard1List":'+ standard1List +
                    ',"standard2List":'+ standard2List +
                    ',"skuList":'+ dataJson.skuList +
                    ',"standardReList":'+ dataJson.standardReList+
                    ',"standard1Name":"'+ speName +
                '"}';
               window.open( preHref );
            }
        },
        fpiEditSubmitData: function( bol1,bol2 ){
            var photos = [];
            $(".product-list > .imglist").each(function(i) {
                photos[i] = {
                    "sortNum": i,
                    "filePath": $(this).find("img").attr("src"),
                    "imgType": Number($(this).attr("type"))
                }
            });

            var filmPhotosArr = [];
            for( var i=0;i<$(".product-list").find("li").length;i++ ){
                filmPhotosArr.push( '{"sortNum":"'+ i +
                		'","filePath":"'+ $(".product-list").find("li").eq(i).find(".product-image").find("img").attr("src")  +
                		'","fileNm":"'+ $(".product-list").find("li").eq(i).find(".product-image").find("img").attr("file-name")  +
                		'","fileResid":"'+ $(".product-list").find("li").eq(i).find(".product-image").find("img").attr("file-resid")  +
                		'","orgFileNm":"'+ $(".product-list").find("li").eq(i).find(".product-image").find("img").attr("alt") +
                		'","imgType":"'+ $(".product-list").find("li").eq(i).attr("type") +'"}' )
            }
            filmPhotosArr = filmPhotosArr.join(",");

            var fpiSpeActiveNum = 0;
            for( var i=0;i<$(".fpi-specifications>ul").find("li").length;i++ ){
                if( $(".fpi-specifications>ul").find("li").eq(i).hasClass("fpi-speActive") ){
                    fpiSpeActiveNum = i;
                }
            }
            var standardUpListData = '';
            var skuListData = '';
            var spuId = '';
            /*whb edit*/
            pageTwoData.standardReListData = [];
            
            /*function standard1ListFn(){
                for( var j=0;j<pageTwoData.fpiSpeData.standard1List.length;j++ ){
                    if ( pageTwoData.fpiSpeData.standard1List[j].standardStr != '1-0' && pageTwoData.fpiSpeData.standard1List[j].standardStr != '2-0' ) {
                        pageTwoData.standardReListData.push( '{ "standardStr" :"'+ pageTwoData.fpiSpeData.standard1List[j].standardStr +'"}' );
                    }
                }
            }*/
            
            function standard1ListFn(){
                for( var j=0;j<pageTwoData.fpiSpeData.length;j++ ){
                    if (1) {
                        pageTwoData.standardReListData.push( '{ "standardStr" :"'+ 'AAAA' +'"}' );
                    }
                }
            }
            
            var proJson = {};
            var speName = [];
            
            //alert(fpiSpeActiveNum);
            if ( fpiSpeActiveNum == 0 ) { //默认
                if ( pageTwoData.fpiSpeActiveData == 1 ) {  //编辑时带来的单层原始数据，删除
                    standard1ListFn();
                    if ( bol2 ) {
                        pageTwo.fpiSubmitData( true );
                        return false;
                    }else {
                        pageTwo.fpiSubmitData( false );
                        return false;
                    }
                }else{
                    function editOne(){
                        var str01 = ""; standardStr = '',standardStr01 = '';
                        if ( pageTwoData.standardReListData0.length == 0 ) {
                            standardStr = "1--1_2-0" ;
                        }else{
                            standardStr = pageTwoData.standardReListData0[0] ;
                        }
                        if ( pageTwoData.standardReListData01.length == 0 ) {
                            standardStr01 = "1--1" ;
                        }else{
                            standardStr01 = pageTwoData.standardReListData01[0] ;
                        }
                        standardUpListData = "[{'enabled':1,'sort':1,'standardStr':"+ standardStr01 +"},{'enabled':1,'sort':1,'standardStr':'2-0'}]";
                        var aaaa=pageTwoData.standardReListData0 != ''?pageTwoData.standardReListData0[1]:'"'+'"';
                        var amt = Decimal2ToAmt($(".fpi-price").find("input[defval='price']").val()) ;
                        skuListData = '[{"skuPriceYuan":"'+ amt+'","skuStandard":'+ standardStr +',"stockNum":"'+ $('.fpi-stock').find("input[defval='stock']").val() +'","skuId":'+ aaaa +'}]';
                        proJson = {
                            "standardUpListData":standardUpListData,
                            "skuListData":skuListData
                        }
                        pageTwoData.standard1List = "[]";
                        pageTwoData.standard2List = "[]";
                    }
                    editOne();
                }
                
            }else if ( fpiSpeActiveNum == 1 ) { //单层
                if ( pageTwoData.fpiSpeActiveData == 0 ) {  //编辑时带来的默认、多层原始数据，删除
                    standard1ListFn();
                    if ( bol2 ) {
                        pageTwo.fpiSubmitData( true );
                        return false;
                    }else {
                        pageTwo.fpiSubmitData( false );
                        return false;
                    }
                }else{
                    function editTwo(){
                        var num = 0,num1 = 0,num2 = 0;
                        for( var b=0;b<$(".fpi-sl-infoContent:visible").length;b++ ){
                            if ( $(".fpi-sl-infoContent:visible").eq(b).attr("slInfo") != "" ) {
                                num++;
                            }
                        }
                        for( var d=0;d<$(".fpi-sl-infoContent").length;d++ ){
                            if ( $(".fpi-sl-infoContent").eq(d).attr("slInfo") != "" ) {
                                num2++;
                            }
                        }
                        for( var c=0;c<$(".fpi-sl-infoContent").length;c++ ){
                            if ( $(".fpi-sl-infoContent").eq(c).attr("slInfo") == "" ) {
                                num1++;
                            }
                        }
                        var str = '',str01 = '',preStr = '',
                            len01 = $(".fpi-singleLayer").find(".fpi-sl-btn").length,
                            len05 = num2,
                            len02 = num,
                            len06 = num1,
                            len03 = $(".fpi-singleLayer").find(".fpi-sl-infoContent:visible").length,
                            enabledNum = [],img = [],sort = [],standardStr = [],standardName = [],
                            skuPriceYuan = [],skuStandard = [],newskuStandard = [],stockNum = [],specification = [],skuId = [],newArr = [];
                            pageTwoData.standardReListData.push( pageTwoData.slDelData );
                        if ( len03 < 1 ) {
                            tool.errortip("请选择要增加的规格！");
                            return false;
                        }
                        for( var y=0;y<$(".fpi-sl-infoContent:visible").length;y++ ){
                            if ( $(".fpi-sl-infoContent:visible").eq(y).attr("slInfo") != ',' ) {
                                newArr.push($(".fpi-sl-infoContent").eq(y))
                            }
                        }

                        var len04 = newArr.length;
                        for( var m=0;m<len05;m++ ){
                            sort.push( $(".fpi-sl-btn").eq(m).data("d").sort );
                            standardStr.push( "'"+ $(".fpi-sl-btn").eq(m).data("d").standardStr +"'" );
                            standardName.push( /\'/g.test($(".fpi-sl-btn").eq(m).data("d").standardName) ?$(".fpi-sl-btn").eq(m).data("d").standardName:"'"+ $(".fpi-sl-btn").eq(m).data("d").standardName +"'" );
                            // $(".fpi-sl-btn").eq(m).data("d").standardName.indexOf("'")>0:$(".fpi-sl-btn").eq(m).data("d").standardName?"'"+ $(".fpi-sl-btn").eq(m).data("d").standardName +"'"
                            var reg = new RegExp( $(".fpi-sl-btn").eq(m).data("d").standardStr )
                            if (  reg.test( pageTwoData.standardReListData11[1][m] ) ) {
                                $(".fpi-sl-btn").eq(m).data("d").standardName = pageTwoData.standardReListData11[3][m];
                            }
                        }
                        for( var i=0;i<len06;i++ ){
                            sort.push( len01+i+30 );
                            standardStr.push( "'1--"+ (i+100) +"'" );
                            standardName.push( "'"+ $(".fpi-sl-btn").eq(len05+i).text() +"'" );
                            newskuStandard.push( '"1--'+ (i+100) +'_2-0"' );
                        }
                        var tt1 = 0;
                        for( var m=0;m<len03;m++ ){
                            skuPriceYuan.push( $(".fpi-sl-infoContent:visible").eq(m).find("input[defVal='price']").val() );
                            var arr = $(".fpi-sl-infoContent:visible").eq(m).attr("slinfo").split(",");
                            if (arr[0]) {
                                skuStandard[m] = '"'+arr[0]+'"';
                            }else{
                                skuStandard[m] = newskuStandard[tt1];
                                tt1 = tt1 + 1;
                            }
                            skuId[m] = arr[1]?arr[1]:'"'+'"';
                            stockNum.push( $(".fpi-sl-infoContent:visible").eq(m).find("input[defVal='stock']").val() );
                            specification.push( '"' + $(".fpi-sl-infoContent:visible").eq(m).find(".fpi-sl-speName").text() + '"' );
                            
                            /*for( var t=0;t<pageTwoData.slDelDataArr.length;t++ ){
                                if ( skuStandard[m].indexOf( pageTwoData.slDelDataArr[t] ) > -1 ) {
                                    skuPriceYuan = skuPriceYuan.arrRemove(m);
                                    skuStandard = skuStandard.arrRemove(m);
                                    stockNum = stockNum.arrRemove(m);
                                    specification = specification.arrRemove(m);
                                    skuId = skuId.arrRemove(m);
                                }
                            }*/
                            
                            var amt = Decimal2ToAmt(skuPriceYuan[m]);
                            str01 +=  '{"skuPriceYuan":"'+ amt +'","skuStandard":'+ skuStandard[m] +',"stockNum":"'+ stockNum[m] +'","specification":'+ specification[m] +',"skuId":'+ skuId[m] +'},';
                        }
                        
                        for( var a=0;a<len05;a++ ){
                            for( var h=0;h<pageTwoData.slDelDataArr.length-1;h++ ){
                                if ( standardStr[a].indexOf( pageTwoData.slDelDataArr[h] ) > -1 ) {
                                    sort = sort.arrRemove(a);
                                    standardStr = standardStr.arrRemove(a);
                                    standardName = standardName.arrRemove(a);
                                }
                            }
                        }

                        for( var n=0;n<len01;n++ ){
                            img.push( $(".fpi-sl-infoContent").eq(n).find(".fpi-sl-pic").attr("src") == undefined?"":$(".fpi-sl-infoContent").eq(n).find(".fpi-sl-pic").attr("src") );
                            if ( $(".fpi-singleLayer").find(".fpi-sl-btn").eq(n).hasClass("fpi-slActive") ) {
                                enabledNum[n] = "1";
                            }else{
                                enabledNum[n] = "0";
                            }

                            str += "{'enabled':"+ enabledNum[n] +",'img':'"+ img[n] +"','sort':"+ sort[n] +",'standardStr':"+ standardStr[n] +",'standardName':"+ standardName[n] +"},";
                            preStr += '{"enabled":'+ enabledNum[n] +',"img":"'+ img[n] +'","sort":'+ sort[n] +',"standardStr":'+ standardStr[n] +',"standardName":'+ standardName[n] +'},';
                        }
                        
                        standardUpListData = "["+ str +"{'enabled':1,'sort':1,'standardStr':'2-0'}]";
                        skuListData = "["+ str01 +"]";
                        skuListData = skuListData.substring(0,skuListData.length-2)+"]";
                        proJson = {
                            "standardUpListData":standardUpListData,
                            "skuListData":skuListData
                        };
                        pageTwoData.standard1List= "["+ preStr +"]";
                        pageTwoData.standard2List = "[]";
                    }
                    editTwo();
                }
                
                speName[0] = $(".fpi-singleLayer-name>p").text();
            }

            var dirId = '';
            /*if ( s.getMainInfoData.dirId == '' || s.getMainInfoData.dirId == undefined ) {
                dirId = pageOneBol.hisDirid != ""?pageOneBol.hisDirid:$("li[lastChoose='true']").attr("dirid")
            }else{
                dirId = s.getMainInfoData.dirId;
            }*/
            if ( s.getMainInfoData.classify == undefined || s.getMainInfoData.classify == '' ) {
                dirId = pageOneBol.hisDirid != ""?pageOneBol.hisDirid:$("li[lastChoose='true']").attr("dirid")
            }else{
                dirId = s.getMainInfoData.classify;
            }
            var dataJson = {
                "spuName": $("input[name=spuName]").val(),
                "advertorial": $("textarea[name=fpiadvertorial]").val() ,
                "detailDesc": $("#description").val(),
                "tmpId": $("li[feeid='true']").attr("id"),
                "weight": $(".fpi-weight div").find("input").val(),
                "volume": $(".fpi-volume div").find("input").val(),
                "filmPhotos": "[" +filmPhotosArr+ "]",
                "dirId": dirId,
                "standardType": fpiSpeActiveNum.toString(),
                "standardUpList": proJson.standardUpListData,
                "skuList": proJson.skuListData,
                "standardReList": "["+ pageTwoData.standardReListData +"]",
                "spuId": ajaxUrl.spuId
            };

            if ( bol1 ) {
                pageTwo.fpiPackages(dataJson,bol2);
                
            }else{
                var preHref = 'http://#/info/product-detail.htm?data='+
                    '{"spuId":"",'+
                    '"channel":"",'+
                    '"bizId":"",'+
                    '"refId":"",'+
                    '"spuName":"'+ dataJson.spuName.replace(/\"/g,'\\"') +
                    '","advertorial":"'+ dataJson.advertorial.replace(/\"/g,'\\"') +
                    '","detailDesc":"'+ $("#description").val().replace(/\"/g,"\\'") +
                    '","tmpId":"'+ dataJson.tmpId +
                    '","weight":"'+ dataJson.weight +
                    '","volume":"'+ dataJson.volume +
                    '","filmPhotos":'+ dataJson.filmPhotos +
                    ',"dirId":"'+ dataJson.dirId +
                    '","standardType":"'+ dataJson.standardType +
                    '","standard1List":'+ pageTwoData.standard1List +
                    ',"standard2List":'+ pageTwoData.standard2List +
                    ',"skuList":'+ dataJson.skuList +
                    ',"standardReList":'+ dataJson.standardReList+
                    ',"standard1Name":"'+ speName +
                '"}';
                window.open( preHref );
            }
        },
        fpiPackages:function(a,bol2){   
        	 /*alert('发布');*/
            if(!!a){
                var dataJson=a;
            }else{
               var dataJson=!!ajaxUrl.spuId?pageTwo.fpiRelease(bol2):pageTwo.fpiToEamine(); 
            }
            
            var url= ajaxUrl.head + ajaxUrl.publishCheck;
        	var param = dataJson;
        	//alert(JSON.stringify(param));
            $.post(url,param,function(data){
//        	alert(JSON.stringify(data));
        	if(data.rspCode=="000002"||data.rspCode=="000001"){
        		tool.errortip( data.rspCode + data.RspMsg );
                pageTwoData.subNum = 1;
                return false;
        	}else{
        		return pageTwo.fpiSubUrls(a,bol2);
        	}
            },"json");
           
//            $.ajax({
//                    url: ajaxUrl.head + ajaxUrl.publishCheck,
//                    type: "POST",
//                    dataType: "json",
//                    data: dataJson,
//                    success: function(msg) {
//                        if ( msg.success ) {
//                            $('#publish_content').text(msg.message);
//                            if(!msg.data){
//                                //无剩余额度
//                                pageTwo.float('dialogs');
//                                $('.but').hide(),$('.but').eq(0).show();
//                                $('#publish_payment').attr('href',(!!ajaxUrl.spuId?"http://enterprise.#/merchant/apppackages/toPayProductPackages.html?id=-2&type=1&sysKey=":"http://enterprise.#/merchant/apppackages/toPayProductPackages.html?id=-1&type=1&sysKey="));
//                            }else if(msg.data==1){
//                                //有剩余额度
//                                $('.but').hide(),$('.but').eq(1).show();
//                                pageTwo.float('dialogs');
//                            }else if(msg.data==2 || msg.data==-1){
//                                return pageTwo.fpiSubUrls(a,bol2);
//                            }else if(msg.data==3){
//                                //有剩余额度
//                                $('.but').hide(),$('.but').eq(1).show();
//                                $('#publish_button').hide().remove();
//                                pageTwo.float('dialogs');
//                            }    
//                        }else{
//                            tool.errortip( msg.message );
//                            pageTwoData.subNum = 1;
//                            return false;
//                        }
//                    },
//                    error: function() {
//                        tool.errortip("请求错误!");
//                        pageTwoData.subNum = 1;
//                        return false;
//                    }
//            });
        },
        even:function(){
         //点击事件
         $('.publish_closes,#publish_close').click(function(){
            //取消显示
            $('.dialogs').hide();
            $('.float').hide();
            pageTwoData.subNum=1;
         })

         //点击确认
         $('#publish_button').unbind('click').bind('click',function(){
            pageTwo.fpiSubUrls('',true,true);
         })

         //点击购买或者去支付
         $('#publish_packages,#publish_payment').click(function(){
            $('#publish_content').text('请根据支付情况选择以下支付结果。');
            $('.but').eq(0).hide(),$('.but').eq(2).show();
            
            
         })

         //点击支付完成
         $('#publish_completion').click(function(){
            pageTwo.fpiGetRemaining();
         })


        },
        //弹出层
       float:function(clas){
           var width=$(window).width(),
           height=$(window).height(),
           width1=$('.'+clas).width(),
           height1=$('.'+clas).height(),
           h=$(document.body).height(),
           heights=0,
           top=(height-height1)/8,
           left=(width-width1)/2;
           $('.'+clas).css({
              'top':top+'px',
              'left':left+'px'
           });
           heights=height>h? height:h;
           $('.float').css({
               'height':heights+'px'
           });
       
           $('.float').show();
           $('.'+clas).show();
      
        },
        fpiSubUrls:function(a,bol2,bol3){
            //编辑和发布
           if(!!a){
                var dataJson=a;
            }else{
               var dataJson=!!ajaxUrl.spuId?pageTwo.fpiRelease(bol2,bol3):pageTwo.fpiToEamine(); 
            }
//           alert(JSON.stringify(dataJson));
//           return;
            if(!!dataJson){
            	var url= ajaxUrl.head + ajaxUrl.fpiSubUrl;
            	var param = dataJson;
            	//alert(JSON.stringify(param));
                $.post(url,param,function(data){
//            	alert(JSON.stringify(data));
            	if(data.rspCode!="000000"){
            		tool.errortip( data.rspCode + data.RspMsg );
                    pageTwoData.subNum = 1;
                    return false;
            	}else{
            		 $(".fpi-examine-btn").on("click",function(){
                         return false;
                     })
                     pageTwoData.subNum=1;
                     //window.location.href = ajaxUrl.head + "/MerChnt/PublictoResult.jsp?shop_id="+shop_id+"&auditStatus=" + msg.data;
                     window.location.href = ajaxUrl.head + "pages/MerChnt/PublictoResult.jsp?shop_id="+shop_id+'&user_id='+user_id;
                     return false;
            	}
                },"json");
//               $.ajax({
//                    url: ajaxUrl.head + ajaxUrl.fpiSubUrl,
//                    type: "POST",
//                    dataType: "json",
//                    data: dataJson,
//                    success: function(msg) {
//
//                        if ( msg.success ) {
//                            $(".fpi-examine-btn").on("click",function(){
//                                return false;
//                            })
//                            
//                            pageTwoData.subNum=1;
//                            window.location.href = ajaxUrl.head + "/goodsProduct/toResult.html?_merchant_user_id_="+merchant_id+"&auditStatus=" + msg.data;
//                            return false;
//                        }else{
//                            $('.dialogs').hide();
//                            $('.float').hide();
//                            tool.errortip( msg.message );
//                            pageTwoData.subNum = 1;
//                            return false;
//                        }
//                    },
//                    error: function() {
//                        tool.errortip("请求错误!");
//                        pageTwoData.subNum = 1;
//                        return false;
//                    }
//                });
            }else{
                return !1;
            }
           
        },
        fpiGetRemaining:function(){
           $.ajax({
                    url: ajaxUrl.head + ajaxUrl.getRemaining,
                    type: "POST",
                    dataType: "json",
                    //data: dataJson,
                    success: function(msg) {
                        if ( msg.success ) {
                            if((!!ajaxUrl.spuId && msg.data.auditNum<1)
                                ||  (!ajaxUrl.spuId && msg.data.publishNum<1)){
                                 $('#publish_content').text('该商品尚未完成支付，请继续支付。');
                                 $('.but').eq(2).hide(),$('.but').eq(3).show();
                                 pageTwoData.subNum=1;
                                 return false;
                            }
                            pageTwo.fpiSubUrls('',true,true);
                        }else{
                            tool.errortip( msg.message );
                            pageTwoData.subNum = 1;
                            return false;
                        }
                    },
                    error: function() {
                        tool.errortip("请求错误!");
                        pageTwoData.subNum = 1;
                        return false;
                    }
                });
        },
        //发布参数
        fpiToEamine:function(){
            var photos = [];
            $(".product-list > .imglist").each(function(i) {
                photos[i] = {
                    "sortNum": i,
                    "filePath": $(this).find("img").attr("src"),
                    "imgType": Number($(this).attr("type"))
                }
            });

            var filmPhotosArr = [];
            for( var i=0;i<$(".product-list").find("li").length;i++ ){
                filmPhotosArr.push( '{"sortNum":"'+ i +
                		'","filePath":"'+ $(".product-list").find("li").eq(i).find(".product-image").find("img").attr("src") +
                		'","fileNm":"'+ $(".product-list").find("li").eq(i).find(".product-image").find("img").attr("file-name") +
                		'","fileResid":"'+ $(".product-list").find("li").eq(i).find(".product-image").find("img").attr("file-resid") +
                		'","orgFileNm":"'+ $(".product-list").find("li").eq(i).find(".product-image").find("img").attr("alt") +
                		'","imgType":"'+ $(".product-list").find("li").eq(i).attr("type") +'"}' )
            }
            filmPhotosArr = filmPhotosArr.join(",");

            var fpiSpeActiveNum = 0;
            for( var i=0;i<$(".fpi-specifications>ul").find("li").length;i++ ){
                if( $(".fpi-specifications>ul").find("li").eq(i).hasClass("fpi-speActive") ){
                    fpiSpeActiveNum = i;
                }
            }
            var standardUpListData = '';
            var skuListData = '';
            var spuId = '';
            var speName = [],standard1List = [],standard2List= [];

            if ( fpiSpeActiveNum == 0 ) { //默认
                var str01 = ""; standardStr = '',standardStr01 = '';
                if ( pageTwoData.standardReListData0.length == 0 ) {
                    standardStr = "1--1_2-0" ;
                }else{
                    standardStr = pageTwoData.standardReListData0[0] ;
                }
                if ( pageTwoData.standardReListData01.length == 0 ) {
                    standardStr01 = "1--1" ;
                }else{
                    standardStr01 = pageTwoData.standardReListData01[0] ;
                }
                standardUpListData = "[{'enabled':1,'sort':1,'standardStr':'"+ standardStr01 +"'},{'enabled':1,'sort':1,'standardStr':'2-0'}]";
                var bbbb=pageTwoData.standardReListData0 != ''?pageTwoData.standardReListData0[1]:'"'+'"';
                var amt = Decimal2ToAmt($(".fpi-price").find("input[defval='price']").val()) ;
                skuListData = '[{"skuPriceYuan":"'+ amt +'","skuStandard":"'+ standardStr +'","stockNum":"'+ $(".fpi-stock").find("input[defval='stock']").val() +'","skuId":'+ bbbb +'}]';
                standard1List = "[]";
                standard2List = "[]";
            }else if ( fpiSpeActiveNum == 1 ) { //单层
                var len01 = $(".fpi-sl-infoContent").length,
                    len02 = $(".fpi-sl-infoContent:visible").length,
                    str = '',str01 = '',img = [],enabledNum = [],skuStandard = [],standardStr = [],preStr = '',
                    num1 = 0,num2 = 0,arr = [];

                for( var z=0;z<len01;z++ ){
                    if ( $(".fpi-sl-infoContent").eq(z).is(":visible") ) {
                        num = z+1;
                    }else{
                        num = 100;
                    }
                    arr.push( num );
                }
                arr = arr.delNum(100);
                for( var m=0;m<len02;m++ ){
                    if ( $(".fpi-sl-infoContent:visible").eq(m).attr("slInfo01") != "" ) {
                        skuStandard.push( $(".fpi-sl-infoContent:visible").eq(m).attr("slInfo01")+'_2-0' )
                    }else{
                        num1++;
                        skuStandard.push( '1--'+ (100+num1) +'_2-0' );
                    }
                    var amt = Decimal2ToAmt($(".fpi-sl-infoContent:visible").eq(m).find("input[defVal='price']").val());
                    str01 +=  '{"skuPriceYuan":"'+ amt +'","skuStandard":"'+ skuStandard[m] +'","stockNum":"'+ $(".fpi-sl-infoContent:visible").eq(m).find("input[defVal='stock']").val() +'","specification":"'+ $(".fpi-sl-infoContent:visible").eq(m).find(".fpi-sl-speName").text() +'","skuId":""},';
                }
                for( var n=0;n<len01;n++ ){
                    if ( $(".fpi-sl-infoContent").eq(n).attr("slInfo01") != "" ) {
                        standardStr.push( $(".fpi-sl-infoContent").eq(n).attr("slInfo01") )
                    }else{
                        num2++;
                        standardStr.push( '1--'+ (100+num2) );
                    }

                    img.push( $(".fpi-sl-infoContent").eq(n).find(".fpi-sl-pic").attr("src") == 'undefined'?"":$(".fpi-sl-infoContent").eq(n).find(".fpi-sl-pic").attr("src") );
                    if ( $(".fpi-singleLayer").find(".fpi-sl-btn").eq(n).hasClass("fpi-slActive") ) {
                        enabledNum[n] = "1";
                    }else{
                        enabledNum[n] = "0";
                    }
                    str += "{'enabled':"+ enabledNum[n] +",'img':'"+ img[n] +"','sort':"+ n +",'standardStr':'"+ standardStr[n] +"','standardName':'"+ $(".fpi-sl-infoContent").eq(n).find(".fpi-sl-speName").text() +"'},";
                    preStr += '{"enabled":'+ enabledNum[n] +',"img":"'+ img[n] +'","sort":'+ n +',"standardStr":"'+ standardStr[n] +'","standardName":"'+ $('.fpi-sl-infoContent').eq(n).find('.fpi-sl-speName').text() +'"},';
                }
                
                standardUpListData = "["+ str +"{'enabled':1,'sort':1,'standardStr':'2-0'}]";
                skuListData = "["+ str01 +"]";
                skuListData = skuListData.substring(0,skuListData.length-2)+"]";
                speName[0] = $(".fpi-singleLayer-name>p").text();
                
                standard1List = "["+ preStr +"]";
                standard1List = standard1List.substring(0,standard1List.length-2)+"]";
                standard2List = "[]";
            };
            
            var dirId = '';

            if ( s.getMainInfoData.classify == undefined || s.getMainInfoData.classify == '' ) {
                dirId = pageOneBol.hisDirid != ""?pageOneBol.hisDirid:$("li[lastChoose='true']").attr("dirid")
            }else{
                dirId = s.getMainInfoData.classify;
            }/*
            if ( s.getMainInfoData.dirId == undefined || s.getMainInfoData.dirId == '' ) {
                dirId = pageOneBol.hisDirid != ""?pageOneBol.hisDirid:$("li[lastChoose='true']").attr("dirid")
            }else{
                dirId = s.getMainInfoData.dirId;
            }*/

            
            var dataJson = {
                "spuName": $("input[name=spuName]").val(),
                "advertorial": $("textarea[name=fpiadvertorial]").val(),
                "detailDesc": $("#description").val(),
                "tmpId": $("li[feeid='true']").attr("id"),
                "weight": $(".fpi-weight div").find("input").val(),
                "volume": $(".fpi-volume div").find("input").val(),
                "filmPhotos": "[" +filmPhotosArr+ "]",
                "dirId": dirId,
                "standardType": fpiSpeActiveNum.toString(),
                "standardUpList": standardUpListData,
                "skuList": skuListData,
                "standardReList": "["+ pageTwoData.standardReListData +"]",
                "spuId": ajaxUrl.spuId
            };
            return dataJson;
        },
        //编辑参数
        fpiRelease:function(bol2,bol3){
            var photos = [];
            $(".product-list > .imglist").each(function(i) {
                photos[i] = {
                    "sortNum": i,
                    "filePath": $(this).find("img").attr("src"),
                    "imgType": Number($(this).attr("type"))
                }
            });

            var filmPhotosArr = [];
            for( var i=0;i<$(".product-list").find("li").length;i++ ){
                filmPhotosArr.push( '{"sortNum":"'+ i +
                		'","filePath":"'+ $(".product-list").find("li").eq(i).find(".product-image").find("img").attr("src")  +
                		'","fileNm":"'+ $(".product-list").find("li").eq(i).find(".product-image").find("img").attr("file-name") +
                		'","fileResid":"'+ $(".product-list").find("li").eq(i).find(".product-image").find("img").attr("file-resid") +
                		'","orgFileNm":"'+ $(".product-list").find("li").eq(i).find(".product-image").find("img").attr("alt") +
                		'","imgType":"'+ $(".product-list").find("li").eq(i).attr("type") +'"}' )
            }
            filmPhotosArr = filmPhotosArr.join(",");

            var fpiSpeActiveNum = 0;
            for( var i=0;i<$(".fpi-specifications>ul").find("li").length;i++ ){
                if( $(".fpi-specifications>ul").find("li").eq(i).hasClass("fpi-speActive") ){
                    fpiSpeActiveNum = i;
                }
            }
            var standardUpListData = '';
            var skuListData = '';
            var spuId = '';
            pageTwoData.standardReListData = [];
            function standard1ListFn(){
                for( var j=0;j<pageTwoData.fpiSpeData.length;j++ ){
                    if ( 1 ) {
                        pageTwoData.standardReListData.push( '{ "standardStr" :"'+ 'AAAA' +'"}' );
                    }
                }
            }
           /* function standard1ListFn(){
                for( var j=0;j<pageTwoData.fpiSpeData.standard1List.length;j++ ){
                    if ( pageTwoData.fpiSpeData.standard1List[j].standardStr != '1-0' && pageTwoData.fpiSpeData.standard1List[j].standardStr != '2-0' ) {
                        pageTwoData.standardReListData.push( '{ "standardStr" :"'+ pageTwoData.fpiSpeData.standard1List[j].standardStr +'"}' );
                    }
                }
            }*/
            var proJson = {};
            var speName = [];
            
            if ( fpiSpeActiveNum == 0 ) { //默认
                if ( pageTwoData.fpiSpeActiveData == 1 ) {  //编辑时带来的单层、多层原始数据，删除
                    standard1ListFn();
                    if ( bol2 ) {
                        pageTwo.fpiSubmitData( true,bol3 );
                        return false;
                    }else {
                        pageTwo.fpiSubmitData( false );
                        return false;
                    }
                }else{
                    function editOne(){
                        var str01 = ""; standardStr = '',standardStr01 = '';
                        if ( pageTwoData.standardReListData0.length == 0 ) {
                            standardStr = "1--1_2-0" ;
                        }else{
                            standardStr = pageTwoData.standardReListData0[0] ;
                        }
                        if ( pageTwoData.standardReListData01.length == 0 ) {
                            standardStr01 = "1--1" ;
                        }else{
                            standardStr01 = pageTwoData.standardReListData01[0] ;
                        }
                        standardUpListData = "[{'enabled':1,'sort':1,'standardStr':"+ standardStr01 +"},{'enabled':1,'sort':1,'standardStr':'2-0'}]";
                        var aaaa=pageTwoData.standardReListData0 != ''?pageTwoData.standardReListData0[1]:'"'+'"';
                        var amt = Decimal2ToAmt($(".fpi-price").find("input[defval='price']").val());
                        skuListData = '[{"skuPriceYuan":"'+ amt +'","skuStandard":'+ standardStr +',"stockNum":"'+ $('.fpi-stock').find("input[defval='stock']").val() +'","skuId":'+ aaaa +'}]';
                        proJson = {
                            "standardUpListData":standardUpListData,
                            "skuListData":skuListData
                        }
                        pageTwoData.standard1List = "[]";
                        pageTwoData.standard2List = "[]";
                    }
                    editOne();
                }
                
            }else if ( fpiSpeActiveNum == 1 ) { //单层
                if ( pageTwoData.fpiSpeActiveData == 0 ) {  //编辑时带来的默认、多层原始数据，删除
                    standard1ListFn();
                    if ( bol2 ) {
                        pageTwo.fpiSubmitData( true,bol3 );
                        return false;
                    }else {
                        pageTwo.fpiSubmitData( false );
                        return false;
                    }
                }else{
                    function editTwo(){
                        var num = 0,num1 = 0,num2 = 0;
                        for( var b=0;b<$(".fpi-sl-infoContent:visible").length;b++ ){
                            if ( $(".fpi-sl-infoContent:visible").eq(b).attr("slInfo") != "" ) {
                                num++;
                            }
                        }
                        for( var d=0;d<$(".fpi-sl-infoContent").length;d++ ){
                            if ( $(".fpi-sl-infoContent").eq(d).attr("slInfo") != "" ) {
                                num2++;
                            }
                        }
                        for( var c=0;c<$(".fpi-sl-infoContent").length;c++ ){
                            if ( $(".fpi-sl-infoContent").eq(c).attr("slInfo") == "" ) {
                                num1++;
                            }
                        }
                        var str = '',str01 = '',preStr = '',
                            len01 = $(".fpi-singleLayer").find(".fpi-sl-btn").length,
                            len05 = num2,
                            len02 = num,
                            len06 = num1,
                            len03 = $(".fpi-singleLayer").find(".fpi-sl-infoContent:visible").length,
                            enabledNum = [],img = [],sort = [],standardStr = [],standardName = [],
                            skuPriceYuan = [],skuStandard = [],newskuStandard = [],stockNum = [],specification = [],skuId = [],newArr = [];
                            pageTwoData.standardReListData.push( pageTwoData.slDelData );
                        if ( len03 < 1 ) {
                            tool.errortip("请选择要增加的规格！");
                            return false;
                        }
                        for( var y=0;y<$(".fpi-sl-infoContent:visible").length;y++ ){
                            if ( $(".fpi-sl-infoContent:visible").eq(y).attr("slInfo") != ',' ) {
                                newArr.push($(".fpi-sl-infoContent").eq(y))
                            }
                        }

                        var len04 = newArr.length;
                        for( var m=0;m<len05;m++ ){
                            sort.push( $(".fpi-sl-btn").eq(m).data("d").sort );
                            standardStr.push( "'"+ $(".fpi-sl-btn").eq(m).data("d").standardStr +"'" );
                            standardName.push( /\'/g.test($(".fpi-sl-btn").eq(m).data("d").standardName) ?$(".fpi-sl-btn").eq(m).data("d").standardName:"'"+ $(".fpi-sl-btn").eq(m).data("d").standardName +"'" );
                            // $(".fpi-sl-btn").eq(m).data("d").standardName.indexOf("'")>0:$(".fpi-sl-btn").eq(m).data("d").standardName?"'"+ $(".fpi-sl-btn").eq(m).data("d").standardName +"'"
                            var reg = new RegExp( $(".fpi-sl-btn").eq(m).data("d").standardStr )
                            if (  reg.test( pageTwoData.standardReListData11[1][m] ) ) {
                                $(".fpi-sl-btn").eq(m).data("d").standardName = pageTwoData.standardReListData11[3][m];
                            }
                        }
                        for( var i=0;i<len06;i++ ){
                            sort.push( len01+i+30 );
                            standardStr.push( "'1--"+ (i+100) +"'" );
                            standardName.push( "'"+ $(".fpi-sl-btn").eq(len05+i).text() +"'" );
                            newskuStandard.push( '"1--'+ (i+100) +'_2-0"' );
                        }
                        var tt1 = 0;
                        for( var m=0;m<len03;m++ ){
                            skuPriceYuan.push( $(".fpi-sl-infoContent:visible").eq(m).find("input[defVal='price']").val() );
                            var arr = $(".fpi-sl-infoContent:visible").eq(m).attr("slinfo").split(",");
                            if (arr[0]) {
                                skuStandard[m] = '"'+arr[0]+'"';
                            }else{
                                skuStandard[m] = newskuStandard[tt1];
                                tt1 = tt1 + 1;
                            }
                            skuId[m] = arr[1]?arr[1]:'"'+'"';
                            stockNum.push( $(".fpi-sl-infoContent:visible").eq(m).find("input[defVal='stock']").val() );
                            specification.push( '"' + $(".fpi-sl-infoContent:visible").eq(m).find(".fpi-sl-speName").text() + '"' );
                            
                            /*for( var t=0;t<pageTwoData.slDelDataArr.length;t++ ){
                                if ( skuStandard[m].indexOf( pageTwoData.slDelDataArr[t] ) > -1 ) {
                                    skuPriceYuan = skuPriceYuan.arrRemove(m);
                                    skuStandard = skuStandard.arrRemove(m);
                                    stockNum = stockNum.arrRemove(m);
                                    specification = specification.arrRemove(m);
                                    skuId = skuId.arrRemove(m);
                                }
                            }*/
                            alert('whb'+skuPriceYuan[m]);
                            str01 +=  '{"skuPriceYuan":'+ skuPriceYuan[m] +',"skuStandard":'+ skuStandard[m] +',"stockNum":'+ stockNum[m] +',"specification":'+ specification[m] +',"skuId":'+ skuId[m] +'},';
                        }
                        
                        for( var a=0;a<len05;a++ ){
                            for( var h=0;h<pageTwoData.slDelDataArr.length-1;h++ ){
                                if ( standardStr[a].indexOf( pageTwoData.slDelDataArr[h] ) > -1 ) {
                                    sort = sort.arrRemove(a);
                                    standardStr = standardStr.arrRemove(a);
                                    standardName = standardName.arrRemove(a);
                                }
                            }
                        }

                        for( var n=0;n<len01;n++ ){
                            img.push( $(".fpi-sl-infoContent").eq(n).find(".fpi-sl-pic").attr("src") == undefined?"":$(".fpi-sl-infoContent").eq(n).find(".fpi-sl-pic").attr("src") );
                            if ( $(".fpi-singleLayer").find(".fpi-sl-btn").eq(n).hasClass("fpi-slActive") ) {
                                enabledNum[n] = "1";
                            }else{
                                enabledNum[n] = "0";
                            }

                            str += "{'enabled':"+ enabledNum[n] +",'img':'"+ img[n] +"','sort':"+ sort[n] +",'standardStr':"+ standardStr[n] +",'standardName':"+ standardName[n] +"},";
                            preStr += '{"enabled":'+ enabledNum[n] +',"img":"'+ img[n] +'","sort":'+ sort[n] +',"standardStr":'+ standardStr[n] +',"standardName":'+ standardName[n] +'},';
                        }
                        
                        standardUpListData = "["+ str +"{'enabled':1,'sort':1,'standardStr':'2-0'}]";
                        skuListData = "["+ str01 +"]";
                        skuListData = skuListData.substring(0,skuListData.length-2)+"]";
                        proJson = {
                            "standardUpListData":standardUpListData,
                            "skuListData":skuListData
                        };
                        pageTwoData.standard1List= "["+ preStr +"]";
                        pageTwoData.standard2List = "[]";
                    }
                    editTwo();
                }
                
                speName[0] = $(".fpi-singleLayer-name>p").text();
            };

            var dirId = '';
            /*
            if ( s.getMainInfoData.dirId == '' || s.getMainInfoData.dirId == undefined ) {
                dirId = pageOneBol.hisDirid != ""?pageOneBol.hisDirid:$("li[lastChoose='true']").attr("dirid")
            }else{
                dirId = s.getMainInfoData.dirId;
            }*/
            if ( s.getMainInfoData.classify == undefined || s.getMainInfoData.classify == '' ) {
                dirId = pageOneBol.hisDirid != ""?pageOneBol.hisDirid:$("li[lastChoose='true']").attr("dirid")
            }else{
                dirId = s.getMainInfoData.classify;
            }
            var dataJson = {
                "spuName": $("input[name=spuName]").val(),
                "advertorial": $("textarea[name=fpiadvertorial]").val() ,
                "detailDesc": $("#description").val(),
                "tmpId": $("li[feeid='true']").attr("id"),
                "weight": $(".fpi-weight div").find("input").val(),
                "volume": $(".fpi-volume div").find("input").val(),
                "filmPhotos": "[" +filmPhotosArr+ "]",
                "dirId": dirId,
                "standardType": fpiSpeActiveNum.toString(),
                "standardUpList": proJson.standardUpListData,
                "skuList": proJson.skuListData,
                "standardReList": "["+ pageTwoData.standardReListData +"]",
                "spuId": ajaxUrl.spuId
            };
            return dataJson;
        }
    };

    //tool
    var tool = {
        limitNum: function(num,tar,dotBol){
            var inputVal =  $(tar).val();
            if ( dotBol ) {
                var dotNum = inputVal.replace(/[^\d\.]/g,"");
                if ( dotNum.indexOf(".")>-1 && dotNum.split(".")[1].length > 3 ) {
                    dotNum = dotNum.substring(0,dotNum.length-1);
                }
                $(tar).val( dotNum );
            }else{
                $(tar).val( inputVal.replace(/\D/g,"") );
            }
            if ( inputVal*1 > num*1 ) {
                $(tar).val( inputVal.substring(0,inputVal.length-1) );
                $(tar).parent("div").siblings(".fpi-errorTip").css("display","inline-block");
                setTimeout(function(){
                    $(tar).parent("div").siblings(".fpi-errorTip").hide();
                },3000);
            }
        },
        limitNumTwo:function(num,tar){
            var inputVal =  $(tar).val(),dotNum = inputVal.replace(/[^\d\.]/g,"");
            if ( dotNum.match( /\./g ) ) {
                if ( dotNum.match( /\./g ).length > 1 ) {
                    dotNum = dotNum.substring(0,dotNum.length-1);
                }
           }
            if ( dotNum.indexOf(".")>-1 && dotNum.split(".")[1].length > 2 ) {
                dotNum = dotNum.substring(0,dotNum.length-1);
            }
            $(tar).val( dotNum );
            if ( inputVal*1 > num*1 ) {
                $(tar).val( inputVal.substring(0,inputVal.length-1) );
                $(tar).parent("div").siblings(".fpi-errorTip").css("display","inline-block");
                setTimeout(function(){
                    $(tar).parent("div").siblings(".fpi-errorTip").hide();
                },3000);
            }
        },
        limitSpe:function( tar ){
            var reg = /[\~|\`|\!|\@|\#|\$|\%|\^|\&|\*|\-|\_|\+|\=|\||\\|\[|\]|\{|\}|\;|\:|\"|\'|\,|\<|\.|\>|\/|\?]/g,
                str = tar.val();
            tar.val( str.replace( /\s{2}/g," " ) );
            if ( reg.test( str ) ) {
                tar.val( str.substring(0,str.length-1) );
            }
        },
        limitSpeLess:function( tar ){
            var reg = /[^a-zA-Z0-9()\-.*/+ \u4E00-\u9FA5]/g,
                str = tar.val();
            tar.val( str.replace( /\s{2}/g," " ) );
            if ( reg.test( str ) ) {
                tar.val( str.replace( reg,"" ) );
                tool.errortip("不可以出现除()-.*/+及空格以外的特殊字符！");
            }
        },
        dropDownList: function( obj,fn ){
            $('.'+ obj).on("click",'.'+ obj +'-btn',function(e){
                e.stopPropagation();
                $('.'+ obj +'-main').find("ul").slideToggle(300);
                fn();
            });
            $(document).on("click",function(){
                $('.'+ obj +'-main').find("ul").slideUp();
            });
            $('.'+obj+'-main > ul').on("click","li",function(){
                $('.'+obj+'-btn p').text( $(this).text() );
            });
        },
        errortip: function(message) {
            var tip = "<div id='error_tip' class='error-tip'></div>";
            if (!$("#error_tip")[0]) {
                $("body").append(tip);
            }
            var h = $("#error_tip").width();
            $("#error_tip").css("margin-left", -h / 2).html(message).show();
            setTimeout(function() {
                $("#error_tip").hide().html("");
            }, 3000);
        }
    }

    pageOne.pageOneInit();
    pageTwo.pageTwoInit();
    
    /*获取商品信息*/
    function getProductInformation() {
    	var param = {
    			"goodsId": getQueryStringByName("goods_id")
    	};
    	var url = ajaxUrl.head + ajaxUrl.getMainInfo;
//    	alert(url);
        $.post(url,param,function(data){
    	if(data.rspCode=="000000"){
    		var d = data.objs;
            s.getMainInfoData = d;
            var typeId = d["typeId"];
            //数据生成
            $("input[name='spuName']").val(d["goodsNm"]);
            $("#fpiadvertorial").val(d["special"] ? d["special"] : "");
            if ( d["content"] ) {
              /*  if ( d["detailDesc"].indexOf("http://www.hbaicai.com/merchant/html") > -1 ) {
                    $("#description").siblings('span').find("iframe").attr("src",d["detailDesc"])
                }else{
                    $("#description").val( d["detailDesc"] )
                }*/
            	$("#description").val( d["content"] )
            };
            
           if ( d.classify ) {
        	   var param = {
        			   'classify':d.classify,
                       'clevel':'4'
               };
        	   //  alert(JSON.stringify(param));
        	   var url= ajaxUrl.head + ajaxUrl.editGetClass;
        	 	$.post(url,param,function(data){
        	 	//alert(JSON.stringify(data));
        	 	//alert(data.objs[5]);
        	 	if(data.rspCode=="000000"){
        	 		var d = data.objs;
                    $(".fpi-nav").empty();
                    $(".fpi-nav").text( d[5] );
                    $(".fpi-edit").hide();
                    $.cookie("pageOption","pageTwo");
        	 	}
        	 	else
        	 	{
        	 		tool.errortip("请求错误!");
        	 	}	
        	 	},"json");

                $.cookie("pageOption","pageTwo");
            }else{
                $(".fpi-edit").attr("editBol","true");
                $(".fpi-edit").trigger("click");
                $.cookie("pageOption","pageOne");
            }

            if ( $.cookie("pageOption") == "pageTwo" ) {
                $(".goodsRelease-main").hide();
                $(".fillProInfo-main").show();
            }else{
                $(".fillProInfo-main").hide();
                $(".goodsRelease-main").show();
            };
            
            editGoodsPic(); //获取商品图片
            editGetSpe(typeId);   //获取商品规格
    	}else{
    		tool.errortip("获取商品信息错误！");
    	}
        },"json");

    };

    if (getQueryStringByName("goods_id") == "") {
        pageTwoData.editOrSub = 1;
        //推荐生成
       // form.tip.recommendTip();
        //运费模板
        fee.getList();
        $.cookie("pageOption","pageOne");
    } else {
        pageTwoData.editOrSub = 2;
        fee.getList();
        getProductInformation();
    }

    if ( $.cookie("pageOption") == "pageTwo" ) {
        $(".goodsRelease-main").hide();
        $(".fillProInfo-main").show();

    }else{
        $(".fillProInfo-main").hide();
        $(".goodsRelease-main").show();
    };
    
});