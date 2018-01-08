<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="C" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/layout/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>抽奖</title>
    <link rel="stylesheet" href="${ctx}/static/guest/css/activityStyle.css">
</head>
<body>
<div class='luck-back'>
    <div class="total-luck-content">
        <div class="total-user">
            <div class="total-user-title">
                <span>参加人员</span>
            </div>
            <ul class="man">
                <c:forEach items="${activityParticipantList}" var="participant">
                    <li><img src="${participant.headimg}" alt=""><span>${participant.nickname}</span></li>
                </c:forEach>
            </ul>
        </div>
    </div>
    <div class="luck-content ce-pack-end">
        <div id="luckuser" class="slotMachine">
            <div class="slot">
                <span class="name">姓名</span>
            </div>
        </div>
        <div class="luck-content-btn">
            <a id="start" class="start" onclick="start()">
                开始
            </a>
        </div>
        <div class="luck-user">
            <div class="luck-user-title">
                <span>中奖名单</span>
            </div>
            <ul class="luck-user-list" id="lucky"></ul>
            <div class="luck-user-btn">
                <a href="#">中奖人</a>
            </div>
        </div>
    </div>
</div>
<script src="${ctx}/static/admin/js/jquery.min.js"></script>
<script>
    window.onload=function(){
        <c:forEach items="${winList}" var="win">
        $('.luck-user-list').prepend("<li><div class='portrait' style='background-image:url(${win.headimg})'></div><div class='luckuserName'>${win.nickname}</div></li>");
        </c:forEach>
    }
    var uuid='${uuid}';
    //参与者
    var participartors = [
            <c:forEach items="${activityParticipantList}" var="participant">
                    {id:"${participant.userid}",image:"${participant.headimg}",phone:"${participant.nickname}"},
            </c:forEach>
        ];
    //中奖白名单
    var winners = [
        <c:forEach items="${luckyParticipantList}" var="lucky">
            {id:"${lucky.userid}",image:"${lucky.headimg}",phone:"${lucky.nickname}"},
        </c:forEach>
        ];


    var pcount = participartors.length-1;
    var wcount = winners.length-1;

    if(${fn:length(winList)==totalLuckyCount}){
        $('#start').text("抽奖完毕");
        $('#start').css('background-color','#999');
    }

    //提交获奖者，每抽中一个即请求一次
    function submitWinner(winnerId){
        // console.log("提交中奖者");
        $.post( "${ctx}/admin/wefamily/drawing?totalnumber="+Totalnumber+"&uuid="+uuid, {winnerId:winnerId});
    }

    $(function(){
        $(".man").slideUp();
        var length=$(".man").find("img").length;
        $(".total-user").css("height",(length-2)*60);
    })

</script>
<script src="${ctx}/static/guest/js/Luckdraw.js" type="text/javascript"></script>
<script src="${ctx}/static/guest/js/myslideup.js" type="text/javascript"></script>
</body>
</html>