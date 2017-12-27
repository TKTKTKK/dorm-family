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

                                            <input type="hidden" name="mediaid" id="hidMediaId"/>
                                        <div class="form-group col-sm-12">
                                            <label class="col-sm-3  control-label" style="padding-top: 2px">经销商：</label>
                                            <div class="col-sm-9 b-l bg-white">
                                                <input type="checkbox" name="merchant" id="merchant" value="Y">
                                            </div>

                                        </div>
                                        <div class="form-group col-sm-12">
                                            <label class="col-sm-3  control-label" style="padding-top: 2px">会员：</label>
                                            <div class="col-sm-9 b-l bg-white">
                                                <input type="checkbox" name="user" id="user" value="Y">
                                            </div>

                                        </div>

                                            <div class="form-group">
                                                <label class="col-sm-3 control-label" style="padding-top: 10px">地址：</label>
                                                <div class="col-sm-9 b-l bg-white">
                                                    <div class="col-sm-4" style="padding: 2px 15px 0 0;margin-bottom: 10px">
                                                        <select class="form-control" name="province" id="s1">
                                                            <option></option>
                                                        </select>
                                                    </div>
                                                    <div class="col-sm-4" style="padding: 2px 15px 0 0;margin-bottom: 10px">
                                                        <select class="select form-control" name="city" id="s2">
                                                            <option></option>
                                                        </select>
                                                    </div>
                                                    <div class="col-sm-4" style="margin-bottom: 10px;padding: 2px 15px 0 0">
                                                        <select class="select form-control" name="district" id="s3">
                                                            <option></option>
                                                        </select>
                                                    </div>
                                                    <span id="addressError" class="text-danger"></span>
                                                </div>
                                            </div>
                                        <div class="form-group">
                                            <label class="col-sm-3  control-label" style="padding-top: 8px">详细地址：</label>
                                            <div class="col-sm-9 b-l bg-white">
                                                <input type="text" class="form-control" data-required="true" name="address" id="address"
                                                       onblur="trimText(this)" data-maxlength="256">
                                            </div>
                                        </div>

                                        <div class="text-right col-sm-12" style="padding-top: 10px">
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
<script type="text/javascript" src="${ctx}/static/admin/geo.js"></script>
<script type="text/javascript">

    setup();
    promptinfo();

    //这个函数是必须的，因为在geo.js里每次更改地址时会调用此函数
    function promptinfo() {
        var address = document.getElementById('address');
        var s1 = document.getElementById('s1');
        var s2 = document.getElementById('s2');
        var s3 = document.getElementById('s3');
        address.value = s1.value + s2.value + s3.value;
    }

    //检查省市区是否合法
    function checkIfValid() {
        var addressError = document.getElementById("addressError");
        addressError.innerHTML = "";
        var province = document.getElementById("s1").value;
        var city = document.getElementById("s2").value;
        var district = document.getElementById("s3").value;
        if (province === '省份' || city === '地级市' || district === '市、县级市、县') {
            addressError.innerHTML = '省份，地级市，市、县级市、县 均为必填项';
            return false;
        }else{
            return true;
        }
    }

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
        var sendToMerchant = "";
        var sendToUser = "";
        var merchant =  document.getElementById("merchant");
        if(merchant.checked){
            sendToMerchant = "Y";
        }
        var user = document.getElementById("user");
        if(user.checked){
            sendToUser = "Y";
        }
        var province = document.getElementById("s1").value;
        var city = document.getElementById("s2").value;
        var district = document.getElementById("s3").value;
        if(province == '省份'){
            province = "";
        }
        if(city == '地级市'){
            city = "";
        }
        if(district == '市、县级市、县'){
            district = "";
        }

        qikoo.dialog.confirm('确定发送该图文消息？',function(){
            //确定
            window.location.href = "${ctx}/admin/account/sendArticleMessageForUserOrMerchant?sendToMerchant="+sendToMerchant+"&sendToUser="+sendToUser+"&province="+province+"&city="+city+"&district="+district;
        },function(){
            //取消
        });
    }

    //保存参数信息
    function saveParams(mediaid, title){
        $('#hidMediaId').val(mediaid);
        $('#hidTitle').val(title);
    }
</script>
</body>
</html>