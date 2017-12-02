package com.mtx.common.entity;

import com.mtx.common.base.BaseEntity;

import javax.persistence.Column;
import javax.persistence.Table;
import java.util.List;

/**
 * Created by wensheng on 12/10/2014.
 */
@Table(name="tb_platform_user")
public class PlatformUser extends BaseEntity {

    @Column
    private String bindid;
    @Column
    private String username;
    @Column
    private String password;
    @Column
    private String name;
    @Column
    private String cellphone;
    @Column
    private String email;
    @Column
    private String openid;
    @Column
    private String title;
    @Column
    private String status;
    //是否托管
    private String trusteeship;
    //用户角色
    private List<PlatformRole> platformRoleList;

    private String plainpassword;
    //角色
    private String[] roles;
    //所管merchant id
    private String merchantid;
    //所管小区名称
    private String merchantname;
    //用户分组ID
    private Integer groupId;

    //当前用户手上的任务数
    private Integer taskcount;


    public String getBindid() {
        return bindid;
    }

    public void setBindid(String bindid) {
        this.bindid = bindid;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getCellphone() {
        return cellphone;
    }

    public void setCellphone(String cellphone) {
        this.cellphone = cellphone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPlainpassword() {
        return plainpassword;
    }

    public void setPlainpassword(String plainpassword) {
        this.plainpassword = plainpassword;
    }

    public List<PlatformRole> getPlatformRoleList() {
        return platformRoleList;
    }

    public void setPlatformRoleList(List<PlatformRole> platformRoleList) {
        this.platformRoleList = platformRoleList;
    }

    public String getOpenid() {
        return openid;
    }

    public void setOpenid(String openid) {
        this.openid = openid;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String[] getRoles() {
        return roles;
    }

    public void setRoles(String[] roles) {
        this.roles = roles;
    }

    public String getMerchantid() {
        return merchantid;
    }

    public void setMerchantid(String merchantid) {
        this.merchantid = merchantid;
    }

    public String getMerchantname() {
        return merchantname;
    }

    public void setMerchantname(String merchantname) {
        this.merchantname = merchantname;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getTrusteeship() {
        return trusteeship;
    }

    public void setTrusteeship(String trusteeship) {
        this.trusteeship = trusteeship;
    }

    public Integer getGroupId() { return groupId;}

    public void setGroupId(Integer groupId) { this.groupId = groupId;}

    public Integer getTaskcount() {
        return taskcount;
    }

    public void setTaskcount(Integer taskcount) {
        this.taskcount = taskcount;
    }
}
