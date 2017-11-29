<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/layout/taglib.jsp" %>
<!DOCTYPE html>
<html lang="en" class="app">
<head>
    <%--<link href="${ctx}/static/admin/css/sweetalert.css" rel="stylesheet">--%>
        <link href="${ctx}/static/admin/css/qikoo/qikoo.css" rel="stylesheet">
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
    </style>
</head>
<body class="">

<section id="content"  class="bg-white">
    <section class="vbox">
        <section class="scrollable">
            <header class="panel-heading bg-white text-md b-b">
                用户 /
                <a href="${ctx}/admin/usermanage/roleDistribute">用户管理</a> /
                <a href="${ctx}/admin/usermanage/wechatUserManage">用户微信</a> /
                <span class="font-bold text-shallowred">微信用户信息</span>
            </header>
            <div class="row" style="margin-right:25px;float: right">
                <a href="${ctx}/admin/usermanage/wechatUserManage" class="btn btn-submit btn-s-md a-noline" style="color: #fff"
                >返回</a>
            </div>
                <div class="col-sm-12 pos">
                    <ul id="myTab" class="nav nav-tabs font-bold text-md">
                                <li class="active" onclick="toggleTab('user')"><a data-toggle="tab">用户信息</a></li>
                    </ul>
                    <c:if test="${empty querytype or querytype eq 'user'}">
                        <div style="margin-bottom: 5px">
                            <span id="successMessage" class="text-success">${successMessage}</span>
                            <span id="errorMessage" class="text-danger">${errorMessage}</span>
                        </div>
                        <form class="form-horizontal  form-bordered" data-validate="parsley"
                              action="${ctx}/admin/usermanage/wechatUserInfo"
                              method="post" id="frm">
                            <section class="panel panel-default m-n">
                                <header class="panel-heading  mintgreen">
                                    <i class="fa fa-gift"></i>
                                    <span class="text-lg">用户信息：</span>
                                </header>
                                <div class="panel-body p-0-15">
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label"><span class="text-danger">*</span>手机号码：</label>
                                        <div class="col-sm-9  b-l bg-white">
                                            <input type="text" data-type="phone" data-required="true" class="form-control" name="contactno" id="contactno" data-maxlength="11"
                                                   onblur="checkPhone(this.value)" value="${wechatUserInfo.contactno}"/>
                                            <span class="text-danger" id="contactnoError"></span>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label"><span class="text-danger">*</span>姓名：</label>
                                        <div class="col-sm-9  b-l bg-white">
                                            <input type="text" class="form-control" data-required="true" name="name" id="name" data-maxlength="90"
                                                   onblur="validateChineseText(90, this, 'nameError')" value="${wechatUserInfo.name}"/>
                                            <span id="nameError" class="text-danger"></span>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">微信昵称：</label>
                                        <div class="col-sm-9  b-l bg-white">
                                            <input type="text" class="form-control"  name="nickname" id="nickname" data-maxlength="90"
                                                   onblur="validateChineseText(90, this, 'nameError')" value="${wechatUserInfo.nickname}" readonly/>
                                            <span id="nicknameError" class="text-danger"></span>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label"><span class="text-danger">*</span>用户类型：</label>
                                        <div class="col-sm-9  b-l bg-white">
                                            <select class="form-control" name="type" id="type"
                                                    data-required="true">
                                                <option value="">--全部--</option>
                                                <c:set var="wechatUserInfoTypeList" value="${web:queryCommonCodeList('WECAHT_USERINFO_TYPE')}"></c:set>
                                                <c:forEach items="${wechatUserInfoTypeList}" var="wut">
                                                    <c:if test="${wechatUserInfo.type eq wut.code}">
                                                        <option value="${wut.code}" selected>${wut.codevalue}</option>
                                                    </c:if>
                                                    <c:if test="${wechatUserInfo.type ne wut.code}">
                                                        <option value="${wut.code}">${wut.codevalue}</option>
                                                    </c:if>
                                                </c:forEach>
                                            </select>
                                            <span id="wechatUserInfoError" class="text-danger"></span>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label"><span class="text-danger">*</span> 是否关注:</label>
                                        <div class="col-sm-9  b-l bg-white" >
                                            <div class="radio col-sm-2">
                                                <label>
                                                    <input type="radio" name="ifsubscribe" id="ifsubscribe1" value="Y"
                                                           <c:if test="${'Y' eq wechatUserInfo.ifsubscribe}">checked</c:if>
                                                           disabled="disabled">已关注
                                                </label>
                                            </div>
                                            <div class="radio col-sm-2">
                                                <label>
                                                    <input type="radio" name="ifsubscribe" id="ifsubscribe2" value="N"
                                                           <c:if test="${empty wechatUserInfo.ifsubscribe || 'N' eq wechatUserInfo.ifsubscribe}">checked</c:if>
                                                           disabled="disabled">未关注
                                                </label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label"><span class="text-danger">*</span> 是否创建账号:</label>
                                        <div class="col-sm-9  b-l bg-white" >
                                            <div class="radio col-sm-2">
                                                <label>
                                                    <input type="radio" name="createAccountFlag" id="createAccountFlag1" value="Y"
                                                           <c:if test="${wechatUserInfo.createAccountFlag}">checked</c:if>
                                                           disabled="disabled">已创建
                                                </label>
                                            </div>
                                            <div class="radio col-sm-2">
                                                <label>
                                                    <input type="radio" name="createAccountFlag" id="createAccountFlag2" value="N"
                                                           <c:if test="${not wechatUserInfo.createAccountFlag}">checked</c:if>
                                                           disabled="disabled">未创建
                                                </label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">备注：</label>
                                        <div class="col-sm-9  b-l bg-white">
                                    <textarea class="form-control" rows="6" name="remarks" id="remarks" data-maxlength="65535"
                                              onblur="trimText(this)">${wechatUserInfo.remarks}</textarea>
                                            <span id="remarksError" class="text-danger"></span>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <div class="col-sm-12">
                                            <input type="hidden" name="uuid"  class="form-control" value="${wechatUserInfo.uuid}">
                                            <input type="hidden" name="versionno"  class="form-control" value="${wechatUserInfo.versionno}">
                                            <input type="hidden" name="openid"  class="form-control" value="${wechatUserInfo.openid}">
                                            <%--<input type="hidden" name="queryCommunityid" class="form-control" value="${queryCommunityid}">--%>
                                        </div>
                                    </div>
                                </div>
                                <div class="panel-footer text-left bg-light lter">
                                    <a class="btn btn-submit btn-s-xs"
                                       onclick="submitWechatUserInfo()"
                                       id="submitBtn"
                                    ><i class="fa fa-check"></i>&nbsp;提&nbsp;交</a>
                                </div>
                            </section>
                        </form>
                    </c:if>
            </div>
        </section>
    </section>
    <a href="#" class="hide nav-off-screen-block" data-toggle="class:nav-off-screen,open" data-target="#nav,html"></a>
</section>
<%--<script src="${ctx}/static/admin/js/sweetalert.min.js"></script>--%>
<script src="${ctx}/static/admin/js/qikoo/qikoo.js"></script>
<script src="${ctx}/static/admin/js/jquery.blockui.min.js"></script>
<script type="text/javascript">

    window.onload = function () {
        //显示父菜单
        showParentMenu('用户');
    }
    /**
     * 提交微信用户信息
     */
    function submitWechatUserInfo(){
        $("#frm").parsley("validate");
        //表单合法
        var phone=document.getElementById("contactno").value;
        if ($('#frm').parsley().isValid() && checkPhone(phone)){

            //ui block
            pleaseWait();
            var searchForm = document.getElementById("frm");
            searchForm.submit();
        }
    }

    function checkFinantion(){
       var chooseValues = document.getElementsByName("roles");
        console.log(chooseValues);
       for(var i =0;i<chooseValues.length;i++){
            if(chooseValues[i].checked && chooseValues[i].value == "2015122500000001"){
                document.getElementById("finantionId").style.display="block";
                return;
           }
       }
        document.getElementById("finantionId").style.display="none";
    }

    function checkPhone(phone) {
        var contactnoError = document.getElementById('contactnoError');
        contactnoError.innerHTML = "";
        trimText(document.getElementById('contactno'));
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