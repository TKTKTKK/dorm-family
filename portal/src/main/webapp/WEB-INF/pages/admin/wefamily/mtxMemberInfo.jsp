<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/layout/taglib.jsp" %>
<!DOCTYPE html>
<html lang="en" class="app">
<head>
<style>
    .money{
        margin-top: 10px;
    }
</style>
</head>
<body class="">

<section id="content" class="bg-white">
    <section class="vbox">
        <section class="scrollable">
            <header class="panel-heading bg-white text-lg">
                满田星 /
                <a href="${ctx}/admin/wefamily/mtxMemberManage">会员管理 </a> /
                <span class="font-bold  text-shallowred"> 会员详情</span>
            </header>
            <div class="col-sm-12 pos">
                <div style="margin-bottom: 5px">
                    <span class="text-success">${successMessage}</span>
                    <span class="text-danger">${errorMessage}</span>
                </div>
                <form class="form-horizontal form-bordered" data-validate="parsley"
                      action="${ctx}/admin/wefamily/updateMtxMember" method="POST"
                      enctype="multipart/form-data" id="frm"
                onsubmit="checkValid()">
                    <section class="panel panel-default">
                        <header class="panel-heading mintgreen">
                            <i class="fa fa-gift"></i>
                            <span class="text-lg">会员详情：</span>
                        </header>
                        <div class="panel-body p-0-15">
                            <div class="form-group">
                                <label class="col-sm-3  control-label"><span class="text-danger">*</span>姓名：</label>
                                <div class="col-sm-9 b-l bg-white">
                                    <input type="text" class="form-control" data-required="true" name="name" id="name"
                                           data-maxlength="48"
                                           onblur="trimText(this)"
                                           value="${mtxMember.name}">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3  control-label"><span class="text-danger">*</span>手机号：</label>
                                <div class="col-sm-9 b-l bg-white">
                                    <input type="text" class="form-control" data-required="true" name="phone" id="contactno"
                                           data-maxlength="90"
                                           onblur="trimText(this)"
                                           value="${mtxMember.phone}">
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
                                <label class="col-sm-3  control-label"><span class="text-danger">*</span>经销商编号：</label>
                                <div class="col-sm-9 b-l bg-white">
                                    <input type="text" class="form-control" data-required="true" name="merchantid" id="merchantid"
                                           data-maxlength="32"
                                           onblur="trimText(this)"
                                           value="${mtxMember.merchantid}">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3  control-label"><span class="text-danger"></span>微信昵称：</label>
                                <div class="col-sm-9 b-l bg-white">
                                    <input type="text" class="form-control" name="wechatname" id="wechatname"
                                           data-maxlength="32"
                                           onblur="trimText(this)"
                                           value="${mtxMember.wechatname}">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3  control-label"><span class="text-danger"></span>微信头像：</label>
                                <div class="col-sm-9 b-l bg-white">
                                    <input type="file" name="imgfile" class="filestyle"  data-icon="false" data-classButton="btn btn-default"
                                           data-classInput="form-control inline v-middle input-s"
                                           id="value"
                                    >
                                    <input type="text" class="hidden" name="wechatimg" value="${mtxMember.wechatimg}">
                                    <div class="hidden" id="imgDiv" style="margin-top: 20px">
                                        <img src="${mtxMember.wechatimg}" width="100" height="100"
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
                                                            <img src="${mtxMember.wechatimg}" width="100%" height="100%" id="showLargePic"/>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div><!-- /.modal-content -->
                                        </div><!-- /.modal-dialog -->
                                    </div>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-3  control-label"><span class="text-danger"></span>积分：</label>
                                <div class="col-sm-9 b-l bg-white">
                                    <input type="number" class="form-control"  name="points" id="points"
                                           data-maxlength="32"
                                           onblur="trimText(this)"
                                           value="${mtxMember.points}">
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-sm-12">
                                    <input type="hidden" name="uuid" class="form-control" value="${mtxMember.uuid}">
                                    <input type="hidden" name="versionno" class="form-control"
                                           value="${mtxMember.versionno}">
                                </div>
                            </div>
                        </div>
                        <div class="panel-footer text-left bg-light lter">
                            <button type="submit" class="btn btn-submit btn-s-xs ">
                                <i class="fa fa-check"></i>&nbsp;提&nbsp;交
                            </button>
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
        showParentMenu('满田星');
        if(${mtxMember.wechatimg!=null && mtxMember.wechatimg!=''}){
            $('#imgDiv').removeClass('hidden');
        }
    }
    function checkValid(){

    }
    setup();
    promptinfo();

    //这个函数是必须的，因为在geo.js里每次更改地址时会调用此函数
    function promptinfo() {}
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
                return false;
            } else {
                return true;
            }
        }
    }
</script>

</body>
</html>