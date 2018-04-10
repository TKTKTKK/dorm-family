package com.dorm.common.utils;

import org.apache.commons.lang3.time.DateFormatUtils;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;

/**
 * 日期工具类, 继承org.apache.commons.lang.time.DateUtils类
 */
public class DateUtils extends org.apache.commons.lang3.time.DateUtils {
	
	private static String[] parsePatterns = { "yyyy-MM-dd", "yyyy-MM-dd HH:mm:ss", "yyyy-MM-dd HH:mm", 
		"yyyy/MM/dd", "yyyy/MM/dd HH:mm:ss", "yyyy/MM/dd HH:mm" , "yyyy-MM-dd HH:mm:ss SSS" };

	/**
	 * 得到当前日期字符串 格式（yyyy-MM-dd）
	 */
	public static String getDate() {
		return getDate("yyyy-MM-dd");
	}
	
	/**
	 * 得到当前日期字符串 格式（yyyy-MM-dd） pattern可以为："yyyy-MM-dd" "HH:mm:ss" "E"
	 */
	public static String getDate(String pattern) {
		return DateFormatUtils.format(new Date(), pattern);
	}
	
	/**
	 * 得到日期字符串 默认格式（yyyy-MM-dd） pattern可以为："yyyy-MM-dd" "HH:mm:ss" "E"
	 */
	public static String formatDate(Date date, Object... pattern) {
		String formatDate = null;
		if (pattern != null && pattern.length > 0) {
			formatDate = DateFormatUtils.format(date, pattern[0].toString());
		} else {
			formatDate = DateFormatUtils.format(date, "yyyy-MM-dd");
		}
		return formatDate;
	}


    /**
     * 得到系统日期时间字符串，转换格式（yyyy-MM-dd HH:mm:ss）
     */
    public static String formatSystemDateTime() {
        return formatDateTime(new Date(System.currentTimeMillis()));
    }

    /**
     * 得到系统日期时间字符串，转换格式（yyyy-MM-dd HH:mm:ss SSS）
     */
    public static String formatSystemDateTimeMillis() {
        return formatDate(new Date(System.currentTimeMillis()),"yyyy-MM-dd HH:mm:ss SSS");
    }
	
	/**
	 * 得到日期时间字符串，转换格式（yyyy-MM-dd HH:mm:ss）
	 */
	public static String formatDateTime(Date date) {
		return formatDate(date, "yyyy-MM-dd HH:mm:ss");
	}

	/**
	 * 得到当前时间字符串 格式（HH:mm:ss）
	 */
	public static String getTime() {
		return formatDate(new Date(), "HH:mm:ss");
	}

	/**
	 * 得到当前日期和时间字符串 格式（yyyy-MM-dd HH:mm:ss）
	 */
	public static String getDateTime() {
		return formatDate(new Date(), "yyyy-MM-dd HH:mm:ss");
	}

	/**
	 * 得到当前年份字符串 格式（yyyy）
	 */
	public static String getYear() {
		return formatDate(new Date(), "yyyy");
	}

	/**
	 * 得到当前月份字符串 格式（MM）
	 */
	public static String getMonth() {
		return formatDate(new Date(), "MM");
	}

	/**
	 * 得到当天字符串 格式（dd）
	 */
	public static String getDay() {
		return formatDate(new Date(), "dd");
	}

	/**
	 * 得到当前星期字符串 格式（E）星期几
	 */
	public static String getWeek() {
		return formatDate(new Date(), "E");
	}
	
	/**
	 * 日期型字符串转化为日期 格式
	 * { "yyyy-MM-dd", "yyyy-MM-dd HH:mm:ss", "yyyy-MM-dd HH:mm", 
	 *   "yyyy/MM/dd", "yyyy/MM/dd HH:mm:ss", "yyyy/MM/dd HH:mm" }
	 */
	public static Date parseDate(Object str) {
		if (str == null){
			return null;
		}
		try {
			return parseDate(str.toString(), parsePatterns);
		} catch (ParseException e) {
			return null;
		}
	}

	/**
	 * 获取过去的天数
	 * @param date
	 * @return
	 */
	public static long pastDays(Date date) {
		long t = new Date().getTime()-date.getTime();
		return t/(24*60*60*1000);
	}
	
    
	public static Date getDateStart(Date date) {
		if(date==null) {
			return null;
		}
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		try {
			date= sdf.parse(formatDate(date, "yyyy-MM-dd")+" 00:00:00");
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return date;
	}
	
	public static Date getDateEnd(Date date) {
		if(date==null) {
			return null;
		}
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		try {
			date= sdf.parse(formatDate(date, "yyyy-MM-dd") +" 23:59:59");
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return date;
	}

    /**
     * 从1970 年 1 月 1 日 00：00：00 至今的秒数
     * @return
     */
    public static String getSeconds() {
        return Long.toString(System.currentTimeMillis() / 1000);
    }

	/**
	 * 比较月份差
	 * @param startDate
	 * @param endDate
	 * @param pattern
     * @return
     */
	public static int compareMonth(String startDate,String endDate,String pattern){

		try {
			Date d1 = DateUtils.parseDate(startDate,pattern);
			Date d2 = DateUtils.parseDate(endDate,pattern);

			Calendar c1 = Calendar.getInstance();
			c1.setTime(d1);
			Calendar c2 = Calendar.getInstance();
			c2.setTime(d2);

			int yearRange = c2.get(Calendar.YEAR) - c1.get(Calendar.YEAR);
			int monthRange = c2.get(Calendar.MONTH) - c1.get(Calendar.MONTH);
			return  (yearRange*12 + monthRange);

		} catch (ParseException e) {
			e.printStackTrace();
		}
		return -1;
	}

	/**
	 * 判断月份是否连续
	 * @param months
	 * @return
     */
	public static boolean isConsecutiveMonth(String[] months,String pattern){
		boolean result = true;
		Arrays.sort(months);
		for(int i = 0; i<months.length-1; i++){
			int range = compareMonth(months[i],months[i+1],pattern);
			if (range != 1){
				result = false;
				break;
			}
		}
		return result;
	}

	/**
	 * 判断月份是否连续(包含相同月)
	 * @param months
	 * @return
	 */
	public static boolean isConsecutiveSameMonth(String[] months,String pattern){
		boolean result = true;
		Arrays.sort(months);
		for(int i = 0; i<months.length-1; i++){
			int range = compareMonth(months[i],months[i+1],pattern);
			if (range > 1){
				result = false;
				break;
			}
		}
		return result;
	}

}
