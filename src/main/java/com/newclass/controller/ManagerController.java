package com.newclass.controller;

import com.newclass.bean.AttentionEntity;
import com.newclass.bean.ManagerEntity;
import com.newclass.bean.PorkEntity;
import com.newclass.bean.UserEntity;
import com.newclass.dao.AttentionDao;
import com.newclass.dao.ManagerDao;
import com.newclass.dao.PorkDao;
import com.newclass.dao.UserDao;
import com.newclass.util.MailUtil;
import net.sf.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

/**
 * Created by liujiawang on 2019/5/15.
 */
@Controller
@RequestMapping("")
public class ManagerController {
    @Autowired
    @Qualifier("managerDao")
    private ManagerDao managerDao;
    @Autowired
    @Qualifier("userDao")
    private UserDao userDao;
    @Autowired
    @Qualifier("porkDao")
    private PorkDao porkDao;
    @Autowired
    @Qualifier("attentionDao")
    private AttentionDao attentionDao;

    @RequestMapping(value = "/managerLogin", method = RequestMethod.GET)
    public String managerLogin(){
        return "managerLogin";
    }


    @RequestMapping(value = "/managerIndex", method = RequestMethod.GET)
    public String managerIndex(HttpSession session){
        try{
            Object user = session.getAttribute("managerId");
            if(user != null){
                return "managerIndex";
            }
        }catch(Exception e){
            return "redirect:/managerLogin";
        }
        return "redirect:/managerLogin";
    }

    @RequestMapping(value = "/managerImport", method = RequestMethod.GET)
    public String managerImport(HttpSession session){
        try{
            Object user = session.getAttribute("managerId");
            if(user != null){
                return "managerImport";
            }
        }catch(Exception e){
            return "redirect:/managerLogin";
        }
        return "redirect:/managerLogin";
    }

    @RequestMapping(value = "/managerLogin", method = RequestMethod.POST)
    public String managerLogin(HttpServletRequest request, HttpServletResponse response, HttpSession session){
        String managerName = request.getParameter("managerName");
        String password = request.getParameter("password");
        try {
            System.out.println(managerName+" "+password);
            List<ManagerEntity> managers = managerDao.getByManagerrName(managerName);
            ManagerEntity manager = managers.get(0);
            if (password.equals(manager.getPassword())) {
                session.setAttribute("managerId",manager.getManagerId());
                return "managerIndex";
            } else {
                session.setAttribute("managerMessage","密码错误");
                return "redirect:/managerLogin";
            }
        }catch (Exception e){
            session.setAttribute("managerMessage","该账号不存在");
            e.printStackTrace();
            return "redirect:/managerLogin";
        }
    }

    @RequestMapping(value="/getAllUser",method = RequestMethod.POST)
    public void getAllUser(HttpServletResponse response) throws IOException {
        List<UserEntity> list = userDao.getAllEntities();
        JSONObject json = new JSONObject();
        json.put("msg",list);
        response.setContentType("application/json;charset=utf-8");
        response.setHeader("Access-Control-Allow-Origin", "*");
        String js = json.toString();
        response.getWriter().write(js.toString());
    }

    @ResponseBody
    @RequestMapping(value="/showedUser",method = RequestMethod.POST)
    public void showedUser(HttpServletRequest request,HttpSession session){
        String userId = request.getParameter("userId");
        userDao.showedUser(userId);
    }

    @ResponseBody
    @RequestMapping(value="/disableUser",method = RequestMethod.POST)
    public void disableUser(HttpServletRequest request,HttpSession session){
        String userId = request.getParameter("userId");
        userDao.disableUser(userId);
    }

    @ResponseBody
    @RequestMapping(value="/deleteUser",method = RequestMethod.POST)
    public void deleteUser(HttpServletRequest request,HttpSession session){
        String userId = request.getParameter("userId");
        userDao.deleteUser(userId);
        attentionDao.deleteAttentionByUserId(userId);
    }

    @ResponseBody
    @RequestMapping(value="/editUser",method = RequestMethod.POST)
    public void editUser(HttpServletRequest request){
        String userId = request.getParameter("userId");
        String password = request.getParameter("password");
        UserEntity user = userDao.getById(Integer.valueOf(userId));
        user.setPassword(password);
        userDao.save(user);
    }

    @ResponseBody
    @RequestMapping(value="/addPork",method = RequestMethod.POST)
    public void addPork(HttpServletRequest request){
        String province = request.getParameter("province");
        String place = request.getParameter("place");
        String type = request.getParameter("type");
        String price = request.getParameter("price");
        PorkEntity pork = new PorkEntity();
        pork.setName("生猪");
        pork.setProvince(province);
        pork.setPrice(new BigDecimal(price));
        pork.setPlace(place);
        pork.setType(type);
        pork.setTime(new Date());
        porkDao.save(pork);

        new Thread() {
            @Override
            public void run() {
                this.setName("sendEmail");//设置名字
                PorkEntity porkEntity = porkDao.getAllEntities(province,place,type).get(0);
                List<AttentionEntity> list = attentionDao.getByPrice(price,porkEntity.getId());
                for(int i=0;i<list.size();i++){
                    UserEntity user = userDao.getById(list.get(i).getUserId());
                    StringBuffer builder = new StringBuffer();
                    String subject = "价格阙值预警";
                    builder.append("<html><head>");
                    builder.append("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\" />");
                    builder.append("</head><body>");
                    builder.append("尊敬的用户");
                    builder.append(user.getUsername());
                    builder.append("<br /><br />");
                    builder.append("\t您所关注的商品：");
                    builder.append(porkEntity.getProvince()+" "+porkEntity.getPlace()+" "+porkEntity.getName()+" "
                            +porkEntity.getType()+"<br/>");
                    builder.append("达到预警价格，当前价格为 "+price);
                    builder.append("<br /><br />");
                    builder.append("------------------------------");
                    builder.append("<br /><br />");
                    String htmlContent = builder.toString();
                    try{
                        MailUtil.sendMail(user.getEmail(), subject, htmlContent);
                    }catch(Exception e){
//            ajax = new AjaxUtil(e.getMessage());
                        e.printStackTrace();
                    }
                }
            }
        }.start();

    }
}
