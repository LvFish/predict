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

                <li><a class="active-menu" href="#"><i
                        class="fa fa-dashboard"></i> 首页</a></li>
                <li><a href="managerImport"><i
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
                        修改用户
                    </h4>
                </div>
                <div class="modal-body">
                    <form class="form-horizontal" role="form">
                        <!--用户框-->

                        <div class="form-group">
                            <label for="edit-username" class="col-sm-2 control-label">用户名</label>
                            <div class="col-sm-10">
                                <input type="hidden" disabled="disabled" class="form-control" id="edit-userId"  required="required">
                                <input type="text" disabled="disabled" class="form-control" id="edit-username"  required="required">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="edit-password" class="col-sm-2 control-label">密码</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" id="edit-password" placeholder="密码" required="required">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="edit-email" class="col-sm-2 control-label">邮箱</label>
                            <div class="col-sm-10">
                                <input type="text" disabled="disabled" class="form-control" id="edit-email" placeholder="邮箱" required="required">
                            </div>
                        </div>


                    </form>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭
                    </button>
                    <button type="button" onclick="editUser()" class="btn btn-primary">
                        添加
                    </button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal -->
    </div>
    <!-- /. NAV SIDE  -->
    <div id="page-wrapper">
        <div id="page-inner">
            <div class="row">
                <div class="col-md-12">
                    <h1 class="page-header">
                        首页 <small>用户管理</small>
                    </h1>
                </div>
            </div>
            <!-- /. ROW  -->
            <div class="row">
                <div class="col-md-12">
                    <!-- Advanced Tables -->
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            用户表

                        </div>
                        <div class="panel-body">
                            <div class="table-responsive">
                                <table class="table table-striped table-bordered table-hover" id="dataTables-example">
                                    <thead>
                                    <tr>
                                        <th>账号</th>
                                        <th>密码</th>
                                        <th>邮箱</th>
                                        <th>用户权限</th>
                                        <th>操作</th>
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
    $(document).ready(function () {

        getAccount();

    });
    function editUser(){
        var userId = document.getElementById('edit-userId').value;
        var password = document.getElementById('edit-password').value;
        $.ajax({
            url:'editUser',
            type:'post',
            data:{
                'userId':userId,
                'password':password,
            },
            async:false,
            success:function(res){
                $('#myModal').modal('hide');
                location.reload();
            }
        })

    }
    function getAccount(){
        $.ajax({  // ajax登陆请求
            url:"getAllUser",
            type:"post",
            data:{

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
                        { "mData": "username"},
                        { "mData": "password"},
                        { "mData": "email"},
                        {"mData" :  function(obj) {
                            if (obj.isDisable == '0') {
                                return "启用";
                            }
                            return "禁用";
                        }},
                        {"mData" : ""},
                        /*  { "mData": 234}, */
                    ],
                    "columnDefs": [
                        //{
                        //    "targets": -2,//编辑
                        //    "data": null,
                        //    "defaultContent": "<button id='editrow' class='btn btn-primary' type='button'><i class='fa fa-edit'></i></button>"
                        //},
                        {
                            "targets": -1,//删除
                            "data": null,
                            "render": function(data, type, row, meta) {
                                var button = "";
                                if(row.isDisable == '0')
                                    button = "<button style='margin-right: 10px;' id='disable' class='btn btn-primary' type='button'>禁用</button>";
                                else
                                    button = "<button style='margin-right: 10px;' id='showed' class='btn btn-primary' type='button'>启用</button>";

                                button +="<button style='margin-right: 10px;' id='edit' class='btn btn-primary' type='button'>修改</button><button id='delete' class='btn btn-primary' type='button'>删除</button>";
                                return button;
                            },

                        }

                    ] ,

                } );

            }
        });

        $(".panel-body").on('click', 'button#delete', function () {

            var data = $("#dataTables-example").DataTable().row($(this).parents("tr")).data();
            /*  alert("Do you want delete " + data.username + "?"); */
            var r=confirm("确认删除用户"+data.username+"？");
            if (r==true)
            {
                $.ajax({
                    url:'deleteUser',
                    type:'post',
                    data:{'userId':data.userId},
                    async:false,
                    success:function() {
                        location.reload();
                    }
                });
            }
            else
            {

            }
        });

        $(".panel-body").on('click', 'button#edit', function () {

            var data = $("#dataTables-example").DataTable().row($(this).parents("tr")).data();
            /*  alert("Do you want delete " + data.username + "?"); */
            document.getElementById('edit-username').value = data.username;
            document.getElementById('edit-password').value = data.password;
            document.getElementById('edit-email').value = data.email;
            document.getElementById('edit-userId').value = data.userId;
            $('#myModal').modal('show');
        });

        $(".panel-body").on('click', 'button#showed', function () {

            var data = $("#dataTables-example").DataTable().row($(this).parents("tr")).data();
            /*  alert("Do you want delete " + data.username + "?"); */
            var r=confirm("确认启用用户"+data.username+"？");
            if (r==true)
            {
                $.ajax({
                    url:'showedUser',
                    type:'post',
                    data:{'userId':data.userId},
                    async:false,
                    success:function() {
                        location.reload();
                    }
                });
            }
            else
            {

            }
        });

        $(".panel-body").on('click', 'button#disable', function () {

            var data = $("#dataTables-example").DataTable().row($(this).parents("tr")).data();
            /*  alert("Do you want delete " + data.username + "?"); */
            var r=confirm("确认禁用用户"+data.username+"？");
            if (r==true)
            {
                $.ajax({
                    url:'disableUser',
                    type:'post',
                    data:{'userId':data.userId},
                    async:false,
                    success:function() {
                        location.reload();
                    }
                });
            }
            else
            {

            }
        });

    }
</script>


<!-- /. WRAPPER  -->
</body>
</html>
