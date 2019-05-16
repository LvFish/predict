package com.newclass.controller;

import com.newclass.bean.AttentionEntity;
import com.newclass.bean.PorkEntity;
import com.newclass.dao.AttentionDao;
import com.newclass.dao.PorkDao;
import net.sf.json.JSONObject;
import org.apache.commons.collections.map.HashedMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by liujiawang on 2019/5/15.
 */
@Controller
@RequestMapping("")
public class AttentionController {
    @Autowired
    @Qualifier("attentionDao")
    private AttentionDao attentionDao;
    @Autowired
    @Qualifier("porkDao")
    private PorkDao porkDao;

    @RequestMapping(value = "/getMyAttention", method = RequestMethod.POST)
    public void getMyAttention(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws IOException {
        String userId = session.getAttribute("userId").toString();
        String province = request.getParameter("province");
        String place = request.getParameter("place");
        String type = request.getParameter("type");
        List<Object[]> attention = attentionDao.getMyAttention(userId,province,place,type);
        List<Map> list = new ArrayList<>();
        for(int i=0;i<attention.size();i++){
            Map<String,Object> map = new HashedMap();
            Object[] o = attention.get(i);
            map.put("id",o[0]);
            map.put("province",o[1]);
            map.put("place",o[2]);
            map.put("name",o[3]);
            map.put("type",o[4]);
            map.put("price",o[5]);
            list.add(map);
        }
        JSONObject json = new JSONObject();
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("msg", list);
        json = JSONObject.fromObject(map);
        response.setContentType("application/json;charset=utf-8");
        response.setHeader("Access-Control-Allow-Origin", "*");
        String js = json.toString();
        response.getWriter().write(js.toString());
    }

    @RequestMapping(value="/editPrice",method = RequestMethod.POST)
    public void editPrice(HttpServletRequest request,HttpServletResponse response){
        String attentionId = request.getParameter("attentionId");
        String price = request.getParameter("price");
        attentionDao.editPrice(attentionId,price);
    }

    @RequestMapping(value="/deleteAttention",method = RequestMethod.POST)
    public void deleteAttention(HttpServletRequest request,HttpServletResponse response){
        String attentionId = request.getParameter("attentionId");
        attentionDao.deleteAttention(attentionId);
    }

    @RequestMapping(value="/addAttention",method = RequestMethod.POST)
    public void addAttention(HttpServletRequest request,HttpServletResponse response,HttpSession session) throws IOException {
        String province = request.getParameter("province");
        String place = request.getParameter("place");
        String type = request.getParameter("type");
        PorkEntity pork = porkDao.getAllEntities(province,place,type).get(0);
        JSONObject json = new JSONObject();
        try{
            List<AttentionEntity> t = attentionDao.getByPorkId(String.valueOf(pork.getId()),session.getAttribute("userId").toString());
            if(t.size()==0){
                AttentionEntity attention = new AttentionEntity();
                attention.setUserId(Integer.valueOf(session.getAttribute("userId").toString()));
                attention.setPorkId(pork.getId());
                attention.setPrice(new BigDecimal(request.getParameter("price")));
                System.out.println("info: "+attention.getUserId()+" "+pork.getId());
                attentionDao.save(attention);
                json.put("status",true);
            }else{
                json.put("status",false);
            }
        }catch(Exception e){
            e.printStackTrace();
            json.put("status",false);
        }
        response.setContentType("application/json;charset=utf-8");
        response.setHeader("Access-Control-Allow-Origin", "*");
        String js = json.toString();
        response.getWriter().write(js.toString());
    }


}

