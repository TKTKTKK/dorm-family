package com.mtx.common.service;

import com.mtx.common.base.BaseService;
import com.mtx.common.entity.CommonCode;
import com.mtx.common.mapper.CommonCodeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by wensheng on 1/19/2015.
 */
@Service
@Transactional
public class CommonCodeService extends BaseService<CommonCodeMapper,CommonCode> {

    @Autowired
    public void setMapper(CommonCodeMapper mapper) {
        super.setMapper(mapper);
    }

    /**
     * 查询默认留言信息
     * @param messageType
     * @return
     */
    public String queryDefaultMessage(String messageType){
        String defaultMessage = "";
        CommonCode commonCode = new CommonCode();
        commonCode.setCodetype(messageType);
        List<CommonCode> commonCodeList =  mapper.select(commonCode);
        int size  = commonCodeList.size();
        //生成0 - size-1 的随机整数
        int randomNum = new java.util.Random().nextInt(size);
        defaultMessage = commonCodeList.get(randomNum).getCodevalue();
        return defaultMessage;
    }


    /**
     * 查询code描述
     * @param codetype
     * @param code
     * @return
     */
    public String queryCodeDesc(String codetype,String code){
        CommonCode commonCode = new CommonCode();
        commonCode.setCodetype(codetype);
        commonCode.setCode(code);
        commonCode = queryForObjectByUniqueKey(commonCode);

        String codeDesc = "";
        if(null != commonCode){
            codeDesc = commonCode.getCodevalue();
        }
        return codeDesc;
    }

    /**
     * 根据type查询code描述列表
     * @param codetype
     * @return
     */
    public List queryCodeList(String codetype){
        CommonCode commonCode = new CommonCode();
        commonCode.setCodetype(codetype);
        commonCode.setOrderby("orderno");
        List<CommonCode> commonCodeList = queryForList(commonCode);
        return commonCodeList;
    }
}
