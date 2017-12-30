<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/layout/taglib.jsp" %>
<!DOCTYPE html>
<html lang="en" class="app">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="format-detection" content="telephone=no">
    <meta http-equiv="x-dns-prefetch-control" content="on">
    <title><c:if test="${qualityMgmt.type == 'REPAIR'}">维修</c:if><c:if test="${qualityMgmt.type == 'MAINTAIN'}">保养</c:if>详情</title>
    <link rel="stylesheet" href="${ctx}/static/guest/css/common.css" type="text/css" />
    <link rel="stylesheet" href="${ctx}/static/guest/css/normalize3.0.2.min.css" />
    <link rel="stylesheet" href="${ctx}/static/guest/css/style.css?v=7" />
    <link href="${ctx}/static/guest/css/mobiscroll.css" rel="stylesheet" />
    <link href="${ctx}/static/guest/css/mobiscroll_date.css" rel="stylesheet" />
    <style>
        .goal_total{padding-left: 1.25rem;border-bottom: 1px solid rgba(0,0,0,0.1);font-size: 1.6rem;color: #333;background-color: #fff;position: relative;padding: 1.17rem 2rem 1.17rem 1.25rem;margin-top: 1rem;}
        .goal_total:nth-of-type(even) span{border-left: 4px solid #ff9933;padding-left: 1.25rem;}
        .goal_total:nth-of-type(odd) span {border-left: 4px solid #5bbc4e;padding-left: 1.25rem;}
        .goal_total img{float: right;right: 1.25rem;position: absolute;width: 1rem;height: 1.6rem;top:1.2rem;}
        .list{background: #fff;}
        .list li{justify-content: space-between;border-bottom: 1px solid rgba(0,0,0,0.1);padding: 1.17rem 2rem;}
        /*.list li:nth-last-of-type(1){border:0;}*/
         /*li:nth-last-child(2){border:0}*/
        .list:nth-last-of-type(1){margin-bottom:4rem;}
        .list li span:nth-of-type(1){font-size: 1.6rem;color: #333}
        .list li span:nth-of-type(2){font-size: 1.6rem;color: #666}
        .list li>input{font-size: 1.6rem;color: #666;text-align: right;float: right;}
        .list li .address{display: table;}
        .list li .address>select{font-size: 1.4rem;color: #666;}
        .list li>.focus{height: 4rem;color: #666;font-size: 0.14rem;}
        .list:nth-of-type(3) li span{color: #666}
        .list li select{font-size: 1.4rem;color: #666;float: right}
        /*箭头朝下*/
        .down{transform: rotate(90deg);}
        /*箭头朝上*/
        .up{transform: rotate(-90deg);}

        label {background-color: #FFF;border: 1px solid #66cc66;padding: 1rem;border-radius: 5px;display: inline-block;position: relative;margin-right: 8px;vertical-align: middle;}
        .chk:checked + label {border: 1px solid #66cc66;}
        .chk:checked + label:after {content: '';position: absolute;top: 0.2rem;left: 0.2rem;width: 1.6rem;height:1.6rem;text-align: center;font-size: 1.4em;vertical-align: text-top;background-image: url("../../../../static/admin/img/do.png");background-size: 1.6rem 1.6rem;background-repeat: no-repeat;}
        .upload-btn-box {
            clear: both;
            background: #fff url("../../../../static/admin/img/upload.gif") center center no-repeat;
            background-size: 61px 61px;
            border: 1px solid #cfcfcf;
            border-radius: 1px;
            width: 64px;
            height: 64px;
            color: #b9b9b9;
            text-align: center;
            margin-bottom: 10px;
            position: relative;
        }
        .upload-btn-box .upload-btn {
            opacity: 0;
            position: absolute;
            width: 64px;
            height: 64px;
            z-index: 1;
            left: 0;
            top: 0;
        }
        .dataRequired{
            color: red;
        }
        #reporterImgContainer{display: inline-block;vertical-align: middle;margin-left: 2rem}
        #reporterImgContainer img{width: 5rem;height: 5rem;margin:1rem;max-width: none}
        #qualityMgmtImgContainer{display: inline-block;vertical-align: middle}
        #qualityMgmtImgUrlContainer{display: inline-block;vertical-align: middle;margin-left: 2rem}
        #qualityMgmtImgContainer img{width: 64px;height: 64px;margin:1rem;max-width: none}
        .my-display-inline-box{width: auto}
        .required{padding: 0 !important;border: 0 !important;color: tomato;text-align: right;}
        .maxlength{padding: 0 !important;border: 0 !important;color: tomato;text-align: right;}
        .fixsubmit{background-color: none;display: flex;display: -webkit-flex}
        .fixsubmit>a:nth-of-type(1){left: 0;background: #5bbc4e;width: 70%;color: white}
        .fixsubmit>a:nth-of-type(2){right: 0;background: #f0d439;width: 30%;color: white}
        #productiondt{width: auto;height: auto}
        #servicedt{width: auto;height: auto}
        #content{font-size: initial}
        #remarks{font-size: initial}
    </style>
</head>
<body>
<c:if test="${scanedFlag ne 'Y'}">
    <div class="choose" id="imgDiv" style="z-index: 10;background: rgba(0,0,0,0.7);"><img src="../../../static/guest/img/help.png" alt="" onclick="closeImg()" style="width: 100%"></div>
</c:if>
    <div class="head">
        <c:if test="${qualityMgmt.type == 'REPAIR'}">
            <a class="back" href="${ctx}/admin/wefamily/repairManageForPhone"></a>
            <span>维修详情</span>
        </c:if>
        <c:if test="${qualityMgmt.type == 'MAINTAIN'}">
            <a class="back" href="${ctx}/admin/wefamily/maintainManageForPhone"></a>
            <span>保养详情</span>
        </c:if>
        <img src="../../../static/guest/img/sao.png" alt="" onclick="scan()">
    </div>

        <form class="form-horizontal" data-validate="parsley"
              action="${ctx}/admin/wefamily/qualityMgmtInfoForPhone" method="POST"
              id="frm">
            <div class="goal_total" style="margin-top: 0px">
                <a href="javaScript:enableUl('machineUl','machineListImg')">
                    <span>主机信息</span>
                    <img src="../../../../static/guest/img/list.png" alt="" id="machineListImg" class="up">
                </a>
            </div>
            <ul class="list" id="machineUl">
                <li>
                    <span>机器型号<a class="dataRequired">*</a></span>
                    <input type="text" id="machinemodel" name="machinemodel" value="${qualityMgmt.machinemodel}"
                           data-required="true" placeholder="请填写机器型号" data-maxlength="32"/>
                </li>
                <li>
                    <span>发动机号<a class="dataRequired">*</a></span>
                    <input type="text" id="engineno" name="engineno" value="${qualityMgmt.engineno}"
                           data-required="true" placeholder="请填写发动机号" data-maxlength="32"/>
                </li>
                <li>
                    <span>机器号<a class="dataRequired">*</a></span>
                    <input type="text" id="machineno" name="machineno" value="${qualityMgmt.machineno}"
                           data-required="true" placeholder="请填写机器号" data-maxlength="32"/>
                </li>
                <li>
                    <span>生产日期<a class="dataRequired">*</a></span>
                    <input class="input" type="text" name="productiondt" id="productiondt" value="${qualityMgmt.productiondt}" readonly
                           data-required="true" placeholder="请选择生产日期" data-maxlength="23">
                </li>
                <c:if test="${qualityMgmt.type == 'REPAIR'}">
                    <li style="display: flex;display: -webkit-flex;">
                        <span style="vertical-align: middle;">问题描述</span>
                    <textarea rows="4" name="content" id="content" data-maxlength="256"
                              style=" width: 16rem;vertical-align: middle;text-align: right" readonly>${qualityMgmt.content}</textarea>
                    </li>
                </c:if>
                <c:if test="${fn:length(reporterAttachmentList) > 0}">
                    <li>
                        <div class="my-display-inline-box">
                            <div id="reporterImgContainer" class="row value">
                                <c:forEach items="${reporterAttachmentList}" var="attachment">
                                    <img src="${attachment.name}" alt="" style="margin-top: 3px;margin-left: 10px" onclick="viewBigImageForUpload(this)" data-toggle="modal" data-target=".bs-example-modal-lg-image">
                                </c:forEach>
                            </div>
                        </div>
                    </li>
                </c:if>
            </ul>
            <div class="goal_total">
                <a href="javaScript:enableUl('personUl','personListImg')">
                    <span>用户信息</span>
                    <img src="../../../../static/guest/img/list.png" alt="" id="personListImg" class="up">
                </a>
            </div>
            <ul class="list" id="personUl">
                <li>
                    <span>姓名<a class="dataRequired">*</a></span>
                    <input type="text" placeholder="请填写真实姓名" value="${qualityMgmt.reportername}" name="reportername" id="reportername"
                           data-required="true" data-maxlength="32">
                </li>
                <li>
                    <span>手机号码<a class="dataRequired">*</a></span>
                    <input type="text" placeholder="请填写手机号码" value="${qualityMgmt.reporterphone}" name="reporterphone" id="reporterphone"
                           data-required="true" data-maxlength="11">
                </li>
            </ul>
            <div class="goal_total">
                <a href="javaScript:enableUl('merchantUl','merchantListImg')">
                    <span>经销商信息</span>
                    <img src="../../../../static/guest/img/list.png" alt="" id="merchantListImg" class="up">
                </a>
            </div>
            <ul class="list" id="merchantUl">
                <li>
                    <span>经销商</span>
                    <input type="text"  value="${merchant.name}"
                           data-required="true" data-maxlength="32" readonly>
                </li>
                <li>
                    <span>联系电话</span>
                    <input type="text"  value="${merchant.contactno}"
                           data-required="true" data-maxlength="32" readonly>
                </li>
                <li>
                    <span>地址</span>
                    <input type="text"  value="${merchant.address}"
                           data-required="true" data-maxlength="32" readonly>
                </li>
            </ul>
            <div class="goal_total">
                <a href="javaScript:enableUl('workerUl','workerListImg')">
                    <span><c:if test="${qualityMgmt.type == 'REPAIR'}">维修</c:if><c:if test="${qualityMgmt.type == 'MAINTAIN'}">保养</c:if>工人信息</span>
                    <img src="../../../../static/guest/img/list.png" alt="" id="workerListImg" class="up">
                </a>
            </div>
            <ul class="list" id="workerUl">
                <li>
                    <span>姓名<a class="dataRequired">*</a></span>
                    <input type="text" placeholder="请填写真实姓名" value="${workerList[0].name}" name="name" id="name"
                           data-required="true" data-maxlength="32">
                    <input type="hidden" name="workerid" value="${workerList[0].uuid}">
                    <input type="hidden" name="workerversionno" value="${workerList[0].versionno}">
                </li>
                <li>
                    <span>手机号码<a class="dataRequired">*</a></span>
                    <input type="text" placeholder="请填写手机号码" value="${workerList[0].phone}" name="phone" id="phone"
                           data-required="true" data-maxlength="11">
                </li>
            </ul>
            <div class="goal_total">
                <a href="javaScript:enableUl('situationUl','situationListImg')">
                    <span>现场情况</span>
                    <img src="../../../../static/guest/img/list.png" alt="" id="situationListImg" class="up">
                </a>
            </div>
            <ul class="list" id="situationUl">
                <li>
                    <span>损坏项目<a class="dataRequired">*</a></span>
                    <input type="text" placeholder="请填写损坏项目" value="${qualityMgmt.program}" name="program" id="program"
                           data-required="true" data-maxlength="50">
                </li>
                <li>
                    <span>处理配件<a class="dataRequired">*</a></span>
                    <input type="text" placeholder="请填写处理的配件" value="${qualityMgmt.parts}" name="parts" id="parts"
                           data-required="true" data-maxlength="32">
                </li>
                <li>
                    <span>现场定位<a class="dataRequired">*</a></span>
                    <input type="text" name="location" id="location" value="${qualityMgmt.location}" data-maxlength="32" readonly onblur="initLocation()">
                    <img src="../../../../static/guest/img/location.png" id="locationImg" onclick="getLocation()" alt="" style="width: 2rem;height: 2rem;float: right">
                </li>
                <li>
                    <span>已作业面积</span>
                    <input type="text" name="workarea" id="workarea" value="${qualityMgmt.workarea}"
                           data-maxlength="20" onblur="trimText(this)" placeholder="请填写已作业面积">
                </li>
                <li>
                    <span>效果如何</span>
                    <input type="text" placeholder="请填写作业效果" value="${qualityMgmt.effect}" name="effect" id="effect"
                            data-maxlength="32">
                </li>
                <li>
                    <span>损坏分类</span>
                    <select name="damagecategory" id="damagecategory" <c:if test="${qualityMgmt.type == 'REPAIR'}"></c:if>>
                        <c:set var="commonCodeList" value="${web:queryCommonCodeList('DAMAGE_CATEGORY')}"></c:set>
                        <option value="">请选择</option>
                        <c:forEach items="${commonCodeList}" var="commonCode">
                            <option value="${commonCode.code}" <c:if test="${qualityMgmt.damagecategory == commonCode.code}">selected</c:if>>${commonCode.codevalue}</option>
                        </c:forEach>
                    </select>
                </li>
                <li>
                    <span>到达所用时间</span>
                    <input type="text" name="arrivetime" value="${qualityMgmt.arrivetime}"
                           data-maxlength="20"  onblur="trimText(this)" id="arrivetime" placeholder="请填写到达所用时间"
                    >
                </li>
                <li>
                    <span><c:if test="${qualityMgmt.type == 'REPAIR'}">维修</c:if><c:if test="${qualityMgmt.type == 'MAINTAIN'}">保养</c:if>日期<a class="dataRequired">*</a></span>
                    <input class="input" type="text" name="servicedt" id="servicedt" readonly
                           value="${qualityMgmt.servicedt}"  data-required="true" data-maxlength="23"
                           <c:if test="${qualityMgmt.type == 'REPAIR'}">placeholder="请选择维修日期"</c:if>
                           <c:if test="${qualityMgmt.type == 'MAINTAIN'}">placeholder="请选择保养日期"</c:if>>
                </li>
                <li>
                    <span>收费金额<a class="dataRequired">*</a></span>
                    <input name="price" id="price" value="${qualityMgmt.price}" size="24" data-required="true"
                           data-maxlength="10" onblur="validateMoney(this,'priceError')" placeholder="请填写收费金额">
                    <span id="priceError" class="text-danger" style="float: right;color: red;font-size: 1.2rem;"></span>
                </li>
                <li style="display: flex;display: -webkit-flex;">
                    <span style="vertical-align: middle;">备注</span>
                    <textarea rows="4" name="remarks" id="remarks" data-maxlength="256"
                              style=" width: 16rem;vertical-align: middle;text-align: right">${qualityMgmt.remarks}</textarea>
                </li>
                <li style="border: 0">
                    <span>人机合影<a class="dataRequired">*</a></span>
                </li>
                <li>
                    <div class="my-display-inline-box">
                        <div id="qualityMgmtImgContainer" class="row value">
                            <c:forEach items="${workerAttachmentList}" var="attachment">
                                <img src="${attachment.name}" alt="" style="margin-top: 3px;margin-left: 10px" onclick="viewBigImageForUpload(this)" data-toggle="modal" data-target=".bs-example-modal-lg-image">
                            </c:forEach>
                        </div>
                        <c:if test="${fn:length(workerAttachmentList) < 4 && qualityMgmt.status ne 'FINISH'}">
                            <div id="qualityMgmtImgUrlContainer" class="upload-btn-box" style="display: inline-block">
                                <input type="file" id="qualityMgmtImg" name="picUrl" class="upload-btn pageUpload"
                                       data-icon="false" data-classButton="btn btn-default"
                                       data-classInput="form-control inline v-middle input-xs"
                                       accept="image/*"
                                    <%--data-max_size="2000000" --%>
                                       data-max-count="4">
                                <div id="picUrlError" class="text-danger"></div>
                            </div>
                        </c:if>
                    </div>
                </li>
            </ul>
            <input type="hidden" name="uuid" class="form-control" value="${qualityMgmt.uuid}">
            <input type="hidden" name="versionno" class="form-control"
                   value="${qualityMgmt.versionno}">
        </form>

    <div class="choose" style="display: none">
        <div class="error">
            <p id="Message"></p >
            <button onclick="closeModel()">OK</button>
        </div>
    </div>

        <c:if test="${qualityMgmt.status ne 'FINISH'}">
            <div class="fixsubmit">
                <a href="javascript:submitQualityMgmtInfo()">保存</a>
                <a href="javascript:finishQualityMgmt()">提交</a>
            </div>
        </c:if>



    <!-- /.modal 大图 start -->
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
    <!-- /.modal 大图 end -->

<script src="${ctx}/static/admin/js/lrz/dist/lrz.bundle.js"></script>
<script src="${ctx}/static/admin/js/jquery.min.js"></script>
<script src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script src="${ctx}/static/js/wechatUtil.js?20171201"></script>
<script src="${ctx}/static/js/coordtransform.js"></script>
<script src="${ctx}/static/js/mobiscroll_date.js" charset="gb2312"></script>
<script src="${ctx}/static/js/mobiscroll.js"></script>
<script type="text/javascript">

    var Message = document.getElementById("Message");
    Message.innerHTML = "";

    function closeModel(){
        $(".choose").css("display","none");
    }


    window.onload = function(){

        if(${successMessage != null}){
            Message.innerHTML = "${successMessage}";
            $(".choose").css("display","block");
        }else if(${errorMessage != null}){
            Message.innerHTML = "${errorMessage}";
            $(".choose").css("display","block");
        }

        var location = $('#location').val();
        if(location.length > 0){
            $('#location').show();
            $('#locationImg').hide();
        }else{
            getLocation();
        }
    }

    $(function () {
        var currYear = (new Date()).getFullYear();
        var opt={};
        opt.date = {preset : 'date'};
        opt.datetime = {preset : 'datetime'};
        opt.time = {preset : 'time'};
        opt.default = {
            theme: 'android-ics light', //皮肤样式
            display: 'modal', //显示方式
            mode: 'scroller', //日期选择模式
            dateFormat: 'yyyy-mm-dd',
            lang: 'zh',
            showNow: true,
            nowText: "返回今天",
            startYear: currYear - 100, //开始年份
            endYear: currYear + 100 //结束年份
        };

        $("#productiondt").mobiscroll($.extend(opt['date'], opt['default']));
        $("#servicedt").mobiscroll($.extend(opt['date'], opt['default']));

    });

    function getLocation(){
        $('#location').show();
        wechatUtil.getLocation({
            success : function(res){
                var gcj02tobd09 = coordtransform.gcj02tobd09(res.longitude,res.latitude);
                wechatUtil.requestFormattedAddress({
                    latitude:gcj02tobd09[1],
                    longitude:gcj02tobd09[0],
                    success:function(data){
                        $('#location').val(data.address);
                    }

                })
            }
        });

        $('#locationImg').hide();
    }

    function initLocation(){
        var location = $('#location').val();
        if(location.length > 0){
            $('#location').show();
            $('#locationImg').hide();
        }else{
            $('#location').hide();
            $('#locationImg').show();
        }
    }

    function submitQualityMgmtInfo(){
        $("#frm").parsley("validate");
        //表单合法 单价合法性
        if ($('#frm').parsley().isValid()){
            var searchForm = document.getElementById("frm");
            searchForm.action = "${ctx}/admin/wefamily/qualityMgmtInfoForPhone?scanedFlag=Y"
            searchForm.submit();
        }
    }


    $('.pageUpload').change(function () {
        if ($(".pageUpload").attr("readonly") == "readonly") {
            $("#notification_bar").css("width", "60%");
            $("#notification_bar").css("left", "20%");
            HC.showNotification("网络较慢，请耐心等待！", 2000);
        } else {
            compressUploadPicture(document.getElementById("qualityMgmtImg"));
        }
    });

    function checkProgram(programCode){
        var checkBox = document.getElementById(programCode);
        if(checkBox.checked){
            checkBox.checked = true;
        }else{
            checkBox.checked = false;
        }
    }

    function enableUl(ulId,imgId){
        var ul = document.getElementById(ulId);
        var lis = ul.getElementsByTagName("li");
        var img = document.getElementById(imgId);
        for(var i=0;i<lis.length;i++){
            if(lis[i].style.display == "none"){
                lis[i].style.display = "block";
                img.className = "up";
            }else{
                lis[i].style.display = "none";
                img.className = "down";
            }
        }
    }

    function finishQualityMgmt(){

        $("#frm").parsley("validate");
        //表单合法 单价合法性
        if ($('#frm').parsley().isValid()){

            if($('#qualityMgmtImgContainer').find('img').length > 0){
                var searchForm = document.getElementById("frm");
                searchForm.action = "${ctx}/admin/wefamily/finishQualityMgmtForPhone?trainId=${qualityMgmt.uuid}&versionno=${qualityMgmt.versionno}&scanedFlag=Y"
                searchForm.submit();
            }else{
                Message.innerHTML = "请上传人机合影！";
                $(".choose").css("display","block");
            }
        }
    }

   /* wechatUtil.getLocation({
        success : function(res){
            alert("latitude : " + res.latitude + " longitude " + res.longitude);
        }
    });*/

    function closeImg(){
        $("#imgDiv").css("display","none");
    }

    function scan(){
        wechatUtil.scanQRCode({
                    success : function(res){
                        var paramArr = wechatUtil.handleScanResult(res.resultStr);
                        $("#machinemodel").val(paramArr[0]);
                        $("#machineno").val(paramArr[1]);
                        $("#engineno").val(paramArr[2]);
                        $("#productiondt").val(paramArr[3]);


                        $.get("${ctx}/admin/wefamily/queryUserByMachineno?machineno="+paramArr[1],function(data,status){
                            if(undefined != data.wpUser){
                                $('#reportername').val(data.wpUser.name);
                                $('#reporterphone').val(data.wpUser.contactno);
                            }
                        });
                    }
                }
        );
    }

</script>

</body>
</html>