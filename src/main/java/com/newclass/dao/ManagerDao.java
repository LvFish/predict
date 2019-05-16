package com.newclass.dao;

import com.newclass.bean.ManagerEntity;
import org.hibernate.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by liujiawang on 2019/5/15.
 */
@Repository("managerDao")
public class ManagerDao extends BaseDao{
    public ManagerEntity getById(int id) {
        return get(ManagerEntity.class, id);
    }

    public List<ManagerEntity> getByManagerrName(String ManagerName){
        String hql = "from ManagerEntity as manager where manager.managerName=?";
        Query query = query(hql);
        query.setString(0,ManagerName);
        List<ManagerEntity> managers = query.list();
        return managers;
    }
}
