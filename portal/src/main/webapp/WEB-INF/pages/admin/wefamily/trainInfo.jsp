<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/layout/taglib.jsp" %>
<!DOCTYPE html>
<html lang="en" class="app">
<head>
    <style type="text/css">
        .permit-list{
            display: none;
            position: absolute;
            top: 0%;
            left: 10%;
            background: sandybrown;
            color: black;
            z-index: 10;
            border-radius: 5px;
            padding: 10px;
        }
        @media (min-width: 768px){
            .hsspan {
                vertical-align: top;
                width: 500px;
                display: inline-block;
                word-wrap: break-word;
            }
        }
        @media (max-width: 767px){
            .hsspan {
                vertical-align: top;
                width: 100px;
                display: inline-block;
                overflow-x: hidden;
                text-overflow: ellipsis;/*超出内容显示为省略号*/
                white-space: nowrap;/*文本不进行换行*/
            }
        }
        .pading{
            padding-top: 0px;
            padding-bottom: 10px;
            border:1px solid transparent;
            height: 30px;
            line-height: 30px;

            padding-left: 12px;
        }
        .pading:hover{
            background-color: #c4e1ff;
            color: #000;
        }
        .feetype-ul{
            display:block;
            height: 150px;
            overflow-x:hidden;
            margin: 0;
            padding: 2px;
            border-radius: 4px;
            border:1px solid #cbd5dd;
        }
        .feetype-ul, li{
            list-style: none;
            margin: 0;
            padding: 0
        }
        #trainImgContainer{display: inline-block;vertical-align: middle}
        #trainImgUrlContainer{display: inline-block;vertical-align: middle;margin-left: 0rem}
        #trainImgContainer img{width: 5rem;height: 5rem;margin:1rem}
    </style>
</head>
<body class="">

<section id="content" class="bg-white">
    <section class="vbox">
        <section class="scrollable">
            <header class="panel-heading bg-white text-lg">
                满田星 / <a href="${ctx}/admin/wefamily/trainManage">培训管理</a>
                / <span class="font-bold  text-shallowred"> 培训信息</span>
            </header>
            <div class="col-sm-12 pos">
                <div style="margin-bottom: 5px">
                    <span class="text-success">${successMessage}</span>
                    <span class="text-danger">${errorMessage}</span>
                </div>
                <form class="form-horizontal form-bordered" data-validate="parsley"
                      action="${ctx}/admin/wefamily/trainInfo" method="POST"
                      enctype="multipart/form-data" id="frm">
                    <section class="panel panel-default">
                        <header class="panel-heading mintgreen">
                            <i class="fa fa-gift"></i>
                            <span class="text-lg">培训信息：</span>
                        </header>
                        <div class="panel-body p-0-15">
                            <div class="form-group">
                                <label class="col-sm-3 control-label"><span class="text-danger">*</span>机器型号：</label>
                                <div class="col-sm-9  b-l bg-white">
                                    <select class="form-control" name="machinemodel" id="machinemodel"
                                            data-required="true">
                                        <c:if test="${fn:length(machineModelList) > 1}">
                                            <option value="">请选择机器型号</option>
                                        </c:if>
                                        <c:forEach items="${machineModelList}" var="machineModel">
                                            <option value="${machineModel}" <c:if test="${train.machinemodel == machineModel}">selected</c:if>>${machineModel}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label"><span class="text-danger">*</span>机器号：</label>
                                <div class="col-sm-9  b-l bg-white">
                                    <div class="" style="position: relative">
                                        <input type="text" class="form-control my-feetype-ul"  name="machineno" id="machineno"
                                               value="${train.machineno}" data-required="true"
                                               placeholder="请输入机器号" data-maxlength="32"
                                        >
                                        <input type="hidden" name="machineid" id="machineid" value="${machine.uuid}">
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label"><span class="text-danger">*</span>发动机号：</label>
                                <div class="col-sm-9  b-l bg-white">
                                    <input type="text" class="form-control"  name="engineno" id="engineno"
                                           value="${train.engineno}" data-required="true"
                                           placeholder="请输入发动机号" data-maxlength="32"
                                    >
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label"><span class="text-danger">*</span>生产日期：</label>
                                <div class="col-sm-9  b-l bg-white">
                                    <input class="datepicker-input form-control" size="16" type="text" data-type="dateIso"
                                           name="productiondt" value="${train.productiondt}" data-maxlength="23"
                                           data-date-format="yyyy-mm-dd" id="productiondt" placeholder="请选择生产日期">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3  control-label"><span class="text-danger">*</span>会员姓名：</label>
                                <div class="col-sm-9 b-l bg-white">
                                    <input type="text" class="form-control" data-required="true" name="personname" id="personname"
                                           data-maxlength="32" placeholder="请输入会员姓名"
                                           onblur="trimText(this)"
                                           value="${train.personname}">
                                    <span id="personnameError" class="text-danger"></span>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3  control-label"><span class="text-danger">*</span>会员电话：</label>
                                <div class="col-sm-9 b-l bg-white">
                                    <input type="text" class="form-control" data-required="true" name="personphone" id="personphone"
                                           data-maxlength="11" placeholder="请输入会员电话"
                                           onblur="checkPhone(this.value)"
                                           value="${train.personphone}">
                                    <span class="text-danger" id="contactnoError"></span>
                                </div>
                            </div>
                            <div class="form-group" >
                                <label class="col-sm-3 control-label"><span class="text-danger">*</span>培训类型：</label>
                                <div class="col-sm-9  b-l bg-white">
                                    <select  class="form-control" name="type" id="type" data-required="true" onchange="changeTrainProgram()">
                                        <c:set var="commonCodeList" value="${web:queryCommonCodeList('TRAIN_TYPE')}"></c:set>
                                        <c:forEach items="${commonCodeList}" var="commonCode">
                                            <option value="${commonCode.code}" <c:if test="${train.type == commonCode.code}">selected</c:if>>${commonCode.codevalue}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label">培训项目：</label>
                                <div class="col-sm-9  b-l bg-white">
                                    <div id="firstTrain">
                                        <c:forEach items="${web:queryCommonCodeList('TRAIN_PROGRAM_FIRST')}" var="programCode">
                                            <div class="checkbox i-checks" style="padding-left: 0px;position: relative">
                                                <label class="checkbox m-n">
                                                    <c:set var="showFlag" value="0" scope="page"></c:set>
                                                    <c:forEach items="${trainProgramList}" var="program">
                                                        <c:if test="${program == programCode.code}">
                                                            <c:set var="showFlag" value="1" scope="page"></c:set>
                                                        </c:if>
                                                    </c:forEach>
                                                    <input type="checkbox" name="programs" value="${programCode.code}" <c:if test="${showFlag == 1}">checked</c:if>>
                                                    <i></i>
                                                    <span>${programCode.codevalue}</span>
                                                </label>
                                                <div class="permit-list"></div>
                                            </div>
                                        </c:forEach>
                                    </div>
                                    <div id="sceneTrain">
                                        <c:forEach items="${web:queryCommonCodeList('TRAIN_PROGRAM_SCENE')}" var="programCode">
                                            <div class="checkbox i-checks" style="padding-left: 0px;position: relative">
                                                <label class="checkbox m-n">
                                                    <c:set var="showFlag" value="0" scope="page"></c:set>
                                                    <c:forEach items="${trainProgramList}" var="program">
                                                        <c:if test="${program == programCode.code}">
                                                            <c:set var="showFlag" value="1" scope="page"></c:set>
                                                        </c:if>
                                                    </c:forEach>
                                                    <input type="checkbox" name="programs" value="${programCode.code}" <c:if test="${showFlag == 1}">checked</c:if>>
                                                    <i></i>
                                                    <span>${programCode.codevalue}</span>
                                                </label>
                                                <div class="permit-list"></div>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <div>
                                    <label class="col-sm-3  control-label"><span class="text-danger">*</span>培训日期：</label>
                                    <div class="col-sm-9 b-l bg-white">
                                        <input class="datepicker-input form-control" size="16" type="text" data-type="dateIso"
                                               name="traindt" value="${train.traindt}" data-maxlength="23"
                                               data-date-format="yyyy-mm-dd" id="traindt" placeholder="请选择培训日期">
                                    </div>
                                </div>
                            </div>
                            <div class="form-group" >
                                <label class="col-sm-3 control-label">培训情况：</label>
                                <div class="col-sm-9  b-l bg-white">
                                    <select  class="form-control" name="situation" id="situation">
                                        <c:set var="commonCodeList" value="${web:queryCommonCodeList('TRAIN_SITUATION')}"></c:set>
                                        <option value="">--请选择--</option>
                                        <c:forEach items="${commonCodeList}" var="commonCode">
                                            <option value="${commonCode.code}" <c:if test="${train.situation == commonCode.code}">selected</c:if>>${commonCode.codevalue}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                            <c:if test="${fn:length(attachmentList) < 4}">
                                <div class="form-group" >
                                    <label class="col-sm-3 control-label">上传人机合影：</label>
                                    <div class="col-sm-9  b-l bg-white">
                                        <div class="my-display-inline-box">
                                            <div id="trainImgUrlContainer">
                                                <input type="file" id="trainImg" name="picUrl" class="filestyle"
                                                       data-icon="false" data-classButton="btn btn-default"
                                                       data-classInput="form-control inline v-middle input-xs"
                                                       onchange="compressUploadPicture(this)" accept="image/*"
                                                    <%--data-max_size="2000000" --%>
                                                       style="display: none"
                                                       data-max-count="4">
                                                <div id="picUrlError" class="text-danger"></div>
                                            </div>
                                            <div id="trainImgContainer" class="row value">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:if>
                            <c:if test="${fn:length(attachmentList) > 0}">
                                <div class="form-group" >
                                    <label class="col-sm-3 control-label"></label>
                                    <div class="col-sm-9  b-l bg-white">
                                        <c:forEach items="${attachmentList}" var="attachment">
                                            <img src="${attachment.name}" width="50" height="50"
                                                 onclick="viewBigImage(this)" data-toggle="modal" data-target=".bs-example-modal-lg-image"/>
                                        </c:forEach>
                                    </div>
                                </div>
                            </c:if>
                            <div class="form-group">
                                <label class="col-sm-3  control-label">地址：</label>
                                <div class="col-sm-9 b-l bg-white">
                                    <input type="text" class="form-control" name="location" id="location"
                                           data-maxlength="32" readonly
                                           onblur="trimText(this)"
                                           value="${train.location}">
                                    <span id="locationError" class="text-danger"></span>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-sm-12">
                                    <input type="hidden" name="uuid" class="form-control" value="${train.uuid}">
                                    <input type="hidden" name="versionno" class="form-control"
                                           value="${train.versionno}">
                                </div>
                            </div>
                        </div>
                        <div class="panel-footer text-left bg-light lter">
                            <c:if test="${train.status ne 'FINISH'}">
                                <button type="submit" class="btn btn-submit btn-s-xs ">
                                    &nbsp;保&nbsp;存
                                </button>
                                <c:if test="${not empty train.uuid}">
                                    <a class="btn btn-primary btn-success" href="javascript:finishTrain()" style="color: white;margin-left: 10px;">
                                        <i class="fa fa-check"></i> 完成培训
                                    </a>
                                </c:if>
                            </c:if>
                        </div>
                    </section>
                </form>
            </div>

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
        </section>
    </section>
    <a href="#" class="hide nav-off-screen-block" data-toggle="class:nav-off-screen,open" data-target="#nav,html"></a>
</section>
<script src="${ctx}/static/admin/js/lrz/dist/lrz.bundle.js"></script>
<script type="text/javascript" src="${ctx}/static/admin/geo.js"></script>
<script src="${ctx}/static/admin/js/qikoo/qikoo.js"></script>
<script type="text/javascript" src="${ctx}/static/admin/js/myScript.js"></script>
<script type="text/javascript">

    window.onload = function () {
        //显示父菜单
        showParentMenu('品质服务');
        changeTrainProgram();
    }

    $('#traintime').datetimepicker({
        weekStart: 1,
        todayBtn: 1,
        autoclose: 1,
        todayHighlight: 1,
        startView: 2,
        forceParse: 0,
        showMeridian: 1
    });

    //根据类型查询培训项目
    function changeTrainProgram(){
        var type = $('#type').val();
        if(type.length > 0 ){
            if(type == 'FIRST'){
                $('#sceneTrain').hide();
                $('#firstTrain').show();
            }else if(type == 'SCENE'){
                $('#sceneTrain').show();
                $('#firstTrain').hide();
            }

        }
    }

    //自动查询机器
    function autoQueryMachineList(obj,callback){
        trimText(obj);
        if($(obj).val().length >= 1){
            queryMachineList(callback);
        }
    }

    //查询机器列表
    function queryMachineList(callback){
        trimText(document.getElementById('machineno'));
        var url = "${ctx}/admin/wefamily/queryMachineList?machineno=" + $('#machineno').val();
        $.get(url
                ,function(data,status){
                    $('#machineUl').html('');
                    if(data.autoQueryMachineList.length > 0){
                        $('#machineUl').removeClass('hidden');
                        $('#machineClose').removeClass('hidden');
                    }else{
                        $('#machineUl').addClass('hidden');
                        $('#machineClose').addClass('hidden')
                    }

                    for(var i=0; i<data.autoQueryMachineList.length; i++){
                        $('#machineUl').append('<li class="pading" value="'+data.autoQueryMachineList[i].uuid+'">' + data.autoQueryMachineList[i].machineno + '</li>');
                    }

                    $('.pading').on('click', function(){
                        $('#machineno').val($(this).text());
                        $('#machineid').val($(this).attr("value"));
                        queryMachineById($(this).attr("value"));
                        if(undefined != callback){
                            callback();
                        }
                        $('#machineUl').addClass('hidden');
                        $('#machineClose').addClass('hidden')
                    });
                    $('#machineClose').on('click', function(){
                        $('#machineUl').addClass('hidden');
                        $('#machineClose').addClass('hidden')
                    });
                });
    }

    //根据id查询机器
    function queryMachineById(machineId){
        if(machineId.length > 0){
            $.get("${ctx}/admin/wefamily/queryMachineById?machineId="+machineId+"&version="+Math.random(),function(data,status){
                if(undefined != data.machine){
                    $('#machinemodel').val(data.machine.machinemodel);
                    $('#engineno').val(data.machine.engineno);
                    $('#productiondate').val(data.machine.productiondate);
                }
            });
        }
    }

    function finishTrain(){
        if(confirm('确定完成培训？')){
            //确定
            $.get("${ctx}/admin/wefamily/finishTrain?trainId=${train.uuid}&versionno=${train.versionno}",function(data,status){
                if(undefined != data.finishFlag){
                    window.location.href = "<%=request.getContextPath()%>/admin/wefamily/trainInfo?trainId=${train.uuid}&finishFlag="+data.finishFlag;
                }
            });
        }
    }

    function checkPhone(phone) {
        var contactnoError = document.getElementById('contactnoError');
        contactnoError.innerHTML = "";
        trimText(document.getElementById('personphone'));
        var myreg=/^[1][3,4,5,7,8][0-9]{9}$/;
        if (!myreg.test(phone)) {
            contactnoError.innerHTML = "请输入正确的手机号！";
            return false;
        } else {
            return true;
        }
    }

</script>

</body>
</html>