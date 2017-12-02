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
            满田星 / <span class="font-bold  text-shallowred"> 经销商</span>
        </header>
        <section class="scrollable padder">
            <div class="row">
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
                                <table class="table table-striped b-t b-light  b-l b-r b-b">

                                    <thead>
                                    <tr>
                                        <th width="25%">经销商名称</th>
                                        <th width="50%">地址</th>
                                        <th width="10%">电话</th>
                                        <th width="15%">操作</th>
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
                                <web:pagination pageList="${merchantList}"/>
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
        showParentMenu('满田星');
        var integerFeeTds = $('.integerFee');
        for(var i=0; i<integerFeeTds.length; i++){
            integerFeeTds[i].innerText = (integerFeeTds[i].innerText*1).toFixed(2);
        }
    }


    function deleteMerchant(merchantId){
        if(confirm("确认删除？")){
            window.location.href = "<%=request.getContextPath()%>/admin/wefamily/deleteMerchant?merchantId="+merchantId;
        }
    }

    function resubmitSearch(page){
        window.location.href = "<%=request.getContextPath()%>/admin/wefamily/merchant?page=" + page;
    }


    function showMerchantIdInfo(){
        window.location.href = "<%=request.getContextPath()%>/admin/wefamily/merchantInfo";
    }

</script>
</body>
</html>