<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="/WEB-INF/layout/taglib.jsp" %>
<!DOCTYPE html>
<html lang="en" class="app">
<head>
    <%--<link href="${ctx}/static/admin/css/sweetalert.css" rel="stylesheet">--%>
        <link href="${ctx}/static/admin/css/qikoo/qikoo.css" rel="stylesheet">
    <style>
        @media (min-width: 768px){
            .hsspan {
                vertical-align: top;
                width: 200px;
                display: inline-block;
                word-wrap: break-word;
            }
        }
        @media (max-width: 767px){
            .hsspan {
                vertical-align: top;
                width: 200px;
                display: inline-block;
                overflow-x: hidden;
                text-overflow: ellipsis;/*超出内容显示为省略号*/
                white-space: nowrap;/*文本不进行换行*/
            }
        }
    </style>
</head>
<body class="">

<section id="content">
    <section class="vbox">
        <section class="scrollable">
            <header class="panel-heading bg-white text-lg">
                用户 /  <a href="${ctx}/admin/usermanage/roleDistribute">用户管理</a>
                 / <span class="font-bold  text-shallowred"> 用户微信</span>
            </header>
            <div class="bg-white closel">
                <div class="col-sm-12 no-padder">
                    <div style="margin-bottom: 5px">
                        <span class="text-success">${successMessage}</span>
                        <span class="text-danger">${errorMessage}</span>
                    </div>
                    <c:if test="${not empty wechatBinding}">
                        <form method="post" action="${ctx}/admin/usermanage/wechatUserManage" class="form-horizontal b-l b-r b-b padding20"
                              data-validate="parsley"
                              id="searchForm">
                        <div class="row">
                            <div class="col-sm-4">
                                <label class="control-label my-display-inline-lbl" style="padding-top: 7px">手机号：</label>

                                <div class="my-display-inline-box" style="margin-bottom: 10px">
                                    <input type="text" class="form-control" id="contactno" name="contactno" onblur="trimText(this)" value="${wechatUserInfo.contactno}"/>
                                </div>
                            </div>
                            <div class="col-sm-4">
                                <label class="control-label my-display-inline-lbl" style="padding-top: 7px">姓名：</label>

                                <div class="my-display-inline-box" style="margin-bottom: 10px">
                                    <input type="text" class="form-control" id="name" name="name" onblur="trimText(this)" value="${wechatUserInfo.name}"/>
                                </div>
                            </div>
                            <div class="col-sm-4">
                                <label class="control-label my-display-inline-lbl" style="padding-top: 7px">微信昵称：</label>

                                <div class="my-display-inline-box" style="margin-bottom: 10px">
                                    <input type="text" class="form-control" id="nickname" name="nickname" onblur="trimText(this)" value="${wechatUserInfo.nickname}"/>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-4">
                                <label class="control-label my-display-inline-lbl" style="padding-top: 7px">用户类型：</label>

                                <div class="my-display-inline-box" style="margin-bottom: 10px">
                                    <select class="form-control" name="type" id="type">
                                        <option value="">--全部--</option>
                                        <c:set var="wechatUserInfoTypeList" value="${web:queryCommonCodeList('WECAHT_USERINFO_TYPE')}"></c:set>
                                        <c:forEach items="${wechatUserInfoTypeList}" var="commonCode">
                                            <c:if test="${wechatUserInfo.type == commonCode.code}">
                                                <option value="${commonCode.code}" selected>${commonCode.codevalue}</option>
                                            </c:if>
                                            <c:if test="${wechatUserInfo.type != commonCode.code}">
                                                <option value="${commonCode.code}">${commonCode.codevalue}</option>
                                            </c:if>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                            <div class="col-sm-4">
                                <label class="control-label my-display-inline-lbl" style="padding-top: 7px">是否关注：</label>

                                <div class="my-display-inline-box" style="margin-bottom: 10px">
                                    <select class="form-control" name="ifsubscribe" id="ifsubscribe">
                                        <option value="">--全部--</option>
                                        <option value="Y" <c:if test="${'Y' eq wechatUserInfo.ifsubscribe}">selected</c:if>>是</option>
                                        <option value="N" <c:if test="${'N' eq wechatUserInfo.ifsubscribe}">selected</c:if>>否</option>
                                    </select>
                                </div>
                            </div>
                            <div class="col-sm-4">
                                <label class="control-label my-display-inline-lbl" style="padding-top: 7px">是否创建账号：</label>

                                <div class="my-display-inline-box" style="margin-bottom: 10px">
                                    <select class="form-control" name="ifCreateAccount" id="ifCreateAccount">
                                        <option value="">--全部--</option>
                                        <option value="Y" <c:if test="${'Y' eq ifCreateAccount}">selected</c:if>>是</option>
                                        <option value="N" <c:if test="${'N' eq ifCreateAccount}">selected</c:if>>否</option>
                                    </select>
                                </div>
                            </div>
                        </div>

                        <div style="clear: both"></div>
                        <div class="row col-sm-12 text-muted text-center" style="padding-right: 5px;">
                                <button type="button" class="btn btn-submit btn-s-xs"
                                        id="submitBtn"
                                        onclick="submitInfo()">查 询
                                </button>
                        </div>

                       </form>
                        <div class="table-responsive">
                            <table class="table table-striped b-t b-light b-b b-l b-r">
                                <thead>
                                <tr>
                                    <th width="4%">
                                        <label class="checkbox m-n">
                                            <input type="checkbox"  id="sltChk"><i></i>
                                        </label>
                                    </th>
                                    <th width="4%">序号</th>
                                    <th width="8%">手机号</th>
                                    <th width="8%">姓名</th>
                                    <th width="8%">微信昵称</th>
                                    <th width="8%">微信头像</th>
                                    <th width="12%">微信openid</th>
                                    <th width="6%">是否关注</th>
                                    <th width="6%">是否创建账号</th>
                                    <th width="6%">用户类型</th>
                                    <th width="12%">提交时间</th>
                                    <th width="8%">备注</th>
                                    <th width="10%">操作</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach items="${wechatUserInfoList}" var="wechatUserInfo" varStatus="stat">
                                    <tr>
                                        <td>
                                               <input type="checkbox" name="wechatUserInfoId" value="${wechatUserInfo.uuid}">
                                        </td>
                                        <td>
                                                ${wechatUserInfo.rownum}
                                        </td>
                                        <td>
                                                ${wechatUserInfo.contactno}
                                        </td>
                                        <td>
                                                ${wechatUserInfo.name}
                                        </td>
                                        <td>
                                                ${wechatUserInfo.nickname}
                                        </td>
                                        <td>
                                            <c:if test="${wechatUserInfo.headimgurl != null && wechatUserInfo.headimgurl != ''}">
                                                <img src="${wechatUserInfo.headimgurl}" style="width: 50px;height: 50px;">
                                            </c:if>
                                        </td>
                                        <td>
                                                ${wechatUserInfo.openid}
                                        </td>
                                        <td>
                                            <%--<c:if test="${web:getWechatUser(wechatUserInfo.openid).subscribe == 1}">
                                                是
                                            </c:if>
                                            <c:if test="${web:getWechatUser(wechatUserInfo.openid).subscribe == 0}">
                                                否
                                            </c:if>--%>
                                            <c:if test="${wechatUserInfo.ifsubscribe == 'Y'}">
                                                是
                                            </c:if>
                                            <c:if test="${wechatUserInfo.ifsubscribe == 'N'}">
                                                否
                                            </c:if>

                                        </td>
                                        <td>
                                            <c:if test="${wechatUserInfo.createAccountFlag}">
                                                是
                                            </c:if>
                                            <c:if test="${ not wechatUserInfo.createAccountFlag}">
                                                否
                                            </c:if>
                                        </td>
                                        <td>
                                                ${web:getCodeDesc('WECAHT_USERINFO_TYPE', wechatUserInfo.type)}
                                        </td>
                                        <td>
                                                ${wechatUserInfo.createon}
                                        </td>
                                        <td>
                                                ${wechatUserInfo.remarks}
                                        </td>
                                        <td>
                                            <a href="${ctx}/admin/usermanage/wechatUserInfo?wechatUserInfoId=${wechatUserInfo.uuid}"
                                               class="btn btn-sm btn-infonew a-noline" style="color: #fff">修改</a>
                                            <a href="${ctx}/admin/usermanage/userInfo?wechatUserInfoId=${wechatUserInfo.uuid}"
                                               class="btn btn-sm btn-yellow a-noline" style="color:white" <c:if test="${wechatUserInfo.createAccountFlag}">disabled="disabled" </c:if>>创建账号</a>
                                        </td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                            <c:if test="${not empty wechatUserInfoList}">
                                <web:pagination pageList="${wechatUserInfoList}" postParam="true"/>
                            </c:if>
                            <button class="btn btn-primary btn-s-xs"  style="color: #fff;" onclick="deleteWechatUserInfo()"> 删除</button>
                        </div>
                    </c:if>
                    <c:if test="${empty wechatBinding}">
                        <span>您还没有添加公众号，请先去</span>
                        <a href="${ctx}/admin/account/search" class="text-info">添加公众号</a>
                    </c:if>
                </div>
            </div>
        </section>
    </section>
    <a href="#" class="hide nav-off-screen-block" data-toggle="class:nav-off-screen,open" data-target="#nav,html"></a>
</section>

<%--<script type="text/javascript" src="${ctx}/static/admin/geo.js"></script>--%>
<%--<script src="${ctx}/static/admin/js/sweetalert.min.js"></script>--%>
<script src="${ctx}/static/admin/js/jquery.blockui.min.js"></script>
<script src="${ctx}/static/admin/js/qikoo/qikoo.js"></script>
<script type="text/javascript">


    window.onload = function(){
        //显示父菜单
        showParentMenu('用户');
    }

    function resubmitSearch(page){
        $("#searchForm").parsley("validate");
        //比较起始日期和截止日期 且 表单合法
        if ($('#searchForm').parsley().isValid()) {
            $('#searchBtn').attr('disabled', true);
            //ui block
            pleaseWait();
            var searchForm = document.getElementById('searchForm');
            searchForm.action = "${ctx}/admin/usermanage/wechatUserManage?page=" + page;
            searchForm.submit();
        }
    }
    //提交查询
    function submitInfo(){
        $("#searchForm").parsley("validate");
        //比较起始日期和截止日期 且 表单合法
        if ($('#searchForm').parsley().isValid()) {
            $('#searchBtn').attr('disabled', true);
            //ui block
            pleaseWait();
            document.getElementById('searchForm').submit();
        }
    }

    //删除用户微信信息
    function deleteWechatUserInfo(){
        var chkValue ="";

        $('input[name="wechatUserInfoId"]:checked').each(function(){
            chkValue += $(this).val() + ",";
        });
        if(chkValue.length == 0){
            qikoo.dialog.confirm('请至少选择一条记录进行操作！');
        }else{
            var url = "${ctx}/admin/usermanage/checkwechatUserInfoIfBind?wechatUserInfoIdsStr="+chkValue;
            $.get(url,function(data,status){
                //存在账号绑定微信
                if(data.bindedNamesStr != ""){
                    var msg = "已有账号绑定了"+data.bindedNamesStr+"的微信,确定删除?"
                }else{
                    var msg = "确定删除?";
                }
                qikoo.dialog.confirm(msg,function(){
                    //确定
                    $.get("${ctx}/admin/usermanage/deleteWechatUserInfo?wechatUserInfoIdsStr="+chkValue+"&version="+Math.random(),function(data,status){
                        if(undefined != data.errorMessage){
                            qikoo.dialog.alert(data.errorMessage);
                        }else if(undefined != data.deleteFlag){
                            var searchForm = document.getElementById("searchForm");
                            searchForm.action = "${ctx}/admin/usermanage/wechatUserManage?deleteFlag=" + data.deleteFlag;
                            searchForm.submit();
                        }
                    });
                },function(){
                    //取消
                });

            });
        }

    }
</script>
</body>
</html>