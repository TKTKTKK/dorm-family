package com.mtx.wechat.entity.result.material;

import java.util.List;

/**
 * Created by wensheng on 2015/12/28.
 */
public class MaterialOtherResult {

    private String total_count;
    private String item_count;
    private List<MediaOther> item;

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

    public List<MediaOther> getItem() {
        return item;
    }

    public void setItem(List<MediaOther> item) {
        this.item = item;
    }
}
