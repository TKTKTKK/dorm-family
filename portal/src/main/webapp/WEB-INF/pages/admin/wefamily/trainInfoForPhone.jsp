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
    <title>培训详情</title>
    <link rel="stylesheet" href="${ctx}/static/guest/css/common.css" type="text/css" />
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
        #trainImgContainer{display: inline-block;vertical-align: middle}
        #trainImgUrlContainer{display: inline-block;vertical-align: middle;margin-left: 2rem}
        #trainImgContainer img{width: 5rem;height: 5rem;margin:1rem}
        .my-display-inline-box{width: auto}
        .required{padding: 0 !important;border: 0 !important;color: tomato;text-align: right;}
        .maxlength{padding: 0 !important;border: 0 !important;color: tomato;text-align: right;}
        .fixsubmit{background-color: none;display: flex;display: -webkit-flex}
        .fixsubmit>a:nth-of-type(1){left: 0;background: #5bbc4e;width: 70%;color: white}
        .fixsubmit>a:nth-of-type(2){right: 0;background: #f0d439;width: 30%;color: white}
    </style>
</head>
<body>
    <div class="head">
        <a class="back" href="${ctx}/admin/wefamily/trainManageForPhone"></a>
        <span>培训详情</span>
        <img src="../../../static/guest/img/sao.png" alt="">
    </div>

        <form class="form-horizontal form-bordered" data-validate="parsley"
              action="${ctx}/admin/wefamily/trainInfoForPhone" method="POST"
              enctype="multipart/form-data" id="frm">
            <div class="goal_total">
                <a href="javaScript:enableUl('machineUl','machineListImg')">
                    <span>主机信息</span>
                    <img src="../../../../static/guest/img/list.png" alt="" id="machineListImg" class="up">
                </a>
            </div>
            <ul class="list" id="machineUl">
                <li>
                    <span>机器型号<a class="dataRequired">*</a></span>
                    <input type="text" id="machinemodel" name="machinemodel" value="${train.machinemodel}"
                           data-required="true" placeholder="请填写机器型号" data-maxlength="32"/>
                </li>
                <li>
                    <span>发动机号<a class="dataRequired">*</a></span>
                    <input type="text" id="engineno" name="engineno" value="${train.engineno}"
                           data-required="true" placeholder="请填写发动机号" data-maxlength="32"/>
                </li>
                <li>
                    <span>机器号<a class="dataRequired">*</a></span>
                    <input type="text" id="machineno" name="machineno" value="${train.machineno}"
                           data-required="true" placeholder="请填写机器号" data-maxlength="32"/>
                </li>
                <li>
                    <span>生产日期<a class="dataRequired">*</a></span>
                    <input class="Wdate" type="text" name="productiondt" id="productiondt" value="${train.productiondt}" onClick="WdatePicker()"
                           data-required="true" placeholder="请选择生产日期" data-maxlength="23">
                </li>
            </ul>
            <div class="goal_total">
                <a href="javaScript:enableUl('personUl','personListImg')">
                    <span>用户信息</span>
                    <img src="../../../../static/guest/img/list.png" alt="" id="personListImg" class="up">
                </a>
            </div>
            <ul class="list" id="personUl">
                <li>
                    <span>姓名<a class="dataRequired">*</a></span>
                    <input type="text" placeholder="请填写真实姓名" value="${train.personname}" name="personname" id="personname"
                           data-required="true" data-maxlength="32">
                </li>
                <li>
                    <span>手机号码<a class="dataRequired">*</a></span>
                    <input type="text" placeholder="请填写手机号码" value="${train.personphone}" name="personphone" id="personphone"
                           data-required="true" data-maxlength="11">
                </li>
            </ul>
            <div class="goal_total">
                <a href="javaScript:enableUl('programUl','programListImg')">
                    <span>培训项目</span>
                    <img src="../../../../static/guest/img/list.png" alt="" id="programListImg" class="up">
                </a>
            </div>
            <ul class="list" id="programUl">
                <c:forEach items="${web:queryCommonCodeList('TRAIN_PROGRAM')}" var="programCode">
                    <c:set var="showFlag" value="0" scope="page"></c:set>
                    <c:forEach items="${trainProgramList}" var="program">
                        <c:if test="${program == programCode.code}">
                            <c:set var="showFlag" value="1" scope="page"></c:set>
                        </c:if>
                    </c:forEach>
                    <c:if test="${showFlag == 1}">
                        <li>
                            <input type="checkbox" class="chk" id="${programCode.code}" name="trainPrograms" onchange="checkProgram('${programCode.code}')" style="display: none;" checked value="${programCode.code}">
                            <label for="${programCode.code}"></label>
                            <span>${programCode.codevalue}</span>
                        </li>
                    </c:if>
                    <c:if test="${showFlag == 0}">
                        <li>
                            <input type="checkbox" class="chk" id="${programCode.code}" name="trainPrograms" onchange="checkProgram('${programCode.code}')" style="display: none;" value="${programCode.code}">
                            <label for="${programCode.code}"></label>
                            <span>${programCode.codevalue}</span>
                        </li>
                    </c:if>
                </c:forEach>
            </ul>
            <div class="goal_total">
                <a href="javaScript:enableUl('situationUl','situationListImg')">
                    <span>现场情况</span>
                    <img src="../../../../static/guest/img/list.png" alt="" id="situationListImg" class="up">
                </a>
            </div>
            <ul class="list" id="situationUl">
                <li>
                    <span>培训类型<a class="dataRequired">*</a></span>
                    <select name="type" id="type" data-required="true">
                        <c:set var="commonCodeList" value="${web:queryCommonCodeList('TRAIN_TYPE')}"></c:set>
                        <c:forEach items="${commonCodeList}" var="commonCode">
                            <option value="${commonCode.code}" <c:if test="${train.type == commonCode.code}">selected</c:if>>${commonCode.codevalue}</option>
                        </c:forEach>
                    </select>
                </li>
                <li>
                    <span>培训日期<a class="dataRequired">*</a></span>
                    <input class="Wdate" type="text" name="traindt" id="traindt" onClick="WdatePicker()"
                           value="${train.traindt}" placeholder="请选择培训日期" data-required="true" data-maxlength="23">
                </li>
                <li>
                    <span>培训情况</span>
                    <select name="situation" id="situation">
                        <c:set var="commonCodeList" value="${web:queryCommonCodeList('TRAIN_SITUATION')}"></c:set>
                        <option>请选择</option>
                        <c:forEach items="${commonCodeList}" var="commonCode">
                            <option value="${commonCode.code}" <c:if test="${train.situation == commonCode.code}">selected</c:if>>${commonCode.codevalue}</option>
                        </c:forEach>
                    </select>
                </li>
                <li>
                    <span>现场定位</span>
                    <input type="text" placeholder="请填写位置" name="location" id="location" value="${train.location}" data-maxlength="32">
                    <%--<img src="../../../../static/admin/img/location.png" alt="" style="width: 2rem;height: 2rem">--%>
                </li>
                <li style="border: 0">
                    <span>上传图片</span>
                </li>
                <li>
                    <div class="my-display-inline-box">
                        <div id="trainImgContainer" class="row value">
                            <c:forEach items="${attachmentList}" var="attachment">
                                <img src="${attachment.name}" alt="" style="margin-top: 3px;margin-left: 10px" onclick="viewBigImageForUpload(this)" data-toggle="modal" data-target=".bs-example-modal-lg-image">
                            </c:forEach>
                        </div>
                        <c:if test="${fn:length(attachmentList) < 4}">
                            <div id="trainImgUrlContainer" class="upload-btn-box" style="display: inline-block">
                                <input type="file" id="trainImg" name="picUrl" class="upload-btn pageUpload"
                                       data-icon="false" data-classButton="btn btn-default"
                                       data-classInput="form-control inline v-middle input-xs"
                                       accept="image/*"
                                    <%--data-max_size="2000000" --%>
                                       data-max-count="4">
                                <div id="picUrlError" class="text-danger"></div>
                            </div>
                        </c:if>
                    </div>
                </li>
            </ul>
            <input type="hidden" name="uuid" class="form-control" value="${train.uuid}">
            <input type="hidden" name="versionno" class="form-control"
                   value="${train.versionno}">
        </form>

        <c:if test="${train.status ne 'FINISH'}">
            <div class="fixsubmit">
                <a href="javascript:submitTrainInfo()">保存</a>
                <a href="javascript:finishTrain()">提交</a>
            </div>
        </c:if>



    <!-- /.modal 大图 start -->
    <div class="modal fade bs-example-modal-lg-image" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">

                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" id="modelCloseBtn"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                    <h4 class="modal-title" id="myLargeModalLabel">大图</h4>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="bs-example" data-example-id="simple-carousel">
                                <div id="carousel-example-generic" class="carousel slide" data-ride="carousel">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div>
    <!-- /.modal 大图 end -->

<script src="${ctx}/static/admin/js/lrz/dist/lrz.bundle.js"></script>
<script type="text/javascript" src="${ctx}/static/admin/geo.js"></script>
<script src="${ctx}/static/admin/js/jquery.min.js"></script>
<script src="${ctx}/static/admin/js/qikoo/qikoo.js"></script>
<script language="javascript" type="text/javascript" src="${ctx}/static/admin/js/calendar/WdatePicker.js"></script>
<script type="text/javascript">

    function submitTrainInfo(){
        $("#frm").parsley("validate");
        //表单合法 单价合法性
        if ($('#frm').parsley().isValid()){
            var searchForm = document.getElementById("frm");
            searchForm.submit();
        }
    }

    $('.pageUpload').change(function () {
        if ($(".pageUpload").attr("readonly") == "readonly") {
            $("#notification_bar").css("width", "60%");
            $("#notification_bar").css("left", "20%");
            HC.showNotification("网络较慢，请耐心等待！", 2000);
        } else {
            compressUploadPicture(document.getElementById("trainImg"));
        }
    });

    function checkProgram(programCode){
        var checkBox = document.getElementById(programCode);
        if(checkBox.checked){
            checkBox.checked = true;
        }else{
            checkBox.checked = false;
        }
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

    function finishTrain(){

            //确定
            $.get("${ctx}/admin/wefamily/finishTrain?trainId=${train.uuid}&versionno=${train.versionno}",function(data,status){
                if(undefined != data.finishFlag){
                    window.location.href = "<%=request.getContextPath()%>/admin/wefamily/trainInfoForPhone?trainId=${train.uuid}&finishFlag="+data.finishFlag;
                }
            });
    }

    </script>

</body>
</html>