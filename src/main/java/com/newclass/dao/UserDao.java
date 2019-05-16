package com.newclass.dao;

import com.newclass.bean.UserEntity;
import org.hibernate.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by liujiawang on 2019/1/28.
 */
@Repository("userDao")
public class UserDao extends BaseDao {
    public UserEntity getById(int id) {
        return get(UserEntity.class, id);

    }


    public List<UserEntity> getByUserName(String UserName){
        String hql = "from UserEntity as user where user.username=?";
        Query query = query(hql);
        query.setString(0,UserName);
        List<UserEntity> users = query.list();
        return users;
    }

    public void insertUser(String UserName,String password,String email){
        UserEntity user = new UserEntity();
        user.setUsername(UserName);
        user.setPassword(password);
        user.setEmail(email);
        save(user);
    }


    public List<UserEntity> getAllEntities(){
        String hql = "from UserEntity";
        Query query = query(hql);
        return query.list();
    }

    public void deleteUser(String userId){
        String hql = "delete UserEntity u where u.userId=:userId";
        Query query = getSession().createQuery(hql);
        query.setParameter("userId", new Integer(userId));
        query.executeUpdate();
    }

    public void disableUser(String userId){
        String hql = "update UserEntity u set u.isDisable=:isDisable where u.userId=:userId";
        Query query = getSession().createQuery(hql);
        query.setParameter("isDisable", new Integer(1));

        query.setParameter("userId", new Integer(userId));

        query.executeUpdate();
    }

    public void showedUser(String userId){
        String hql = "update UserEntity u set u.isDisable=:isDisable where u.userId=:userId";
        Query query = getSession().createQuery(hql);
        query.setParameter("isDisable", new Integer(0));

        query.setParameter("userId", new Integer(userId));

        query.executeUpdate();
    }

}