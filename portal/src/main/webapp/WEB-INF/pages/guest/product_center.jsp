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
    <title>产品中心</title>
    <link rel="stylesheet" href="${ctx}/static/guest/css/common.css" type="text/css" />
    <style>
        .content .goods_list li {width:48%;background-color: #fff;border-radius:1rem;margin-bottom: 1.25rem;}
        .content .goods_list li:nth-child(odd){float: left;}
        .content .goods_list li:nth-child(even){float: right;}
        .content .goods_list li>a{display: block;text-align: center;padding: 1.25rem 1.25rem 0 1.25rem;}
        .content .goods_list li a img{width: 100%;display: block;padding-bottom: 0.5rem}
        .content .goods_list li a .goods_desword{height:3rem;border-bottom: 1px solid rgba(0,0,0,0.1);}
        .content .goods_list li a .goods_desword p{font-size: 1.2rem;color: #333;display: block;overflow: hidden;white-space: normal;text-overflow: ellipsis;margin: auto;display: -webkit-box;-webkit-line-clamp: 2;-webkit-box-orient: vertical;}
        .content .goods_list li a span:after{content: '...'}
        .content .goods_list .goods_action{font-size: 1.4rem;text-align: center;padding: 0.5rem 0;border-radius: 0 0rem 1rem 1rem;background-color: #fff;}
        .content .goods_list .goods_action a{display: inline-block;width: 45%;}
        .content .goods_list .goods_action a:nth-of-type(1){color: #5bbc4e;}
        /*.content .goods_list .goods_action a:nth-of-type(2){color: #faa83d}*/
    </style>
</head>
<body>
<div class="head">
    <a class="back" href=""></a>
    <span>产品中心</span>
    <img src="../../../static/guest/img/sao.png" alt="">
</div>
<div class="content">
    <ul class="goods_list">
        <c:forEach items="${mtxProductList}" var="mtxProduct">
        <li>
            <a href="${ctx}/guest/product_detail?uuid=${mtxProduct.uuid}">
                <img src="${mtxProduct.img}" alt="">
                <div class="goods_desword">
                    <p>${mtxProduct.model}${mtxProduct.name}</p>
                </div>
            </a>
            <div class="goods_action">
                <a href="${ctx}/guest/reserve?uuid=${mtxProduct.uuid}">
                    咨询购买
                </a>
            </div>
        </li>
        </c:forEach>
        <div class="clearfix"></div>
    </ul>
</div>
</body>
</html>