package com.dorm.family.service;

import com.dorm.common.exception.ServiceException;
import com.dorm.common.utils.DateUtils;
import com.dorm.common.utils.StringUtils;
import com.dorm.common.utils.UserUtils;
import com.dorm.family.entity.Address;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.InputStream;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Created by hsy on 18-01-04.
 */
@Service
@Transactional
public class AddressImportService extends ExcelDataImportService{
    private static Logger logger = LoggerFactory.getLogger(AddressImportService.class);

    @Autowired
    private AddressService addressService;
    /**
     *
     * @param is
     */
    public Map importAddressData(InputStream is, Map<String, Object> resultMap) throws ServiceException {
        //文件为空错误信息
        String fileEmptyMsg = "";
        //分层错误信息
        String layerErrorMsg = "";
        //房间号错误信息
        String roomnoErrorMsg = "";
        //价格错误信息
        String areaErrorMsg = "";
        //唯一键错误信息
        String uniqueErrorMsg = "";


        try {
            POIFSFileSystem fs = new POIFSFileSystem(is);
            HSSFWorkbook wb = new HSSFWorkbook(fs);
            HSSFSheet sheet = wb.getSheetAt(0);
            // 得到总行数
            int rowNum = sheet.getLastRowNum();
            //文件为空
            if(rowNum <= 0){
                fileEmptyMsg = "抱歉，文件不能为空";
                resultMap.put("fileEmptyMsg", fileEmptyMsg);
            }else{
                HSSFRow row = sheet.getRow(0);
                String dormitoryId = String.valueOf(row.getCell(0));
                //得到总列数
                int colNum = row.getPhysicalNumberOfCells();
                List<Address> addressList = new ArrayList<Address>();

                String loginUserId = UserUtils.getUserId();
                String dt = DateUtils.formatSystemDateTimeMillis();

                for (int i = 1; i <= rowNum; i++) {
                    Address address = new Address();
                    address.setUuid(StringUtils.getUUID());
                    address.setDormitoryid(dormitoryId);
                    address.setCreateby(loginUserId);
                    address.setModifyby(loginUserId);
                    address.setCreateon(dt);
                    address.setModifyon(dt);
                    address.setVersionno(1);
                    address.setDelind("N");

                    row = sheet.getRow(i);
                    if(row==null){
                        uniqueErrorMsg += "文件中第"+(i+1)+"行不能为空！ ";
                    }else{
                        int j = 1;
                        while (j < colNum) {
                            String str = getCellFormatValue(row.getCell((short) j)).trim();
                            switch (j) {
                                case 1: {
                                    if(StringUtils.isNotBlank(str)){
                                        address.setLayer(str);
                                    }else{
                                        layerErrorMsg += "第" + (i + 1) + "单元或楼层不能为空!";
                                    }
                                    break;
                                }
                                case 2: {
                                    if(StringUtils.isNotBlank(str)){
                                        address.setRoomno(str);
                                    }else{
                                        roomnoErrorMsg += "第" + (i + 1) + "房间号不能为空!";
                                    }
                                    break;
                                }
                                case 3: {
                                    if(StringUtils.isNotBlank(str)){

                                        String collectremitpriceRegExp = "^\\d+(\\.\\d+)?$";
                                        Pattern pattern = Pattern.compile(collectremitpriceRegExp);
                                        Matcher matcher = pattern.matcher(str);
                                        //不合法
                                        if (!matcher.find()) {
                                            areaErrorMsg += "第" + (i + 1) + "行面积输入非法; ";
                                        } else {
                                            DecimalFormat df = new DecimalFormat("#.00");
                                            Double collectremitarea = Double.parseDouble(str);
                                            String collectremitStr = df.format(collectremitarea);
                                            //长度不能超过10
                                            if (collectremitStr.length() > 10) {
                                                areaErrorMsg += "第" + (i + 1) + "行价格输入非法（最大长度不能超过10）; ";
                                            } else {
                                                address.setArea(Double.parseDouble(collectremitStr));
                                            }
                                        }
                                    }else{
                                        address.setArea(0);
                                    }
                                    break;
                                }
                            }
                            j++;
                        }

                        //单元或楼层不合法
                        if (StringUtils.isNotBlank(address.getLayer()) && address.getLayer().length() > 10) {
                            layerErrorMsg += "第" + (i + 1) + "行单元或楼层输入不合法（最大长度不能超过10）; ";
                        }
                        //房间号不合法
                        if (StringUtils.isNotBlank(address.getRoomno()) && address.getRoomno().length() > 10) {
                            roomnoErrorMsg += "第" + (i + 1) + "行房间号输入不合法（最大长度不能超过10）; ";
                        }

                        List<Address> tempAddressList = addressService.getAddressBylayerAndRoomno(address);
                        if(null != tempAddressList && tempAddressList.size()>0){
                            uniqueErrorMsg+= "第" + (i + 1) + "行房间信息已存在;";
                        }else{
                            addressList.add(address);
                        }
                    }
                }


                if(StringUtils.isBlank(fileEmptyMsg)&&StringUtils.isBlank(layerErrorMsg)
                        && StringUtils.isBlank(roomnoErrorMsg) && StringUtils.isBlank(areaErrorMsg)){
                    try{
                        System.out.println("***********start batch insert***********");
                        if(addressList.size() > 0){
                            addressService.batchInsert(addressList);
                        }
                        System.out.println("***********batch insert complete***********");
                    }catch (DuplicateKeyException e){
                        logger.error(e.getMessage());
                        throw e;
                    }
                }else{
                    if(fileEmptyMsg.length() > 0){
                        resultMap.put("fileEmptyMsg", fileEmptyMsg);
                    }
                    if(layerErrorMsg.length() > 0){
                        resultMap.put("layerErrorMsg", layerErrorMsg);
                    }
                    if(roomnoErrorMsg.length() > 0){
                        resultMap.put("roomnoErrorMsg", roomnoErrorMsg);
                    }
                    if(areaErrorMsg.length() > 0){
                        resultMap.put("areaErrorMsg", areaErrorMsg);
                    }
                    if(uniqueErrorMsg.length() > 0){
                        resultMap.put("uniqueErrorMsg", uniqueErrorMsg);
                    }
                }
            }
        }catch (Exception e) {
            logger.error(e.getMessage());
            throw new ServiceException(e);
        }
        return resultMap;
    }

}
