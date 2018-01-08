<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/layout/taglib.jsp" %>
<!DOCTYPE html>
<html lang="en" class="app">
<head>
<style>
    #detailImgContainer{display: inline-block;vertical-align: middle}
    #detailImgUrlContainer{display: inline-block;vertical-align: middle;margin-left: 0rem}
    #detailImgContainer img{width: 5rem;height: 5rem;margin:1rem}
</style>
</head>
<body class="">

<section id="content" class="bg-white">
    <section class="vbox">
        <section class="scrollable">
            <header class="panel-heading bg-white text-lg">
                活动中心 /
                <a href="${ctx}/admin/wefamily/mtxActivityManage">活动管理 </a> /
                <span class="font-bold  text-shallowred"> 活动详情</span>
            </header>
            <div class="col-sm-12 pos">
                <div style="margin-bottom: 5px">
                    <c:if test="${message==null ||message==''}">
                        <span class="text-success">${successMessage}</span>
                    </c:if>
                    <span class="text-danger">${message}</span>
                    <span class="text-danger">${errorMessage}</span>
                </div>
                <form class="form-horizontal form-bordered" data-validate="parsley"
                      action="${ctx}/admin/wefamily/updateMtxActivity" method="POST"
                      enctype="multipart/form-data" id="frm" onsubmit="return submitForm()">
                    <section class="panel panel-default">
                        <header class="panel-heading mintgreen">
                            <i class="fa fa-gift"></i>
                            <span class="text-lg">活动详情：</span>
                        </header>
                        <div class="panel-body p-0-15">
                            <div class="form-group">
                                <label class="col-sm-3  control-label"><span class="text-danger">*</span>经销商：</label>
                                <div class="col-sm-9 b-l bg-white">
                                    <c:choose>
                                        <c:when test="${activity.status eq 'PENDING'||activity.status eq 'APP'||activity.status eq 'DRAWING'}">
                                            <input class="form-control hidden" type="text" name="merchantid" value="${activity.merchantid}"
                                                   id="merchantid"
                                                   data-required="true">
                                            <input class="form-control" type="text"
                                                    <c:forEach items="${merchantList}" var="merchant">
                                                        <c:if test="${merchant.uuid == activity.merchantid}">
                                                           value="${merchant.name}"
                                                        </c:if>
                                                    </c:forEach>
                                                   disabled>
                                        </c:when>
                                        <c:otherwise>
                                            <select class="form-control" id="merchantid" name="merchantid" data-required="true">
                                                <option value="">--全部--</option>
                                                <c:forEach items="${merchantList}" var="merchant">
                                                    <c:if test="${merchant.uuid == activity.merchantid}">
                                                        <option value="${merchant.uuid}" selected>${merchant.name}</option>
                                                    </c:if>
                                                    <c:if test="${merchant.uuid != activity.merchantid}">
                                                        <option value="${merchant.uuid}">${merchant.name}</option>
                                                    </c:if>
                                                </c:forEach>
                                            </select>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-sm-3 control-label"><span class="text-danger">*</span>活动名称：</div>
                                <div class="col-sm-9 b-l bg-white">
                                    <input class="form-control" type="text" name="name" value="${activity.name}"
                                           id="name" data-maxlength="64"
                                            <c:if test="${activity.status eq 'PENDING'||activity.status eq 'APP'||activity.status eq 'DRAWING'}">
                                               disabled
                                            </c:if>
                                           data-required="true">
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-sm-3 control-label"><span class="text-danger">*</span>活动地点：</div>
                                <div class="col-sm-9 b-l bg-white">
                                    <input class="form-control" type="text" name="address" value="${activity.address}"
                                           id="address" data-maxlength="90"
                                    <c:if test="${activity.status eq 'PENDING'||activity.status eq 'APP'||activity.status eq 'DRAWING'}">
                                           disabled
                                    </c:if>
                                           data-required="true">
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-sm-3 control-label"><span class="text-danger">*</span>主题图片：</div>
                                <div class="col-sm-9 b-l bg-white">
                                    <c:if test="${activity.status eq 'INIT'||activity.status eq ''||activity.status eq null}">
                                    <div id="imgStyle" style="width: 265px">
                                        <input type="file" name="imgfile" id="imgfile" class="filestyle"  data-icon="false" data-classButton="btn btn-default"
                                               data-classInput="form-control inline v-middle input-s"
                                               id="value"
                                        ></div>
                                    <span id="imgError" class="text-danger"></span>
                                    </c:if>
                                    <input type="text" class="hidden" name="img" id="img" value="${activity.img}">
                                    <div class="hidden" id="imgDiv"
                                    <c:if test="${activity.status eq 'INIT'||activity.status eq ''||activity.status eq null}">
                                        style="margin-top: 20px"
                                            </c:if>
                                         >
                                        <img src="${activity.img}" width="100" height="100"
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
                                                            <img src="${activity.img}" width="100%" height="100%" id="showLargePic"/>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div><!-- /.modal-content -->
                                        </div><!-- /.modal-dialog -->
                                    </div>
                                </div>
                            </div>
                            <c:if test="${not empty activity.qrcode}">
                                <div class="form-group" >
                                    <label class="col-sm-3 control-label">活动二维码</label>
                                    <div class="col-sm-9  b-l bg-white">
                                        <img src="${activity.qrcode}" width="100px" height="100px"
                                             onclick="viewBigImage(this)" data-toggle="modal" data-target=".bs-example-modal-lg-image"/>
                                    </div>
                                </div>
                            </c:if>
                            <div class="form-group">
                                <div class="col-sm-3 control-label"><span class="text-danger">*</span>开始时间：</div>
                                <div class="col-sm-9 b-l bg-white">
                                    <input class="input-sm form-control" type="text"
                                           name="startdate"
                                           data-date-format="yyyy-mm-dd hh:ii:00" id="startdate"
                                           size="23" data-required="true" readonly
                                    <c:if test="${activity.status eq 'PENDING'||activity.status eq 'APP'||activity.status eq 'DRAWING'}">
                                           disabled
                                    </c:if>
                                           value="${activity.startdate}"
                                    >
                                    <div class="text-danger" id="dateError">
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-sm-3 control-label"><span class="text-danger">*</span>结束时间：</div>
                                <div class="col-sm-9 b-l bg-white">
                                    <input class="input-sm form-control" type="text"
                                           name="enddate"
                                           data-date-format="yyyy-mm-dd hh:ii:00" id="enddate"
                                           size="23" data-required="true" readonly
                                    <c:if test="${activity.status eq 'PENDING'||activity.status eq 'APP'||activity.status eq 'DRAWING'}">
                                           disabled
                                    </c:if>
                                           value="${activity.enddate}"
                                    >
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-sm-3 control-label"><span class="text-danger">*</span>活动邀请码：</div>
                                <div class="col-sm-9 b-l bg-white">
                                    <input class="form-control" type="text" name="password" value="${activity.password}"
                                           id="password" data-maxlength="48"
                                    <c:if test="${activity.status eq 'PENDING'||activity.status eq 'APP'||activity.status eq 'DRAWING'}">
                                           disabled
                                    </c:if>
                                           data-required="true">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3  control-label"><span class="text-danger">*</span>状态：</label>
                                <div class="col-sm-9 b-l bg-white">
                                    <c:choose>
                                        <c:when test="${activity.status eq 'PENDING'||activity.status eq 'DRAWING'}">
                                            <select class="form-control" id="status" name="status">
                                                <option value="">--全部--</option>
                                                <c:set var="typeList" value="${web:queryCommonCodeList('ACTIVITY_STATUS')}"></c:set>
                                                <c:forEach items="${typeList}" var="typeCode">
                                                    <c:if test="${activity.status == typeCode.code}">
                                                        <option value="${typeCode.code}" selected>${typeCode.codevalue}</option>
                                                    </c:if>
                                                    <c:if test="${activity.status != typeCode.code}">
                                                        <option value="${typeCode.code}">${typeCode.codevalue}</option>
                                                    </c:if>
                                                </c:forEach>
                                            </select>
                                        </c:when>
                                        <c:when test="${activity.status eq 'APP'}">
                                            <input class="form-control hidden" type="text" name="status" value="${activity.status}"
                                                   id="status"
                                                   data-required="true">
                                            <c:set var="typeList" value="${web:queryCommonCodeList('ACTIVITY_STATUS')}"></c:set>
                                            <input class="form-control" type="text"
                                            <c:forEach items="${typeList}" var="typeCode">
                                            <c:if test="${activity.status == typeCode.code}">
                                                   value="${typeCode.codevalue}"
                                            </c:if>
                                            </c:forEach>
                                                   disabled>
                                        </c:when>
                                        <c:otherwise>
                                                    <input class="form-control" type="text" value="未开始"
                                                           id="status" disabled
                                                           data-required="true">
                                                    <input class="form-control hidden" type="text" name="status" value="INIT"
                                                           data-required="true">
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label"><span class="text-danger">*</span>活动详情：</label>
                                <div class="col-sm-9 b-l bg-white">
                                    <c:choose>
                                        <c:when test="${activity.status eq 'PENDING'||activity.status eq 'APP'||activity.status eq 'DRAWING'}">
                                            <textarea class="form-control hidden"  name="detail">${activity.detail}</textarea>
                                            <div class="form-control" style="background-color:#eeeeee;width: 100%;height: auto">${activity.detail}</div>
                                        </c:when>
                                        <c:otherwise>
                                            <textarea id="notificationContent" class="form-control" data-required="true" name="detail" style="width:100%; height: 350px;">${activity.detail}</textarea>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label"><span class="text-danger">*</span><span class="text-danger"></span>中奖总人数：</label>
                                <div class="col-sm-9 b-l bg-white">
                                    <input class="form-control" type="number" data-required="true" id="totalLuckyCount" name="totalLuckyCount" value="${activity.totalLuckyCount}"
                                           <c:if test="${activity.status eq 'APP'}">disabled</c:if>>
                                    <span class="text-danger"  id="errorCountMessage"></span>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label"><span class="text-danger">*</span><span class="text-danger"></span>每轮中奖人数：</label>
                                <div class="col-sm-9 b-l bg-white">
                                   <input class="form-control" type="number"  data-required="true" id="everyLuckyCount" name="everyLuckyCount" value="${activity.everyLuckyCount}"
                                          <c:if test="${activity.status eq 'APP'}">disabled</c:if>>
                                </div>
                            </div>

                            <div id="participantid" class="hidden">
                                <div class="form-group">
                                    <label class="col-sm-3 control-label"><span class="text-danger"></span>参加活动人员名单：</label>
                                    <div class="col-sm-9 b-l bg-white">
                                        <div class="row">
                                            <div class="col-sm-2">
                                                <input type="text" placeholder="姓名" id="participantname" name="participantname" style="width:100%;height: 34px" value="${participantname}"/></div>

                                            <span class="text-danger"  id="participantnameMessage" style="position: absolute;margin-top: 32px;margin-left: -190px"></span>
                                            <div class="col-sm-2">
                                                <input type="text" placeholder="手机号" id="participantphone" name="participantphone" style="width:100%;height: 34px" value="${participantphone}"/></div>
                                            <div class="col-sm-2">
                                                <a type="submit"  class="btn btn-submit btn-s-xs"
                                                   onclick="searchUser()"
                                                   id="searchBtn" style="color: #fff">查 询</a></div>
                                        </div>
                                        <c:choose>
                                            <c:when test="${fn:length(participantList)<=0}">
                                                <input class="form-control" type="text" value="暂无人员" disabled style="margin-top: 20px">
                                            </c:when>
                                            <c:otherwise>
                                                <div style="margin-top: 20px">
                                                <label class="checkbox m-n">
                                                    <input type="checkbox" name="sltAll" id="sltAll" style="width: 20px;height: 20px;"
                                                           <c:if test="${activity.status eq 'APP'||(activity.status eq 'DRAWING' && empty participantname && empty participantphone)}">disabled</c:if>
                                                           onclick="selectAllOrNone('users','sltAll')"><i></i>全选等同于全不选
                                                </label>
                                                </div>
                                                <br/>
                                                <c:forEach items="${participantList}" var="participant">
                                                    <label class="checkbox m-n col-sm-3">
                                                        <input type="checkbox" name="users" value="${participant.userid}"
                                                               onclick="modifySelectAllOrNone('users','sltAll')" style="width: 20px;height: 20px"
                                                        <c:forEach items="${luckyList}" var="lucky">
                                                               <c:if test="${lucky.userid eq participant.userid}">checked</c:if>
                                                        </c:forEach>
                                                               <c:if test="${activity.status eq 'APP'||(activity.status eq 'DRAWING' && empty participantname && empty participantphone)}">disabled</c:if>
                                                        ><i></i><img src="${participant.headimg}" style="border-radius:25px;" width="30px" height="30px" alt=""><span style="font-size: 1.8rem">${participant.name}-${participant.contactno}</span>
                                                    </label>
                                                </c:forEach>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                            </div>

                            <div id="achieveid" class="hidden">
                                <div class="form-group">
                                    <label class="col-sm-3 control-label"><span class="text-danger"></span>中奖人员名单：</label>
                                    <div class="col-sm-9 b-l bg-white">
                                        <c:if test="${fn:length(winList)>0}">
                                            <c:forEach items="${winList}" var="participant">
                                                <c:if test="${participant.status eq 'WIN'}">
                                                    <label class="col-sm-4 text-danger" style="font-size: 1.8rem">
                                                        <img src="${participant.headimg}" style="border-radius:25px;" width="30px" height="30px" alt="">${participant.name}-${participant.contactno}</label>
                                                </c:if>
                                            </c:forEach>
                                        </c:if>
                                        <c:if test="${fn:length(winList)<=0}">
                                            <input class="form-control" type="text" value="暂无中奖记录" disabled>
                                        </c:if>
                                    </div>
                                </div>
                            </div>
                            <div id="ActivityImg" class="hidden">
                                <c:if test="${fn:length(attachmentList) < 4}">
                                    <div class="form-group" >
                                        <label class="col-sm-3 control-label">活动图片：</label>
                                        <div class="col-sm-9  b-l bg-white">
                                            <div class="my-display-inline-box">
                                                <div id="detailImgUrlContainer">
                                                    <input type="file" id="detailImg" name="picUrl" class="filestyle"
                                                           data-icon="false" data-classButton="btn btn-default"
                                                           data-classInput="form-control inline v-middle input-xs"
                                                           onchange="compressUploadPicture(this)" accept="image/*"
                                                           style="display: none"
                                                           data-max-count="4">
                                                    <div id="picUrlError" class="text-danger"></div>
                                                </div>
                                                <div id="detailImgContainer" class="row value">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:if>
                                <c:if test="${fn:length(attachmentList) > 0}">
                                    <div class="form-group" >
                                        <label class="col-sm-3 control-label">图片：</label>
                                        <div class="col-sm-9  b-l bg-white">
                                            <c:forEach items="${attachmentList}" var="attachment">
                                                <img src="${attachment.name}" width="50" height="50"
                                                     onclick="viewBigImage(this)" data-toggle="modal" data-target=".bs-example-modal-lg-image"/>
                                            </c:forEach>
                                        </div>
                                    </div>
                                </c:if>
                            </div>
                            <div class="form-group">
                                <div class="col-sm-12">
                                    <input type="hidden" name="uuid" class="form-control" value="${activity.uuid}">
                                    <input type="hidden" name="versionno" class="form-control"
                                           value="${activity.versionno}">
                                </div>
                            </div>
                            <div class="modal fade bs-example-modal-lg-image" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
                                <div class="modal-dialog modal-lg">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <button type="button" class="close" data-dismiss="modal" id="modelCloseBtn"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                                            <h4 class="modal-title" id="myLargeModalLabel">大图</h4>
                                        </div>
                                        <div class="modal-body">
                                            <div class="row">
                                                <div class="col-sm-12">
                                                    <div class="bs-example" data-example-id="simple-carousel">
                                                        <div id="carousel-example-generic" class="carousel slide" data-ride="carousel">
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div><!-- /.modal-content -->
                                </div><!-- /.modal-dialog -->
                            </div>
                        </div>
                        <div class="panel-footer text-left bg-light lter">
                            <c:choose>
                                <c:when test="${activity.status eq 'PENDING'||activity.status eq 'DRAWING'}">
                                    <c:if test="${fn:length(participantList)>0}">
                                    <a onclick="submitParticipant()" class="btn btn-submit btn-s-xs ">
                                        </i>&nbsp;确&nbsp;定
                                    </a>
                                    </c:if>
                                </c:when>
                                <c:otherwise>
                                    <c:if test="${activity.status ne 'DRAWING'}">
                                        <c:choose>
                                            <c:when test="${activity.status eq 'APP'&&fn:length(attachmentList)==4}">
                                                <button class="btn btn-submit btn-s-xs hidden">
                                                    &nbsp;提&nbsp;交
                                                </button>
                                            </c:when>
                                            <c:otherwise>
                                                <button class="btn btn-submit btn-s-xs ">
                                                    &nbsp;提&nbsp;交
                                                </button>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:if>
                                </c:otherwise>
                            </c:choose>
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
<script charset="utf-8" src="${ctx}/static/admin/editor/kindeditor.js"></script>
<script src="${ctx}/static/admin/js/lrz/dist/lrz.bundle.js"></script>
<script src="${ctx}/static/admin/js/qikoo/qikoo.js"></script>
<script type="text/javascript" src="${ctx}/static/admin/js/myScript.js"></script>
<script type="text/javascript" src="${ctx}/static/admin/geo.js"></script>
<script type="text/javascript">
    window.onload = function () {
        //显示父菜单
        showParentMenu('活动中心');
        if(${activity.img!=null && activity.img!=''}){
            $('#imgDiv').removeClass('hidden');
        }
        if(${activity.status=='PENDING'||activity.status=='DRAWING'}){
            $('#participantid').removeClass('hidden');
        }
        if(${activity.status=='APP'}){
            $('#participantid').removeClass('hidden');
            $('#achieveid').removeClass('hidden');
            $('#ActivityImg').removeClass('hidden');
        }
    }

    function validImg(){
        var imgError=document.getElementById("imgError");
        imgError.innerHTML="";
        var imgfile=$("#imgfile").val();
        var img=$("#img").val();
        if((imgfile==null||imgfile=='')&&(img==null||img=='')){
            $("#imgStyle").css("border","1px solid red");
            imgError.innerHTML="该项为必填项."
            return false;
        }else{
            $("#imgStyle").css("border","none");
            return true;
        }
    }

    KindEditor.ready(function(K) {
        window.editor = K.create('#notificationContent', {
            uploadJson : '${ctx}/static/editor/jsp/upload_json.jsp',
            fileManagerJson : '${ctx}/static/editor/jsp/file_manager_json.jsp',
            items : ['fullscreen', 'source', 'undo', 'redo', 'print', 'cut', 'copy', 'paste',
                'plainpaste', 'wordpaste', '|', 'justifyleft', 'justifycenter', 'justifyright',
                'justifyfull', 'insertorderedlist', 'insertunorderedlist', 'indent', 'outdent', 'lineheight','subscript',
                'superscript', '|', 'selectall', '-',
                'title', 'fontname', 'fontsize', '|', 'forecolor', 'hilitecolor', 'bold',
                'italic', 'underline', 'strikethrough', 'removeformat', '|', 'advtable', 'hr', 'image', 'link', 'unlink']
        });

    });

    function validStatus(){
        if(${activity.status==null || activity.status==''||activity.status=='INIT'}){
            return validImg();
        }else{
            return true;
        }
    }

    function submitForm(){
        $("#frm").parsley("validate");
        if(compareBeginEndDate("startdate", "enddate", "dateError")&&validStatus()){
            if(${activity.status=='APP'}){
                return true;
            }else{
                return validRegular();
            }
        }else{
            return false;
        }
    }

    function searchUser(){
        var uuid='${activity.uuid}';
        var participantname=document.getElementById("participantname").value;
        var participantphone=document.getElementById("participantphone").value;
        window.location.href="${ctx}/admin/wefamily/goMtxActivity?uuid="+uuid+"&participantname="+participantname+"&participantphone="+participantphone;
    }

    function submitParticipant(){
        var uuid='${activity.uuid}';
        var participantname=document.getElementById("participantname").value;
        var participantphone=document.getElementById("participantphone").value;
        var status=$("select[name='status'] option:selected").val();
        if((participantname!=''&&participantname!=null)||(participantphone!=''&&participantphone!=null)){
            var searchForm = document.getElementById("frm");
            searchForm.action = "${ctx}/admin/wefamily/addParticipant?uuid="+uuid+"&participantname="+participantname+"&participantphone="+participantphone;
            searchForm.submit();
        }else{
            if(validRegular()){
                var searchForm = document.getElementById("frm");
                searchForm.action = "${ctx}/admin/wefamily/addParticipant?uuid="+uuid+"&status="+status;
                searchForm.submit();
            }
        }
    }
    function validRegular(){
        var totalList=${fn:length(totalList)};
        var uuid='${activity.uuid}';
        var errorCountMessage=document.getElementById("errorCountMessage");
        errorCountMessage.innerHTML="";
        var totalLuckyCount=document.getElementById("totalLuckyCount").value;
        var everyLuckyCount=document.getElementById("everyLuckyCount").value;
        if(totalLuckyCount<everyLuckyCount){
            errorCountMessage.innerHTML="每轮中奖人数不能大于中奖总人数！";
            return false;
        }else{
            if(totalList<=0){
                return true;
            }else{
                if(totalList<totalLuckyCount){
                    errorCountMessage.innerHTML="总人数超过限制！";
                }else{
                    return true;
                }
            }
        }
    }
    $('#startdate').datetimepicker({
        weekStart: 1,
        todayBtn: 1,
        autoclose: 1,
        todayHighlight: 1,
        startView: 2,
        forceParse: 0,
        showMeridian: 1,
    });

    $('#enddate').datetimepicker({
        weekStart: 1,
        todayBtn: 1,
        autoclose: 1,
        todayHighlight: 1,
        startView: 2,
        forceParse: 0,
        showMeridian: 1
    });

    //比较起始日期和截止日期
    function compareBeginEndDate(startDateStr, endDateStr, dateError) {
        var startDateStr = document.getElementById(startDateStr);
        var endDateStr = document.getElementById(endDateStr);
        var dateError = document.getElementById(dateError);
        dateError.innerHTML = '';
        //比较起始和截止日期的大小
        var starttimes;
        var arr = startDateStr.value.split(" ");
        if (arr != null && arr != '') {
            var begin = arr[0].split("-");
            var end = arr[1].split(":");
            var bgDate = new Date(begin[0], begin[1], begin[2], end[0], end[1], end[2]);
            starttimes= bgDate.getTime();
        }
        var edtimes;
        var arrs = endDateStr.value.split(" ");
        if (arrs != null && arrs != '') {
            var begins = arrs[0].split("-");
            var ends = arrs[1].split(":");
            var edDate = new Date(begins[0], begins[1], begins[2], ends[0], ends[1], ends[2]);
            edtimes = edDate.getTime();
        }
        if (starttimes > edtimes) {
            dateError.innerHTML = '起始日期不能大于截止日期';
            return false;
        }
        return true;
    }
    //全选 或 全不选
    function selectAllOrNone(users, sltAll){
        var user = document.getElementsByName(users);
        for(var i=0; i<user.length; i++){
            //全选
            if(document.getElementById(sltAll).checked){
                if(!user[i].checked){
                    user[i].checked = true;
                }
            }else{
                //全不选
                if(user[i].checked){
                    user[i].checked = false;
                }
            }
        }
    }

    //用户选择的个数
    function querySltCount(users){
        var user = document.getElementsByName(users);
        var sltCount = 0;
        for(var i=0; i<user.length; i++){
            if(user[i].checked){
                sltCount ++;
            }
        }
        return sltCount;
    }

    //修改全选、全不选
    function modifySelectAllOrNone(users,sltAll){
        var user = document.getElementsByName(users);
        var sltCount = querySltCount(users);
        if(sltCount == user.length){
            var sltAllChk = document.getElementById(sltAll);
            if(undefined != sltAllChk && null != sltAllChk){
                sltAllChk.checked = true;
            }
        }else{
            var sltAllChk = document.getElementById(sltAll);
            if(undefined != sltAllChk && null != sltAllChk){
                sltAllChk.checked = false;
            }
        }
    }
</script>
</body>
</html>