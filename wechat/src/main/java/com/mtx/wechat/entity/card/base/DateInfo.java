package com.mtx.wechat.entity.card.base;

/**
 * 使用日期，有效期的信息
 */
public class DateInfo {
    private Integer type;
    private String begin_timestamp;
    private String end_timestamp;
    private Integer fixed_term;
    private Integer fixed_begin_term;

    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
    }

    public String getBegin_timestamp() {
        return begin_timestamp;
    }

    public void setBegin_timestamp(String begin_timestamp) {
        this.begin_timestamp = begin_timestamp;
    }

    public String getEnd_timestamp() {
        return end_timestamp;
    }

    public void setEnd_timestamp(String end_timestamp) {
        this.end_timestamp = end_timestamp;
    }

    public Integer getFixed_term() {
        return fixed_term;
    }

    public void setFixed_term(Integer fixed_term) {
        this.fixed_term = fixed_term;
    }

    public Integer getFixed_begin_term() {
        return fixed_begin_term;
    }

    public void setFixed_begin_term(Integer fixed_begin_term) {
        this.fixed_begin_term = fixed_begin_term;
    }
}
