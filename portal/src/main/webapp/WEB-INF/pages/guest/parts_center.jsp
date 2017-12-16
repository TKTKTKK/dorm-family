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
<div class="choose" id="imgDiv" style="z-index: 10;background: rgba(0,0,0,0.7);"><img src="../../../static/guest/img/help.png" alt="" onclick="closeImg()" style="width: 100%"></div>
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
<div class="content">
    <div class="goods_info">
        <div class="info_name">
            <p style="text-align: center;"><input id="machinename" style="text-align: center;" type="text" value="${partsCenter.machinename}"/></p>
            <hr>
            <p>物料编码：<input type="text" id="material_code" value="${partsCenter.machineno}"/></p>
            <p>零售价：<input type="text" id="price" value="${partsCenter.price}${partsCenter.format}"/></p>
            <p>适用机型：<input type="text" id="fitmodel" value="${partsCenter.machinemodel}"/></p>
            <p>产地：<input type="text" id="address" value="${partsCenter.address}"/> </p>
            <input type="text" id="uuid" value="${partsCenter.uuid}" style="display: none"/>
            <hr>
            <p>配件图片</p>
            <ul class="parts_img">
                <c:forEach items="${attachmentList}" var="attachment">
                <li><img src="${attachment.name}" alt=""></li>
                </c:forEach>
            </ul>
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
<script type="text/javascript">
    var errorMessage = document.getElementById("errorMessage");
    errorMessage.innerHTML = "";
    window.onload=function (){
        if('${Flag}'=='1'){
            closeImg();
        }
    }
    function closeImg(){
        $("#imgDiv").css("display","none");
    }
    function searchParts(){
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
    function closeModel(){
        $("#chooseClose").css("display","none");
    }
    function scan(){
        wechatUtil.scanQRCode({
                    success : function(res){
                        var paramArr = wechatUtil.handleScanResult(res.resultStr);
                        $("#code").val(paramArr[0]);
                        $("#material_code").val(paramArr[0]);
                        $("#machinename").val(paramArr[1]);
                        $("#price").val(paramArr[2]);
                        $("#fitmodel").val(paramArr[3]);
                        $("#address").val(paramArr[4]);
                        $.post("${ctx}/admin/wefamily/getMtxParts?code="+$("#material_code").val(),function(data){
                            if(data.machine){
                                searchParts();
                            }
                        });
                    }
                }
        );
    }
    function validDate(){
        var uuid=$("#uuid").val();
        if(uuid!=null &&uuid!=''){

        }else{
            errorMessage.innerHTML="请选择配件！";
            $("#chooseClose").css("display","block");
        }
    }
</script>
</html>