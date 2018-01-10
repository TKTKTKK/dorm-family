<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/layout/taglib.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <meta name="apple-mobile-web-app-capable" content="yes"><!-- 删除默认的苹果工具栏和菜单栏。 -->
    <meta name="apple-mobile-web-app-status-bar-style" content="black"><!-- 控制状态栏显示样式 -->
    <meta name="format-detection" content="telephone=no"><!-- 禁止了把数字转化为拨号链接 -->
    <meta http-equiv="x-dns-prefetch-control" content="on"><!-- 浏览器开启预解析功能 -->
    <title>配件中心</title>
    <link rel="stylesheet" href="${ctx}/static/guest/css/common.css" type="text/css" />
    <link rel="stylesheet" href="${ctx}/static/guest/css/reviewMediaSwipebox.css" type="text/css" />
    <style>
        .parts_num{background-color: rgba(91,188,78,0.4);height: 4.5rem;padding:1rem;box-sizing: border-box;display: -webkit-flex;display: flex;justify-content: space-around;}
        .parts_num span {color: #fff;font-size: 1.5rem;vertical-align: middle;line-height: 2.5rem}
        .parts_num input{vertical-align: middle;width: 12rem;font-size: 1.7rem;border-radius: 1rem;text-align: center;color: #333;box-shadow: 0px 0px 5px 0 rgba(0,0,0,0.75) inset;}
        .goods_info{background-color: #fff}
        .goods_info .info_name{font-size: 1.5rem;padding: 0.7rem 2.1rem;color: #333;}
        .goods_info .info_name p{padding: 0.8rem 0}
        .goods_info .info_name hr{height: 1px;border:none;border-top:1px dashed rgba(0,0,0,0.1);margin: 0.7rem;}
        .parts_img li{width: 30%;display: inline-block;margin: 1%;}
        .parts_img li img{width: 100%}
        .spanid{background:#5bbc4e;border-radius: 0.5rem ;width: 5rem;text-align: center;}
        p input{font-size: 1.5rem;}
    </style>
</head>
<body>
<div class="choose" id="imgDiv" style="z-index: 10;background: rgba(0,0,0,0.7);display: none"><img src="../../../static/guest/img/help.png" alt="" onclick="closeImg()" style="width: 100%"></div>
<div class="choose" id="moneyDiv" style="z-index: 10;background: rgba(0,0,0,0.7);display: none"><img src="../../../static/guest/img/erweima.jpg" alt="" onclick="closeImg()" style="width: 100%"></div>
<div class="head">
    <span>配件中心</span>
    <img src="../../../static/guest/img/sao.png" alt="" onclick="scan()">
</div>
<form action="" method="post" id="frm">
<div class="parts_num">
    <span>手动输入配件号</span>
    <input type="text" id="code" name="code" value="${code}">
    <span class="spanid" onclick="searchParts()">查询</span>
</div>
</form>
<div style="text-align: center;margin-top: 50px;font-size: 1.6rem" id="msg">
    <span>请输入配件编号进行查询。</span></br>
    <span>因物流、地域差异，查询数据仅供参考。</span>
</div>
<div class="content" style="display: none">
    <div class="goods_info">
        <div class="info_name">
            <p style="text-align: center;"><input id="machinename" style="text-align: center;" type="text" value="${partsCenter.machinename}"/></p>
            <hr>
            <form action="" method="post" id="form">
            <p>物料编码：<input type="text" name="code" id="material_code" value="${partsCenter.machineno}"/></p>
            </form>
            <p>零售价：<input type="text" id="price" value="${partsCenter.price}${partsCenter.format}"/></p>
            <p>适用机型：<input type="text" id="fitmodel" value="${partsCenter.machinemodel}"/></p>
            <p>说明书版本：<input type="text" id="instruction" value="${partsCenter.instruction}"/> </p>
            <hr>
            <c:if test="${fn:length(attachmentList)>0}">
            <div id="imgid">
                <p>配件图片</p>
                    <ul class="parts_img">
                        <c:forEach items="${attachmentList}" var="attachment">
                            <a class="swipebox" id="swipebox" href= "${attachment.name}" onclick="reviewMediaShow(this)">
                                <li><img src="${attachment.name}" alt=""></li>
                            </a>
                        </c:forEach>
                    </ul>
            </div>
            </c:if>
        </div>
    </div>
</div>
<a  class="fixsubmit" onclick="validDate()">购买</a>
<div class="choose" id="chooseClose" style="display: none">
    <div class="error">
        <p id="errorMessage"></p >
        <button onclick="closeModel()">我知道了</button>
    </div>
</div>
</body>
<script src="${ctx}/static/admin/js/jquery.min.js"></script>
<script src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script src="${ctx}/static/js/wechatUtil.js?20171201"></script>
<script type="text/javascript" src="${ctx}/static/js/reviewMediaJquery.swipebox.js"></script>
<script type="text/javascript">
    var errorMessage = document.getElementById("errorMessage");
    errorMessage.innerHTML = "";
    window.onload=function (){
        if('${Flag}'=='1'){
            closeImg();
            $("#msg").css("display","none");
        }
        var codevalue=$("#code").val();
        if(codevalue==''||codevalue==null){
            $("#imgDiv").css("display","block");
        }
        if('${Flag}'=='0'){
            closeImg();
            $("#msg").css("display","none");
            errorMessage.innerHTML="对不起，配件不存在！";
            $("#chooseClose").css("display","block");
        }
        if(${partsCenter!=null}){
            $(".content").css("display","block");
            $("#imgid").css("display","block");
        }
    }
    function closeImg(){
        $("#imgDiv").css("display","none");
        $("#moneyDiv").css("display","none");
    }
    function searchParts(){
        $("#msg").css("display","none");
        var code=$("#code").val();
        if(code!=null&&code!=''){
            var searchForm = document.getElementById("frm");
            searchForm.action = "${ctx}/guest/parts_center";
            searchForm.submit();
        }else{
            errorMessage.innerHTML="配件号不能为空！";
            $("#chooseClose").css("display","block");
        }
    }
    function searchPartsAuto(){
        if(code!=null&&code!=''){
            var searchForm = document.getElementById("form");
            searchForm.action = "${ctx}/guest/parts_center";
            searchForm.submit();
        }else{
            errorMessage.innerHTML="配件号不能为空！";
            $("#chooseClose").css("display","block");
        }
    }
    function closeModel(){
        $("#chooseClose").css("display","none");
        $("#moneyDiv").css("display","none");
    }
    function scan(){
        wechatUtil.scanQRCode({
                    success : function(res){
                        var paramArr = wechatUtil.handleScanResult(res.resultStr);
                        $("#imgDiv").css("display","none");
                        $(".content").css("display","block");
                        $("#imgid").css("display","none");
                        $("#code").val('');
                        $("#material_code").val(paramArr[0]);
                        $("#machinename").val(paramArr[1]);
                        $("#price").val(paramArr[2]);
                        $("#fitmodel").val(paramArr[3]);
                        $("#instruction").val(paramArr[4]);
                        $.post("${ctx}/guest/getMtxParts?code="+$("#material_code").val(),function(data){
                            if(data.machine){
                                $("#imgid").css("display","block");
                                $("#imgDiv").css("display","none");
                                searchPartsAuto();
                            }
                        });
                    }
                }
        );
    }
    function validDate(){
        var material_code=$("#material_code").val();
        if(material_code!=null &&material_code!=''){
            $("#moneyDiv").css("display","block");
        }else{
            errorMessage.innerHTML="请选择配件！";
            $("#chooseClose").css("display","block");
        }
    }

    function reviewMediaShow(obj){
        var reviewMediaClass = $(obj).attr("class");
        $( '.'+reviewMediaClass+'' ).swipebox();
    }
    $( '.swipebox-video' ).swipebox();

</script>
</html>