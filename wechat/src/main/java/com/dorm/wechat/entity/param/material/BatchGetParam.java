package com.dorm.wechat.entity.param.material;

/**
 * Created by wensheng on 2015/12/28.
 */
public class BatchGetParam {

    private String type;
    private int offset;
    private int count;

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public int getOffset() {
        return offset;
    }

    public void setOffset(int offset) {
        this.offset = offset;
    }

    public int getCount() {
        return count;
    }

    public void setCount(int count) {
        this.count = count;
    }
}
