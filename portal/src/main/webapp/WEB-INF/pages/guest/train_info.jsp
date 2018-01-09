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
    <title>培训详情</title>
    <link rel="stylesheet" href="${ctx}/static/guest/css/common.css" type="text/css" />
    <link rel="stylesheet" href="${ctx}/static/guest/css/normalize3.0.2.min.css" />
    <link rel="stylesheet" href="${ctx}/static/guest/css/style.css?v=7" />
    <link href="${ctx}/static/guest/css/mobiscroll.css" rel="stylesheet" />
    <link href="${ctx}/static/guest/css/mobiscroll_date.css" rel="stylesheet" />
    <style>
        .goal_total{padding-left: 1.25rem;border-bottom: 1px solid rgba(0,0,0,0.1);font-size: 1.6rem;color: #333;background-color: #fff;position: relative;padding: 1.17rem 2rem 1.17rem 1.25rem;margin-top: 1rem;}
        .goal_total:nth-of-type(odd) span{border-left: 4px solid #ff9933;padding-left: 1.25rem;}
        .goal_total:nth-of-type(2) span {border-left: 4px solid #5bbc4e;padding-left: 1.25rem;}
        .goal_total:nth-of-type(3) span {border-left: 4px solid #5bbc4e;padding-left: 1.25rem;}
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
        #trainImgContainer{display: inline-block;vertical-align: middle}
        #trainImgUrlContainer{display: inline-block;vertical-align: middle;margin-left: 2rem}
        #trainImgContainer img{width: 64px;height: 64px;margin:1rem;max-width: none}
        .my-display-inline-box{width: auto}
        .required{padding: 0 !important;border: 0 !important;color: tomato;text-align: right;}
        .maxlength{padding: 0 !important;border: 0 !important;color: tomato;text-align: right;}
        .fixsubmit{background-color: none;display: flex;display: -webkit-flex}
        .fixsubmit>a:nth-of-type(1){left: 0;background: #5bbc4e;width: 100%;color: white}
        #productiondt{height: auto;width: auto}
        #traindt{height: auto;width: auto}

    </style>
</head>
<body>
    <div class="head">
        <a class="back" href="${ctx}/guest/member/train_list"></a>
        <span>培训详情</span>
    </div>


            <div class="goal_total" style="margin-top: 0px">
                <a href="javaScript:enableUl('machineUl','machineListImg')">
                    <span>主机信息</span>
                    <img src="../../../../static/guest/img/list.png" alt="" id="machineListImg" class="up">
                </a>
            </div>
            <ul class="list" id="machineUl" style="margin-bottom: 0px;">
                <li>
                    <span>机器型号</span>
                    <input type="text" id="machinemodel" name="machinemodel" value="${train.machinemodel}"
                           data-required="true" placeholder="请填写机器型号" data-maxlength="32" readonly/>
                </li>
                <li>
                    <span>机器号</span>
                    <input type="text" id="machineno" name="machineno" value="${train.machineno}"
                           data-required="true" placeholder="请填写机器号" data-maxlength="32" readonly/>
                </li>
            </ul>
            <div class="goal_total" style="margin-top: 0px ">
                <a href="javaScript:enableUl('situationUl','situationListImg')">
                    <span>现场情况</span>
                    <img src="../../../../static/guest/img/list.png" alt="" id="situationListImg" class="up">
                </a>
            </div>
            <ul class="list" id="situationUl" style="margin-bottom: 0px">
                <li>
                    <span>培训日期</span>
                    <input class="input" type="text" name="traindt" id="traindt" readonly
                           value="${train.traindt}" placeholder="请选择培训日期" data-required="true" data-maxlength="23">
                </li>
                <li>
                    <span>培训地点</span>
                    <input type="text" name="location" id="location" value="${train.location}" data-maxlength="32" readonly onblur="initLocation()">
                </li>
            </ul>

       <form class="form-horizontal" data-validate="parsley"
                  action="" method="POST" id="frm">
            <div class="goal_total" style="margin-top: 0px ">
                <span class="evaluateSpan">您对本次服务满意吗？</span>
            </div>
            <ul class="list">
                <li>
                    <span>评价</span>
                    <select name="situation" id="situation">
                        <c:set var="commonCodeList" value="${web:queryCommonCodeList('TRAIN_SITUATION')}"></c:set>
                        <option value="">请选择</option>
                        <c:forEach items="${commonCodeList}" var="commonCode">
                            <option value="${commonCode.code}" <c:if test="${train.situation == commonCode.code}">selected</c:if>>${commonCode.codevalue}</option>
                        </c:forEach>
                    </select>
                </li>
                <li style="display: flex;display: -webkit-flex;">
                    <span style="vertical-align: middle;">备注</span>
                    <textarea rows="4" name="situationremarks" id="situationremarks" data-maxlength="256"
                              style=" width: 16rem;vertical-align: middle;text-align: right">${train.situationremarks}</textarea>
                </li>
            </ul>


            <input type="hidden" name="uuid" class="form-control" value="${train.uuid}">
            <input type="hidden" name="versionno" class="form-control"
                   value="${train.versionno}">
        </form>

    <div class="choose" style="display: none">
        <div class="error">
            <p id="Message"></p >
            <button onclick="closeModel()">我知道了</button>
        </div>
    </div>

        <c:if test="${train.status eq 'FINISH' && empty train.situation}">
            <div class="fixsubmit">
                <a href="javascript:saveSituationInfo()">保存</a>
            </div>
        </c:if>





<script src="${ctx}/static/admin/js/lrz/dist/lrz.bundle.js"></script>
<script src="${ctx}/static/admin/js/jquery.min.js"></script>
<script src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script src="${ctx}/static/js/wechatUtil.js?20171201"></script>
<script src="${ctx}/static/js/coordtransform.js"></script>
<script src="${ctx}/static/js/mobiscroll_date.js" charset="utf-8"></script>
<script src="${ctx}/static/js/mobiscroll.js"></script>
<script type="text/javascript">

    var Message = document.getElementById("Message");
    Message.innerHTML = "";

    function closeModel(){
        $(".choose").css("display","none");
    }

    function closeImg(){
        $("#imgDiv").css("display","none");
    }

    function saveSituationInfo(){
        var searchForm = document.getElementById("frm");
        searchForm.action = "${ctx}/guest/saveSituationInfo"
        searchForm.submit();
    }

    window.onload = function(){
        if(${successMessage != null}){
            Message.innerHTML = "${successMessage}";
            $(".choose").css("display","block");
        }else if(${errorMessage != null}){
            Message.innerHTML = "${errorMessage}";
            $(".choose").css("display","block");
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

        $("#traindt").mobiscroll($.extend(opt['date'], opt['default']));
        $("#productiondt").mobiscroll($.extend(opt['date'], opt['default']));

    });

    function submitTrainInfo(){
        $("#frm").parsley("validate");
        //表单合法 单价合法性
        if ($('#frm').parsley().isValid()){
            var searchForm = document.getElementById("frm");
            searchForm.action = "${ctx}/admin/wefamily/trainInfoForPhone?scanedFlag=Y"
            searchForm.submit();
        }
    }

    $('.pageUpload').change(function () {
        if ($(".pageUpload").attr("readonly") == "readonly") {
            $("#notification_bar").css("width", "60%");
            $("#notification_bar").css("left", "20%");
            HC.showNotification("网络较慢，请耐心等待！", 2000);
        } else {
            compressUploadPicture(document.getElementById("trainImg"));
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
            for(var i=0;i<lis.length;i++) {
            if(lis[i].style.display == "none"){
                lis[i].style.display = "block";
                img.className = "up";
        }else{
                lis[i].style.display = "none";
                img.className = "down";
            }
        }
    }

    function finishTrain(){

        $("#frm").parsley("validate");
        //表单合法 单价合法性
        if ($('#frm').parsley().isValid()){
            if($('#trainImgContainer').find('img').length > 0){
                var searchForm = document.getElementById("frm");
                searchForm.action = "${ctx}/admin/wefamily/finishTrainForPhone?trainId=${train.uuid}&versionno=${train.versionno}&scanedFlag=Y"
                searchForm.submit();
            }else{
                Message.innerHTML = "请上传人机合影！";
                $(".choose").css("display","block");
            }
        }
    }

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

    function changeTrainProgram(){
        var ul = document.getElementById("programUl");
        var lis = ul.getElementsByTagName("li");

        var type = $('#type').val();
        if(type.length > 0 ){
            if(type == 'FIRST'){
                for(var i=0;i<lis.length;i++){
                    if(lis[i].className == 'first'){
                        lis[i].style.display = "block";
                    }else if(lis[i].className == 'scene'){
                        lis[i].style.display = "none";
                    }
                }
            }else if(type == 'SCENE'){
                for(var i=0;i<lis.length;i++){
                    if(lis[i].className == 'scene'){
                        lis[i].style.display = "block";
                    }else if(lis[i].className == 'first'){
                        lis[i].style.display = "none";
                    }
                }
            }

        }
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
                                $('#personname').val(data.wpUser.name);
                                $('#personphone').val(data.wpUser.contactno);
                            }
                        });

                    }
                }
        );
    }

</script>

</body>
</html>