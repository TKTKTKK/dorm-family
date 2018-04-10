package com.dorm.family.service;


import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFDateUtil;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import com.dorm.common.utils.StringUtils;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public abstract class ExcelDataImportService {

    private static Logger logger = LoggerFactory.getLogger(ExcelDataImportService.class);

    /**
     * 获取单元格数据内容为字符串类型的数据
     *
     * @param cell Excel单元格
     * @return String 单元格数据内容
     */
    public String getStringCellValue(HSSFCell cell) {
        String strCell = "";
        switch (cell.getCellType()) {
            case HSSFCell.CELL_TYPE_STRING:
                strCell = cell.getStringCellValue();
                break;
            case HSSFCell.CELL_TYPE_NUMERIC:
                strCell = String.valueOf(cell.getNumericCellValue());
                break;
            case HSSFCell.CELL_TYPE_BOOLEAN:
                strCell = String.valueOf(cell.getBooleanCellValue());
                break;
            case HSSFCell.CELL_TYPE_BLANK:
                strCell = "";
                break;
            default:
                strCell = "";
                break;
        }
        if (strCell.equals("") || strCell == null) {
            return "";
        }
        if (cell == null) {
            return "";
        }
        return strCell;
    }

    /**
     * 获取单元格数据内容为日期类型的数据
     *
     * @param cell Excel单元格
     * @return String 单元格数据内容
     */
    public String getDateCellValue(HSSFCell cell) {
        String result = "";
        try {
            int cellType = cell.getCellType();
            if (cellType == HSSFCell.CELL_TYPE_NUMERIC) {
                Date date = cell.getDateCellValue();
                result = (date.getYear() + 1900) + "-" + (date.getMonth() + 1)
                        + "-" + date.getDate();
            } else if (cellType == HSSFCell.CELL_TYPE_STRING) {
                String date = getStringCellValue(cell);
                result = date.replaceAll("[年月]", "-").replace("日", "").trim();
            } else if (cellType == HSSFCell.CELL_TYPE_BLANK) {
                result = "";
            }
        } catch (Exception e) {
            logger.error("日期格式不正确!");
        }
        return result;
    }

    /**
     * 根据HSSFCell类型设置数据
     *
     * @param cell
     * @return
     */
    public String getCellFormatValue(HSSFCell cell) {
        String cellvalue = "";
        if (cell != null) {
            // 判断当前Cell的Type
            switch (cell.getCellType()) {
                // 如果当前Cell的Type为NUMERIC
                case HSSFCell.CELL_TYPE_NUMERIC:
                case HSSFCell.CELL_TYPE_FORMULA: {
                    // 判断当前的cell是否为Date
                    if (HSSFDateUtil.isCellDateFormatted(cell)) {
                        // 如果是Date类型则，转化为Data格式

                        //方法1：这样子的data格式是带时分秒的：2011-10-12 0:00:00
                        //cellvalue = cell.getDateCellValue().toLocaleString();

                        //方法2：这样子的data格式是不带带时分秒的：2011-10-12
                        Date date = cell.getDateCellValue();
                        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                        cellvalue = sdf.format(date);

                    }
                    // 如果是纯数字
                    else {
                        // 取得当前Cell的数值
                        cellvalue = String.valueOf(cell.getNumericCellValue());
                    }
                    break;
                }
                // 如果当前Cell的Type为STRIN
                case HSSFCell.CELL_TYPE_STRING:
                    // 取得当前的Cell字符串
                    cellvalue = cell.getRichStringCellValue().getString();
                    break;
                // 默认的Cell值
                default:
                    cellvalue = " ";
            }
        } else {
            cellvalue = "";
        }
        return cellvalue;
    }


    /**
     * 去除单元格数字类型开头的所有0
     * @param row
     * @param colum
     * @return
     */
    public String formatNumericLeadingZero(HSSFRow row,int colum){
        DecimalFormat dfe = new DecimalFormat("0");
        String str = getCellFormatValue(row.getCell((short) colum)).trim();
        if(null != row.getCell((short)colum) && HSSFCell.CELL_TYPE_NUMERIC == row.getCell((short)colum).getCellType()){
            str = dfe.format(row.getCell((short)colum).getNumericCellValue());
            if(str.lastIndexOf(".0") > 0){
                str = str.substring(0,str.lastIndexOf(".0"));
            }
        }
        return str.replaceFirst("^0*", "");
    }


    /**
     * 验证手机号格式
     * @param contactNo
     * @return
     */
    public boolean validateCellPhoneFormat(String contactNo){
        String contactnoRegExp = "^[1]\\d{10}$";
        Pattern pattern = Pattern.compile(contactnoRegExp);
        Matcher matcher = pattern.matcher(contactNo);
        return matcher.find();
    }


    /**
     * 验证身份证格式
     * @param idNo
     * @return
     */
    public boolean validateIdNoFormat(String idNo){
        if(StringUtils.isNotBlank(idNo)){
            if(idNo.length() != 15 && idNo.length() != 18){
                return false;
            }
        }

        String idnoRegExp = "^\\d{18}|\\d{15}|(\\d{17}[a-zA-Z]{1})$";
        Pattern pattern = Pattern.compile(idnoRegExp);
        Matcher matcher = pattern.matcher(idNo);
        return matcher.find();
    }
}
