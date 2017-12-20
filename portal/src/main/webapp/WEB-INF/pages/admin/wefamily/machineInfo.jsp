<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/layout/taglib.jsp" %>
<!DOCTYPE html>
<html lang="en" class="app">
<head>

</head>
<body class="">
<section id="content" class="bg-white">
    <section class="vbox">
        <section class="scrollable">
            <header class="panel-heading bg-white text-lg">
                满田星 / <span class="font-bold  text-shallowred"> 机器信息</span>
            </header>
            <div class="col-sm-12 pos">
                <div style="margin-bottom: 5px">
                    <span class="text-success">${successMessage}</span>
                    <span class="text-danger">${errorMessage}</span>
                </div>
                <form class="form-horizontal form-bordered" data-validate="parsley"
                      action="" method="POST"
                      enctype="multipart/form-data" id="frm">
                    <section class="panel panel-default">
                        <header class="panel-heading mintgreen">
                            <i class="fa fa-gift"></i>
                            <span class="text-lg">机器信息：</span>
                        </header>
                        <div class="panel-body p-0-15">
                            <div class="form-group">
                                <label class="col-sm-3  control-label"><span class="text-danger">*</span>机器名称：</label>
                                <div class="col-sm-9 b-l bg-white">
                                    <input type="text" class="form-control" data-required="true" name="machinename" id="machinename"
                                           data-maxlength="32"
                                           onblur="trimText(this)"
                                           value="${machine.machinename}">
                                    <span id="machinenameError" class="text-danger"></span>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3  control-label"><span class="text-danger">*</span>机器型号：</label>
                                <div class="col-sm-9 b-l bg-white">
                                    <input type="text" class="form-control" data-required="true" name="machinemodel" id="machinemodel"
                                           data-maxlength="32"
                                           onblur="trimText(this)"
                                           value="${machine.machinemodel}">
                                    <span id="machinemodelError" class="text-danger"></span>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3  control-label"><span class="text-danger">*</span>机器号：</label>
                                <div class="col-sm-9 b-l bg-white">
                                    <input type="text" class="form-control" data-required="true" name="machineno" id="machineno"
                                           data-maxlength="32"
                                           onblur="trimText(this)"
                                           value="${machine.machineno}">
                                    <span id="machinenoError" class="text-danger"></span>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3  control-label"><span class="text-danger">*</span>发动机号：</label>
                                <div class="col-sm-9 b-l bg-white">
                                    <input type="text" class="form-control" data-required="true" name="engineno" id="engineno"
                                           data-maxlength="32"
                                           onblur="trimText(this)"
                                           value="${machine.engineno}">
                                    <span id="enginenoError" class="text-danger"></span>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3  control-label"><span class="text-danger">*</span>价格：</label>
                                <div class="col-sm-9 b-l bg-white">
                                    <input type="text" class="form-control" data-required="true" name="price" id="price"
                                           data-maxlength="11"
                                           onblur="validateMoney(this,'priceError')"
                                           value="${machine.price}">
                                    <div class="text-danger" id="priceError"></div>
                                </div>
                            </div>
                            <div class="form-group">
                                <div>
                                    <label class="col-sm-3  control-label"><span class="text-danger">*</span>生产日期：</label>
                                    <div class="col-sm-9 b-l bg-white">
                                        <input class="datepicker-input form-control" size="16" type="text" data-type="dateIso"
                                               name="productiondate" value="${endDateStr}"
                                               data-date-format="yyyy-mm-dd" id="productiondate" placeholder="生产日期">
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-sm-12">
                                    <input type="hidden" name="uuid" class="form-control" value="${machine.uuid}">
                                    <input type="hidden" name="versionno" class="form-control"
                                           value="${machine.versionno}">
                                </div>
                            </div>
                        </div>
                        <div class="panel-footer text-left bg-light lter">
                                <a onclick="submitForm()" class="btn btn-submit btn-s-xs ">
                                    <i class="fa fa-check"></i>&nbsp;提&nbsp;交
                                </a>
                        </div>
                    </section>
                </form>
            </div>
        </section>
    </section>
    <a href="#" class="hide nav-off-screen-block" data-toggle="class:nav-off-screen,open" data-target="#nav,html"></a>
</section>
<script type="text/javascript" src="${ctx}/static/admin/geo.js"></script>
<script type="text/javascript">

    window.onload = function () {
        //显示父菜单
        showParentMenu('满田星');
        if('${machine.price}'.length > 0){
            formatMoney(document.getElementById('price'));
        }
    }
    function submitForm(){
        $("#frm").parsley("validate");
        if(validateMoney(document.getElementById('price'),'priceError') && $('#frm').parsley().isValid()){
            var searchForm = document.getElementById("frm");
            searchForm.action = "${ctx}/admin/wefamily/machineInfo";
            searchForm.submit();
        }
    }
    function validMoney(){
        return validateMoney(document.getElementById('price'),'priceError');
    }
</script>

</body>
</html>