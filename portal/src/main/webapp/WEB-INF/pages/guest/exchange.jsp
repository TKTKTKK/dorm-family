<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="/WEB-INF/layout/taglib.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="format-detection" content="telephone=no">
    <meta http-equiv="x-dns-prefetch-control" content="on">
    <title>兑换</title>
    <link rel="stylesheet" href="${ctx}/static/guest/css/common.css" type="text/css" />
    <style>
        .goods>img{width: 5rem;height:5rem;}
        .goods>span{font-size: 1.6rem;}
        .list{background: #fff;}
        .list li{display: flex;display: -webkit-flex;justify-content: space-between;border-bottom: 1px solid rgba(0,0,0,0.1);padding: 1.17rem 2rem;}
        .list li>span{font-size: 1.6rem;color: #333}
        .list li>input{font-size: 1.4rem;color: #666;text-align: right;}
        .list li .address>select{font-size: 1.4rem;color: #666;text-align: right;}
        .goods_parm{display: flex;display: -webkit-flex;justify-content: space-around;align-items: center;}
        .goods_parm img{width: 10rem;height:10rem;display: inline-block;vertical-align: middle;}
        .goods_parm	.parm_list{display: inline-block;vertical-align: middle;}
        .goods_parm	.parm_list li{margin:1rem 0;}
        .goods_parm	.parm_list li:nth-last-child{margin-bottom:0;}
        .parm{background: #fff;padding:1.25rem;color: #333;font-size: 1.4rem;}
        .parm>p{border-bottom: 1px solid rgba(0,0,0,0.1);font-size: 1.4rem;display: block;height: 3.35rem;line-height: 3.35rem;margin-bottom: 1rem;}
        .parm p span{border-bottom:2px solid #faa83d;padding-bottom: 0.7rem;color: #faa83d;font-size: 1.5rem;}
        .parm .detail>img{width: 100%}

    </style>
</head>
<body>
<div class="head">
    <a href="${ctx}/guest/member/good_exchange" class="back"></a>
    <span>兑换</span>
</div>
<div class="parm">
    <p>
        <span>商品详情</span>
    </p>
    <div class="goods_parm">
        <img src="${mtxProduct.img}" alt="">
        <ul class="parm_list">
            <li><span>名称:</span><span>${mtxProduct.name}</span></li>
            <li><span>所需积分:</span><span>${mtxProduct.points}</span></li>
        </ul>
    </div>
</div>
<form method="post" action="" id="searchForm">
<ul class="list">
    <li>
        <span>购买数量</span>
        <input type="number" id="count" name="count" value="${mMtxExchangeRecord.count}" placeholder="请输入数量(必填)">
    </li>
    <li>
        <span>送货地址</span>
        <div class="address">
            <select name="address">
                <option value="">全部</option>
                <c:forEach var="merchant" items="${merchantList}">
                    <option value="${merchant}">${merchant}</option>
                </c:forEach>
            </select>
        </div>
    </li>
    <li>
        <span>补充内容</span>
        <textarea  type="textarea" name="detail" id="detail" value="${mMtxExchangeRecord.detail}" placeholder="对本次兑换的说明" style="height:4rem;text-align:right;color:#666;font-size: 1.4rem;"></textarea>
    </li>
</ul>
    <input type="text" name="productid" class="hidden" value="${mtxProduct.uuid}" style="display:none">
    <input  class="fixsubmit" onclick="submitForm()" value="兑换">
</form>
<div class="choose" style="display: none">
    <div class="error">
        <p id="errorMessage"></p >
        <button onclick="closeModel()">我知道了</button>
    </div>
</div>
</body>
<script src="${ctx}/static/admin/js/jquery.min.js"></script>
<script type="text/javascript" src="${ctx}/static/admin/geo.js"></script>
<script type="text/javascript">
    var errorMessage = document.getElementById("errorMessage");
    errorMessage.innerHTML = "";
    window.onload=function (){
        var message='${message}';
        if(message!=null&&message!=''){
            errorMessage.innerHTML=message;
            $(".choose").css("display","block");
        }
    }
    function  submitForm(){
        var count=document.getElementById("count").value;
        var address=$("select[name='address'] option:selected").val();
        var detail=document.getElementById("detail").value;
        if(count!=null&&count!=''&&address!=null&&address!=''&&detail!=null&&detail!=''){
            if(count.length>6){
                errorMessage.innerHTML="购买数量过多！";
                $(".choose").css("display","block");
            }else{
                var searchForm = document.getElementById("searchForm");
                searchForm.action = "${ctx}/guest/exchange";
                searchForm.submit();
            }
        }else{
            errorMessage.innerHTML="信息不完整或输入有误！";
            $(".choose").css("display","block");
        }
    }
    function closeModel(){
        $(".choose").css("display","none");
    }
</script>
</html>