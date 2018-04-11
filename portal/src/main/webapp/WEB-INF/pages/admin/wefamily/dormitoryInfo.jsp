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
                销售管理 / <a href="${ctx}/admin/wefamily/dormitoryManage"><span class="font-bold  text-shallowred"> 宿舍楼</span></a>
            </header>
            <div class="col-sm-12 pos">
                <div style="margin-bottom: 5px">
                    <span class="text-success">${successMessage}</span>
                    <span class="text-danger">${errorMessage}</span>
                </div>
                <form class="form-horizontal form-bordered" data-validate="parsley"
                      action="${ctx}/admin/wefamily/dormitoryInfo" method="POST"
                      onsubmit="return checkIfValid()" id="frm">
                    <section class="panel panel-default">
                        <header class="panel-heading mintgreen">
                            <i class="fa fa-gift"></i>
                            <span class="text-lg">宿舍楼信息：</span>
                        </header>
                        <div class="panel-body p-0-15">
                            <div class="form-group">
                                <label class="col-sm-3  control-label"><span class="text-danger">*</span>宿舍楼名称：</label>
                                <div class="col-sm-9 b-l bg-white">
                                    <input type="text" class="form-control" data-required="true" name="name" id="name"
                                           data-maxlength="48"
                                           onblur="trimText(this)"
                                           value="${dormitory.name}">
                                    <span id="nameError" class="text-danger"></span>
                                </div>
                            </div>

                            <div class="form-group" >
                                <label class="col-sm-3 control-label"><span class="text-danger">*</span>宿舍类型：</label>
                                <div class="col-sm-9  b-l bg-white">
                                    <select  class="form-control" name="type" id="type"
                                             data-required="true">
                                        <c:set var="commonCodeList" value="${web:queryCommonCodeList('DORMITORY_TYPE')}"></c:set>
                                        <option value="">--请选择--</option>
                                        <c:forEach items="${commonCodeList}" var="commonCode">
                                            <option value="${commonCode.code}" <c:if test="${dormitory.type == commonCode.code}">selected</c:if>>${commonCode.codevalue}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-3 control-label">
                                    <span class="text-danger">*</span>
                                    宿舍楼电话：</label>

                                <div class="col-sm-9 b-l bg-white">
                                    <input type="text" name="contactno" class="form-control" data-required="true"
                                           onblur="trimText(this)"
                                           value="${dormitory.contactno}"
                                           data-maxlength="100" id="contactno"
                                           placeholder="若电话有多个，请用逗号隔开。">
                                    <span id="contactnoError" class="text-danger"></span>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-3  control-label"><span class="text-danger">*</span>常用联系人：</label>
                                <div class="col-sm-9 b-l bg-white">
                                    <input type="text" class="form-control" data-required="true" name="frequentcontacts" id="frequentcontacts"
                                           data-maxlength="48"
                                           onblur="trimText(this)"
                                           value="${dormitory.frequentcontacts}">
                                    <span id="frequentcontactsError" class="text-danger"></span>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-3 control-label">
                                    <span class="text-danger">*</span>
                                    常用联系人电话：</label>

                                <div class="col-sm-9 b-l bg-white">
                                    <input type="text" name="contactsphone" class="form-control" data-required="true"
                                           onblur="trimText(this)"
                                           value="${dormitory.contactsphone}"
                                           data-maxlength="20" id="contactsphone">
                                    <span id="contactsphoneError" class="text-danger"></span>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-3  control-label"><span class="text-danger">*</span>地址：</label>
                                <div class="col-sm-9 b-l bg-white">
                                    <input type="text" class="form-control" data-required="true" name="address" id="address"
                                           data-maxlength="48"
                                           onblur="trimText(this)"
                                           value="${dormitory.address}">
                                </div>
                            </div>



                            <div class="form-group">
                                <div class="col-sm-12">
                                    <input type="hidden" name="uuid" class="form-control" value="${dormitory.uuid}">
                                    <input type="hidden" name="versionno" class="form-control"
                                           value="${dormitory.versionno}">
                                </div>
                            </div>
                        </div>
                        <div class="panel-footer text-left bg-light lter">
                            <c:if test="${empty view}">
                                <button type="submit" class="btn btn-submit btn-s-xs ">
                                    <i class="fa fa-check"></i>&nbsp;提&nbsp;交
                                </button>
                            </c:if>
                        </div>
                    </section>
                    <div>
                        <p class="warningword"><span class="font-bold">
                                        <i class="fa fa-warning">：</i>
                                    </span>若电话有多个，请用逗号隔开。</p>
                    </div>
                </form>
            </div>

        </section>
    </section>
    <a href="#" class="hide nav-off-screen-block" data-toggle="class:nav-off-screen,open" data-target="#nav,html"></a>
</section>
<script type="text/javascript" src="${ctx}/static/admin/geo.js"></script>
<script src="${ctx}/static/admin/js/lrz/dist/lrz.bundle.js"></script>
<script type="text/javascript">

    window.onload = function () {
        //显示父菜单
        showParentMenu('销售管理');
    }

    setup();
    promptinfo();

    if (('${merchant.province}'.length > 0 && '${merchant.city}'.length > 0 && '${merchant.district}'.length > 0)) {
        var s1Slt = document.getElementById('s1');
        var s2Slt = document.getElementById('s2');
        var s3Slt = document.getElementById('s3');
        s1Slt.value = '${merchant.province}';
        change(1);
        if ('${merchant.address}'.length <= 0) {
            promptinfo();
        }
        s2Slt.value = '${merchant.city}';
        change(2);
        if ('${merchant.address}'.length <= 0) {
            promptinfo();
        }
        s3Slt.value = '${merchant.district}';
        if ('${merchant.address}'.length > 0) {
            var address = document.getElementById('address');
            address.value = '${merchant.address}';
        }
    }

    //这个函数是必须的，因为在geo.js里每次更改地址时会调用此函数
    function promptinfo() {
        var address = document.getElementById('address');
        var s1 = document.getElementById('s1');
        var s2 = document.getElementById('s2');
        var s3 = document.getElementById('s3');
        address.value = s1.value + s2.value + s3.value;
    }

    //检查省市区是否合法
    function checkIfValid() {
        var addressError = document.getElementById("addressError");
        addressError.innerHTML = "";
        var province = document.getElementById("s1").value;
        var city = document.getElementById("s2").value;
        var district = document.getElementById("s3").value;
        if (province === '省份' || city === '地级市' || district === '市、县级市、县') {
            addressError.innerHTML = '省份，地级市，市、县级市、县 均为必填项';
            return false;
        }

        var address = document.getElementById('address');
        var content = address.value;
        content = content.replace("\n", "");
        address.value = content;
        //小区名称
        var nameValid = validateChineseText(48, document.getElementById('name').value, 'nameError');
        //前台电话
        var contactnoValid = validateChineseText(100, document.getElementById('contactno').value, 'contactnoError');
        //物业地址
        var addressValid = validateChineseText(256, document.getElementById('address').value, 'addressError');

        document.getElementById("contactsphoneError").innerHTML = "";
        var phoneno = $('#contactsphone').val();
        var rule=/^[1][3,4,5,7,8][0-9]{9}$/;
        if(!rule.test(phoneno) || phoneno.length > 11){
            document.getElementById("contactsphoneError").innerHTML = "输入非法";
            return false;
        }

        return nameValid && contactnoValid && addressValid;
    }
    //上传文件
    function uploadFile(){
        //检查上传文件的大小
        checkFileSize();
    }

</script>

</body>
</html>