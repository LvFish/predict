package com.newclass.controller;

import com.newclass.bean.UserEntity;
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
import java.util.List;

/**
 * Created by liujiawang on 2019/1/28.
 */
@Controller
@RequestMapping("")
public class UserController {
    @Autowired
    @Qualifier("userDao")
    private UserDao userDao;

    @RequestMapping(value ="/login", method = RequestMethod.GET)
    public String login(){
        return "login";
    }

    @RequestMapping(value ="/index", method = RequestMethod.GET)
    public String index(){
        return "index";
    }

    @RequestMapping(value ="/priceTend", method = RequestMethod.GET)
    public String priceTend(){
        return "priceTend";
    }

    @RequestMapping(value ="/pricePredict", method = RequestMethod.GET)
    public String pricePredict(HttpSession session){
        try{
            Object user = session.getAttribute("userId");
            if(user != null){
                return "pricePredict";
            }
        }catch(Exception e){
            return "redirect:/login";
        }
        return "redirect:/login";
    }

    @RequestMapping(value ="/myAttention", method = RequestMethod.GET)
    public String myAttention(HttpSession session){
        try{
            Object userId = session.getAttribute("userId");
            if(userId == null){
                return "redirect:/login";
            }
        }catch(Exception e){
            return "redirect:/login";
        }
        return "myAttention";
    }

    @RequestMapping(value ="/userDetail", method = RequestMethod.GET)
    public String userDetail(HttpSession session){
        try{
            Object user = session.getAttribute("userId");
            if(user != null){
                return "userDetail";
            }
        }catch(Exception e){
            return "redirect:/login";
        }
        return "redirect:/login";
    }


    @RequestMapping(value="/getUserDetail",method = RequestMethod.POST)
    public void getUserDetail(HttpServletResponse response,HttpSession session) throws IOException {
        String userId = session.getAttribute("userId").toString();
        UserEntity user = userDao.getById(Integer.valueOf(userId));
        JSONObject json = new JSONObject();
        json.put("msg",user);
        response.setContentType("application/json;charset=utf-8");
        response.setHeader("Access-Control-Allow-Origin", "*");
        String js = json.toString();
        response.getWriter().write(js.toString());
    }


    @RequestMapping(value = "/login", method = RequestMethod.POST)
    public String login(String username, String password , HttpSession session){
        try {
            System.out.println(username+" "+password);
            List<UserEntity> users = userDao.getByUserName(username);
            UserEntity user = users.get(0);
            if(user.getIsDisable()==1){
                session.setAttribute("message","该用户已被禁用");
                return "redirect:/login";
            }
            if (password.equals(user.getPassword())) {
                session.setAttribute("userId",user.getUserId());
                return "index";
            } else {
                session.setAttribute("message","密码错误");
                return "redirect:/login";
            }
        }catch (Exception e){
            session.setAttribute("message","该账号不存在");
            e.printStackTrace();
            return "redirect:/login";
        }
    }

    @RequestMapping(value ="/register", method = RequestMethod.GET)
    public String register(){
        return "register";
    }

    @RequestMapping(value ="/register", method = RequestMethod.POST)
    public String register(String username , String password , String password2
            , String code , String number , String email , HttpSession session){
        System.out.println(username+" "+password+" "+password2+" "+code+" "+number);
        if(!code.equals(number)){
            session.setAttribute("message","验证码不正确");
            return "redirect:/register";
        }

        if(username==null || username.equals("")){
            session.setAttribute("message","用户名为空");
            return "redirect:/register";
        }
        try{
            List<UserEntity> users = userDao.getByUserName(username);
            UserEntity user = users.get(0);
            session.setAttribute("message","用户名已存在");
            return "redirect:/register";
        }catch (Exception e){
        }
        if(!password.equals(password2)){
            session.setAttribute("message","两次密码不一致");
            return "redirect:/register";
        }
        userDao.insertUser(username,password,email);
        return "index";
    }

    @RequestMapping(value="/updateUser",method = RequestMethod.POST)
    public String updateUser( String password, String code , String number  , HttpSession session){
        if(!code.equals(number)){
            session.setAttribute("userMessage","验证码不正确");
        }else{
            String userId = session.getAttribute("userId").toString();
            UserEntity user = userDao.getById(Integer.valueOf(userId));
            user.setPassword(password);
            userDao.save(user);
            session.setAttribute("userMessage","修改成功");
        }
        return "redirect:/userDetail";
    }


    @RequestMapping(value ="/forget", method = RequestMethod.GET)
    public String forget(){
        return "forget";
    }

    @RequestMapping(value ="/forget", method = RequestMethod.POST)
    public String forget(String username , String password1 , String password2 ,
                         String code , String number , String email , HttpSession session){
//        System.out.println(username+" "+password1+" "+password2+" "+code+" "+number);
        if(!code.equals(number)){
            session.setAttribute("message","验证码不正确");
            return "redirect:/user/forget";
        }

        if(!password1.equals(password2)){
            session.setAttribute("message","两次密码不一致");
            return "redirect:/user/register";
        }
        UserEntity u = userDao.getByUserName(username).get(0);
        if(u==null||!u.getEmail().equals(email)){
            session.setAttribute("message","身份信息错误");
            return "redirect:/user/forget";
        }
        u.setPassword(password1);
        userDao.save(u);
        return "index";
    }

    @ResponseBody
    @RequestMapping(value="/sendEmail",method = RequestMethod.POST)
    public void sendEmail(HttpServletRequest request, HttpServletResponse response) throws IOException {
        JSONObject json = new JSONObject();
        String title = "验证码";
        String email = request.getParameter("email");
        StringBuilder builder = new StringBuilder();
        int t = (int)(Math.random()*100000);
        if(t<100000){
            t+=100000;
        }
        String subject = "注册验证码";
        builder.append("<html><head>");
        builder.append("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\" />");
        builder.append("</head><body>");
        builder.append("尊敬的");
        builder.append(email);
        builder.append("<br /><br />");
        builder.append("\t验证码为：");
        builder.append(t);
        builder.append("<br /><br />");
        builder.append("------------------------------");
        builder.append("<br /><br />");
        String htmlContent = builder.toString();
        try{
            MailUtil.sendMail(email, subject, htmlContent);
            json.put("msg", t);
        }catch(Exception e){
//            ajax = new AjaxUtil(e.getMessage());
            json.put("msg",false);
            e.printStackTrace();
        }
        response.setContentType("application/json;charset=utf-8");
        response.setHeader("Access-Control-Allow-Origin", "*");
        String js = json.toString();
        response.getWriter().write(js.toString());
    }



}
