package com.dorm.family.service;

import com.dorm.common.exception.ServiceException;
import com.dorm.common.utils.DateUtils;
import com.dorm.common.utils.UserUtils;
import com.dorm.family.entity.Machine;
import com.dorm.family.entity.MtxProduct;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.slf4j.Logger;
import com.dorm.common.utils.StringUtils;
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
public class PartsImportService extends ExcelDataImportService{
    private static Logger logger = LoggerFactory.getLogger(PartsImportService.class);

    @Autowired
    private MachineService machineService;
    @Autowired
    private MtxProductService mtxProductService;
    /**
     *
     * @param is
     */
    public Map importPartsData(InputStream is, Map<String, Object> resultMap) throws ServiceException {
        //文件为空错误信息
        String fileEmptyMsg = "";
        //适用机型错误信息
        String modelErrorMsg = "";
        //物料编码错误信息
        String machinenoErrorMsg = "";
        //配件名称错误信息
        String nameErrorMsg = "";
        //价格错误信息
        String priceErrorMsg = "";
        //规格错误信息
        String formatErrorMsg = "";
        //说明书版本错误信息
        String instructionErrorMsg = "";
        //备注错误信息
        String remarksErrorMsg = "";
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
                //得到总列数
                int colNum = row.getPhysicalNumberOfCells();
                List<Machine> machineList = new ArrayList<Machine>();

                String bindid = UserUtils.getUserBindId();


                String loginUserId = UserUtils.getUserId();
                String dt = DateUtils.formatSystemDateTimeMillis();

                for (int i = 1; i <= rowNum; i++) {
                    Machine machine = new Machine();
                    machine.setUuid(StringUtils.getUUID());
                    machine.setBindid(bindid);
                    machine.setType("PARTS");
                    machine.setCreateby(loginUserId);
                    machine.setModifyby(loginUserId);
                    machine.setCreateon(dt);
                    machine.setModifyon(dt);
                    machine.setVersionno(1);
                    machine.setDelind("N");

                    MtxProduct product=new MtxProduct();

                    row = sheet.getRow(i);
                    if(row==null){
                        uniqueErrorMsg += "文件中第"+(i+1)+"行不能为空！ ";
                    }else{
                        int j = 0;
                        while (j < colNum) {
                            String str = getCellFormatValue(row.getCell((short) j)).trim();
                            switch (j) {
                                case 0: {
                                    if(StringUtils.isNotBlank(str)){
                                        machine.setMachinemodel(str);
                                        product.setModel(str);
                                    }else{
                                        modelErrorMsg+= "第" + (i + 1) + "适用机型不能为空!";
                                    }
                                    break;
                                }
                                case 1: {
                                    if(StringUtils.isNotBlank(str)){
                                        machine.setMachineno(str);
                                    }else{
                                        machinenoErrorMsg+= "第" + (i + 1) + "物料编码不能为空!";
                                    }
                                    break;
                                }
                                case 2: {
                                    if(StringUtils.isNotBlank(str)){
                                        machine.setMachinename(str);
                                    }else{
                                        nameErrorMsg+= "第" + (i + 1) + "配件名称不能为空!";
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
                                            priceErrorMsg += "第" + (i + 1) + "行价格输入非法; ";
                                        } else {
                                            DecimalFormat df = new DecimalFormat("#.00");
                                            Double collectremitarea = Double.parseDouble(str);
                                            String collectremitStr = df.format(collectremitarea);
                                            //长度不能超过10
                                            if (collectremitStr.length() > 10) {
                                                priceErrorMsg += "第" + (i + 1) + "行价格输入非法（最大长度不能超过10）; ";
                                            } else {
                                                machine.setPrice(Double.parseDouble(collectremitStr));
                                            }
                                        }
                                    }else{
                                        priceErrorMsg+= "第" + (i + 1) + "价格不能为空!";
                                    }
                                    break;

                                }
                                case 4: {
                                    if(StringUtils.isNotBlank(str)){
                                        machine.setFormat(str);
                                    }else{
                                        formatErrorMsg+= "第" + (i + 1) + "规格不能为空!";
                                    }
                                    break;
                                }
                                case 5: {
                                    if(StringUtils.isNotBlank(str)){
                                        machine.setInstruction(str);
                                    }else{
                                        instructionErrorMsg+= "第" + (i + 1) + "说明书版本不能为空!";
                                    }
                                    break;
                                }
                                case 6: {
                                    if (StringUtils.isNotBlank(str)) {
                                        machine.setRemarks(str);
                                    }
                                    break;
                                }
                            }
                            j++;
                        }

                        //适用机型不合法
                        if (StringUtils.isNotBlank(machine.getMachinemodel())&&machine.getMachinemodel().length() > 32) {
                            modelErrorMsg += "第" + (i + 1) + "行适用机型输入不合法（最大长度不能超过32）; ";
                        }
                        //物料编码不合法
                        if (StringUtils.isNotBlank(machine.getMachineno())&&machine.getMachineno().length() > 32) {
                            machinenoErrorMsg += "第" + (i + 1) + "行适物料编码输入不合法（最大长度不能超过32）; ";
                        }
                        //配件名称不合法
                        if (StringUtils.isNotBlank(machine.getMachinename())&&machine.getMachinename().length() > 32) {
                            nameErrorMsg += "第" + (i + 1) + "行配件名称输入不合法（最大长度不能超过32）; ";
                        }
                        //规格不合法
                        if (StringUtils.isNotBlank(machine.getFormat())&&machine.getFormat().length() >10) {
                            formatErrorMsg += "第" + (i + 1) + "行规格输入不合法（最大长度不能超过10）; ";
                        }
                        //说明书版本不合法
                        if (StringUtils.isNotBlank(machine.getInstruction())&&machine.getInstruction().length() > 64) {
                            instructionErrorMsg += "第" + (i + 1) + "行说明书版本输入不合法（最大长度不能超过64）; ";
                        }
                        //备注不合法
                        if (StringUtils.isNotBlank(machine.getRemarks())&&machine.getRemarks().length() > 256) {
                            remarksErrorMsg += "第" + (i + 1) + "行备注输入不合法（最大长度不能超过256）; ";
                        }
                        List<MtxProduct> productList=new ArrayList<MtxProduct>();
                        productList=mtxProductService.queryForList(product);
                        if(productList.size()>0){
                            machineList.add(machine);
                        }else{
                            uniqueErrorMsg+= "第" + (i + 1) + "行适应机型不存在;";
                        }
                    }
                }

                //文件不为空、项目id合法、楼栋号合法、单元号合法、房间号合法、客户名称合法、证件号码合法、手机号码合法、
                //房屋面积合法、户型合法
                if(StringUtils.isBlank(fileEmptyMsg)&&StringUtils.isBlank(modelErrorMsg)
                        && StringUtils.isBlank(machinenoErrorMsg) && StringUtils.isBlank(nameErrorMsg)
                        && StringUtils.isBlank(priceErrorMsg) && StringUtils.isBlank(formatErrorMsg)
                        && StringUtils.isBlank(instructionErrorMsg) && StringUtils.isBlank(remarksErrorMsg)
                        && StringUtils.isBlank(priceErrorMsg) && StringUtils.isBlank(uniqueErrorMsg)){
                    try{
                        System.out.println("***********start batch insert***********");
                        if(machineList.size() > 0){
                            machineService.deleteAll();
                            machineService.batchInsert(machineList);
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
                    if(modelErrorMsg.length() > 0){
                        resultMap.put("modelErrorMsg", modelErrorMsg);
                    }
                    if(machinenoErrorMsg.length() > 0){
                        resultMap.put("machinenoErrorMsg", machinenoErrorMsg);
                    }
                    if(nameErrorMsg.length() > 0){
                        resultMap.put("nameErrorMsg", nameErrorMsg);
                    }
                    if(formatErrorMsg.length() > 0){
                        resultMap.put("formatErrorMsg", formatErrorMsg);
                    }
                    if(instructionErrorMsg.length() > 0){
                        resultMap.put("instructionErrorMsg", instructionErrorMsg);
                    }
                    if(remarksErrorMsg.length() > 0){
                        resultMap.put("remarksErrorMsg", remarksErrorMsg);
                    }
                    if(uniqueErrorMsg.length() > 0){
                        resultMap.put("uniqueErrorMsg", uniqueErrorMsg);
                    }
                    if(priceErrorMsg.length() > 0){
                        resultMap.put("priceErrorMsg", priceErrorMsg);
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
