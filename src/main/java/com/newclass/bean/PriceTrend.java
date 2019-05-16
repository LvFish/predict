package com.newclass.bean;

import java.io.Serializable;
import java.math.BigDecimal;

/**
 * Created by liujiawang on 2019/5/14.
 */

public class PriceTrend implements Serializable {
    private static final long serialVersionUID = 1L;

    private BigDecimal price;
    private String day;

    public PriceTrend(BigDecimal price,String day){
        super();
        this.price = price;
        this.day = day;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public String getDay() {
        return day;
    }

    public void setDay(String day) {
        this.day = day;
    }
}
