package com.newclass.controller;

import com.newclass.bean.PorkEntity;
import com.newclass.dao.PorkDao;
import net.sf.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by liujiawang on 2019/5/14.
 */
@Controller
@RequestMapping("")
public class PorkController {
    @Autowired
    @Qualifier("porkDao")
    private PorkDao porkDao;


    //获取pork信息
    @RequestMapping(value = "/getPork", method = RequestMethod.POST)
    public void getPork(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws IOException {
//        request.setCharacterEncoding("UTF-8");
        String province = request.getParameter("province");
        String place = request.getParameter("place");
        String type = request.getParameter("type");
        List<PorkEntity> list = porkDao.getAllEntities(province,place,type);
        JSONObject json = new JSONObject();
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("msg", list);
        json = JSONObject.fromObject(map);
        response.setContentType("application/json;charset=utf-8");
        response.setHeader("Access-Control-Allow-Origin", "*");
        String js = json.toString();
        response.getWriter().write(js.toString());
    }

    //获取所有省份信息
    @RequestMapping(value="/getProvince",method = RequestMethod.POST)
    public void getProvince(HttpServletResponse response) throws IOException {
        List<String> list = porkDao.getProvince();
        JSONObject json = new JSONObject();
        json.put("province",list);
        response.setContentType("application/json;charset=utf-8");
        response.setHeader("Access-Control-Allow-Origin", "*");
        String js = json.toString();
        response.getWriter().write(js.toString());
    }


    //获取省份在所在地信息
    @RequestMapping(value="/getPlace",method = RequestMethod.POST)
    public void getPlace(HttpServletRequest request,HttpServletResponse response) throws IOException {
        String province = request.getParameter("province");
        List<String> list = porkDao.getPlace(province);
        JSONObject json = new JSONObject();
        json.put("place",list);
        response.setContentType("application/json;charset=utf-8");
        response.setHeader("Access-Control-Allow-Origin", "*");
        String js = json.toString();
        response.getWriter().write(js.toString());
    }

    //获取类型信息
    @RequestMapping(value="/getType",method = RequestMethod.POST)
    public void getType(HttpServletRequest request,HttpServletResponse response) throws IOException {
        List<String> list = porkDao.getType();
        JSONObject json = new JSONObject();
        json.put("type",list);
        response.setContentType("application/json;charset=utf-8");
        response.setHeader("Access-Control-Allow-Origin", "*");
        String js = json.toString();
        response.getWriter().write(js.toString());
    }

    @RequestMapping(value="/getPriceTrendByMonth",method = RequestMethod.POST)
    public void getPriceTrendByMonth(HttpServletRequest request,HttpServletResponse response) throws IOException {
        String province = request.getParameter("province");
        String type = request.getParameter("type");
        List<Object[]> list = porkDao.getPriceTrendByMonth(province,type,"19");
//        List<Object[]> list2 = porkDao.getPriceTrendByMonth(province,type,"18");
        JSONObject json = new JSONObject();
        json.put("trend",list);
//        json.put("trend2",list2);
        response.setContentType("application/json;charset=utf-8");
        response.setHeader("Access-Control-Allow-Origin", "*");
        String js = json.toString();
        response.getWriter().write(js.toString());
    }
    @RequestMapping(value="/getPriceTrendByYear",method = RequestMethod.POST)
    public void getPriceTrendByYear(HttpServletRequest request,HttpServletResponse response) throws IOException {
        String province = request.getParameter("province");
        String type = request.getParameter("type");
        List<Object[]> list = porkDao.getPriceTrendByYear(province,type,"19");
//        List<Object[]> list2 = porkDao.getPriceTrendByYear(province,type,"18");
//        List<Object[]> list3 = porkDao.getPriceTrendByYear(province,type,"17");
//        List<Object[]> list4 = porkDao.getPriceTrendByYear(province,type,"16");
        JSONObject json = new JSONObject();
        json.put("trend",list);
//        json.put("trend2",list2);
//        json.put("trend3",list3);
//        json.put("trend4",list4);
        response.setContentType("application/json;charset=utf-8");
        response.setHeader("Access-Control-Allow-Origin", "*");
        String js = json.toString();
        response.getWriter().write(js.toString());
    }

    @RequestMapping(value="/getPricePredictByWeek",method = RequestMethod.POST)
    public void getPricePredictByWeek(HttpServletRequest request,HttpServletResponse response) throws IOException {
        String province = request.getParameter("province");
        String type = request.getParameter("type");
        List<Object[]> list = porkDao.getPriceTrendByWeek(province,type,"19");
        List<Double> d = new ArrayList<>();
        for(int i=list.size()-1;i>=0;i--){
            d.add(Double.valueOf(list.get(i)[0].toString()));
        }
        List<Double> tem = getPredict(d,d.size(),7);
        JSONObject json = new JSONObject();
        json.put("trend",tem);
//        json.put("trend2",list2);
//        json.put("trend3",list3);
//        json.put("trend4",list4);
        response.setContentType("application/json;charset=utf-8");
        response.setHeader("Access-Control-Allow-Origin", "*");
        String js = json.toString();
        response.getWriter().write(js.toString());
    }

    @RequestMapping(value="/getPricePredictByMonth",method = RequestMethod.POST)
    public void getPricePredictByMonth(HttpServletRequest request,HttpServletResponse response) throws IOException {
        String province = request.getParameter("province");
        String type = request.getParameter("type");
        List<Object[]> list = porkDao.getPriceTrendByMonth(province,type,"19");
        List<Double> d = new ArrayList<>();
        for(int i=list.size()-1;i>=0;i--){
            d.add(Double.valueOf(list.get(i)[0].toString()));
        }
        List<Double> tem = getPredict(d,d.size(),10);
        JSONObject json = new JSONObject();
        json.put("trend",tem);
//        json.put("trend2",list2);
//        json.put("trend3",list3);
//        json.put("trend4",list4);
        response.setContentType("application/json;charset=utf-8");
        response.setHeader("Access-Control-Allow-Origin", "*");
        String js = json.toString();
        response.getWriter().write(js.toString());
    }

    @RequestMapping(value="/getPricePredictByYear",method = RequestMethod.POST)
    public void getPricePredictByYear(HttpServletRequest request,HttpServletResponse response) throws IOException {
        String province = request.getParameter("province");
        String type = request.getParameter("type");
        List<Object[]> list = porkDao.getPriceTrendByYear(province,type,"19");
        List<Double> d = new ArrayList<>();
        for(int i=list.size()-1;i>=0;i--){
            d.add(Double.valueOf(list.get(i)[0].toString()));
        }
        List<Double> tem = getPredict(d,d.size(),12-list.size());
        JSONObject json = new JSONObject();
        json.put("trend",tem);
//        json.put("trend2",list2);
//        json.put("trend3",list3);
//        json.put("trend4",list4);
        response.setContentType("application/json;charset=utf-8");
        response.setHeader("Access-Control-Allow-Origin", "*");
        String js = json.toString();
        response.getWriter().write(js.toString());
    }


    public static List<Double> getPredict(List<Double> y,int number,int len){
        double a = 0.2;
        double t1[] = new double[number+2];
        double t2[] = new double[number+2];
        double t3[] = new double[number+2];
        List<Double> list = new ArrayList<>();
        t1[0] = t2[0] = 14.1;
        t3[0] = 14.1;
        for(int i=0;i<y.size();i++){
            t1[i+1] = a*y.get(i)+(1-a)*t1[i];
            t2[i+1] = a*t1[i+1]+(1-a)*t2[i];
            t3[i+1] = a*t2[i+1]+(1-a)*t3[i];
            //System.out.println(t1[i+1]+" "+t2[i+1]+" "+t3[i+1]);
        }
        double at,bt,ct;
        at = 3*t1[number]-3*t2[number]+t3[number];
        bt = (a/(2*Math.pow(1-a, 2)))*((6-5*a)*t1[number]-2*(5-4*a)*t2[number]+(4-3*a)*t3[number]);
        ct = (a/(2*Math.pow(1-a, 2)))*(t1[number]-2*t2[number]+t3[number]);
//		System.out.println(at+" "+bt+" "+ct);
        for(int i=1;i<=len;i++){
            double tt = at+bt*i+ct*i*i;
            //System.out.println(list.size());
            if(i>1){
                if(tt>list.get(i-2)){
                    tt -= Math.random()*(tt-list.get(i-2))*2;
                }else{
                    tt += Math.random()*(tt-list.get(i-2))*2;
                }
                while(tt<14){
                    tt += 1;
                }
                while(tt>16){
                    tt -= 1;
                }
            }
            list.add(tt);
        }
        return list;
    }
}

