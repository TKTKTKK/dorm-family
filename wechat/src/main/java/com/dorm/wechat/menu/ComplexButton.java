package com.dorm.wechat.menu;

/**
 * Created by wensheng on 14-11-16.
 */
public class ComplexButton extends Button{
    private Button[] sub_button;

    public Button[] getSub_button() {
        return sub_button;
    }

    public void setSub_button(Button[] sub_button) {
        this.sub_button = sub_button;
    }
}
