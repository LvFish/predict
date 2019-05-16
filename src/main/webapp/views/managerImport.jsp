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
    <title>管理端</title>
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
            <a class="navbar-brand" href="#">管理端</a>
        </div>


    </nav>
    <!--/. NAV TOP  -->
    <nav class="navbar-default navbar-side" role="navigation">
        <div class="sidebar-collapse">
            <ul class="nav" id="main-menu">

                <li><a href="managerIndex"><i
                        class="fa fa-dashboard"></i> 首页</a></li>
                <li><a class="active-menu" href="#"><i
                        class="fa fa-dashboard"></i> 导入</a></li>

            </ul>

        </div>

    </nav>


    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                        &times;
                    </button>
                    <h4 class="modal-title" id="myModalLabel">
                        添加价格
                    </h4>
                </div>
                <div class="modal-body">
                    <form class="form-horizontal" role="form">
                        <!--用户框-->
                        <div class="form-group">
                            <label for="add-province" class="col-sm-2 control-label">省</label>
                            <div class="col-sm-10">
                                <select class="form-control" id="add-province" onchange="addProvinceChange()">
                                    <option value ="">请选择</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="add-place" class="col-sm-2 control-label">报价地点</label>
                            <div class="col-sm-10">
                                <select class="form-control" id="add-place">
                                    <option value ="">请选择</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="add-type" class="col-sm-2 control-label">种类</label>
                            <div class="col-sm-10">
                                <select class="form-control" id="add-type">
                                    <option value ="">请选择</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="add-price" class="col-sm-2 control-label">报价</label>
                            <div class="col-sm-10">
                                <input type="number" class="form-control" id="add-price" placeholder="报价" required="required">
                            </div>
                        </div>

                    </form>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭
                    </button>
                    <button type="button" onclick="addPork()" class="btn btn-primary">
                        添加
                    </button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal -->
    </div>

    <div id="page-wrapper">
        <div id="page-inner">
            <div class="row">
                <div class="col-md-12">
                    <h1 class="page-header">
                        导入 <small>查看价格信息</small>
                    </h1>
                </div>
            </div>
            <!-- /. ROW  -->
            <div class="row">
                <div class="col-md-12">
                    <!-- Advanced Tables -->
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            价格表
                            <div class="panel-heading">
                                省份：
                                <select  id="choose-province" onchange="provinceChange()">
                                    <option value ="">请选择</option>

                                </select>
                                报价地点：
                                <select id="choose-place" onchange="placeChange()">
                                    <option value="">请选择</option>

                                </select>
                                分类：
                                <select id="choose-type" onchange="typeChange()">
                                    <option value="">请选择</option>
                                </select>
                                <button onclick="queryPork()">查询</button>
                                <button data-toggle="modal" data-target="#myModal"
                                        style="background:none;border:none;float:right;outline:none;"><i class="fa fa-plus" aria-hidden="true"></i></button>
                            </div>
                        </div>
                        <div class="panel-body">
                            <div class="table-responsive">
                                <table class="table table-striped table-bordered table-hover" id="dataTables-example">
                                    <thead>
                                    <tr>
                                        <th>日期</th>
                                        <th>省市</th>
                                        <th>报价地点</th>
                                        <th>产品名称</th>
                                        <th>分类</th>
                                        <th>价格（元每公斤）</th>
                                    </tr>
                                    </thead>

                                </table>
                            </div>

                        </div>
                    </div>
                    <!--End Advanced Tables -->
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
    var province;
    var place;
    var type;
    $(document).ready(function () {
        window.province='湖南省';
        window.place='';
        window.type='';
        getAccount();
        getProvince();
        getType();
    });
    function queryPork(){
        console.log(window.province+" "+window.place+" "+window.type);
        getAccount();
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
                    $("#add-province").append("<option value='"+list[i]+"'>"+list[i]+"</option>");
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
                    $("#add-type").append("<option value='"+list[i]+"'>"+list[i]+"</option>");
                }
            }
        });

    }
    function provinceChange(){
        var objS = document.getElementById("choose-province");
        var grade = objS.options[objS.selectedIndex];
        window.province = grade.value;
        $.ajax({
            url:'getPlace',
            type:'post',
            data:{'province':window.province},
            async:false,
            success:function(res) {
                window.place='';
                var list = res.place;
                $("#choose-place").empty();
                $("#choose-place").append("<option value=''>请选择</option>");
                for(var i=0;i<list.length;i++){
                    $("#choose-place").append("<option value='"+list[i]+"'>"+list[i]+"</option>");
                }
            }
        });
    }
    function addProvinceChange(){
        var objS = document.getElementById("add-province");
        var grade = objS.options[objS.selectedIndex];
        var province = grade.value;
        $.ajax({
            url:'getPlace',
            type:'post',
            data:{'province':province},
            async:false,
            success:function(res) {
                var list = res.place;
                $("#add-place").empty();
                $("#add-place").append("<option value=''>请选择</option>");
                for(var i=0;i<list.length;i++){
                    $("#add-place").append("<option value='"+list[i]+"'>"+list[i]+"</option>");
                }
            }
        });
    }

    function addPork(){
        var objS = document.getElementById("add-province");
        var grade = objS.options[objS.selectedIndex];
        var province = grade.value;
        objS = document.getElementById("add-place");
        grade = objS.options[objS.selectedIndex];
        var place = grade.value;
        objS = document.getElementById("add-type");
        grade = objS.options[objS.selectedIndex];
        var type = grade.value;
        var price = document.getElementById("add-price").value;
        if(province.length<=0||place.length<=0||type.length<=0||price.length<=0){
            alert("请输入正确信息!");return;
        }
        $.ajax({
            url:"addPork",
            type:"post",
            data:{
                'province':province,
                'place':place,
                'type':type,
                'price':price,
            },
            async:false,
            success:function() {
                $('#myModal').modal('hide');
                location.reload();
            }
        })

    }
    function placeChange(){
        var objS = document.getElementById("choose-place");
        var grade = objS.options[objS.selectedIndex];
        window.place = grade.value;
    }
    function typeChange(){
        var objS = document.getElementById("choose-type");
        var grade = objS.options[objS.selectedIndex];
        window.type = grade.value;
    }
    function getMyDate(time){
        var oDate = new Date(time),
            oYear = oDate.getFullYear(),
            oMonth = oDate.getMonth()+1,
            oDay = oDate.getDate(),
            oTime = oYear +'-'+ getzf(oMonth) +'-'+ getzf(oDay);//最后拼接时间
        return oTime;
    };

    //补0操作,当时间数据小于10的时候，给该数据前面加一个0
    function getzf(num){
        if(parseInt(num) < 10){
            num = '0'+num;
        }
        return num;
    }


    function getAccount(){
        $.ajax({  // ajax登陆请求
            url:"getPork",
            type:"post",
            data:{
                'province':window.province,
                'place':window.place,
                'type':window.type
            },
            async:false,
            success:function(res){
                var jsonDate =res;

//                        var jsonObj = eval( '(' + jsonDate + ')' );
                var msg = jsonDate.msg;
                $('#dataTables-example').dataTable().fnDestroy();//sample_1是table的id
                $('#dataTables-example').dataTable( {
                    bProcessing : true,
                    searching : false,
                    "oLanguage" : { // 国际化配置
                        "sProcessing" : "正在获取数据，请稍后...",
                        "sLengthMenu" : "显示 _MENU_ 条",
                        "sZeroRecords" : "没有找到数据",
                        "sInfo" : "从 _START_ 到  _END_ 条记录 总记录数为 _TOTAL_ 条",
                        "sInfoEmpty" : "记录数为0",
                        "sInfoFiltered" : "(全部记录数 _MAX_ 条)",
                        "sInfoPostFix" : "",
                        "sSearch" : "查询",
                        "sUrl" : "",
                        "oPaginate" : {
                            "sFirst" : "第一页",
                            "sPrevious" : "上一页",
                            "sNext" : "下一页",
                            "sLast" : "最后一页"
                        }
                    },

                    "aaData":msg,
                    "aoColumns": [
                        // 按顺序来
                        { "mData": function(obj){
                            return getMyDate(obj.time.time)//通过调用函数来格式化所获取的时间戳
                        }},// 是否选中
                        { "mData": "province"},
                        { "mData": "place"},
                        { "mData": "name"},
                        {"mData" : "type"},
                        {"mData" : "price"},
                        /*  { "mData": 234}, */
                    ],

                } );

            }
        });

    }
</script>


<!-- /. WRAPPER  -->
</body>
</html>

