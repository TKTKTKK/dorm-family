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
                    <span class="text-success">${successMessage}</span>
                    <span class="text-danger">${errorMessage}</span>
                </div>
                <form class="form-horizontal form-bordered" data-validate="parsley"
                      action="" method="POST"
                      enctype="multipart/form-data" id="frm">
                    <section class="panel panel-default">
                        <header class="panel-heading mintgreen">
                            <i class="fa fa-gift"></i>
                            <span class="text-lg">活动详情：</span>
                        </header>
                        <div class="panel-body p-0-15">
                            <div class="form-group">
                                <label class="col-sm-3  control-label"><span class="text-danger">*</span>经销商：</label>
                                <div class="col-sm-9 b-l bg-white">
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
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-sm-3 control-label"><span class="text-danger">*</span>活动名称：</div>
                                <div class="col-sm-9 b-l bg-white">
                                    <input class="form-control" type="text" name="name" value="${activity.name}"
                                           id="name" data-maxlength="64"
                                           data-required="true">
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-sm-3 control-label"><span class="text-danger">*</span>活动地点：</div>
                                <div class="col-sm-9 b-l bg-white">
                                    <input class="form-control" type="text" name="address" value="${activity.address}"
                                           id="address" data-maxlength="90"
                                           data-required="true">
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-sm-3 control-label"><span class="text-danger">*</span>开始时间：</div>
                                <div class="col-sm-9 b-l bg-white">
                                    <input class="input-sm form-control" type="text"
                                           name="startdate"
                                           data-date-format="yyyy-mm-dd hh:ii:00" id="startdate"
                                           size="23" data-required="true" readonly
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
                                           value="${activity.enddate}"
                                    >
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-sm-3 control-label"><span class="text-danger">*</span>活动邀请码：</div>
                                <div class="col-sm-9 b-l bg-white">
                                    <input class="form-control" type="text" name="password" value="${activity.password}"
                                           id="password" data-maxlength="48"
                                           data-required="true">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3  control-label"><span class="text-danger">*</span>状态：</label>
                                <div class="col-sm-9 b-l bg-white">
                                    <select class="form-control" id="status" name="status" data-required="true">
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
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label"><span class="text-danger">*</span>活动详情：</label>
                                <div class="col-sm-9 b-l bg-white">
                                    <textarea  class="form-control" data-required="true" name="detail" style="width:300px; height:100px;" data-maxlength="256">${activity.detail}</textarea>
                                </div>
                            </div>
                            <div>
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
                                <div class="form-group">
                                    <label class="col-sm-3 control-label"><span class="text-danger"></span>参加活动人员名单：</label>
                                    <div class="col-sm-9 b-l bg-white">
                                        <label class="checkbox m-n">
                                            <input type="checkbox" name="sltAll" id="sltAll" style="width: 20px;height: 20px"
                                                   onclick="selectAllOrNone('users','sltAll')"><i></i>
                                        </label>
                                        <br/>
                                        <label class="checkbox m-n col-sm-6">
                                            <input type="checkbox" name="users" value="${userall.uuid}"
                                                   onclick="modifySelectAllOrNone('users','sltAll')" style="width: 20px;height: 20px"
                                            ><i></i><span style="font-size: 1.8rem">何世玉</span>
                                        </label>
                                        <label class="checkbox m-n col-sm-6">
                                            <input type="checkbox" name="users" value="${userall.uuid}"
                                                   onclick="modifySelectAllOrNone('users','sltAll')" style="width: 20px;height: 20px"
                                            ><i></i><span style="font-size: 1.8rem">何世玉</span>
                                        </label>
                                        <label class="checkbox m-n col-sm-6">
                                            <input type="checkbox" name="users" value="${userall.uuid}"
                                                   onclick="modifySelectAllOrNone('users','sltAll')" style="width: 20px;height: 20px"
                                            ><i></i><span style="font-size: 1.8rem">何世玉</span>
                                        </label>
                                        <label class="checkbox m-n col-sm-6">
                                            <input type="checkbox" name="users" value="${userall.uuid}"
                                                   onclick="modifySelectAllOrNone('users','sltAll')" style="width: 20px;height: 20px"
                                            ><i></i><span style="font-size: 1.8rem">何世玉</span>
                                        </label>
                                        <label class="checkbox m-n col-sm-6">
                                            <input type="checkbox" name="users" value="${userall.uuid}"
                                                   onclick="modifySelectAllOrNone('users','sltAll')" style="width: 20px;height: 20px"
                                            ><i></i><span style="font-size: 1.8rem">何世玉</span>
                                        </label>
                                        <label class="checkbox m-n col-sm-6">
                                            <input type="checkbox" name="users" value="${userall.uuid}"
                                                   onclick="modifySelectAllOrNone('users','sltAll')" style="width: 20px;height: 20px"
                                            ><i></i><span style="font-size: 1.8rem">何世玉</span>
                                        </label>
                                        <label class="checkbox m-n col-sm-6">
                                            <input type="checkbox" name="users" value="${userall.uuid}"
                                                   onclick="modifySelectAllOrNone('users','sltAll')" style="width: 20px;height: 20px"
                                            ><i></i><span style="font-size: 1.8rem">何世玉</span>
                                        </label>
                                        <label class="checkbox m-n col-sm-6">
                                            <input type="checkbox" name="users" value="${userall.uuid}"
                                                   onclick="modifySelectAllOrNone('users','sltAll')" style="width: 20px;height: 20px"
                                            ><i></i><span style="font-size: 1.8rem">何世玉</span>
                                        </label>
                                        <label class="checkbox m-n col-sm-6">
                                            <input type="checkbox" name="users" value="${userall.uuid}"
                                                   onclick="modifySelectAllOrNone('users','sltAll')" style="width: 20px;height: 20px"
                                            ><i></i><span style="font-size: 1.8rem">何世玉</span>
                                        </label>
                                        <label class="checkbox m-n col-sm-6">
                                            <input type="checkbox" name="users" value="${userall.uuid}"
                                                   onclick="modifySelectAllOrNone('users','sltAll')" style="width: 20px;height: 20px"
                                            ><i></i><span style="font-size: 1.8rem">何世玉</span>
                                        </label>
                                        <label class="checkbox m-n col-sm-6">
                                            <input type="checkbox" name="users" value="${userall.uuid}"
                                                   onclick="modifySelectAllOrNone('users','sltAll')" style="width: 20px;height: 20px"
                                            ><i></i><span style="font-size: 1.8rem">何世玉</span>
                                        </label>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-3 control-label"><span class="text-danger"></span>中奖人员名单：</label>
                                    <div class="col-sm-9 b-l bg-white">
                                        <label class="col-sm-3 text-danger" style="font-size: 1.8rem">参加活动人员名单</label>
                                        <label class="col-sm-3 text-danger" style="font-size: 1.8rem">参加活动人员名单</label>
                                        <label class="col-sm-3 text-danger" style="font-size: 1.8rem">参加活动人员名单</label>
                                        <label class="col-sm-3 text-danger" style="font-size: 1.8rem">参加活动人员名单</label>
                                        <label class="col-sm-3 text-danger" style="font-size: 1.8rem">参加活动人员名单</label>
                                    </div>
                                </div>
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
                            <a onclick="submitForm()" class="btn btn-submit btn-s-xs ">
                                <i class="fa fa-check"></i>&nbsp;提&nbsp;交
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
<script src="${ctx}/static/admin/js/lrz/dist/lrz.bundle.js"></script>
<script src="${ctx}/static/admin/js/qikoo/qikoo.js"></script>
<script type="text/javascript" src="${ctx}/static/admin/js/myScript.js"></script>
<script type="text/javascript" src="${ctx}/static/admin/geo.js"></script>
<script type="text/javascript">

    window.onload = function () {
        //显示父菜单
        showParentMenu('活动中心');
        if(${mtxProduct.img!=null && mtxProduct.img!=''}){
            $('#imgDiv').removeClass('hidden');
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
    function submitForm(){
        $("#frm").parsley("validate");
        if($('#frm').parsley().isValid()&&compareBeginEndDate("startdate", "enddate", "dateError")){
            var searchForm = document.getElementById("frm");
            searchForm.action = "${ctx}/admin/wefamily/updateMtxActivity";
            searchForm.submit();
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