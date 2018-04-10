package com.dorm.wechat.entity.result.material;

import java.util.List;

/**
 * Created by wensheng on 2015/12/28.
 */
public class MaterialNewsResult {

    private String total_count;
    private String item_count;
    private List<MediaNews> item;

    public String getTotal_count() {
        return total_count;
    }

    public void setTotal_count(String total_count) {
        this.total_count = total_count;
    }

    public String getItem_count() {
        return item_count;
    }

    public void setItem_count(String item_count) {
        this.item_count = item_count;
    }

    public List<MediaNews> getItem() {
        return item;
    }

    public void setItem(List<MediaNews> item) {
        this.item = item;
    }
}
