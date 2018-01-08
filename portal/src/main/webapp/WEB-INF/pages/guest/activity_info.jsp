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
    <link rel="stylesheet" href="${ctx}/static/guest/css/reviewMediaSwipebox.css" type="text/css" />
    <style>
        .content{background-color: #fff;margin-bottom: 3.67rem;}
        .title{font-size:1.6rem;color: #333;font-weight: bold;margin-bottom: 1.25rem;}
        .activity_kind>p{border-left: 4px solid #ff9933;padding-left: 1.25rem;color:#ff9933;font-size: 1.5rem;margin: 1.25rem 0;}
        .words_detail p{margin-bottom: 0.2rem;}
        .words_detail img{width: 2rem;vertical-align: middle;margin-right: 0.5rem;}
        .words_detail span {vertical-align: middle;font-size: 1.2rem;color: #333;}
        .edit img{width: 100%;margin-bottom: 1rem;}
        .edit p{color: #333;font-size: 1.4rem}
        .winner img,.partman img{
            width: 3.25rem;
            height: 3.25rem;
            display: block;
            margin: auto;
            margin-bottom: 0.5rem;
        }
        .winner li{
            width: 18%;
            display: inline-block;
            padding: 0.5rem 0 0.5rem 0rem;
            text-align: center;
        }
        .winner li span{
            color: #333;
            display: inline-block;
            height: 32px;
            overflow: hidden;
        }
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
        .chk:checked + label:after {content: '';position: absolute;top: 0.2rem;left: 0.2rem;width: 1.6rem;height:1.6rem;text-align: center;font-size: 1.4em;vertical-align: text-top;background-image: url(do.png);background-size: 1.6rem 1.6rem;background-repeat: no-repeat;}
        .words_detail .status_now{color: #66cc66;border-radius: 10px;border: 1px solid #66cc66;padding: 2px 8px;float: right;margin-top: 5px;}
        .modal-header .close{
            padding: 5px 10px !important;
        }
        .choose .error{
            left: 10%;
            width: 80%;
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
        #inviteCodeError,#contactnoError{
            color: red;font-size: 1.2rem;font-weight: lighter;margin-bottom: 25px !important;
        }
        #activityImgContainer{display: inline-block;vertical-align: middle}
        #activityImgUrlContainer{display: inline-block;vertical-align: middle;margin-left: 2rem}
        #activityImgContainer img{width: 64px;height: 64px;margin:1rem;max-width: none}
        .my-display-inline-box{width: auto}
    </style>
</head>
<body class="">
<section id="content" class="bg-white">
    <section class="vbox">
        <section class="scrollable padder">

            <div class="head">
                <a class="back" href="${ctx}/guest/activity_list"></a>
                <span>活动详情</span>
            </div>
            <div class="content">
                <p class="title">${mtxActivity.name}</p>
                <div class="activity_kind">
                    <p>活动信息</p>
                    <div class="words_detail">
                        <p><img src="../../../../static/guest/img/time.png" alt=""><span>${fn:substring(mtxActivity.startdate, 0,16 )}至${fn:substring(mtxActivity.enddate, 0,16 )}</span></p>
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
                                    <span>${winParticipant.nickname}</span>
                                </li>
                            </c:forEach>
                        </ul>
                    </div>
                </c:if>
                <div class="activity_kind">
                    <p>参加人员</p>
                    <ul class="partman">
                        <c:forEach items="${activityParticipantList}" var="activityParticipant">
                            <li>
                                <img src="${activityParticipant.headimg}" alt="">
                            </li>
                        </c:forEach>
                    </ul>
                </div>

                <c:if test="${fn:length(attachmentList) > 0}">
                    <div class="activity_kind">
                        <p>活动图片</p>
                        <li class="list">
                            <div class="my-display-inline-box">
                                <div id="activityImgContainer" class="row value">
                                    <c:forEach items="${attachmentList}" var="attachment">
                                        <a class="swipebox" href= "${attachment.name}" onclick="reviewMediaShow(this)">
                                            <img style="width:50px;height: 50px;margin-right:10px;"
                                                 src="${attachment.name}" alt="Bottle Closeup"/>
                                        </a>
                                    </c:forEach>
                                </div>
                            </div>
                        </li>
                    </div>
                </c:if>

            </div>


            <c:if test="${mtxActivity.status == 'PENDING'}">
                <c:choose>
                    <c:when test="${participanted == 'Y'}">
                        <div class="fixsubmit">已参加</div>
                    </c:when>
                    <c:otherwise>
                        <div class="fixsubmit" onclick="openParticipateDiv()">我要参加</div>
                    </c:otherwise>
                </c:choose>

            </c:if>

            <div class="choose" id="participantDiv" style="display: none">
                <div class="error">
                    <li>
                        <span>邀请码：</span>
                        <input type="text" id="inviteCode" name="inviteCode"
                               data-required="true"  data-maxlength="32" placeholder="请填写邀请码"/>

                    </li>
                    <li>
                        <span>姓&nbsp;&nbsp;&nbsp;名：</span>
                        <input type="text" id="name" name="name" value="${wpUser.name}"
                               data-required="true"  data-maxlength="32" placeholder="请填写姓名"/>
                    </li>
                    <li>
                        <span>手&nbsp;&nbsp;&nbsp;机：</span>
                        <input type="number" id="contactno" name="contactno" value="${wpUser.contactno}"
                               data-required="true"  data-maxlength="11" placeholder="请填写手机"/>
                    </li>
                    <li>
                        <span id="inviteCodeError"></span>
                        <span id="contactnoError"></span>
                    </li>

                    <button onclick="participateActivity()">参加</button>



                </div>
            </div>

            <div class="choose" id="Msg" style="display: none">
                <div class="error">
                    <img src="${ctx}/static/guest/img/mtx.jpg" style="display: none" id="public"/>
                    <p id="errorMessage"></p >
                    <button onclick="closeModel()">我知道了</button>
                </div>
            </div>


        </section>
    </section>
</section>
</body>
<script src="${ctx}/static/admin/js/jquery.min.js"></script>
<script type="text/javascript" src="${ctx}/static/js/reviewMediaJquery.swipebox.js"></script>
<script type="text/javascript">

    function openParticipateDiv(){
        var errorMessage = document.getElementById("errorMessage");
        errorMessage.innerHTML = "";

        if('${wpUser.ifsubscribe}' != 'Y'){
            $("#Msg").css("display","block");
            $("#public").css("display","block");
            errorMessage.innerHTML = "请先关注公众号！"
        }else{
            $("#participantDiv").css("display","block");
        }
    }

    function closeModel(){
        $("#Msg").css("display","none");
    }

    function reviewMediaShow(obj){
        var reviewMediaClass = $(obj).attr("class");
        $( '.'+reviewMediaClass+'' ).swipebox();
    }
    $( '.swipebox-video' ).swipebox();

    function participateActivity(){
        var inviteCodeError = document.getElementById("inviteCodeError");
        inviteCodeError.innerHTML = "";
        var contactnoError = document.getElementById("contactnoError");
        contactnoError.innerHTML = "";

        var inviteCode = $("#inviteCode").val();
        var name = $("#name").val();
        var contactno = $("#contactno").val();


        if(inviteCode != '${mtxActivity.password}'){
            inviteCodeError.innerHTML = "邀请码错误";
        }else if(contactno.length!=11){
            contactnoError.innerHTML = "手机号有误";
        }else if(inviteCode.length > 0 && name.length > 0){

            window.location.href="${ctx}/guest/participateActivity?activityId=${mtxActivity.uuid}&name="+name+"&contactno="+contactno;

            $("#participantDiv").css("display","none");
        }

    }

</script>

</html>