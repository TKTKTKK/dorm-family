<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/layout/taglib.jsp" %>
<!DOCTYPE html>
<html lang="en" class="app">
<head>
<style>
</style>
</head>
<body class="">

<section id="content" class="bg-white">
    <section class="vbox">
        <section class="scrollable">
            <header class="panel-heading bg-white text-lg">
                会员中心 /
                <a href="${ctx}/admin/wefamily/mtxWpUserManage">会员管理 </a> /
                <span class="font-bold  text-shallowred"> 会员详情</span>
            </header>
            <div class="col-sm-12 pos">
                <div style="margin-bottom: 5px">
                    <span class="text-success">${successMessage}</span>
                    <span class="text-danger">${errorMessage}</span>
                </div>
                <form class="form-horizontal form-bordered" data-validate="parsley"
                      action="" method="POST"
                      enctype="multipart/form-data" id="frm"
                >
                    <section class="panel panel-default">
                        <header class="panel-heading mintgreen">
                            <i class="fa fa-gift"></i>
                            <span class="text-lg">用户详情：</span>
                        </header>
                        <div class="panel-body p-0-15">
                            <div class="form-group">
                                <label class="col-sm-3  control-label"><span class="text-danger">*</span>姓名：</label>
                                <div class="col-sm-9 b-l bg-white">
                                    <input type="text" class="form-control" data-required="true" name="name" id="name"
                                           data-maxlength="48"
                                           onblur="trimText(this)"
                                           value="${wpUser.name}">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3  control-label"><span class="text-danger">*</span>手机号：</label>
                                <div class="col-sm-9 b-l bg-white">
                                    <input type="text" class="form-control" data-required="true" name="contactno" id="contactno"
                                           data-maxlength="90"
                                           onblur="trimText(this)"
                                           value="${wpUser.contactno}">
                                    <span id="phoneError" class="text-danger"></span>
                                </div>

                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label"><span class="text-danger">*</span>地址：</label>
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
                                <label class="col-sm-3  control-label"><span class="text-danger">*</span>详细地址：</label>
                                <div class="col-sm-9 b-l bg-white">
                                    <input type="text" class="form-control" data-required="true" name="address" id="address"
                                           onblur="trimText(this)" data-maxlength="256"
                                           value="${wpUser.address}">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3  control-label"><span class="text-danger"></span>微信昵称：</label>
                                <div class="col-sm-9 b-l bg-white">
                                    <input type="text" class="form-control" name="nickname" id="nickname"
                                           data-maxlength="32"
                                           onblur="trimText(this)"
                                           value="${wpUser.nickname}">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3  control-label"><span class="text-danger"></span>微信头像：</label>
                                <div class="col-sm-9 b-l bg-white">
                                    <input type="file" name="imgfile" class="filestyle"  data-icon="false" data-classButton="btn btn-default"
                                           data-classInput="form-control inline v-middle input-s"
                                           id="value"
                                    >
                                    <input type="text" class="hidden" name="headimgurl" value="${wpUser.headimgurl}">
                                    <div class="hidden" id="imgDiv" style="margin-top: 20px">
                                        <img src="${wpUser.headimgurl}" width="100" height="100"
                                             data-toggle="modal" data-target=".bs-example-modal-lg1"
                                             class="hover-pointer">
                                    </div>


                                    <!-- /.modal -->
                                    <div class="modal fade bs-example-modal-lg1" tabindex="-1" role="dialog" aria-labelledby="myLargePicModalLabel" aria-hidden="true">
                                        <div class="modal-dialog modal-lg">
                                            <div class="modal-content">

                                                <div class="modal-header">
                                                    <button type="button" class="close" data-dismiss="modal" id="modelPicCloseBtn"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                                                    <h4 class="modal-title" id="myLargePicModalLabel">大图</h4>
                                                </div>
                                                <div class="modal-body">
                                                    <div class="row">
                                                        <div class="col-sm-12">
                                                            <img src="${wpUser.headimgurl}" width="100%" height="100%" id="showLargePic"/>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div><!-- /.modal-content -->
                                        </div><!-- /.modal-dialog -->
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3  control-label"><span class="text-danger"></span>身份类型：</label>
                                <div class="col-sm-9 b-l bg-white">
                                    <c:set var="identifyList" value="${web:queryCommonCodeList('IDENTITY_CODE')}"></c:set>
                                    <select name="type" class="form-control" id="type">
                                        <option value="">请选择你的身份</option>
                                        <c:forEach items="${identifyList}" var="commonCode">
                                            <option value="${commonCode.code}"
                                                    <c:if test="${wpUser.type eq commonCode.code}">
                                                        selected
                                                    </c:if>
                                            >${commonCode.codevalue}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                            <div id="extend" style="display: none">
                            <div class="form-group">
                                <label class="col-sm-3  control-label"><span class="text-danger"></span>积分：</label>
                                <div class="col-sm-9 b-l bg-white">
                                    <input type="number" class="form-control"  name="points" id="points" disabled
                                           onblur="trimText(this)"
                                           value="${wpUser.points}">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3  control-label"><span class="text-danger"></span>是否关注：</label>
                                <div class="col-sm-9 b-l bg-white">
                                    <select name="ifsubscribe" id="ifsubscribe" class="form-control">
                                        <option value="">请选择</option>identify
                                        <option value="Y" <c:if test="${wpUser.ifsubscribe eq 'Y'}">selected</c:if>>已关注</option>
                                        <option value="N" <c:if test="${wpUser.ifsubscribe eq 'N'}">selected</c:if>>未关注</option>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3  control-label"><span class="text-danger"></span>是否是会员：</label>
                                <div class="col-sm-9 b-l bg-white">
                                    <select name="ifauth" id="ifauth" class="form-control">
                                        <option value="">请选择</option>identify
                                        <option value="Y" <c:if test="${wpUser.ifauth eq 'Y'}">selected</c:if>>会员</option>
                                        <option value="N" <c:if test="${wpUser.ifauth eq 'N'}">selected</c:if>>非会员</option>
                                    </select>
                                </div>
                            </div>
                            </div>
                            <div class="form-group">
                                <div class="col-sm-12">
                                    <input type="hidden" name="uuid" class="form-control" value="${wpUser.uuid}">
                                    <input type="hidden" name="versionno" class="form-control"
                                           value="${wpUser.versionno}">
                                </div>
                            </div>
                        </div>
                        <div class="panel-footer text-left bg-light lter">
                            <a onclick="checkValid()"
                               class="btn  btn-infonew btn-sm" style="color: white;font-size: 14px">
                                提  交
                            </a>
                        </div>
                    </section>
                    <div>
                        <p class="warningword"><span class="font-bold"><i class="fa fa-warning">：</i></span>
                            点击图片，可查看大图。</p>
                    </div>
                </form>
            </div>
        </section>
    </section>
    <a href="#" class="hide nav-off-screen-block" data-toggle="class:nav-off-screen,open" data-target="#nav,html"></a>
</section>
<script type="text/javascript" src="${ctx}/static/admin/geo.js"></script>
<script charset="utf-8" src="${ctx}/static/admin/editor/kindeditor.js"></script>
<script charset="utf-8" src="${ctx}/static/admin/editor/lang/zh_CN.js"></script>
<script charset="utf-8" src="${ctx}/static/admin/editor/plugins/lineheight/lineheight.js"></script>
<script type="text/javascript">

    window.onload = function () {
        //显示父菜单
        showParentMenu('会员中心');
        if(${wpUser.headimgurl!=null && wpUser.headimgurl!=''}){
            $('#imgDiv').removeClass('hidden');
        }
        if(${wpUser.uuid!=null && wpUser.uuid!=''}){
            $('#extend').css("display","block");
        }
    }
    function checkValid(){
        $("#frm").parsley("validate");
        if(checkIfValid() && $('#frm').parsley().isValid()&&isPoneAvailable()){
            var searchForm = document.getElementById("frm");
            searchForm.action = "${ctx}/admin/wefamily/updateWpUser";
            searchForm.submit();
        }
    }
    setup();
    promptinfo();


    if (('${wpUser.province}'.length > 0 && '${wpUser.city}'.length > 0 && '${wpUser.district}'.length > 0)) {
        var s1Slt = document.getElementById('s1');
        var s2Slt = document.getElementById('s2');
        var s3Slt = document.getElementById('s3');
        s1Slt.value = '${wpUser.province}';
        change(1);
        if ('${wpUser.address}'.length <= 0) {
            promptinfo();
        }
        s2Slt.value = '${wpUser.city}';
        change(2);
        if ('${wpUser.address}'.length <= 0) {
            promptinfo();
        }
        s3Slt.value = '${wpUser.district}';
        if ('${wpUser.address}'.length <= 0) {
            promptinfo();
        }
        if ('${wpUser.address}'.length > 0) {
            var address = document.getElementById('address');
            address.value = '${wpUser.address}';
        }
    }

    //这个函数是必须的，因为在geo.js里每次更改地址时会调用此函数
    function promptinfo() {
        var address = document.getElementById('address');
        var s1 = document.getElementById('s1');
        var s2 = document.getElementById('s2');
        var s3 = document.getElementById('s3');
        address.value = s1.value + s2.value + s3.value;
    }

    function isPoneAvailable() {
        var phoneError = document.getElementById("phoneError");
        phoneError.innerHTML = "";
        trimText(document.getElementById('contactno'));
        var phone=document.getElementById("contactno").value;
        if(phone.length==0 || phone==undefined ||phone==null){
            return true;
        }else{
            var myreg=/^[1][3,4,5,7,8][0-9]{9}$/;
            if (!myreg.test(phone)) {
                phoneError.innerHTML ="手机号输入不正确！";
                return false;
            } else {
                return true;
            }
        }
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
</script>

</body>
</html>