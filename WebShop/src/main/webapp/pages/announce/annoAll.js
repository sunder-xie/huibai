var basepath=null; /*根目录*/

var startpagenum =1;
var offset =20;

//页面加载时触发
$(function(){
	 setAllDomain();
	 getNoticeLists(startpagenum,offset);
});
 
var setAllDomain = function(){
	basepath=getRootPath();	
}

//默认加载  
function getNoticeLists(pagenumber,offsize){  
	
	    var map={
			keyword:''
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
				datatable ="<ul style=min-height: 677px;>";
			    var num= data.result.length < data.offset ? data.result.length :data.offset;
			    var noteDt ,noteType ;
				for (var i=0;i<num;i++)
				{
					noteDt = formatStringyyyyMMddToyyyy_MM_ddhh_mm_ss(data.result[i].instDt);
					noteType = data.result[i].noteType;
					datatable+= '<li class="list-item" style="display: list-item; opacity: 1;">'; 
					datatable+= "  <a class=\"list-item-color\" href=\"annoDetail.jsp?noteId=" ;
					datatable+= data.result[i].noteId;
					datatable+= "\">";
					if( noteType=='01')/*公告*/
					{
						datatable+='【公告】';
					}else if(noteType=='02')
					{
						datatable+='【促销】';
					}else
				    {
						datatable+='【公告】';
				    }
					datatable+= data.result[i].title;
					datatable+="</a> <span >" ;
					datatable+= noteDt ;
					datatable+="</span></li>";
			    }
				
				datatable+= "</ul>";
			
				datatable+="<div class=\"data-paginator clearfix\">";
				datatable+='<div id="J_bottomPage"></div>';
				datatable+=	"</div>";
				
				$("#anno-data-table").empty();
				$("#J_bottomPage").empty();
				//$("#anno-data-table").append(datatable);
				$("#anno-data-table").html(datatable);	
				
				$("#J_bottomPage").pager({ pagenumber: pagenumber, pagecount:data.pageCount,totalcount:data.total, buttonClickCallback: PageClick});  
			}else{
				
			}
		},"json");
    
}  
  
//回调函数  
PageClick = function(pageclickednumber) {  
	getNoticeLists(pageclickednumber,offset);  
}  