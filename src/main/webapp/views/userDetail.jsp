<%--
  Created by IntelliJ IDEA.
  User: liujiawang
  Date: 2019/5/15
  Time: 5:31 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Dream</title>
    <!-- Bootstrap Styles-->
    <link href="/assets/css/bootstrap.css" rel="stylesheet" />
    <!-- FontAwesome Styles-->
    <link href="/assets/css/font-awesome.css" rel="stylesheet" />
    <!-- Morris Chart Styles-->
    <link href="/assets/js/morris/morris-0.4.3.min.css" rel="stylesheet" />
    <!-- Custom Styles-->
    <link href="/assets/css/custom-styles.css" rel="stylesheet" />
    <!-- Google Fonts-->
    <link href='https://fonts.googleapis.com/css?family=Open+Sans'
          rel='stylesheet' type='text/css' />

    <!-- JS Scripts-->
    <!-- jQuery Js -->
    <script src="/assets/js/jquery-1.10.2.js"></script>
    <!-- Bootstrap Js -->
    <script src="/assets/js/bootstrap.min.js"></script>
    <!-- Metis Menu Js -->
    <script src="/assets/js/jquery.metisMenu.js"></script>
    <!-- Morris Chart Js -->
    <script src="/assets/js/morris/raphael-2.1.0.min.js"></script>
    <script src="/assets/js/morris/morris.js"></script>
    <!-- Custom Js -->
    <script src="/assets/js/echarts.min.js"></script>
</head>

<body>
<div id="wrapper">
    <nav class="navbar navbar-default top-navbar" role="navigation">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse"
                    data-target=".sidebar-collapse">
                <span class="sr-only">Toggle navigation</span> <span
                    class="icon-bar"></span> <span class="icon-bar"></span>
                <span
                        class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="#">后台管理</a>
        </div>


    </nav>
    <!--/. NAV TOP  -->
    <nav class="navbar-default navbar-side" role="navigation">
        <div class="sidebar-collapse">
            <ul class="nav" id="main-menu">

                <li><a  href="indexx"><i
                        class="fa fa-dashboard"></i> 首页</a></li>
                <li><a href="priceTend"><i class="fa fa-desktop"></i>
                    价格走势图</a></li>
                <li><a href="pricePredict"><i class="fa fa-bar-chart-o"></i>
                    价格预测图</a></li>
                <li><a href="myAttention"><i class="fa fa-eye"></i>
                    我的关注</a></li>
                <li><a class="active-menu" href="#"><i class="fa fa-credit-card"></i>
                    我的信息</a></li>

            </ul>

        </div>

    </nav>
    <!-- /. NAV SIDE  -->
    <div id="page-wrapper">
        <div id="page-inner">
            <div class="row">
                <div class="col-md-12">
                    <h1 class="page-header">
                        用户详情
                    </h1>
                </div>
            </div>
            <!-- /. ROW  -->
            <div class="row">

                <div class="col-md-12 col-sm-12 col-xs-12">
                    <div class="panel panel-default">

                        <div class="panel-heading">
                            <div class="panel-heading">
                                用户详情
                            </div>
                        </div>
                        <div class="panel-body">
                            <div class="panel-body">
                            <form class="form-horizontal" role="form" action="/updateUser" method="post">


                                    <div class="form-group">
                                        <label for="username">用户名</label>
                                        <input type="text" class="form-control" required="required" disabled="disabled" id="username" placeholder="" value="">
                                    </div>

                                    <div class="form-group">
                                        <label for="password">密码</label>
                                        <input type="password" name="password" class="form-control" required="required" id="password" placeholder="密码" value="">
                                    </div>


                                            <div class="form-group">
                                                <label for="email" >邮箱</label>
                                                <div class="row">
                                                <div class="col-sm-9">
                                                <input type="email" disabled="disabled" class="form-control" id="email" placeholder="邮箱" value="">
                                                </div>
                                                    <div class="col-sm-3">

                                                            <input type="button" style="outline:none;" class="btn btn-primary" onclick="sendemail(this)" id="form-button" value="获取验证码">
                                                    </div>
                                            </div>



                                    </div>
                                    <div class="form-group">
                                        <label  for="form-number">验证码</label>
                                        <input type="text" name="number" required="required" placeholder="验证码..." class="form-username form-control" id="form-number" >
                                    </div>
                                <div>
                                    <input type="hidden" name="code" id="code" value=""/>
                                </div>
                                <c:if test="${userMessage!=null}">
                                    <div class="form-group">
                                        <p>${userMessage}</p>
                                    </div>
                                </c:if>
                                    <button type="submit" class="btn btn-primary">更新</button>
                            </form>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
            <!-- /. PAGE WRAPPER  -->
        </div>
    </div>
</div>

<script src="/assets/js/jquery-1.10.2.js"></script>
<!-- Bootstrap Js -->
<script src="/assets/js/bootstrap.min.js"></script>
<!-- Metis Menu Js -->
<script src="/assets/js/jquery.metisMenu.js"></script>
<!-- DATA TABLE SCRIPTS -->
<script src="/assets/js/dataTables/jquery.dataTables.js"></script>
<script src="/assets/js/dataTables/dataTables.bootstrap.js"></script>

<script type="text/javascript">

    var time=60;
    var code = "";
    function sendemail(val){

//        var obj = $("#btn");
        var email = document.getElementById('email').value;
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

    $(document).ready(function () {

        getAccount();

    });

    function getAccount(){
        $.ajax({  // ajax登陆请求
            url:"getUserDetail",
            type:"post",
            data:{

            },
            async:false,
            success:function(res){
                var user = res.msg;
                document.getElementById("username").value = user.username;
                document.getElementById("email").value = user.email;
            }
        });

    }
</script>


<!-- /. WRAPPER  -->
</body>
</html>

