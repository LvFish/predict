<%--
  Created by IntelliJ IDEA.
  User: liujiawang
  Date: 2019/5/14
  Time: 10:06 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">

<head>

    <meta charset="utf-8">

    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>注册</title>

    <!-- CSS -->
    <link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Roboto:400,100,300,500">
    <link rel="stylesheet" href="/assets/css/bootstrap.css">
    <link rel="stylesheet" href="/assets/css/font-awesome.css">
    <link rel="stylesheet" href="/assets/css/form-elements.css">
    <link rel="stylesheet" href="/assets/css/style.css">

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

    <!-- Favicon and touch icons -->
    <link rel="shortcut icon" href="assets/ico/favicon.png">
    <link rel="apple-touch-icon-precomposed" sizes="144x144" href="assets/ico/apple-touch-icon-144-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="114x114" href="assets/ico/apple-touch-icon-114-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="72x72" href="assets/ico/apple-touch-icon-72-precomposed.png">
    <link rel="apple-touch-icon-precomposed" href="assets/ico/apple-touch-icon-57-precomposed.png">

</head>

<body>

<!-- Top content -->
<div class="top-content">

    <div class="inner-bg">
        <div class="container">

            <div class="row">
                <div class="col-sm-6 col-sm-offset-3 form-box">
                    <div class="form-top">
                        <div class="form-top-left">
                            <h3>注册用户</h3>
                            <p>请输入你的信息</p>
                        </div>
                        <div class="form-top-right">
                            <i class="fa fa-lock"></i>
                        </div>
                    </div>
                    <div class="form-bottom">
                        <form role="form" class="login-form" action="/register" method="post">
                            <div class="form-group">
                                <label class="sr-only" for="form-username">Username</label>
                                <input type="text"  name="username" placeholder="用户名..." class="form-username form-control" id="form-username">
                            </div>
                            <div class="form-group">
                                <label class="sr-only" for="form-password">Password</label>
                                <input type="password" name="password" placeholder="密码..." class="form-password form-control" id="form-password">
                            </div>
                            <div class="form-group">
                                <label class="sr-only" for="form-password2">Password</label>
                                <input type="password" name="password2" placeholder="密码..." class="form-password form-control" id="form-password2">
                            </div>
                            <div class="row">
                                <div class="col-sm-9">
                                    <div class="form-group">
                                        <label class="sr-only" for="form-email">Email</label>
                                        <input type="email" name="email" placeholder="邮箱..." class="form-username form-control" id="form-email" >
                                    </div>
                                </div>
                                <div class="col-sm-3">
                                    <div class="form-group">
                                        <label class="sr-only" for="form-button">Button</label>
                                        <input type="button" style="outline:none;" class="btn" onclick="sendemail(this)" id="form-button" value="获取验证码">
                                    </div>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="sr-only" for="form-number">验证码</label>
                                <input type="text" name="number" placeholder="验证码..." class="form-username form-control" id="form-number" >
                            </div>
                            <div>
                                <input type="hidden" name="code" id="code" value=""/>
                            </div>
                            <c:if test="${message!=null}">
                                <div class="form-group">
                                 <p>${message}</p>
                                </div>
                            </c:if>
                            <div class="row">

                                    <button type="submit" class="btn" style="width: 100%;">注册</button>
                            </div>


                        </form>

                    </div>
                </div>
            </div>

        </div>
    </div>

</div>

<script type="text/javascript">
    var time=60;
    var code = "";
    function sendemail(val){

//        var obj = $("#btn");
        var email = document.getElementById('form-email').value;
        var isEmail = /^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/;
        if(email==""||email.length==0){
            alert("邮箱不能为空");
            return;
        }else if(!(isEmail.test(email))){
            alert("请输入正确格式邮箱");
            return;
        }
        settime(val);
        $.post("/sendEmail",
            {
                email: email,
            },
            function(data,status){
                if(status){
                    console.log(data.msg);
                    //登陆成功
                    code = data.msg;
                    document.getElementById('code').setAttribute("value",code);
                }else{
                    alert("发送失败");
                }
            });

    }
    function settime(obj) { //发送验证码倒计时
        if (time == 0) {
            obj.removeAttribute("disabled");
            obj.value="免费获取验证码";
            time = 60;
            return;
        } else {
            obj.setAttribute("disabled", true);
            obj.value="重新发送(" + time + ")";
            time--;
        }
        setTimeout(function() {
                settime(obj) }
            ,1000)
    }
</script>


<!-- Javascript -->
<script src="/assets/js/jquery-1.10.2.js"></script>
<script src="/assets/js/bootstrap.min.js"></script>
<script src="/assets/js/jquery.backstretch.js"></script>

<script src="/assets/js/scripts.js"></script>

<!--[if lt IE 10]>
<script src="/assets/js/placeholder.js"></script>
<![endif]-->

</body>

</html>