package com.newclass.bean;

import javax.persistence.*;
import java.math.BigDecimal;

/**
 * Created by liujiawang on 2019/5/15.
 */
@Entity
@Table(name = "attention", schema = "predict", catalog = "")
public class AttentionEntity {
    private int attentionId;
    private Integer userId;
    private Integer porkId;
    private BigDecimal price;

    @Id
    @Column(name = "attention_id", nullable = false)
    public int getAttentionId() {
        return attentionId;
    }

    public void setAttentionId(int attentionId) {
        this.attentionId = attentionId;
    }

    @Basic
    @Column(name = "user_id", nullable = true)
    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    @Basic
    @Column(name = "pork_id", nullable = true)
    public Integer getPorkId() {
        return porkId;
    }

    public void setPorkId(Integer porkId) {
        this.porkId = porkId;
    }

    @Basic
    @Column(name = "price", nullable = true, precision = 2)
    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        AttentionEntity that = (AttentionEntity) o;

        if (attentionId != that.attentionId) return false;
        if (userId != null ? !userId.equals(that.userId) : that.userId != null) return false;
        if (porkId != null ? !porkId.equals(that.porkId) : that.porkId != null) return false;
        if (price != null ? !price.equals(that.price) : that.price != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = attentionId;
        result = 31 * result + (userId != null ? userId.hashCode() : 0);
        result = 31 * result + (porkId != null ? porkId.hashCode() : 0);
        result = 31 * result + (price != null ? price.hashCode() : 0);
        return result;
    }
}
