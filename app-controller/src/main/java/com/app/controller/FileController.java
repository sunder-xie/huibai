package com.app.controller;

import java.io.File;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.app.common.model.Message;
import com.app.common.model.xheditorMsg;
import com.hlb.utils.date.DateUtil;
import com.hlb.utils.security.UUID;
import com.app.service.ResourcesService;
import com.app.bean.TblResourcesInfo;
import com.app.common.utils.LTConstant;

@Controller
@RequestMapping("File")
public class FileController {
	
	private Logger log = LoggerFactory.getLogger(this.getClass());
	
	@Resource
	private ResourcesService resServiceImpl;
	
	private static final HashMap<String, String> TypeMap = new HashMap<String, String>();
    //设置文件允许上传的类型
    static {
        TypeMap.put("image", "gif,jpg,jpeg,png,bmp");
        TypeMap.put("flash", "swf,flv");
        TypeMap.put("media", "swf,flv,mp3,wav,wma,wmv,mid,avi,mpg,asf,rm,rmvb");
        TypeMap.put("file", "doc,docx,xls,xlsx,ppt,pptx,htm,html,txt,dwg,pdf");
    }
     
    // 设置文件上传大小
    public static long fileSize = 3 * 1024 * 1024;
	
    
    /**
     * 文件上传并入库
     *
     * @param file
     * @param request
     * @return message: 0 上传成功 1 上传失败 2 文件超过上传大小 3 文件格式错误 4 上传文件路径非法 5 上传目录没有写权限  6 没有文件上传
     *      
     *@RequestMapping(value = "FileUpload", method = RequestMethod.POST)
     */
    @RequestMapping("FileUpload")
    public @ResponseBody Message FileUpload(HttpServletRequest request,MultipartFile file) {
        Message msg = new Message();
        
        //String basePath = request.getSession().getServletContext().getRealPath("/");
        //String basePath = req.getScheme()+"://"+req.getServerName()+":"+req.getServerPort()+path; 
        String FILE_PATH =null;
        String FILE_URL =null;
        if(LTConstant.TestFlag.equals("1"))
        {
            FILE_PATH = LTConstant.TEST_FILES_PATH;
            FILE_URL = LTConstant.TEST_FILES_URL;
        }
        else{
        	FILE_PATH = LTConstant.FILES_PATH;
        	FILE_URL = LTConstant.FILES_URL;
        }
        
      //获取请求参数
        Map<String,String> params = LTConstant.getParameters(request);
        
        TblResourcesInfo resInfo = new TblResourcesInfo();
        resInfo.setKeyid(params.get("keyid"));
        resInfo.setType(params.get("type"));
        log.info("images path is :" + FILE_PATH +" images url is :" + FILE_URL);
        log.info("keyid is :" + resInfo.getKeyid() + " type is:"+resInfo.getType() );
        
        if (!file.isEmpty()) {
        	log.info("file name is :" + file.getOriginalFilename());
        	
        	log.info("file size is :" + file.getSize());
            //当文件超过设置的大小时，则不运行上传
            if (file.getSize() > fileSize) {
            	msg.setRspCode("000002").setRspMsg("文件超过上传大小!");
                return msg;
            }
            //获取文件名后缀
            String OriginalFilename = file.getOriginalFilename();
            String fileSuffix = OriginalFilename.substring(
                    OriginalFilename.lastIndexOf(".") + 1).toLowerCase();
             
            //String fileSuffix="jpeg";
             
            log.info("file fileSuffix is :" + fileSuffix);
            //判断该类型的文件是否在允许上传的文件类型内
            if (!Arrays.asList(TypeMap.get("image").split(",")).contains(
                    fileSuffix)) {
            	msg.setRspCode("000003").setRspMsg("文件格式错误!");
                return msg;
            }
            log.info("file fileSuffix is :" + ServletFileUpload.isMultipartContent(request));
            if (!ServletFileUpload.isMultipartContent(request)) {
                msg.setRspCode("000006").setRspMsg("没有文件上传!");
                return msg;
            }
            
            // 检查上传文件的目录
            File uploadDir = new File(FILE_PATH);
            if (!uploadDir.isDirectory()) {
                if (!uploadDir.mkdir()) {
                	log.info("上传文件路径非法");
                    msg.setRspCode("000004").setRspMsg("上传文件路径非法!");
                    return msg;
                }
            }
            // 是否有上传的权限
            if (!uploadDir.canWrite()) {
            	log.info("上传目录没有写权限");
                msg.setRspCode("000005").setRspMsg("上传目录没有写权限!"); 
                return msg;
            }
             
            //新文件名
            String newname = "";
//            if(null != filePre){
//                newname += filePre;//对应模块上传的文件名前缀
//            }
            
            UUID uuid =new UUID();
            String resid= uuid.getUUID();
            newname += resid + "." + fileSuffix;
            log.info("新文件名为:"+newname);
            try {
                 //创建文件
                File saveFile = new File(FILE_PATH, newname);
                //File saveFile = new File(FILE_PATH, OriginalFilename);
                //保存文件
                file.transferTo(saveFile);
                log.info("上传成功");
                //FileTranser.saveFielByFileName(file, uploadPath, newname);
                resInfo.setResid(resid);
                resInfo.setResnm(OriginalFilename);
                resInfo.setUrl(FILE_URL+"/"+newname);
                resInfo.setStatus("0");
                resInfo.setNewFileNm(newname);
                resInfo.setInstDt(DateUtil.getCurrentDate(DateUtil.DATE_FORMAT_14));
                return resServiceImpl.saveResources(resInfo);
            } catch (Exception e) {
                log.error(e.getMessage(), e);
                msg.setRspCode("000001").setRspMsg("文件失败!");
                return msg;
            }
        } else {
        	log.info("没有文件上传");
        	 msg.setRspCode("000006").setRspMsg("没有文件上传!");
             return msg;
        }
    }
    
    /**
     * 文件上传入库
     *
     * @param file
     * @param request
     * @return message: 0 上传成功 1 上传失败 2 文件超过上传大小 3 文件格式错误 4 上传文件路径非法 5 上传目录没有写权限  6 没有文件上传
     *      
     *@RequestMapping(value = "FileUpload", method = RequestMethod.POST)
     */
    @RequestMapping("ImagesUploadAndInData")
    public @ResponseBody Message ImagesUploadAndInData(HttpServletRequest request,MultipartFile file) {
        Message msg = new Message();
        
        String FILE_PATH =null;
        String FILE_URL =null;
        if(LTConstant.TestFlag.equals("1"))
        {
            FILE_PATH = LTConstant.TEST_IMAGES_PATH;
            FILE_URL = LTConstant.TEST_IMAGES_URL;
        }
        else{
        	FILE_PATH = LTConstant.IMAGES_PATH;
        	FILE_URL = LTConstant.IMAGES_URL;
        }
        
        log.info("images path is :" + FILE_PATH +" images url is :" + FILE_URL);
        
        //获取请求参数
        Map<String,String> params = LTConstant.getParameters(request);
        
        if (!file.isEmpty()) {
        	log.info("file name is :" + file.getOriginalFilename());
        	
        	log.info("file size is :" + file.getSize());
            //当文件超过设置的大小时，则不运行上传
            if (file.getSize() > fileSize) {
            	msg.setRspCode("000002").setRspMsg("文件超过上传大小!");
                return msg;
            }
            //获取文件名后缀
            String OriginalFilename = file.getOriginalFilename();
            String fileSuffix = OriginalFilename.substring(
                    OriginalFilename.lastIndexOf(".") + 1).toLowerCase();
             
            //String fileSuffix="jpeg";
             
            log.info("file fileSuffix is :" + fileSuffix);
            //判断该类型的文件是否在允许上传的文件类型内
            if (!Arrays.asList(TypeMap.get("image").split(",")).contains(
                    fileSuffix)) {
            	msg.setRspCode("000003").setRspMsg("文件格式错误!");
                return msg;
            }
            log.info("file fileSuffix is :" + ServletFileUpload.isMultipartContent(request));
            if (!ServletFileUpload.isMultipartContent(request)) {
                msg.setRspCode("000006").setRspMsg("没有文件上传!");
                return msg;
            }
            
            // 检查上传文件的目录
            File uploadDir = new File(FILE_PATH);
            if (!uploadDir.isDirectory()) {
                if (!uploadDir.mkdir()) {
                	log.info("上传文件路径非法");
                    msg.setRspCode("000004").setRspMsg("上传文件路径非法!");
                    return msg;
                }
            }
            // 是否有上传的权限
            if (!uploadDir.canWrite()) {
            	log.info("上传目录没有写权限");
                msg.setRspCode("000005").setRspMsg("上传目录没有写权限!"); 
                return msg;
            }
             
            //新文件名
            String newname = "";
//            if(null != filePre){
//                newname += filePre;//对应模块上传的文件名前缀
//            }
            
            UUID uuid =new UUID();
            String resid= uuid.getUUID();
            newname += resid + "." + fileSuffix;
            log.info("新文件名为:"+newname);
            try {
                 //创建文件
                File saveFile = new File(FILE_PATH, newname);
                //File saveFile = new File(FILE_PATH, OriginalFilename);
                //保存文件
                file.transferTo(saveFile);
                log.info("上传成功");
                //FileTranser.saveFielByFileName(file, uploadPath, newname);
                TblResourcesInfo resInfo = new TblResourcesInfo();
                resInfo.setKeyid(params.get("keyid"));
                resInfo.setType(params.get("type"));
                log.info("keyid is :" + resInfo.getKeyid() + " type is:"+resInfo.getType() );
                resInfo.setResid(resid);
                resInfo.setResnm(OriginalFilename);
                resInfo.setUrl(FILE_URL+"/"+newname);
                resInfo.setStatus("0");
                resInfo.setNewFileNm(newname);
                resInfo.setInstDt(DateUtil.getCurrentDate(DateUtil.DATE_FORMAT_14));
                return resServiceImpl.saveResources(resInfo);
            } catch (Exception e) {
                log.error(e.getMessage(), e);
                msg.setRspCode("000001").setRspMsg("文件失败!");
                return msg;
            }
        } else {
        	log.info("没有文件上传");
        	 msg.setRspCode("000006").setRspMsg("没有文件上传!");
             return msg;
        }
    }
    
    /**
     * 图片文件上传
     *
     * @param file
     * @param request
     * @return message: 0 上传成功 1 上传失败 2 文件超过上传大小 3 文件格式错误 4 上传文件路径非法 5 上传目录没有写权限  6 没有文件上传
     *      
     *@RequestMapping(value = "ImagesUpload", method = RequestMethod.POST)
     */
    @RequestMapping("ImagesUpload")
    public @ResponseBody Message ImagesUpload(HttpServletRequest request,MultipartFile file) {
        Message msg = new Message();
        
        String FILE_PATH =null;
        String FILE_URL =null;
        if(LTConstant.TestFlag.equals("1"))
        {
            FILE_PATH = LTConstant.TEST_IMAGES_PATH;
            FILE_URL = LTConstant.TEST_IMAGES_URL;
        }
        else{
        	FILE_PATH = LTConstant.IMAGES_PATH;
        	FILE_URL = LTConstant.IMAGES_URL;
        }
        
        log.info("images path is :" + FILE_PATH +" images url is :" + FILE_URL);
        
        //获取请求参数
        Map<String,String> params = LTConstant.getParameters(request);
        
        if (!file.isEmpty()) {
        	log.info("file name is :" + file.getOriginalFilename());
        	
        	log.info("file size is :" + file.getSize());
            //当文件超过设置的大小时，则不运行上传
            if (file.getSize() > fileSize) {
            	msg.setRspCode("000002").setRspMsg("文件超过上传大小!");
                return msg;
            }
            //获取文件名后缀
            String OriginalFilename = file.getOriginalFilename();
            String fileSuffix = OriginalFilename.substring(
                    OriginalFilename.lastIndexOf(".") + 1).toLowerCase();
             
            //String fileSuffix="jpeg";
             
            log.info("file fileSuffix is :" + fileSuffix);
            //判断该类型的文件是否在允许上传的文件类型内
            if (!Arrays.asList(TypeMap.get("image").split(",")).contains(
                    fileSuffix)) {
            	msg.setRspCode("000003").setRspMsg("文件格式错误!");
                return msg;
            }
            log.info("file fileSuffix is :" + ServletFileUpload.isMultipartContent(request));
            if (!ServletFileUpload.isMultipartContent(request)) {
                msg.setRspCode("000006").setRspMsg("没有文件上传!");
                return msg;
            }
            
            // 检查上传文件的目录
            File uploadDir = new File(FILE_PATH);
            if (!uploadDir.isDirectory()) {
                if (!uploadDir.mkdir()) {
                	log.info("上传文件路径非法");
                    msg.setRspCode("000004").setRspMsg("上传文件路径非法!");
                    return msg;
                }
            }
            // 是否有上传的权限
            if (!uploadDir.canWrite()) {
            	log.info("上传目录没有写权限");
                msg.setRspCode("000005").setRspMsg("上传目录没有写权限!"); 
                return msg;
            }
             
            //新文件名
            String newname = "";
//            if(null != filePre){
//                newname += filePre;//对应模块上传的文件名前缀
//            }
            
            UUID uuid =new UUID();
            String resid= uuid.getUUID();
            newname += resid + "." + fileSuffix;
            log.info("新文件名为:"+newname);
            try {
                 //创建文件
                File saveFile = new File(FILE_PATH, newname);
                //File saveFile = new File(FILE_PATH, OriginalFilename);
                //保存文件
                file.transferTo(saveFile);
                log.info("上传成功");
                TblResourcesInfo resInfo = new TblResourcesInfo();
//                resInfo.setKeyid(params.get("keyid"));
//                resInfo.setType(params.get("type"));
//                log.info("keyid is :" + resInfo.getKeyid() + " type is:"+resInfo.getType() );
                resInfo.setResid(resid);
                resInfo.setResnm(OriginalFilename);
                resInfo.setUrl(FILE_URL+"/"+newname);
                resInfo.setStatus("0");
                resInfo.setNewFileNm(newname);
                msg.setObjs(resInfo);
                msg.setRspCode("000000").setRspMsg("上传成功!");
                return msg;
            } catch (Exception e) {
                log.error(e.getMessage(), e);
                msg.setRspCode("000001").setRspMsg("文件失败!");
                return msg;
            }
        } else {
        	log.info("没有文件上传");
        	 msg.setRspCode("000006").setRspMsg("没有文件上传!");
             return msg;
        }
    }
    
    @RequestMapping("ProImgUpload")
    public @ResponseBody xheditorMsg ProImgUpload(HttpServletRequest request,MultipartFile filedata,TblResourcesInfo resInfo) {
    	xheditorMsg msg = new xheditorMsg();
        
        String FILE_PATH =null;
        String FILE_URL =null;
        if(LTConstant.TestFlag.equals("1"))
        {
            FILE_PATH = LTConstant.TEST_IMAGES_PATH;
            FILE_URL = LTConstant.TEST_IMAGES_URL;
        }
        else{
        	FILE_PATH = LTConstant.IMAGES_PATH;
        	FILE_URL = LTConstant.IMAGES_URL;
        }
        log.info("file path is :" + FILE_PATH);
        log.info("file path is :" + resInfo.getKeyid());
        if (!filedata.isEmpty()) {
        	log.info("file name is :" + filedata.getOriginalFilename());
        	
        	log.info("file size is :" + filedata.getSize());
            //当文件超过设置的大小时，则不运行上传
            if (filedata.getSize() > fileSize) {
            	msg.setErr("000002").setMsg("文件超过上传大小!");
                return msg;
            }
            //获取文件名后缀
            String OriginalFilename = filedata.getOriginalFilename();
            String fileSuffix = OriginalFilename.substring(
                    OriginalFilename.lastIndexOf(".") + 1).toLowerCase();
             
            //String fileSuffix="jpeg";
             
            log.info("file fileSuffix is :" + fileSuffix);
            //判断该类型的文件是否在允许上传的文件类型内
            if (!Arrays.asList(TypeMap.get("image").split(",")).contains(
                    fileSuffix)) {
            	msg.setErr("000003").setMsg("文件格式错误!");
                return msg;
            }
            log.info("file fileSuffix is :" + ServletFileUpload.isMultipartContent(request));
            if (!ServletFileUpload.isMultipartContent(request)) {
                msg.setErr("000006").setMsg("没有文件上传!");
                return msg;
            }
            
            // 检查上传文件的目录
            File uploadDir = new File(FILE_PATH);
            if (!uploadDir.isDirectory()) {
                if (!uploadDir.mkdir()) {
                	log.info("上传文件路径非法");
                    msg.setErr("000004").setMsg("上传文件路径非法!");
                    return msg;
                }
            }
            // 是否有上传的权限
            if (!uploadDir.canWrite()) {
            	log.info("上传目录没有写权限");
                msg.setErr("000005").setMsg("上传目录没有写权限!"); 
                return msg;
            }
             
            //新文件名
            String newname = "";
//            if(null != filePre){
//                newname += filePre;//对应模块上传的文件名前缀
//            }
            
            UUID uuid =new UUID();
            String resid= uuid.getUUID();
            String returnmsg ="";
            newname += resid + "." + fileSuffix;
            log.info("新文件名为:"+newname);
            try {
                 //创建文件
                File saveFile = new File(FILE_PATH, newname);
                //File saveFile = new File(FILE_PATH, OriginalFilename);
                //保存文件
                filedata.transferTo(saveFile);
                log.info("上传成功");
                resInfo.setResid(resid);
                resInfo.setResnm(OriginalFilename);
                resInfo.setUrl(FILE_URL+"/"+newname);
                resInfo.setStatus("0");
                resInfo.setNewFileNm(newname);
                returnmsg = FILE_URL+"/"+newname;
                msg.setErr("").setMsg(returnmsg);
                return msg;
            } catch (Exception e) {
                log.error(e.getMessage(), e);
                msg.setErr("000001").setMsg("文件失败!");
                return msg;
            }
        } else {
        	log.info("没有文件上传");
        	 msg.setErr("000006").setMsg("没有文件上传!");
             return msg;
        }
    }
   
}
