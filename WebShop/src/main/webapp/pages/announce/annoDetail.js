var basepath=null; /*根目录*/

//页面加载时触发
$(function(){
	 setAllDomain();
	 getNoticeDetail();
	 getNoticeAll(1,5);
});
 
var setAllDomain = function(){
	basepath=getRootPath();	
}

//页面加载时触发
function getNoticeDetail() {
	var anno_id ; //公告编号
	//alert(window.location.href);
	anno_id=getQueryStringByName("noteId");
	//alert(anno_id);
	var param = {
		"noteId":anno_id
	};
	var url = basepath +"Notice/GetNoticeDetail.action";
	$.post(url,param,function(data){
		if(data.rspCode=="000000"){
		//	alert(JSON.stringify(data));
			var noteDt = formatStringyyyyMMddToyyyy_MM_ddhh_mm_ss(data.objs.instDt);
			$("#annoDetail").append("<h2>"+data.objs.title+"</h2><h3>发布时间："+noteDt+
				"</h3><p>"+data.objs.content+"</p>");
		}else{
			showInfos(data.rspMsg);
		}
	},"json");	
}

//默认加载  
function getNoticeAll(pagenumber,offsize){  
	
	    var map={
			keyword:'无'
		};
		var param = {
			start:pagenumber,
			offset:offsize,			
			conditions:map
		};
		//向服务器发送请求，查询满足条件的记录  
		$.post(basepath+"Notice/GetNoticeAll.action",param,function(data){
			if(data.rspCode=="000000"){			
			//	alert(JSON.stringify(data));
				var datatable='';
				datatable ='<ul style="min-height: 124px;">';
			    var num= data.result.length < data.offset ? data.result.length :data.offset;
			   
				for (var i=0;i<num;i++)
				{
					datatable+= '<li class="list-item" style="display: list-item; opacity: 1;"> <a href="annoDetail.jsp?noteId=' ;
					datatable+= data.result[i].noteId;
					datatable+= '">';
					datatable+= data.result[i].title;
					datatable+="</a>" ;
					datatable+="</li>";
			    }
				
				datatable+= "</ul>";
				
				datatable+="<div class=\"data-paginator clearfix\">";
				datatable+='<div id="J_bottomPage"></div>';
				datatable+=	"</div>";
				
				$("#side-announceList").empty();
				$("#J_bottomPage").empty();
				//$("#anno-data-table").append(datatable);
				$("#side-announceList").html(datatable);	
				
				$("#J_bottomPage").pager({ pagenumber: pagenumber, pagecount:data.pageCount,totalcount:data.total, buttonClickCallback: PageClick});  
			}else{
				
			}
		},"json");    
} 
