package com.newclass.dao;

import com.newclass.bean.PorkEntity;
import org.hibernate.Query;
import org.springframework.stereotype.Repository;

import java.util.List;


@Repository("porkDao")
public class PorkDao extends BaseDao {
    public PorkEntity getById(int id) {
        return get(PorkEntity.class, id);

    }


    public long findCount() {
        String hqlString = "select count(*) from PorkEntity as p";
        Query query = this.getSession().createQuery(hqlString);
        return (long) query.uniqueResult();
    }

    public List<PorkEntity> getAllEntities(String province,String place,String type){
        String hql = "from PorkEntity as p where p.province like ? and p.place like ? and p.type like ?";
        Query query = query(hql);
        query.setString(0,"%"+province+"%");
        query.setString(1,"%"+place+"%");
        query.setString(2,"%"+type+"%");
        return query.list();
    }

    public List<String> getProvince(){
        String hqlString = "select distinct province from PorkEntity as p";
        Query query = this.getSession().createQuery(hqlString);
        return query.list();
    }

    public List<String> getType(){
        String hqlString = "select distinct type from PorkEntity as p";
        Query query = this.getSession().createQuery(hqlString);
        return query.list();
    }

    public List<String> getPlace(String province){
        String hqlString = "select distinct place from PorkEntity as p where p.province = '"+province+"'";
        Query query = this.getSession().createQuery(hqlString);
        return query.list();
    }


    public List<Object[]> getPriceTrendByMonth(String province, String type,String year){
        String hql = "select round(avg(p.price),2) as avg,DATE_FORMAT(date_sub('2019-05-14',interval " +
                "(cast(timestampdiff(day,p.time,'2019-05-14')/3 as SIGNED INTEGER)*3) day),'%m-%d') as day " +
                "from predict.pork as p where p.type like '%"+type+"%' " +
                "and p.province like '%"+province+"%' " +
                "and DATE_FORMAT(time,'%y') = '"+year+"' " +
                "group by DATE_FORMAT(date_sub('2019-05-14',interval (cast(timestampdiff(day,p.time,'2019-05-14')/3 as SIGNED INTEGER)*3) day),'%m-%d')" +
                " order by day desc limit 10;";
        Query query  = getSession().createSQLQuery(hql);
        return query.list();
    }

    public List<Object[]> getPriceTrendByYear(String province, String type,String year){
        String hql = "select round(avg(p.price),2), DATE_FORMAT(p.time,'%m') as day from predict.pork as p " +
                "where p.type like '%"+type+"%' " +
                "and p.province like '%"+province+"%' " +
                "and DATE_FORMAT(p.time,'%y') = '"+year+"' " +
                "group by DATE_FORMAT(p.time,'%m')  " +
                "order by day desc";
        Query query  = getSession().createSQLQuery(hql);
        return query.list();
    }

    public List<Object[]> getPriceTrendByWeek(String province,String type,String year){
        String hql = "SELECT round(avg(p.price),2) AS avg,DATE_FORMAT(date_sub('2019-05-14'," +
                "INTERVAL (timestampdiff(DAY,p.time,'2019-05-14')) DAY),'%m-%d')" +
                " AS DAY FROM predict.pork AS p WHERE p.type LIKE '%"+type+"%' AND p.province LIKE '%"+province+"%' " +
                "AND DATE_FORMAT(time,'%y')='"+year+"' GROUP BY DATE_FORMAT(date_sub('2019-05-14',INTERVAL " +
                "(timestampdiff(DAY,p.time,'2019-05-14')) DAY),'%m-%d') ORDER BY DAY DESC LIMIT 7;";
        Query query  = getSession().createSQLQuery(hql);
        return query.list();
    }


}