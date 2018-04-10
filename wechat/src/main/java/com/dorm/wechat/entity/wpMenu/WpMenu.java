package com.dorm.wechat.entity.wpMenu;

import com.dorm.common.base.BaseEntity;

import javax.persistence.Column;
import javax.persistence.Table;
import java.util.List;

/**
 * Created by admin on 16-1-14.
 */
@Table(name = "tb_wp_menu")
public class WpMenu  extends BaseEntity {
    @Column
    private String bindid;
    @Column
    private String parentid;
    @Column
    private String name;
    @Column
    private String type;
    @Column
    private String link;
    @Column
    private Integer orderno;
    @Column
    private String menusname;
    @Column
    private String menustype;
    @Column
    private String groupid;

    private List<WpMenu> wpChildMenuList;

    public String getBindid() { return bindid;}

    public void setBindid(String bindid) { this.bindid = bindid;}

    public String getParentid() {  return parentid; }

    public void setParentid(String parentid) { this.parentid = parentid;}

    public String getName() { return name;}

    public void setName(String name) { this.name = name;}

    public String getType() { return type;}

    public void setType(String type) { this.type = type;}

    public String getLink() { return link;}

    public void setLink(String link) { this.link = link;}

    public Integer getOrderno() { return orderno;}

    public void setOrderno(Integer orderno) {  this.orderno = orderno;}

    public List<WpMenu> getWpChildMenuList() { return wpChildMenuList;}

    public void setWpChildMenuList(List<WpMenu> wpChildMenuList) {  this.wpChildMenuList = wpChildMenuList;}

    public String getMenusname() { return menusname;}

    public void setMenusname(String menusname) { this.menusname = menusname;}

    public String getMenustype() { return menustype;}

    public void setMenustype(String menustype) { this.menustype = menustype;}

    public String getGroupid() { return groupid;}

    public void setGroupid(String groupid) { this.groupid = groupid;}
}
