package com.hlb.utils.date;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;

/**
 * 时间维护的一个工具包.其中格式说明
 * <ul>
 * 	<li>y - year</li>
 * 	<li>w - weeks of year</li>
 * 	<li>M - Month</li>
 * 	<li>W - weeks of Month</li>
 * 	<li>d - days of Month</li>
 * 	<li>D - days of Year</li>
 * 	<li>F - week of Month</li>
 * 	<li>E - 星期中的天数</li>
 * 	<li>H - 天中的小时数【0-23】</li>
 * 	<li>k - 天中的小时数【1-24】</li>
 * 	<li>kam - 天中的小时数,eg 22下午59</li>
 * 	<li>Kam - 天中的小时数</li>
 * 	<li>m - 小时中的分钟数</li>
 * 	<li>s - 一分钟的秒数</li>
 * 	<li>S - 一秒钟的毫秒数</li>
 * </ul>
 * */
public class DateUtil {
	/**定义格式 yyyyMMDD*/
	public final static String DATE_FORMAT_8 ="yyyyMMdd" ;
	/**定义格式yyyyMMDDHHmmss*/
	public final static String DATE_FORMAT_14 ="yyyyMMddHHmmss" ;
	
	/**定义格式yyyy-MM-DD HH:mm:ss*/
	public final static String DATE_FORMAT_14_H ="yyyy-MM-dd HH:mm:ss" ;
	
	/**
	 * 获取指定格式的当前日的时间字符串，也可以获取周、一年中的某一天等等信息
	 * */
	public static String getCurrentDate(String pattern){
		return getDateToString(new Date(), pattern);
	}
	
	/**
	 * 获取给定日期、给定格式的字符串
	 * */
	public static String getDateToString(Date date,String pattern){
		SimpleDateFormat dateFormat = new SimpleDateFormat(pattern);
		return dateFormat.format(date);
	}
	
	/**
	 * 将指定格式的字符串转化为date
	 * @throws ParseException 
	 * */
	public static Date getDateFromString(String source,String pattern) throws ParseException{
		SimpleDateFormat dateFormat = new SimpleDateFormat(pattern);
		return dateFormat.parse(source);
	}
	
	/**
	 * 判断某个字符串是否可以转化为指定格式的日期
	 * */
	public static boolean isDateFromString(String source,String pattern){
		try {
			getDateFromString(source,pattern);
			return true;
		} catch (ParseException e) {
			return false;
		}
	}
	
	/**
	 * 判断日期大小
	 * @param date1
	 * @param date2
	 * @return int,当date1大于date2返回 1等于返回0,其他返回-1
	 * */
	public static int compareDate(Date date1,Date date2){
		long d1=date1.getTime();
		long d2=date2.getTime();
		if(d1>d2){
			return 1;
		}else if(d1==d2){
			return 0;
		}else{
			return -1;
		}
	}
	
	/**
	 * 获得指定日期的偏移日期（yyyyMMdd）
	 * @param refDate 参照日期
	 * @param offSize 偏移日期(天数)
	 * @return
	 */
	public static String getOffSizeDate(String refDate,String offSize) {
		Calendar calendar = GregorianCalendar.getInstance();
		calendar.set(Integer.parseInt(refDate.substring(0, 4)), 
							  Integer.parseInt(refDate.substring(4, 6)) - 1, 
							  Integer.parseInt(refDate.substring(6, 8)));
		calendar.add(Calendar.DATE, Integer.parseInt(offSize));
		String year = String.valueOf(calendar.get(Calendar.YEAR));
		String month = String.valueOf(calendar.get(Calendar.MONTH) + 1);
		String retDate = String.valueOf(calendar.get(Calendar.DATE));
		if(Integer.parseInt(month) < 10) {
			month = "0" + month;
		}
		if(Integer.parseInt(retDate) < 10) {
			retDate = "0" + retDate;
		}
		return year + month + retDate;
	}
	
	/**
	 * 获得指定日期的偏移日期（yyyyMMddhhmmss）
	 * @param refDate 参照日期
	 * @param offSize 偏移日期(天数)
	 * @return
	 */
	public static String getOffSizeDateTime(String refDate,String offSize) {
		Calendar calendar = GregorianCalendar.getInstance();
		calendar.set(Integer.parseInt(refDate.substring(0, 4)), 
							  Integer.parseInt(refDate.substring(4, 6)) - 1, 
							  Integer.parseInt(refDate.substring(6, 8)));
		calendar.add(Calendar.DATE, Integer.parseInt(offSize));
		String year = String.valueOf(calendar.get(Calendar.YEAR));
		String month = String.valueOf(calendar.get(Calendar.MONTH) + 1);
		String retDate = String.valueOf(calendar.get(Calendar.DATE));
		if(Integer.parseInt(month) < 10) {
			month = "0" + month;
		}
		if(Integer.parseInt(retDate) < 10) {
			retDate = "0" + retDate;
		}
		return year + month + retDate+refDate.substring(8, 14);
	}
	
	/**
	 * 转换（yyyyMMddhhmmss）为(yyyy-MM-dd HH:mm:ss)
	 * @return
	 */
	
	public static String changeTime(String sourDt)throws Exception{
		if(sourDt==null||sourDt==""){
		throw new Exception("The time must not be null or ''");
		}
		SimpleDateFormat oldFormat = new SimpleDateFormat("yyyyMMddHHmmss");
		SimpleDateFormat newFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date date = oldFormat.parse(sourDt);
		return newFormat.format(date);
		}
	
	/**
	 * 比较2个（yyyyMMddhhmmss）大小
	 * @return
	 */
	public static int compare_date(String DATE1, String DATE2) {
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
		try {
			DATE1=changeTime(DATE1);
			DATE2=changeTime(DATE2);
		Date dt1 = df.parse(DATE1);
		Date dt2 = df.parse(DATE2);
		if (dt1.getTime() > dt2.getTime()) {
		System.out.println("dt1 在dt2前");
		return 1;
		} else if (dt1.getTime() < dt2.getTime()) {
		System.out.println("dt1在dt2后");
		return -1;
		} else {
		return 0;
		}
		} catch (Exception exception) {
		exception.printStackTrace();
		}
		return 0;
		}
	
	
	/**
	 * 比较2个（yyyyMMddhhmmss）大小
	 * @return
	 */
	public static long get_second_space(String DATE1, String DATE2) {
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
		long interval =0L;
		
		try {
			DATE1 = changeTime(DATE1);
			DATE2 = changeTime(DATE2);
			Date dt1 = df.parse(DATE1);
			Date dt2 = df.parse(DATE2);
			
			if (dt1.getTime() > dt2.getTime()) {
				
				interval = (dt1.getTime() - dt2.getTime())/1000;
			} else if (dt1.getTime() < dt2.getTime()) {
				
				interval = (dt2.getTime() - dt1.getTime())/1000;
			} else {
				interval =  0;
			}
		} catch (Exception exception) {
			exception.printStackTrace();
		}
		return interval;
	}
	
	/**
	 * 计算两个日期相差的月数
	 * @param date1 <String>
	 * @param date2 <String>
	 * @return int
	 * @throws ParseException
	 */
	public static int getMonthSpace(String date1, String date2) {
		int result = 0;
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		Calendar c1 = Calendar.getInstance();
		Calendar c2 = Calendar.getInstance();
		try {
			c1.setTime(sdf.parse(date1));
			c2.setTime(sdf.parse(date2));
			int mon = (c2.get(Calendar.YEAR)-c1.get(Calendar.YEAR))*12;
			result = mon + (c2.get(Calendar.MONTH) - c1.get(Calendar.MONTH));
			return result == 0 ? 1 : Math.abs(result);
		} catch (ParseException e) {
			return 0;	
		}
	}
	
	/**
	 * 获取当前日期的下一个季度
	 * @param date1 <String>
	 * @param date2 <String>
	 * @return int
	 * @throws ParseException
	 */
	public static String getNextQuarterOfYear(String date) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		Calendar calendar = Calendar.getInstance();
		try {
			calendar.setTime(sdf.parse(date));
			calendar.add(Calendar.MONTH, 3);
	        calendar.set(Calendar.DAY_OF_MONTH, 0);  
			return DateUtil.getDateToString(calendar.getTime(),DateUtil.DATE_FORMAT_8); 
		} catch (ParseException e) {
			return date;	
		}
	}

}
