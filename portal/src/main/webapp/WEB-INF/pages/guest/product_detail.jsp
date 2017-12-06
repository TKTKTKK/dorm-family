<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
    <title>产品详情</title>
    <link rel="stylesheet" href="${ctx}/static/guest/css/common.css" type="text/css" />
    <style>
        .parm{background: #fff;padding:1.25rem;color: #333;font-size: 1.4rem;}
        .parm>p{border-bottom: 1px solid rgba(0,0,0,0.1);font-size: 1.4rem;display: block;height: 3.35rem;line-height: 3.35rem;margin-bottom: 1rem;}
        .parm p span{border-bottom:2px solid #faa83d;padding-bottom: 0.7rem;color: #faa83d;font-size: 1.5rem;}
        .parm .detail>img{width: 100%}
        .goods_parm{display: flex;display: -webkit-flex;justify-content: space-around;align-items: center;}
        .goods_parm img{width: 10rem;height:10rem;display: inline-block;vertical-align: middle;}
        .goods_parm	.parm_list{display: inline-block;vertical-align: middle;}
        .goods_parm	.parm_list li{margin:1rem 0;}
        .goods_parm	.parm_list li:nth-last-child{margin-bottom:0;}
    </style>
</head>
<body>
<div class="head">
    <a href="${ctx}/guest/product_center" class="back"></a>
    <span>产品详情</span>
</div>
<div class="parm">
    <p>
        <span>产品参数</span>
    </p>
    <div class="goods_parm">
        <img src="${mtxProduct.img}" alt="">
        <ul class="parm_list">
            <li><span>产品型式：</span><span>${mtxProduct.name}</span></li>
            <li><span>产品型号：</span><span>${mtxProduct.model}</span></li>
            <!-- 				<li><span>工作行数：</span><span>6</span></li>
                            <li><span>标准功率：</span><span>3.3KW3600n/min</span></li> -->
        </ul>
    </div>
    <p>
        <span>产品详情</span>
    </p>
    <div class="detail">${mtxProduct.detail}</div>

</div>
</body>
</html>