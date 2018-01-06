<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/layout/taglib.jsp" %>
<!DOCTYPE html>
<html lang="en" class="app">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="format-detection" content="telephone=no">
    <meta http-equiv="x-dns-prefetch-control" content="on">
    <title><c:if test="${qualityMgmt.type == 'REPAIR'}">报修</c:if><c:if test="${qualityMgmt.type == 'MAINTAIN'}">保养</c:if>详情</title>
    <link rel="stylesheet" href="${ctx}/static/guest/css/common.css" type="text/css" />
    <link rel="stylesheet" href="${ctx}/static/guest/css/reviewMediaSwipebox.css" type="text/css" />
    <style>
        .goal_total{padding-left: 1.25rem;border-bottom: 1px solid rgba(0,0,0,0.1);font-size: 1.6rem;color: #333;background-color: #fff;position: relative;padding: 1.17rem 2rem 1.17rem 1.25rem;margin-top: 1rem;}
        .goal_total:nth-of-type(even) span{border-left: 4px solid #ff9933;padding-left: 1.25rem;}
        .goal_total:nth-of-type(odd) span {border-left: 4px solid #5bbc4e;padding-left: 1.25rem;}
        .goal_total img{float: right;right: 1.25rem;position: absolute;width: 1rem;height: 1.6rem;top:1.2rem;}
        .list{background: #fff;}
        .list li{justify-content: space-between;border-bottom: 1px solid rgba(0,0,0,0.1);padding: 1.17rem 2rem;}
        /*.list li:nth-last-of-type(1){border:0;}*/
         /*li:nth-last-child(2){border:0}*/
        .list:nth-last-of-type(1){margin-bottom:4rem;}
        .list li span:nth-of-type(1){font-size: 1.6rem;color: #333}
        .list li span:nth-of-type(2){font-size: 1.6rem;color: #666}
        .list li>input{font-size: 1.6rem;color: #666;text-align: right;float: right;}
        .list li .address{display: table;}
        .list li .address>select{font-size: 1.4rem;color: #666;}
        .list li>.focus{height: 4rem;color: #666;font-size: 0.14rem;}
        .list:nth-of-type(3) li span{color: #666}
        .list li select{font-size: 1.4rem;color: #666;float: right}
        /*箭头朝下*/
        .down{transform: rotate(90deg);}
        /*箭头朝上*/
        .up{transform: rotate(-90deg);}

        label {background-color: #FFF;border: 1px solid #66cc66;padding: 1rem;border-radius: 5px;display: inline-block;position: relative;margin-right: 8px;vertical-align: middle;}
        .chk:checked + label {border: 1px solid #66cc66;}
        .chk:checked + label:after {content: '';position: absolute;top: 0.2rem;left: 0.2rem;width: 1.6rem;height:1.6rem;text-align: center;font-size: 1.4em;vertical-align: text-top;background-image: url("../../../../static/admin/img/do.png");background-size: 1.6rem 1.6rem;background-repeat: no-repeat;}
        .upload-btn-box {
            clear: both;
            background: #fff url("../../../../static/admin/img/upload.gif") center center no-repeat;
            background-size: 61px 61px;
            border: 1px solid #cfcfcf;
            border-radius: 1px;
            width: 64px;
            height: 64px;
            color: #b9b9b9;
            text-align: center;
            margin-bottom: 10px;
            position: relative;
        }
        .upload-btn-box .upload-btn {
            opacity: 0;
            position: absolute;
            width: 64px;
            height: 64px;
            z-index: 1;
            left: 0;
            top: 0;
        }
        .dataRequired{
            color: red;
        }
        #reporterImgContainer{display: inline-block;vertical-align: middle}
        #reporterImgContainer img{width: 5rem;height: 5rem;margin:1rem}
        #qualityMgmtImgContainer{display: inline-block;vertical-align: middle}
        #qualityMgmtImgUrlContainer{display: inline-block;vertical-align: middle;margin-left: 2rem}
        #qualityMgmtImgContainer img{width: 4.5rem;height: 4.5rem;margin:1rem}
        .my-display-inline-box{width: auto}
        .required{padding: 0 !important;border: 0 !important;color: tomato;text-align: right;}
        .maxlength{padding: 0 !important;border: 0 !important;color: tomato;text-align: right;}
        .fixsubmit{background-color: none;display: flex;display: -webkit-flex}
        .fixsubmit>a:nth-of-type(1){left: 0;background: #5bbc4e;width: 100%;color: white}
    </style>
</head>
<body>
    <div class="head">
        <c:if test="${qualityMgmt.type == 'REPAIR'}">
            <a class="back" href="${ctx}/guest/member/repair_list"></a>
            <span>报修详情</span>
        </c:if>
        <c:if test="${qualityMgmt.type == 'MAINTAIN'}">
            <a class="back" href="${ctx}/guest/member/maintain_list"></a>
            <span>保养详情</span>
        </c:if>
    </div>
            <div class="goal_total" style="margin-top: 0px">
                    <span>主机信息</span>
                    <img src="../../../../static/guest/img/list.png" alt="" id="machineListImg" class="up">
            </div>
            <ul class="list" id="machineUl">
                <li>
                    <span>机器型号</span>
                    <input type="text" id="machinemodel" name="machinemodel" value="${qualityMgmt.machinemodel}"
                           data-required="true"  data-maxlength="32" readonly/>
                </li>
                <li>
                    <span>机器号</span>
                    <input type="text" id="machineno" name="machineno" value="${qualityMgmt.machineno}"
                           data-required="true"  data-maxlength="32" readonly/>
                </li>
            </ul>
            <div class="goal_total">
                    <span>现场情况</span>
                    <img src="../../../../static/guest/img/list.png" alt="" id="situationListImg" class="up">
            </div>
            <ul class="list" id="situationUl" style="margin-bottom: 0px;">
                <li>
                    <span><c:if test="${qualityMgmt.type == 'REPAIR'}">维修</c:if><c:if test="${qualityMgmt.type == 'MAINTAIN'}">保养</c:if>日期</span>
                    <input class="Wdate" type="text" name="servicedt" id="servicedt" onClick="WdatePicker()"
                           value="${qualityMgmt.servicedt}"  data-required="true" data-maxlength="23" disabled>
                </li>
                <li>
                    <span>收费金额</span>
                    <input name="price" id="price" value="${qualityMgmt.price}" size="24"
                           data-maxlength="10" readonly>
                    <span id="priceError" class="text-danger" style="float: right;color: red;font-size: 1.2rem;"></span>
                </li>
            </ul>
            <form class="form-horizontal" data-validate="parsley"
                      action="" method="POST" id="frm">
                <c:if test="${qualityMgmt.status == 'FINISH'}">
                    <div class="goal_total">
                        <span>评价</span>
                        <img src="../../../../static/guest/img/list.png" alt="" id="situationListImg" class="up">
                    </div>
                    <ul class="list">
                        <li>
                            <span>用户评价</span>
                            <select name="evaluate" id="evaluate">
                                <c:set var="commonCodeList" value="${web:queryCommonCodeList('REPAIR_EVALUATE')}"></c:set>
                                <option value="">请选择</option>
                                <c:forEach items="${commonCodeList}" var="commonCode">
                                    <option value="${commonCode.code}" <c:if test="${qualityMgmt.evaluate == commonCode.code}">selected</c:if>>${commonCode.codevalue}</option>
                                </c:forEach>
                            </select>
                        </li>
                        <li style="display: flex;display: -webkit-flex;">
                            <span style="vertical-align: middle;">备注</span>
                    <textarea rows="4" name="evaluateremarks" id="evaluateremarks" data-maxlength="256"
                              style=" width: 16rem;vertical-align: middle;text-align: right">${qualityMgmt.evaluateremarks}</textarea>
                        </li>
                    </ul>

                </c:if>


            <input type="hidden" name="uuid" class="form-control" value="${qualityMgmt.uuid}">
            <input type="hidden" name="versionno" class="form-control"
                   value="${qualityMgmt.versionno}">
            <input type="hidden" name="workerid" value="${workerList[0].uuid}">
            <input type="hidden" name="workerversionno" value="${workerList[0].versionno}">
        </form>

    <c:if test="${qualityMgmt.status eq 'FINISH' && empty qualityMgmt.evaluate}">
        <div class="fixsubmit">
            <a href="javascript:saveEvaluateInfo()">保存</a>
        </div>
    </c:if>

    <div class="choose" style="display: none">
        <div class="error">
            <p id="Message"></p >
            <button onclick="closeModel()">我知道了</button>
        </div>
    </div>

<script src="${ctx}/static/admin/js/lrz/dist/lrz.bundle.js"></script>
<script src="${ctx}/static/admin/js/jquery.min.js"></script>
<script src="${ctx}/static/admin/js/calendar/WdatePicker.js"></script>
<script src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script src="${ctx}/static/js/wechatUtil.js?20171201"></script>
<script type="text/javascript" src="${ctx}/static/js/reviewMediaJquery.swipebox.js"></script>
<script type="text/javascript">

    var Message = document.getElementById("Message");
    Message.innerHTML = "";

    function closeModel(){
        $(".choose").css("display","none");
    }


    window.onload = function(){

        if(${successMessage != null}){
            Message.innerHTML = "${successMessage}";
            $(".choose").css("display","block");
        }else if(${errorMessage != null}){
            Message.innerHTML = "${errorMessage}";
            $(".choose").css("display","block");
        }
    }

    function saveEvaluateInfo(){
        var searchForm = document.getElementById("frm");
        searchForm.action = "${ctx}/guest/saveEvaluateInfo"
        searchForm.submit();
    }

    function enableUl(ulId,imgId){
        var ul = document.getElementById(ulId);
        var lis = ul.getElementsByTagName("li");
        var img = document.getElementById(imgId);
        for(var i=0;i<lis.length;i++){
            if(lis[i].style.display == "none"){
                lis[i].style.display = "block";
                img.className = "up";
            }else{
                lis[i].style.display = "none";
                img.className = "down";
            }
        }
    }



    function reviewMediaShow(obj){
        var reviewMediaClass = $(obj).attr("class");
        $( '.'+reviewMediaClass+'' ).swipebox();
    }
    $( '.swipebox-video' ).swipebox();


    //去空格
    function trimText(obj){
        if(obj.value.length > 0){
            obj.value = obj.value.replace(/(^\s*)|(\s*$)/g, "");
        }
    }
</script>

</body>
</html>