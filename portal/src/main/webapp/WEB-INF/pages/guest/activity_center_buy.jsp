<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="C" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/layout/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>购机人名单</title>
    <style>

        *{-webkit-box-sizing: border-box; -moz-box-sizing: border-box; box-sizing: border-box;}
        html,body{padding: 0; margin: 0; font-family: 14px; font-family: "微软雅黑";}

        .luck-back{background-image: url(/static/guest/img/activityBack.jpg); background-size: cover; background-position: top center; position: absolute; height: 100%; width: 100%; color: #fff;}

        .luck-user-list>li{margin-top: 10px; position: relative;}

        .luck-user-btn>a{background: #f29807; width: 100%; line-height: 40px; display: block; border-radius: 5px; text-decoration: none; color: #fff;}
        .luck-user-btn>a:hover{background: #fcb842;}
        .luck-content-btn a{background: #f29807; width:150px; text-decoration: none; display: inline-block; color: #fff; text-align: center; margin: 0 10px; cursor: pointer;}
        .luck-content-btn a:hover{background: #fcb842; }
        .slotMachine .slot>span{position: absolute; bottom: 0; left: 0; line-height: 50px; text-decoration: center; background-color: rgba(0,0,0,.5); width: 100%;}

        ::-webkit-scrollbar{width: 10px;  height: 16px;  border-radius: 6px;}
        ::-webkit-scrollbar-track{border-radius:6px;  background-color: rgba(255,255,255,.2);}
        ::-webkit-scrollbar-thumb{border-radius: 6px;  background-color: #fff;}

        .man{list-style: none;margin:0;padding: 0;height: 90%;overflow-y: hidden;}
        .man li{margin: 10px;}
        .man li img{width: 60px;height:60px;border-radius: 60px;vertical-align: middle;}
        .man li span{vertical-align: middle;padding: 10px;vertical-align: middle;display: inline-block;width: 70%;}
        .total-user{position: absolute; left: 20px; top: 20px; bottom: 20px; width: 300px; background-color: rgba(255,255,255,.2); border-radius: 5px;overflow: hidden}
        .total-user-title span{width: 90%;display: block;text-align: center;line-height: 40px;left: 5%;color: #f5b43a;font-weight: bold;}
        .total-user-title::before{position: absolute; content: ""; top: 100%; left: 0; width: 100%; background:-webkit-linear-gradient(left,rgba(248,215,59,0),#f0d03a,rgba(248,215,59,0)); height:1px;}
        .total-user-title::after{position: absolute; content: ""; top: 0%; left: 0; width: 100%; background:-webkit-linear-gradient(left,rgba(248,215,59,0),#f0d03a,rgba(248,215,59,0)); height:1px;}
    </style>
</head>
<body>
<div class='luck-back'>
    <div class="total-luck-content" style="position: relative;width: 25%;padding: 20px;border-radius: 5px;margin: auto;text-align: center;">
        <div class="total-user">
            <div class="total-user-title">
                <span>购机人名单</span>
            </div>
            <ul class="man">
                <c:forEach items="${luckList}" var="participant">
                    <li><img src="${participant.headimg}" alt=""><span>${participant.nickname}</span></li>
                </c:forEach>
            </ul>
        </div>
    </div>
</div>
<script src="${ctx}/static/admin/js/jquery.min.js"></script>
<script>
    $(function(){
        $(".man").slideUp();
        var length=$(".man").find("img").length;
        $(".total-user").css("height",(length+1)*60);
    })
</script>
<script src="${ctx}/static/guest/js/myslideup.js" type="text/javascript"></script>
</body>
</html>