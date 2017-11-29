<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="/WEB-INF/layout/taglib.jsp" %>
<!DOCTYPE html>
<html lang="en" class="app">
<head>
    <%--<link href="${ctx}/static/admin/css/sweetalert.css" rel="stylesheet">--%>
    <link href="${ctx}/static/admin/css/qikoo/qikoo.css" rel="stylesheet">
    <style>
        #frmForSlt{
            margin-left: 20%;
        }
        .mod-dialog-bg {
            background: #000;
            opacity: .5;
            filter: alpha(opacity=50);
            height: 100%;
            left: 0;
            position: fixed;
            top: 0;
            width: 100%;
            z-index: 1041;
        }
        .mod-dialog {
            background-color: #fff;
            border: solid 1px #82c92f;
            border-top: none;
            min-width: 300px;
            position: absolute;
            z-index: 1042;
        }
    </style>
</head>
<body class="">
<section id="content">
    <section class="vbox">
        <section class="scrollable">
            <header class="panel-heading bg-white text-lg">
                自动回复 / <span class="font-bold  text-shallowred"> 图文消息 </span>
            </header>
            <div class="bg-white closel clearfix">
                <div class="col-sm-12 no-padder">
                    <c:if test="${not empty wechatBinding}">
                        <div style="margin-bottom: 5px">
                            <c:if test="${'1' eq successMessage}">
                                <span class="text-success">发送成功</span>
                            </c:if>
                        </div>
                        <div class="table-responsive">
                            <table class="table table-striped b-t b-light b-b b-l b-r">
                                <thead>
                                <tr>
                                    <th>标题</th>
                                    <th>操作</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach items="${materialNewsResult.item}" var="item">
                                    <tr>
                                        <td>${item.content.news_item[0].title}</td>
                                        <td>
                                            <button class="btn btn-submit btn-sm a-noline"
                                                    data-toggle="modal" data-target=".bs-example-modal-lg"
                                                    onclick="saveParams('${item.media_id}','${item.content.news_item[0].title}')">
                                                发送图文消息
                                            </button>
                                        </td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>

                        </div>
                            <div class="form-group col-sm-12 text-center">
                                  <input type="hidden"  class="form-control"  data-required="true"  name="page" id="page" value="${pageno}">
                            </div>
                        <div class="navbar-right">
                            <button id="preId" style="display: block;" class="btn btn-sm btn-submit" onclick="showPrePage()"> 上一页</button>
                            <button id="nextId" style="display: block;" class="btn btn-sm btn-default" onclick="showNextPage()"> 下一页</button>
                        </div>
                    </c:if>
                    <c:if test="${empty wechatBinding}">
                        <span>您还没有添加公众号，请先去</span>
                        <a href="${ctx}/admin/account/search" class="text-info">添加公众号</a>
                    </c:if>
                </div>
            </div>

            <input type="hidden" id="hidTitle"/>
            <!-- /.modal -->
            <div class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel"
                 aria-hidden="true">
                <div class="modal-dialog modal-lg">
                    <div class="modal-content">

                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" id="modelCloseBtn"><span
                                    aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                            <h4 class="modal-title" id="myLargeModalLabel">发送对象为？</h4>
                        </div>
                        <div class="modal-body">
                            <div class="row">
                                <div class="col-sm-12">
                                    <form class="form-horizontal" data-validate="parsley" action=""
                                          method="POST" id="frmForSlt">
                                        <div class="form-group col-sm-12">
                                            <input type="hidden" name="mediaid" id="hidMediaId"/>

                                            <div class="radio col-sm-12">
                                                <label>
                                                    <input type="radio" name="authType" id="authType1" value="Y" checked>已认证业主
                                                </label>
                                            </div>
                                            <div class="radio col-sm-12">
                                                <label>
                                                    <input type="radio" name="authType" id="authType2" value="N" >未认证业主
                                                </label>
                                            </div>
                                            <div class="radio col-sm-12">
                                                <label>
                                                    <input type="radio" name="authType" id="authType3" value="S" ><div><textarea id="openid" name="openid" cols="40" rows="5" disabled placeholder="多个openid以;隔开"></textarea><span id="note" id="note" class="hidden text-danger">不能为空</span></div>
                                                </label>
                                            </div>
                                        </div>
                                        <div class="text-right col-sm-12">
                                            <a class="btn btn-success btn-s-xs"
                                               href="javascript:sendMsgByAuthType()">发 送</a>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- /.modal-content -->
                </div>
                <!-- /.modal-dialog -->
            </div>
            <!-- /.modal -->
        </section>
    </section>
    <a href="#" class="hide nav-off-screen-block" data-toggle="class:nav-off-screen,open" data-target="#nav,html"></a>
</section>

<%--<script src="${ctx}/static/admin/js/sweetalert.min.js"></script>--%>
<script src="${ctx}/static/admin/js/qikoo/qikoo.js"></script>
<script type="text/javascript">

    //输入openid
    $('#authType1').click(function(){
        $('#openid').attr("disabled","true");
        $('#note').addClass("hidden");
        $('#openid').val("");
    });
    $('#authType2').click(function(){
        $('#openid').attr("disabled","true");
        $('#note').addClass("hidden");
        $('#openid').val("");
    });
    $('#authType3').click(function(){
        $('#openid').removeAttr("disabled");
        $('#note').addClass("hidden");
        $('#openid').val("");
    });

    window.onload = function(){
        //显示父菜单
        showParentMenu('公众号');
        console.log('${pageno}'*20);
        console.log('${materialNewsResult.total_count}'-'${materialNewsResult.item_count}');
        if('${pageno}'*20<'${materialNewsResult.total_count}'-'${materialNewsResult.item_count}')
        {
            document.getElementById("nextId").style.display = "block";
        }
        if('${pageno}'*20>='${materialNewsResult.total_count}'-'${materialNewsResult.item_count}')
        {
            document.getElementById("nextId").style.display = "none";
        }

        if('${pageno}'>0)
        {
            document.getElementById("preId").style.display = "block";
        }
        if('${pageno}'<=0)
        {
            document.getElementById("preId").style.display = "none";
        }
    }
    function showNextPage(){
        var pageno=${pageno}+1;
        console.log(pageno);
        window.location.href = "${ctx}/admin/account/articleMessage?page="+pageno;
    }
    function showPrePage(){
        var pageno=${pageno}-1;
        window.location.href = "${ctx}/admin/account/articleMessage?page="+pageno;
    }

    //根据认证类型发送图文消息
    function sendMsgByAuthType() {

        //验证openid非空



        var authTypeArray = document.getElementsByName('authType');
        var authTypeStr = '';
        for (var i = 0; i < authTypeArray.length; i++) {
            if (authTypeArray[i].checked) {
                authTypeStr = authTypeArray[i].value;
            }
        }
        //已认证业主
        if(authTypeStr == 'Y'){
            window.location.href = "${ctx}/admin/account/sendArticleMessage?mediaid="+$('#hidMediaId').val()+"&title="+$('#hidTitle').val();
        }else if(authTypeStr == 'N'){
            qikoo.dialog.confirm('确定发送该图文消息？',function(){
                //确定
                window.location.href = "${ctx}/admin/account/sendArticleMessageForUnautherized?mediaid="+$('#hidMediaId').val();
            },function(){
                //取消
            });
            <%--//未认证业主--%>
            <%--swal({--%>
                <%--title: "确定发送该图文消息?",--%>
                <%--text: "你将发送此图文消息至业主!",--%>
                <%--type: "warning",--%>
                <%--showCancelButton: true,--%>
                <%--confirmButtonColor: "#DD6B55",--%>
                <%--confirmButtonText: "确定",--%>
                <%--closeOnConfirm: false--%>
            <%--}, function () {--%>
                <%--window.location.href = "${ctx}/admin/account/sendArticleMessageForUnautherized?mediaid="+$('#hidMediaId').val();--%>
            <%--});--%>
        }else{
            if(!$('#openid').val().trim().length == 0){
            qikoo.dialog.confirm('确定发送该图文消息？',function(){
                //确定
                document.getElementById('frmForSlt').action="${ctx}/admin/account/sendArticleMessageForAssigned";

                $('#frmForSlt').submit();

            });
            }else{
//            $('#note').show();
                $('#note').removeClass("hidden");
//                $('#note').css("","");
            }
        }
    }

    //保存参数信息
    function saveParams(mediaid, title){
        $('#hidMediaId').val(mediaid);
        $('#hidTitle').val(title);
    }
</script>
</body>
</html>