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
    <title>注册</title>
    <link rel="stylesheet" href="${ctx}/static/guest/css/common.css" type="text/css" />
    <style>
        .list{background: #fff;margin-top:1.25rem;margin-bottom: 4rem;}
        .list li{display: flex;display: -webkit-flex;justify-content: space-between;border-bottom: 1px solid rgba(0,0,0,0.1);padding: 1.17rem 2rem;}
        .list li>span:nth-of-type(1){font-size: 1.6rem;color: #333}
        .list li>input,.list li>span:nth-of-type(2){font-size: 1.4rem;color: #666;text-align: right;}
        .list li .address{text-align: right}
        .list li .address>select{font-size: 1.4rem;color: #666;text-align: right;width:30%}
        .head .finish{color: #fff;font-size: 1.4rem;}
    </style>
</head>
<body>
<div class="choose" id="imgDiv" style="z-index: 10;background: rgba(0,0,0,0.7);"><img src="../../../static/guest/img/help.png" alt="" onclick="closeImg()" style="width: 100%"></div>
<div class="head">
    <span>注册</span>
    <img src="../../../static/guest/img/sao.png" alt="" onclick="scan()">
</div>
<form method="post" action="" id="searchForm">
<ul class="list">
    <li>
        <span>姓名</span>
        <input type="text" name="name" id="name" value="${wpUser.name}" placeholder="请填写真实姓名" >
    </li>
    <li>
        <span>电话</span>
        <input type="text" name="contactno" id="contactno" value="${wpUser.contactno}" placeholder="请填写真实号码">
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
        <input type="text" name="address" id="address" value="${wpUser.address}" placeholder="请填写详细地址">
    </li>
    <li>
        <span>机器型号</span>
        <input type="text" id="machinemodel" name="machinemodel" value="${machine.machinemodel}" placeholder="请填写机器型号">
    </li>
    <li>
        <span>机器名称</span>
        <input type="text" id="machinename" name="machinename" value="${machine.machinename}" placeholder="请填写机器名称">
    </li>
    <li>
        <span>机器号</span>
        <input type="text" id="machineno" name="machineno" value="${machine.machineno}" placeholder="请填写机器号">
    </li>
    <li>
        <span>发动机号</span>
        <input type="text" id="machinengine" name="engineno" value="${machine.engineno}" placeholder="请填写发动机号">
    </li>
</ul>
    <span  class="fixsubmit" onclick="submitForm()">注册</span>
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
<script src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script src="${ctx}/static/js/wechatUtil.js?20171201"></script>
<script type="text/javascript">
    var errorMessage = document.getElementById("errorMessage");
    errorMessage.innerHTML = "";
    window.onload=function (){
        var message='${ErrorMessage}';
        if(message.length>0 &&message!=null&& message!='')
        {
            errorMessage.innerHTML=message;
            $(".choose").css("display","block");
            $("#imgDiv").css("display","none");
        }
    }
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
    if (('${wpUser.province}'.length > 0 && '${wpUser.city}'.length > 0 && '${wpUser.district}'.length > 0)) {
        var s1Slt = document.getElementById('s1');
        var s2Slt = document.getElementById('s2');
        var s3Slt = document.getElementById('s3');
        s1Slt.value = '${wpUser.province}';
        change(1);
        if ('${wpUser.address}'.length <= 0) {
            promptinfo();
        }
        s2Slt.value = '${wpUser.city}';
        change(2);
        if ('${wpUser.address}'.length <= 0) {
            promptinfo();
        }
        s3Slt.value = '${wpUser.district}';
        if ('${wpUser.address}'.length <= 0) {
            promptinfo();
        }
        if ('${wpUser.address}'.length > 0) {
            var address = document.getElementById('address');
            address.value = '${wpUser.address}';
        }
    }
    promptinfo();
    function promptinfo() {
        var address = document.getElementById('address');
        var s1 = document.getElementById('s1');
        var s2 = document.getElementById('s2');
        var s3 = document.getElementById('s3');
        address.value = s1.value + s2.value + s3.value;
    }
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
        var machinemodelError='';
        var machinemodel=document.getElementById("machinemodel").value;
        var machinenameError='';
        var machinename=document.getElementById("machinename").value;
        var machinProductError='';
        var machineno=document.getElementById("machineno").value;
        var machinengineError='';
        var machinengine=document.getElementById("machinengine").value;
        if(name==''||name==null){
            nameError="姓名为必填！"
        }else{
            nameError="";
        }
        if(machinemodel==''||machinemodel==null){
            machinemodelError="机器型号为必填！"
        }else{
            machinemodelError="";
        }
        if(machinename==''||machinename==null){
            machinenameError="机器名称为必填！"
        }else{
            machinenameError="";
        }
        if(machineno==''||machineno==null){
            machinProductError="机器号为必填！"
        }else{
            machinProductError="";
        }
        if(machinengine==''||machinengine==null){
            machinengineError="发动机号为必填！"
        }else{
            machinengineError="";
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
        if(nameError=='' &&phoneError==''&&addressDetailError==''&&addressError==''&&contactnoError==''&&machinemodelError==''&&machinenameError==''&&machinProductError==''&&machinengineError==''){
            var searchForm = document.getElementById("searchForm");
            searchForm.action = "${ctx}/guest/register";
            searchForm.submit();
        }else if(isPoneAvailable()){
            errorMessage.innerHTML="信息输入不完整！";
            $(".choose").css("display","block");
            $("#imgDiv").css("display","none");
        }
        else{
            errorMessage.innerHTML="手机号输入不正确！";
            $(".choose").css("display","block");
            $("#imgDiv").css("display","none");
        }
    }
    function closeModel(){
        $(".choose").css("display","none");
    }
    function closeImg(){
        $("#imgDiv").css("display","none");
    }

    function scan(){
        wechatUtil.scanQRCode({
                    success : function(res){
                        var paramArr = wechatUtil.handleScanResult(res.resultStr);
                        $("#machinemodel").val(paramArr[0]);
                        $("#machinename").val(paramArr[1]);
                        $("#machineno").val(paramArr[2]);
                        $("#engineno").val(paramArr[3]);
                    }
                }
        );
    }
</script>
</html>