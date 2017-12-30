<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/layout/taglib.jsp" %>
<!DOCTYPE html>
<html lang="en" class="app">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <meta name="apple-mobile-web-app-capable" content="yes"><!-- 删除默认的苹果工具栏和菜单栏。 -->
    <meta name="apple-mobile-web-app-status-bar-style" content="black"><!-- 控制状态栏显示样式 -->
    <meta name="format-detection" content="telephone=no"><!-- 禁止了把数字转化为拨号链接 -->
    <meta http-equiv="x-dns-prefetch-control" content="on"><!-- 浏览器开启预解析功能 -->
    <title>活动详情</title>
    <link rel="stylesheet" href="${ctx}/static/guest/css/common.css" type="text/css" />
    <style>
        .content{background-color: #fff;margin-bottom: 3.67rem;}
        .title{font-size:1.6rem;color: #333;font-weight: bold;margin-bottom: 1.25rem;}
        .activity_kind>p{border-left: 4px solid #ff9933;padding-left: 1.25rem;color:#ff9933;font-size: 1.5rem;margin: 1.25rem 0;}
        .words_detail p{margin-bottom: 0.2rem;}
        .words_detail img{width: 2rem;vertical-align: middle;margin-right: 0.5rem;}
        .words_detail span {vertical-align: middle;font-size: 1.2rem;color: #333;}
        .edit img{width: 100%;margin-bottom: 1rem;}
        .edit p{color: #333;font-size: 1.4rem}
        .winner img,.partman img{width: 3.25rem}
        .winner li{display: flex;display: -webkit-flex;justify-content: space-between;align-items: center;padding: 0.5rem 0 0.5rem 1.25rem;}
        .winner li span{color: #333}
        .winner .name{width: 17%;}
        .winner .phone{width: 27%;}
        .winner	.wechat_name{width: 30%;text-align: right;}
        .list li{padding-left: 0}
        .list li>input{font-size: 1.6rem;color: #666;text-align: right;float: right;}
        .all{line-height: 2rem;font-size: 1.4rem;color: #66cc66;}
        .partman{padding: 0.5rem 0 0.5rem 1.25rem;}
        .partman li{width: 4rem;display: inline-block;margin-bottom: 0.75rem}
        /*箭头朝下*/
        .down{transform: rotate(90deg);}
        /*箭头朝上*/
        .up{transform: rotate(-90deg);}

        label {background-color: #FFF;border: 1px solid #66cc66;padding: 1rem;border-radius: 5px;display: inline-block;position: relative;margin-right: 8px;vertical-align: bottom;}
        .chk:checked + label {border: 1px solid #66cc66;}
        .chk:checked + label:after {content: '';position: absolute;top: 0.2rem;left: 0.2rem;width: 1.6rem;height:1.6rem;text-align: center;font-size: 1.4em;vertical-align: text-top;background-image: url("../../../../static/admin/img/do.png");background-size: 1.6rem 1.6rem;background-repeat: no-repeat;}
        .words_detail .status_now{color: #66cc66;border-radius: 10px;border: 1px solid #66cc66;padding: 2px 8px;float: right;margin-top: 5px;}
        .modal-header .close{
            padding: 5px 10px !important;
        }
        .choose .error span{
            font-weight: bold;
        }
        .choose .error li{
            margin-bottom: 15px;
        }
        .choose .error button{
            font-size: 1.6rem;
        }
        #inviteCodeError{
            color: red;font-size: 1.2rem;font-weight: lighter;margin-bottom: 25px !important;
        }
        .checkAllButton{
            background-color: #5bbc4e;
            border-radius: 9px;
            width: 5rem;
            height: 2.6rem;
            color: #fff;
            margin-bottom: 10px;
        }
        .fixsubmit a{color: #fff}
        .showParticipantsA{
            right: 1.25rem;
            position: absolute;
            width: 3rem;
            height: 1.6rem;
            top: 0;
            text-align: right;
        }
        .showParticipantsA img{
            position: relative;
            float: none;
            right: 0;
            width: 1rem;
            height: 1.6rem;
            top: 0;
        }
        #activityImgContainer{display: inline-block;vertical-align: middle}
        #activityImgUrlContainer{display: inline-block;vertical-align: middle;margin-left: 2rem}
        #activityImgContainer img{width: 64px;height: 64px;margin:1rem;max-width: none}
        .my-display-inline-box{width: auto}
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
        .activityRule span{
            font-size: 1.6rem;
            color: #333;
        }
        .activityRule input{
            font-size: 1.6rem;
            color: #666;
            text-align: right;
            float: right;
        }
        .activityRule li{
            justify-content: space-between;
            border-bottom: 1px solid rgba(0,0,0,0.1);
            padding: 1.4rem 2rem;
        }
        .required{padding: 0 !important;border: 0 !important;color: tomato;text-align: right;}
    </style>
</head>
<body class="">


            <div class="head">
                <a class="back" href="${ctx}/admin/wefamily/mtxActivityManageForPhone"></a>
                <span>活动详情</span>
            </div>
            <div class="content">
                <p class="title">${mtxActivity.name}</p>
                <div class="activity_kind">
                    <p>活动信息</p>
                    <div class="words_detail">
                        <p><img src="../../../../static/guest/img/time.png" alt=""><span>${fn:substring(mtxActivity.startdate, 0,10 )}—${fn:substring(mtxActivity.enddate, 0,10 )}</span></p>
                        <p><img src="../../../../static/guest/img/address.png" alt=""><span>${mtxActivity.address}</span></p>
                        <p><img src="../../../../static/guest/img/company.png" alt=""><span>满田星公司</span><span class="status_now">${web:getCodeDesc("ACTIVITY_STATUS",mtxActivity.status)}</span></p>
                    </div>
                </div>
                <div class="activity_kind">
                    <p>活动详情</p>
                    <div class="edit">
                        <p>${mtxActivity.detail}</p>
                    </div>
                </div>
                <c:if test="${mtxActivity.status == 'APP'}">
                    <div class="activity_kind">
                        <p>中奖人员</p>
                        <ul class="winner">
                            <c:forEach items="${winParticipantList}" var="winParticipant">
                                <li>
                                    <img src="${winParticipant.headimg}" alt="">
                                </li>
                            </c:forEach>
                        </ul>
                    </div>
                </c:if>

                    <div class="activity_kind">
                       <p style="position: relative">参加人员
                           <a href="javaScript:showParticipants()" class="showParticipantsA">
                                <img src="../../../../static/guest/img/list.png" alt="" id="participantListImg" class="down">
                           </a>
                       </p>


                        <button class="checkAllButton" id="checkAllButton" onclick="checkAllParticipant()">全选</button>
                        <form id="participantFrm" method="POST">
                            <ul class="winner list" id="participantsUl">
                                <c:forEach items="${activityParticipantList}" var="activityParticipant">
                                    <c:set var="showFlag" value="0" scope="page"></c:set>
                                    <c:forEach items="${luckyParticipantList}" var="luckyParticipant">
                                        <c:if test="${luckyParticipant.userid == activityParticipant.userid}">
                                            <c:set var="showFlag" value="1" scope="page"></c:set>
                                        </c:if>
                                    </c:forEach>
                                    <li class="first">
                                        <input type="checkbox" class="chk" id="${activityParticipant.uuid}" name="users" onchange="checkParticipant('${activityParticipant.uuid}')" style="display: none;" <c:if test="${showFlag == 1}">checked </c:if> value="${activityParticipant.userid}">
                                        <label for="${activityParticipant.uuid}"></label>
                                        <img src="${activityParticipant.headimg}" alt=""><span class="name">${activityParticipant.name}</span><span class="phone">${activityParticipant.contactno}</span><span class="wechat_name">${activityParticipant.nickname}</span>
                                    </li>
                                </c:forEach>
                            </ul>
                            <c:if test="${mtxActivity.status == 'PENDING' or mtxActivity.status == 'DRAWING'}">
                                <div class="activity_kind">
                                    <p style="position: relative">活动规则</p>
                                    <ul class="activityRule">
                                        <li>
                                            <span>中奖总人数<a class="dataRequired">*</a></span>
                                            <input data-type="digits" id="totalLuckyCount" name="totalLuckyCount"
                                                   placeholder="请填写中奖总人数" data-required="true" value="${mtxActivity.totalLuckyCount}"/>
                                            <span id="totalLuckyCountError" style="float: right;color: red;font-size: 1.2rem;"></span>
                                        </li>
                                        <li>
                                            <span>每轮中奖人数<a class="dataRequired">*</a></span>
                                            <input data-type="digits" id="everyLuckyCount" name="everyLuckyCount"
                                                   placeholder="请填写每轮中奖人数" data-required="true" value="${mtxActivity.everyLuckyCount}"/>
                                            <span id="everyLuckyCountError" style="float: right;color: red;font-size: 1.2rem;"></span>
                                        </li>
                                    </ul>
                                </div>
                            </c:if>

                            <c:if test="${mtxActivity.status == 'APP'}">
                                <div class="activity_kind">
                                    <p>活动照片</p>

                                    <li class="list">
                                        <div class="my-display-inline-box">
                                            <div id="activityImgContainer" class="row value">
                                                <c:forEach items="${attachmentList}" var="attachment">
                                                    <img src="${attachment.name}" alt="" style="margin-top: 3px;margin-left: 10px" onclick="viewBigImageForUpload(this)" data-toggle="modal" data-target=".bs-example-modal-lg-image">
                                                </c:forEach>
                                            </div>
                                            <c:if test="${fn:length(attachmentList) < 4}">
                                                <div id="activityImgUrlContainer" class="upload-btn-box" style="display: inline-block">
                                                    <input type="file" id="activityImg" name="picUrl" class="upload-btn pageUpload"
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
                                </div>
                            </c:if>
                        </form>
                    </div>
            </div>


                <c:if test="${mtxActivity.status == 'APP' && fn:length(attachmentList) < 4}">
                    <div class="fixsubmit">
                        <div><a href="javascript:uploadActivityImg()">上传图片</a></div>
                    </div>
                </c:if>
                <c:if test="${mtxActivity.status == 'PENDING' or mtxActivity.status == 'DRAWING'}">
                    <div class="fixsubmit">
                        <div><a href="javascript:submitActivityInfo()">保存</a></div>
                    </div>
                </c:if>


            <div class="choose" style="display: none">
                <div class="error">
                    <p id="Message"></p >
                    <button onclick="closeModel()">OK</button>
                </div>
            </div>

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




<script src="${ctx}/static/admin/js/jquery.min.js"></script>
<script type="text/javascript" src="${ctx}/static/admin/js/myScript.js"></script>
<script src="${ctx}/static/admin/js/lrz/dist/lrz.bundle.js"></script>
<script type="text/javascript">

    var Message = document.getElementById("Message");
    Message.innerHTML = "";

    function closeModel(){
        $(".choose").css("display","none");
    }

    window.onload = function(){
        showParticipants();

        if(${successMessage != null}){
            Message.innerHTML = "${successMessage}";
            $(".choose").css("display","block");
        }else if(${errorMessage != null}){
            Message.innerHTML = "${errorMessage}";
            $(".choose").css("display","block");
        }
    }


    $('.pageUpload').change(function () {
        if ($(".pageUpload").attr("readonly") == "readonly") {
            $("#notification_bar").css("width", "60%");
            $("#notification_bar").css("left", "20%");
            HC.showNotification("网络较慢，请耐心等待！", 2000);
        } else {
            compressUploadPicture(document.getElementById("activityImg"));
        }
    });

    function showParticipants(){
        var participantsUl = document.getElementById("participantsUl");
        var lis = participantsUl.getElementsByTagName("li");
        var img = document.getElementById("participantListImg");
        if(lis.length>4){
            for(var i=4;i<lis.length;i++) {
                if(lis[i].style.display == "none"){
                    lis[i].style.display = "flex";
                    img.className = "up";
                }else{
                    lis[i].style.display = "none";
                    img.className = "down";
                }
            }
        }

    }

    function checkCount(){
        var totalLuckyCountError = document.getElementById("totalLuckyCountError");
        totalLuckyCountError.innerHTML = "";
        var everyLuckyCountError = document.getElementById("everyLuckyCountError");
        everyLuckyCountError.innerHTML = "";

        var totalLuckyCount = $("#totalLuckyCount").val();
        var everyLuckyCount = $("#everyLuckyCount").val();

        var ul = document.getElementById("participantsUl");
        var inputs = ul.getElementsByTagName("input");
        var count = 0;
        if(inputs.length>0){
            for(var i=0;i<inputs.length;i++){
                if(inputs[i].checked) {
                    count ++;
                }
            }
        }

        //全选、全不选
        if(count == 0 || count == inputs.length){
            if(totalLuckyCount > inputs.length){
                totalLuckyCountError.innerHTML = "不能大于参与人数";
                return false;
            }
        }else{
            if(totalLuckyCount > count){
                totalLuckyCountError.innerHTML = "不能大于参与人数";
                return false;
            }
        }
        if(everyLuckyCount > totalLuckyCount){
            everyLuckyCountError.innerHTML = "不能大于中奖总数"
            return false;
        }
        return true;
    }


    function submitActivityInfo(){


        $("#participantFrm").parsley("validate");
        //表单合法 单价合法性
        if ($('#participantFrm').parsley().isValid() && checkCount()){

            var participantFrm = document.getElementById("participantFrm");
            participantFrm.action = "${ctx}/admin/wefamily/addParticipant?uuid=${mtxActivity.uuid}&versionno=${mtxActivity.versionno}&fromPhone=Y";
            participantFrm.submit();
        }
    }

    function uploadActivityImg(){
        $("#participantFrm").parsley("validate");
        //表单合法 单价合法性
        if ($('#participantFrm').parsley().isValid()){
            var participantFrm = document.getElementById("participantFrm");
            participantFrm.action = "${ctx}/admin/wefamily/uploadActivityImg?activityId=${mtxActivity.uuid}";
            participantFrm.submit();
        }
    }



    function checkParticipant(participantId){
        var checkBox = document.getElementById(participantId);
        if(checkBox.checked){
            checkBox.checked = true;
        }else{
            checkBox.checked = false;
        }
        var ul = document.getElementById("participantsUl");
        var inputs = ul.getElementsByTagName("input");
        var count = 0;
        if(inputs.length>0){
            for(var i=0;i<inputs.length;i++){
                if(inputs[i].checked) {
                    count ++;
                }
            }
        }
        /*var checkAllButton = document.getElementById("checkAllButton");

        if(count == inputs.length){
            checkAllButton.innerHTML = "全不选";
        }else{
            checkAllButton.innerHTML = "全选";
        }*/
    }

    function checkAllParticipant(){
        var ul = document.getElementById("participantsUl");
        var inputs = ul.getElementsByTagName("input");
        var ifCheck = "";
        var count = 0;
        if(inputs.length>0){
            for(var i=0;i<inputs.length;i++){
                if(!inputs[i].checked) {
                    ifCheck = "Y";
                }else{
                    count ++;
                }
            }
            if(ifCheck == "Y"){
                for(var i=0;i<inputs.length;i++){
                    inputs[i].checked = true;
                }
            }else{
                for(var i=0;i<inputs.length;i++){
                    inputs[i].checked = false;
                }
            }
        }

        /*var checkAllButton = document.getElementById("checkAllButton");

        if(count < inputs.length){
            checkAllButton.innerHTML = "全不选";
        }else if(count == inputs.length){
            checkAllButton.innerHTML = "全选";
        }*/

    }
</script>
</body>
</html>