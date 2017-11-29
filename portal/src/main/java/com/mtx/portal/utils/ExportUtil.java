package com.mtx.portal.utils;

import com.mtx.common.utils.StringUtils;
import net.sf.jxls.transformer.XLSTransformer;
import org.apache.poi.hssf.usermodel.HSSFBorderFormatting;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFClientAnchor;
import org.apache.poi.hssf.usermodel.HSSFDataFormat;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Drawing;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.util.CellRangeAddress;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletResponse;
import java.awt.image.BufferedImage;
import java.io.*;
import java.net.URL;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by wensheng on 15-4-29.
 */
public class ExportUtil {

    private static Logger logger = LoggerFactory.getLogger(ExportUtil.class);

    /**
     *
     * @param beanParams
     * @param excelTemplateName
     * @param response
     */
    public static void exportExcel(Map<String,List> beanParams,String excelTemplateName,HttpServletResponse response){

        InputStream is = ExportUtil.class.getResourceAsStream(excelTemplateName);
        XLSTransformer former = new XLSTransformer();
        try {
//            XSSFWorkbook workbook = (XSSFWorkbook)former.transformXLS(is, beanParams);
            Workbook workbook = former.transformXLS(is, beanParams);
            response.setContentType("application/vnd.ms-excel;charset=utf-8");
            OutputStream os;
            os = response.getOutputStream();
            workbook.write(os);
            os.flush();
            os.close();
        } catch (InvalidFormatException e) {
            logger.error(e.getMessage(),e);
        } catch (IOException e) {
            logger.error(e.getMessage());
        }
    }

    /**
     *
     * @param beanParams
     * @param url
     * @param response
     */
    public static void exportExcel(Map<String,List> beanParams, URL url, HttpServletResponse response){
        try {
            InputStream is = url.openStream();
            XLSTransformer former = new XLSTransformer();

            Workbook workbook = former.transformXLS(is, beanParams);
            response.setContentType("application/vnd.ms-excel;charset=utf-8");
            OutputStream os;
            os = response.getOutputStream();
            workbook.write(os);
            os.flush();
            os.close();
        } catch (InvalidFormatException e) {
            logger.error(e.getMessage(),e);
        } catch (IOException e) {
            logger.error(e.getMessage());
        }
    }

    /**
     *导出excel（多种参数）
     * @param beanParams
     * @param excelTemplateName
     * @param response
     */
    public static void exportExcelForMultiple(Map<String,Object> beanParams,String excelTemplateName,HttpServletResponse response){

        InputStream is = ExportUtil.class.getResourceAsStream(excelTemplateName);
        XLSTransformer former = new XLSTransformer();
        try {
//            XSSFWorkbook workbook = (XSSFWorkbook)former.transformXLS(is, beanParams);
            Workbook workbook = former.transformXLS(is, beanParams);
            response.setContentType("application/vnd.ms-excel;charset=utf-8");
            OutputStream os;
            os = response.getOutputStream();
            workbook.write(os);
            os.flush();
            os.close();
        } catch (InvalidFormatException e) {
            logger.error(e.getMessage());
        } catch (IOException e) {
            logger.error(e.getMessage());
        }
    }

    /**
     * @param beanParams
     * @param url
     * @param response
     */
    public static void exportExcelForMultiple(Map<String, Object> beanParams, URL url, HttpServletResponse response) {

        try {
            InputStream is = url.openStream();
            XLSTransformer former = new XLSTransformer();
            Workbook workbook = former.transformXLS(is, beanParams);
            response.setContentType("application/vnd.ms-excel;charset=utf-8");
            OutputStream os;
            os = response.getOutputStream();
            workbook.write(os);
            os.flush();
            os.close();
        } catch (IOException e) {
            logger.error(e.getMessage(),e);
        } catch (InvalidFormatException e) {
            logger.error(e.getMessage(),e);
        }

    }

    /**
     * @param beanParamsList
     * @param sheetNames
     * @param beanName
     * @param excelTemplateName
     * @param imageUrl
     * @param dx1               the x coordinate within the first cell.
     * @param dy1               the y coordinate within the first cell.
     * @param dx2               the x coordinate within the second cell.
     * @param dy2               the y coordinate within the second cell.
     * @param col1              the column (0 based) of the first cell.
     * @param row1              the row (0 based) of the first cell.
     * @param col2              the column (0 based) of the second cell.
     * @param row2              the row (0 based) of the second cell.
     * @param response
     */
    public static void exportExcelForMultipleSheetsList(List beanParamsList, List sheetNames, String beanName, String excelTemplateName, String imageUrl,
                                                        int dx1, int dy1, int dx2, int dy2, short col1, int row1, short col2, int row2,
                                                        HttpServletResponse response) {

        InputStream is = ExportUtil.class.getResourceAsStream(excelTemplateName);
        XLSTransformer former = new XLSTransformer();
        try {

            Workbook workbook = former.transformMultipleSheetsList(is, beanParamsList, sheetNames, beanName, new HashMap(), 0);

            if(StringUtils.isNotEmpty(imageUrl)) {
                for (Object sheetName : sheetNames) {
                    Sheet sheet = workbook.getSheet(sheetName.toString());
                    Drawing drawing = sheet.createDrawingPatriarch();

                    ByteArrayOutputStream bos = new ByteArrayOutputStream();
                    BufferedImage BufferImg = ImageIO.read(new File(imageUrl));
                    ImageIO.write(BufferImg, "PNG", bos);

                    HSSFClientAnchor anchor = new HSSFClientAnchor(dx1, dy1, dx2, dy2, col1, row1, col2, row2); //设置图片显示区域
                    drawing.createPicture(anchor, workbook.addPicture(bos.toByteArray(), workbook.PICTURE_TYPE_PNG));
                }
            }

            response.setContentType("application/vnd.ms-excel;charset=utf-8");
            OutputStream os;
            os = response.getOutputStream();
            workbook.write(os);
            os.flush();
            os.close();
        } catch (InvalidFormatException e) {
            logger.error(e.getMessage());
        } catch (IOException e) {
            logger.error(e.getMessage());
        }
    }

    /**
     * 导出excel（合并单元格）
     * @param beanParams
     * @param excelTemplateName
     * @param response
     */
    public static void exportExcelForFeeMerge(Map<String,Object> beanParams,String excelTemplateName,
                                              HttpServletResponse response){

        InputStream is = ExportUtil.class.getResourceAsStream(excelTemplateName);
        XLSTransformer former = new XLSTransformer();
        try {
            Workbook workbook = former.transformXLS(is, beanParams);
            int startDateRowIndex = Integer.parseInt(String.valueOf(beanParams.get("startDateRowIndex")));
            int startRow = startDateRowIndex;
            Sheet sheet = workbook.getSheetAt(0);
            int allDataRows = Integer.parseInt(String.valueOf(beanParams.get("allDataRows")));
            int columnIndex = Integer.parseInt(String.valueOf(beanParams.get("columnIndex")));
            for(int i=startDateRowIndex+1; i<startDateRowIndex+allDataRows; i++){
                if(!sheet.getRow(startRow).getCell(columnIndex).toString()
                        .equals(sheet.getRow(i).getCell(columnIndex).toString())){
                    if(i-startRow > 1){
                        //需要合并
                        sheet.addMergedRegion(new CellRangeAddress(startRow,i-1,columnIndex,columnIndex));
                    }
                    //更新开始行
                    startRow = i;
                }
            }

            List<Integer> moneyColumnIndex = (List<Integer>) beanParams.get("moneyColumnIndex");
            //设置最后一行的颜色
            for(int i=0; i<sheet.getRow(startDateRowIndex+allDataRows-1).getLastCellNum(); i++){
                CellStyle cellStyle =workbook.createCellStyle();
                cellStyle.setFillForegroundColor(HSSFColor.LIGHT_GREEN.index);
                cellStyle.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
                cellStyle.setBottomBorderColor(HSSFColor.BLACK.index);
                cellStyle.setBorderBottom(HSSFBorderFormatting.BORDER_THIN);
                cellStyle.setRightBorderColor(HSSFColor.BLACK.index);
                cellStyle.setBorderRight(HSSFBorderFormatting.BORDER_THIN);
                cellStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);
                if(null != moneyColumnIndex && moneyColumnIndex.contains(i)){
                    cellStyle.setDataFormat(HSSFDataFormat.getBuiltinFormat("0.00"));
                    sheet.getRow(startDateRowIndex+allDataRows-1).getCell(i).setCellStyle(cellStyle);
                }else{
                    sheet.getRow(startDateRowIndex+allDataRows-1).getCell(i).setCellStyle(cellStyle);
                }
            }

            response.setContentType("application/vnd.ms-excel;charset=utf-8");
            OutputStream os;
            os = response.getOutputStream();
            workbook.write(os);
            os.flush();
            os.close();
        } catch (InvalidFormatException e) {
            logger.error(e.getMessage());
        } catch (IOException e) {
            logger.error(e.getMessage());
        } catch (Exception e) {
            logger.error(e.getMessage());
        }
    }
}
