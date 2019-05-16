package com.newclass.dao;

import com.newclass.bean.AttentionEntity;
import org.hibernate.Query;
import org.springframework.stereotype.Repository;

import java.math.BigDecimal;
import java.util.List;


@Repository("attentionDao")
public class AttentionDao extends BaseDao {
    public AttentionEntity getById(int id) {
        return get(AttentionEntity.class, id);

    }

    public List<AttentionEntity> getByPorkId(String porkId,String userId){
        String hql = "from AttentionEntity as a where a.porkId = "+porkId+" and a.userId = "+userId;
        Query query = getSession().createQuery(hql);
        return query.list();
    }

    public List<Object[]> getMyAttention(String userId,String province,String place,String type){
        String hql = "select a.attention_id,p.province,p.place,p.name,p.type,a.price from predict.attention a,predict.pork p" +
                " where a.pork_id = p.id\n" +
                " and a.user_id = "+userId+
                " and p.province like '%"+province+"%'"+
                " and p.place like '%"+place+"%'"+
                " and p.type like '%"+type+"%'";
        Query query  = getSession().createSQLQuery(hql);
        return query.list();
    }

    public void editPrice(String attentionId,String price){
        String hql = "update AttentionEntity a set a.price=:price where a.attentionId=:attentionId";
        Query query = getSession().createQuery(hql);
        query.setParameter("price", new BigDecimal(price));

        query.setParameter("attentionId", new Integer(attentionId));

        query.executeUpdate();

    }

    public void deleteAttention(String attentionId){
        String hql = "delete AttentionEntity a where a.attentionId=:attentionId";
        Query query = getSession().createQuery(hql);
        query.setParameter("attentionId", new Integer(attentionId));
        query.executeUpdate();
    }

    public void deleteAttentionByUserId(String userId){
        String hql = "delete AttentionEntity a where a.userId=:userId";
        Query query = getSession().createQuery(hql);
        query.setParameter("userId", new Integer(userId));
        query.executeUpdate();
    }

    public List<AttentionEntity> getByPrice(String price,int id){
        String hql = "from AttentionEntity as a where a.price <= "+price+" and a.porkId = "+id;
        Query query = getSession().createQuery(hql);
        return query.list();
    }

}