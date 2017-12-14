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
    <title>预订</title>
    <link rel="stylesheet" href="${ctx}/static/guest/css/common.css" type="text/css" />
    <style>
        .goods{ display: flex;display: -webkit-flex;justify-content: space-between;align-items: center;margin: 0 0 1.25rem 0;height: 8rem;background: #fff;padding: 1rem 2rem;box-sizing: border-box;color: #333}
        .goods>img{width: 5rem;height:5rem;}
        .goods>span{font-size: 1.6rem;}
        .list{background: #fff;}
        .list li{display: flex;display: -webkit-flex;justify-content: space-between;border-bottom: 1px solid rgba(0,0,0,0.1);padding: 1.17rem 2rem;}
        .list li>span{font-size: 1.6rem;color: #333}
        .list li>input{font-size: 1.4rem;color: #666;text-align: right;}
        .list li .address{text-align: right}
        .list li .address>select{font-size: 1.4rem;color: #666;text-align: right;width:30%}
    </style>
</head>
<body>
<div class="head">
    <a href="${ctx}/guest/product_center" class="back"></a>
    <span>预订</span>
</div>
<div class="goods">
    <img src="${mtxProduct.img}" alt="">
    <span>${mtxProduct.model}${mtxProduct.name}</span>
</div>
<form method="post" action="" id="searchForm">

<ul class="list">
    <li>
        <span>姓名</span>
        <input type="text" id="name" name="name" placeholder="请填写真实姓名">
    </li>
    <li>
        <span>电话</span>
        <input id="contactno" type="text" name="phone" placeholder="请填写真实号码">
    </li>
    <li>
        <span style="width: 17%">地区</span>
        <div class="address">
            <select name="province" id="s1"><option></option></select><!--插件-->
            <select name="city" id="s2"><option></option></select>
            <select name="district" id="s3"><option></option></select>
        </div>
    </li>
    <li>
        <span>详细地址</span>
        <input type="text" name="address" id="address" placeholder="请填写详细地址">
    </li>
    <li>
        <span>补充内容</span>
        <textarea  type="textarea" id="detail" placeholder="对本次预订的说明" style="height:4rem;text-align:right;color:#666;font-size: 1.4rem;"></textarea>
    </li>
</ul>
    <input type="text" name="productid" class="hidden" value="${mtxProduct.uuid}" style="display:none">
    <input  class="submit" onclick="submitForm()" value="提交">
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
    //去空格
    function trimText(obj){
        if(obj.value.length > 0){
            obj.value = obj.value.replace(/(^\s*)|(\s*$)/g, "");
        }
    }
    var contactnoError='';
    function isPoneAvailable() {
        trimText(document.getElementById('contactno'));
        var phone=document.getElementById("contactno").value;
        if(phone.length==0 || phone==undefined ||phone==null){
            return true;
        }else{
            var myreg=/^[1][3,4,5,7,8][0-9]{9}$/;
            if (!myreg.test(phone)) {
                return false;
            } else {
                return true;
            }
        }
    }
    setup();
    function promptinfo() {}
    //检查省市区是否合法
    var addressError ='';
    function checkIfValid() {
        var province = document.getElementById("s1").value;
        var city = document.getElementById("s2").value;
        var district = document.getElementById("s3").value;
        if (province === '省份' || city === '地级市' || district === '市、县级市、县') {
            return false;
        }else{
            return true;
        }
    }
    function  submitForm(){
        var nameError='';
        var name=document.getElementById("name").value;
        var phoneError='';
        var phone=document.getElementById("contactno").value;
        var addressDetailError='';
        var addressDetail=document.getElementById("address").value;
        if(name==''||name==null){
            nameError="姓名为必填！"
        }else{
            nameError="";
        }
        if(phone==''||phone==null){
            phoneError="手机号为必填！"
        }else{
            phoneError="";
        }
        if(addressDetail==''||addressDetail==null){
            addressDetailError="地址详情为必填！"
        }else{
            addressDetailError="";
        }
        if(checkIfValid()){
            addressError='';
        }else{
            addressError= '省份，地级市，市、县级市、县 均为必填项';
        }
        if(isPoneAvailable()){
            contactnoError='';
        }else{
            contactnoError= "请输入正确的手机号！";
        }
        if(nameError=='' &&phoneError==''&&addressDetailError==''&&addressError==''&&contactnoError==''){
            var searchForm = document.getElementById("searchForm");
            searchForm.action = "${ctx}/guest/reserve";
            searchForm.submit();
        }else{
            errorMessage.innerHTML="信息不完整或输入有误，请确认后重试！";
            $(".choose").css("display","block");
        }
    }
    function closeModel(){
        $(".choose").css("display","none");
    }
</script>
</html>