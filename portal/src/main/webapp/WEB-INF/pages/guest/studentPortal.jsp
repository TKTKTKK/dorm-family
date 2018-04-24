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
    <title>学生入口</title>
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
        .list li>.focus{height:4rem;color:#666;font-size:0.14rem;}
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
        #qualityMgmtImgContainer{display: inline-block;vertical-align: middle}
        #qualityMgmtImgUrlContainer{display: inline-block;vertical-align: middle;margin-left: 2rem}
        #qualityMgmtImgContainer img{width: 50px;height: 50px;margin:1rem;max-width: none}
        .my-display-inline-box{width: auto}
        .required{padding: 0 !important;border: 0 !important;color: tomato;text-align: right;}
        .maxlength{padding: 0 !important;border: 0 !important;color: tomato;text-align: right;}
        .hidden{display: none}
        #productiondt{width: auto;height: auto}
    </style>
</head>
<body>

    <div class="head">
        <span>学生入口</span>
    </div>

        <form class="form-horizontal form-bordered" data-validate="parsley"
              action="${ctx}/guest/studentPortal" method="POST" id="frm">
            <ul class="list">
                <li style="margin-top: 180px;">
                    <span>学生学号<a class="dataRequired">*</a></span>
                    <input type="text" id="stuno" name="stuno" value="${student.stuno}"
                           data-required="true" placeholder="请填写学号" data-maxlength="32" onblur="trimText(this)"/>
                </li>
                <li>
                    <span>身份验证<a class="dataRequired">*</a></span>
                    <input type="text" id="idnoForCheck" name="idnoForCheck" value="${student.idno}"
                           data-required="true" placeholder="请填写证件号码" data-maxlength="32" onblur="trimText(this)"/>
                </li>
                <li>
                    <span>操作类型<a class="dataRequired">*</a></span>
                    <select name="type" id="type">
                        <c:set var="commonCodeList" value="${web:queryCommonCodeList('STUDENT_PORTAL')}"></c:set>
                        <c:forEach items="${commonCodeList}" var="commonCode">
                            <option value="${commonCode.code}"<c:if test="${type == commonCode.code}">selected</c:if>>${commonCode.codevalue}</option>
                        </c:forEach>
                    </select>
                </li>

            </ul>
        </form>

        <div class="choose" style="display: none">
            <div class="error">
                <p id="errorMessage"></p >
                <button onclick="closeModel()">我知道了</button>
            </div>
        </div>

        <a href="javascript:submitRepairInfo()">
            <div class="fixsubmit">
                    进入
            </div>
        </a>



<script src="${ctx}/static/admin/js/lrz/dist/lrz.bundle.js"></script>
<script src="${ctx}/static/admin/js/jquery.min.js"></script>
<script type="text/javascript" src="${ctx}/static/admin/js/myScript.js"></script>
<script src="${ctx}/static/js/mobiscroll_date.js" charset="utf-8"></script>
<script src="${ctx}/static/js/mobiscroll.js"></script>
<script src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script src="${ctx}/static/js/wechatUtil.js?20171201"></script>
<script src="${ctx}/static/js/coordtransform.js"></script>
<script type="text/javascript">

    var errorMessage = document.getElementById("errorMessage");
    errorMessage.innerHTML = "";
    //去空格
    function trimText(obj){
        if(obj.value.length > 0){
            obj.value = obj.value.replace(/(^\s*)|(\s*$)/g, "");
        }
    }

    window.onload = function(){
        if('' != '${errorMessage}'){
            errorMessage.innerHTML = '${errorMessage}';
            $(".choose").css("display","block");
        }
    }

    function getReportlocation(){
        $('#reportlocation').show();
        wechatUtil.getLocation({
            success : function(res){
                var gcj02tobd09 = coordtransform.gcj02tobd09(res.longitude,res.latitude);
                wechatUtil.requestFormattedAddress({
                    latitude:gcj02tobd09[1],
                    longitude:gcj02tobd09[0],
                    success:function(data){
                        $('#reportlocation').val(data.address);
                    }

                })
            }
        });

        $('#reportlocationImg').hide();
    }

    function initReportlocation(){
        var reportlocation = $('#reportlocation').val();
        if(reportlocation.length > 0){
            $('#reportlocation').show();
            $('#reportlocationImg').hide();
        }else{
            $('#reportlocation').hide();
            $('#reportlocationImg').show();
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

    });

    function submitRepairInfo(){
        var stunoError = '';
        var stuno = document.getElementById("stuno").value;
        if(stuno == ""){
            stunoError = "请填写学号！"
        }

        var idnoError = '';
        var idnoForCheck = document.getElementById("idnoForCheck").value;
        if(idnoForCheck == ""){
            idnoError = "请填写证件号码！"
        }

        if(stunoError == "" && idnoError==""){
            var searchForm = document.getElementById("frm");
            searchForm.submit();
        }else{
            errorMessage.innerHTML = stunoError + idnoError;
            $(".choose").css("display","block");
        }
    }

    function closeModel(){
        $(".choose").css("display","none");
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
                    }
                }
        );
    }

    </script>

</body>
</html>