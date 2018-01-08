<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="/WEB-INF/layout/taglib.jsp" %>
<!DOCTYPE html>
<html lang="en" class="app">
<head>
    <link href="${ctx}/static/admin/css/qikoo/qikoo.css" rel="stylesheet">
</head>
<style>
</style>
<body class="">

<section id="content">
    <section class="vbox">
        <header class="panel-heading bg-white text-lg">
            销售服务 / <span class="font-bold  text-shallowred"> 经销商管理</span>
        </header>
        <section class="scrollable padder">
            <div class="row">

                <div class="bg-white closel">
                    <div class="col-sm-12 no-padder">
                        <form method="post" action="${ctx}/admin/wefamily/merchantManage" class="form-horizontal b-l b-r b-b b-t padding20"
                              data-validate="parsley"
                              id="searchForm">
                            <div class="row">
                                <div class="col-sm-3 col-xs-12 m-b-sm" style="padding-right: 0px">
                                    <input type="text" class="form-control" id="name" name="name" onblur="trimText(this)" value="${merchant.name}"
                                           placeholder="经销商名称"
                                    />
                                </div>
                                <div class="col-sm-3 col-xs-12 m-b-sm" style="padding-right: 0px">
                                    <input type="text" class="form-control" id="address" name="address" onblur="trimText(this)" value="${merchant.address}"
                                           placeholder="地址"
                                    />
                                </div>

                                <div class="col-sm-3 col-xs-12 m-b-sm" style="padding-right: 0px">
                                    <input type="text" class="form-control" id="legalperson" name="legalperson" onblur="trimText(this)" value="${merchant.legalperson}"
                                           placeholder="法人代表"
                                    />
                                </div>

                            </div>
                            <div class="row col-sm-12 text-center text-white" style="margin-top: 20px">
                                <a class="btn btn-submit btn-s-xs " onclick="submitSearch()"
                                   id="searchBtn" style="color: white">查 询
                                </a>
                            </div>
                        </form>
                    </div>
                </div>
                <div class="bg-white closel newclosel">
                    <c:if test="${not empty wechatBinding}">
                            <div>
                                <span class="text-success">${successMessage}</span>
                                <span class="text-success" id="synSuccessMsg"></span>
                                <span class="text-danger" id="synFailureMsg"></span>
                                <c:if test="${successFlag == 1}">
                                    <span class="text-success">删除成功！</span>
                                </c:if>
                            </div>
                            <div class="table-responsive" >
                                <table class="table table-striped b-t b-light  b-l b-r b-b text-center">

                                    <thead>
                                    <tr>
                                        <th class="text-center">经销商名称</th>
                                        <th class="text-center">地址</th>
                                        <th class="text-center">经销商电话</th>
                                        <th class="text-center">法人代表</th>
                                        <th class="text-center">常用联系人</th>
                                        <th class="text-center">常用联系人电话</th>
                                        <th class="text-center">操作</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach items="${merchantList}" var="merchant">
                                        <tr>
                                            <td>
                                                    ${merchant.name}
                                            </td>
                                            <td>
                                                    ${merchant.address}
                                            </td>
                                            <td>
                                                    ${merchant.contactno}
                                            </td>
                                            <td>
                                                    ${merchant.legalperson}
                                            </td>
                                            <td>
                                                    ${merchant.frequentcontacts}
                                            </td>
                                            <td>
                                                    ${merchant.contactsphone}
                                            </td>
                                            <td>
                                                <a href="${ctx}/admin/wefamily/merchantInfo?merchantId=${merchant.uuid}"
                                                   class="btn  btn-infonew btn-sm" style="color: white">
                                                    修改
                                                </a>

                                                <a href="javascript:deleteMerchant('${merchant.uuid}')" class="btn  btn-dangernew btn-sm" style="color: white">删除</a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                                <web:pagination pageList="${merchantList}" postParam="true"/>
                                <c:if test="${topAccount == 'Y'}">
                                    <button class="btn btn-sm btn-submit" onclick="showMerchantIdInfo()"> 添加</button>
                                </c:if>
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
<script src="${ctx}/static/admin/js/jquery.blockui.min.js"></script>
<script src="${ctx}/static/admin/js/qikoo/qikoo.js"></script>
<script type="text/javascript">

    window.onload = function(){
        //显示父菜单
        showParentMenu('销售服务');
    }

    //提交查询
    function submitSearch() {
        $("#searchForm").parsley("validate");
        //比较起始日期和截止日期 且 表单合法
        if ($('#searchForm').parsley().isValid()) {
            $('#searchBtn').attr('disabled', true);
            //ui block
            pleaseWait();
            document.getElementById('searchForm').submit();
        }
    }

    function resubmitSearch(page){
        $("#searchForm").parsley("validate");
        //比较起始日期和截止日期 且 表单合法
        if ($('#searchForm').parsley().isValid()) {
            $('#searchBtn').attr('disabled', true);
            //ui block
            pleaseWait();
            var searchForm = document.getElementById("searchForm");
            searchForm.action = "${ctx}/admin/wefamily/merchantManage?page=" + page;
            searchForm.submit();
        }
    }


    function deleteMerchant(merchantId){
        qikoo.dialog.confirm('确认删除？',function(){
            window.location.href = "<%=request.getContextPath()%>/admin/wefamily/deleteMerchant?merchantId="+merchantId;
        },function(){
            //取消
        });
    }


    function showMerchantIdInfo(){
        window.location.href = "<%=request.getContextPath()%>/admin/wefamily/merchantInfo";
    }

</script>
</body>
</html>