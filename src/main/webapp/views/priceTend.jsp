<%--
  Created by IntelliJ IDEA.
  User: liujiawang
  Date: 2019/5/14
  Time: 10:20 AM
  To change this template use File | Settings | File Templates.
--%>
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

                <li><a href="index"><i
                        class="fa fa-dashboard"></i> 首页</a></li>
                <li><a href="#" class="active-menu"><i class="fa fa-desktop"></i>
                    价格走势图</a></li>
                <li><a href="pricePredict"><i class="fa fa-bar-chart-o"></i>
                    价格预测图</a></li>
                <li><a href="myAttention"><i class="fa fa-eye"></i>
                    我的关注</a></li>
                <li><a href="userDetail"><i class="fa fa-credit-card"></i>
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
                        查看价格走势
                    </h1>
                </div>
            </div>
            <!-- /. ROW  -->
            <!-- /. PAGE WRAPPER  -->
            <div class="row">

                <div class="col-md-12 col-sm-12 col-xs-12">
                    <div class="panel panel-default">

                            <div class="panel-heading">
                                <div class="panel-heading">
                                    省份：
                                    <select  id="choose-province" onchange="provinceChange()">
                                        <option value ="">请选择</option>

                                    </select>
                                    分类：
                                    <select id="choose-type" onchange="typeChange()">
                                        <option value="">请选择</option>
                                    </select>
                                    趋势：
                                    <select id="choose-trend" onchange="trendChange()">
                                        <option value="1">月趋势</option>
                                        <option value="2">年趋势</option>
                                    </select>
                                    <button onclick="queryTrend()">查询</button>
                                </div>
                            </div>
                        <div class="panel-body">
                            <div id="price-trend" style="width: 900px;height:600px;"></div>
                        </div>
                    </div>
                </div>
            </div>
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
    var province;
    var trend;
    var type;
    var title = '全国';
    $(document).ready(function () {
        window.province='';
        window.trend='1';
        window.type='';
        queryTrend();
        getProvince();
        getType();
    });
    function queryTrend() {
        console.log(window.trend);
        var url = 'getPriceTrendByMonth';
        if(window.trend=='2'){
            url = 'getPriceTrendByYear';
        }
        $.ajax({  // ajax登陆请求
            url:url,
            type:"post",
            data:{
                'province':window.province,
                'type':window.type,
            },
            async:false,
            success:function(res){
                var jsonDate =res;
                var trend = jsonDate.trend;
                var keys = [];
                var values = [];
                for(var i=trend.length-1;i>=0;i--){
                    keys.push(trend[i][1]);
                    values.push(trend[i][0]);
                }
                var myChart = echarts.init(document.getElementById('price-trend'));
                /* console.log(jsonObj.day1); */
                var tt = '一个月内';
                if(window.trend!='1'){
                    tt = '当年';
                }
                option = {
                    title : {
                        text: window.type+tt+window.title+'价格趋势',
                    },
                    tooltip : {
                        trigger: 'axis'
                    },
                    toolbox: {
                        show : true,
                        feature : {
                            mark : {show: true},
                            dataView : {show: true, readOnly: false},
                            magicType : {show: true, type: ['line', 'bar']},
                            restore : {show: true},
                            saveAsImage : {show: true}
                        }
                    },
                    calculable : true,
                    xAxis: {
                        type: 'category',
                        data: keys,
                        boundaryGap : false,
                    },
                    yAxis: {
                        min:10,
                        max:18,
                        type: 'value'
                    },
                    series: [{
                        data: values,
                        type: 'line',
                        markPoint : {
                            data : [
                                {type : 'max', name: '最大值'},
                                {type : 'min', name: '最小值'}
                            ]
                        },
                        markLine : {
                            data : [
                                {type : 'average', name: '平均值'}
                            ]
                        }
                    }]
                };
                myChart.setOption(option);

            }
        });
    }
    function trendChange(){
        var objS = document.getElementById("choose-trend");
        var grade = objS.options[objS.selectedIndex];
        window.trend = grade.value;
    }
    function getProvince() {
        $.ajax({
            url:'getProvince',
            type:'post',
            data:{},
            async:false,
            success:function(res) {
                var list = res.province;
                for(var i=0;i<list.length;i++){
                    $("#choose-province").append("<option value='"+list[i]+"'>"+list[i]+"</option>");
                }
            }
        });

    }
    function getType() {
        $.ajax({
            url:'getType',
            type:'post',
            data:{},
            async:false,
            success:function(res) {
                var list = res.type;
                for(var i=0;i<list.length;i++){
                    $("#choose-type").append("<option value='"+list[i]+"'>"+list[i]+"</option>");
                }
            }
        });

    }
    function provinceChange(){
        var objS = document.getElementById("choose-province");
        var grade = objS.options[objS.selectedIndex];
        window.province = grade.value;
        window.title = grade.value;
        if(grade.value==''){
            window.title = '全国';
        }

    }
    function typeChange(){
        var objS = document.getElementById("choose-type");
        var grade = objS.options[objS.selectedIndex];
        window.type = grade.value;
    }

</script>


<!-- /. WRAPPER  -->
</body>
</html>
