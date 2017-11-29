package com.mtx.common.base;

import com.mtx.common.exception.EntityStructureException;
import com.mtx.common.utils.ReflectUtil;

import javax.persistence.*;
import java.io.Serializable;
import java.lang.reflect.Field;

public class BaseEntity implements Serializable {

    private static final long serialVersionUID = 4277687223460013700L;

    @Id
    private String uuid;

    @Column
    private String createby;
    @Column
    private String createon;
    @Column
    private String modifyby;
    @Column
    private String modifyon;

    @Column
    @Version
    private Integer versionno;

    @Column
    private String delind;

    @OrderBy
    private String orderby;

    private boolean needaudit = false;

    private String auditDetails;

    public static long getSerialVersionUID() {
        return serialVersionUID;
    }

    public String getUuid() {
        return uuid;
    }

    public void setUuid(String uuid) {
        this.uuid = uuid;
    }

    public String getCreateby() {
        return createby;
    }

    public void setCreateby(String createby) {
        this.createby = createby;
    }

    public String getCreateon() {
        return createon;
    }

    public void setCreateon(String createon) {
        this.createon = createon;
    }

    public String getModifyby() {
        return modifyby;
    }

    public void setModifyby(String modifyby) {
        this.modifyby = modifyby;
    }

    public String getModifyon() {
        return modifyon;
    }

    public void setModifyon(String modifyon) {
        this.modifyon = modifyon;
    }

    public Integer getVersionno() {
        return versionno;
    }

    public void setVersionno(Integer versionno) {
        this.versionno = versionno;
    }

    public String getDelind() {
        return delind;
    }

    public void setDelind(String delind) {
        this.delind = delind;
    }

    public String getOrderby() {
        return orderby;
    }

    public void setOrderby(String orderby) {
        this.orderby = orderby;
    }

    public boolean getNeedaudit() {
        return needaudit;
    }

    public String tableName(){
        Table table = this.getClass().getAnnotation(Table.class);
        if(table != null){
            return table.name();
        }
        throw new EntityStructureException("@Table is undefined");
    }

    public String id(){
        for(Field field : ReflectUtil.getDeclaredFields(this)){
            if(field.isAnnotationPresent(Id.class)){
                return field.getName();
            }
        }
        throw new EntityStructureException("@Id is undefined");
    }

    public String versionColumn(){
        for(Field field : ReflectUtil.getDeclaredFields(this)){
            if(field.isAnnotationPresent(Version.class)){
                return field.getName();
            }
        }
        throw new EntityStructureException("@Version is undefined");
    }

    public String getAuditDetails(){
        return auditDetails;
    }

    public void setAuditDetails(String auditDetails) {
        this.auditDetails = auditDetails;
    }
}