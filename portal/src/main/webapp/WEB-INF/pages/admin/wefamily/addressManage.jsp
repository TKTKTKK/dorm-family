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
            宿舍管理 / <a href="${ctx}/admin/wefamily/dormitoryManage"> 宿舍楼管理</a> / <span class="font-bold  text-shallowred">房间信息管理</span>
        </header>
        <section class="scrollable padder">
            <div class="row">

                <div class="bg-white closel">
                    <div class="col-sm-12 no-padder">
                        <form method="post" action="${ctx}/admin/wefamily/addressManage" class="form-horizontal b-l b-r b-b b-t padding20"
                              data-validate="parsley"
                              id="searchForm">
                            <div class="row">
                                <div class="col-sm-3 col-xs-12 m-b-sm" style="padding-right: 0px">
                                    <input type="text" class="form-control" id="name" name="name" onblur="trimText(this)" value="${dormitory.name}"
                                           placeholder="宿舍楼名称" readonly
                                    />
                                </div>
                                <div class="col-sm-3 col-xs-12 m-b-sm" style="padding-right: 0px">
                                    <input type="text" class="form-control" id="layer" name="layer" onblur="trimText(this)" value="${adddress.layer}"
                                            <c:choose>
                                                <c:when test="${dormitory.type ne 'N'}"> placeholder="单元"</c:when>
                                                <c:otherwise> placeholder="楼层"</c:otherwise>
                                            </c:choose>
                                    />
                                </div>
                                <div class="col-sm-3 col-xs-12 m-b-sm" style="padding-right: 0px">
                                    <input type="text" class="form-control" id="roomno" name="roomno" onblur="trimText(this)" value="${adddress.roomno}"
                                           placeholder="地址"
                                    />
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-sm-12">
                                    <input type="hidden" name="dormitoryid" class="form-control" value="${dormitory.uuid}">
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
                        <div class="row col-sm-12">
                            <div style="margin-bottom: 5px">
                                <div class="text-success">${successMessages}</div>
                                <div class="text-danger">${errorMessage}</div>
                                <div class="text-danger">${fileEmptyMsg}</div>
                                <div class="text-danger">${layerErrorMsg}</div>
                                <div class="text-danger">${roomnoErrorMsg}</div>
                                <div class="text-danger">${areaErrorMsg}</div>
                                <div class="text-danger">${uniqueErrorMsg}</div>
                            </div>
                        </div>
                            <div class="table-responsive" >
                                <table class="table table-striped b-t b-light  b-l b-r b-b text-center">

                                    <thead>
                                    <tr>
                                        <c:choose>
                                            <c:when test="${dormitory.type ne 'N'}"><th class="text-center">单元</th></c:when>
                                            <c:otherwise> <th class="text-center">楼层</th></c:otherwise>
                                        </c:choose>
                                        <th class="text-center">房间号</th>
                                        <th class="text-center">面积</th>
                                        <th class="text-center">操作</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach items="${addressPageList}" var="address">
                                        <tr>
                                            <td>
                                                    ${address.layer}
                                            </td>
                                            <td>
                                                    ${address.roomno}
                                            </td>
                                            <td>
                                                    ${address.area}
                                            </td>
                                            <td>
                                                <a href="${ctx}/admin/wefamily/addressInfo?addressId=${address.uuid}&dormitoryId=${dormitory.uuid}"
                                                   class="btn  btn-infonew btn-sm" style="color: white">
                                                    修改
                                                </a>
                                                <a href="${ctx}/admin/wefamily/studentManage?addressId=${address.uuid}"
                                                   class="btn  btn-yellow btn-sm" style="color: white">
                                                    学生信息
                                                </a>
                                                <a href="javascript:deleteAddress('${address.uuid}')" class="btn  btn-dangernew btn-sm" style="color: white">删除</a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                                <c:if test="${fn:length(addressPageList) > 0}">
                                    <web:pagination pageList="${addressPageList}" postParam="true"/>
                                </c:if>
                                <button class="btn btn-sm btn-submit" onclick="addAddress()"> 添加</button>

                                <button class="btn btn-sm btn-submit" onclick="downloadAddressTpl()">下载导入模板</button>
                                <button class="btn btn-sm btn-default"
                                        data-toggle="modal" data-target=".bs-example-modal-lg-import-address">导入
                                </button>
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

    <div class="modal fade bs-example-modal-lg-import-address" tabindex="-1" role="dialog"
         aria-labelledby="myLargeModalLabelForImport" aria-hidden="true">
        <div class="modal-dialog modal-lg" style="margin-top: 15%">
            <div class="modal-content">

                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" id="modelCloseBtnForImport"><span
                            aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                    <h4 class="modal-title" id="myLargeModalLabelForImport">导入</h4>
                </div>
                <form class="form-horizontal" data-validate="parsley" action="${ctx}/admin/wefamily/importAddressInfo"
                      method="POST"
                      enctype="multipart/form-data" id="frms"
                      onsubmit="return checkFileTypes()">
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-sm-12">
                                <div class="form-group" style="border:0">
                                    <label class="col-sm-3 control-label" style="padding-top: 0">文件：</label>

                                    <div class="col-sm-9">
                                        <input type="file" name="fileUrl" id="fileIds">

                                        <div id="picUrlErrors" class="text-danger"></div>
                                        <input type="text" class="hidden" value="${dormitory.uuid}" name="dormitoryId">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer text-center" style="text-align: center">
                        <button type="submit" class="btn btn-submit btn-s-md">提 交</button>
                    </div>

                </form>
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>
    <a href="#" class="hide nav-off-screen-block" data-toggle="class:nav-off-screen,open" data-target="#nav,html"></a>
</section>
<script src="${ctx}/static/admin/js/jquery.blockui.min.js"></script>
<script src="${ctx}/static/admin/js/qikoo/qikoo.js"></script>
<script type="text/javascript">

    window.onload = function(){
        //显示父菜单
        showParentMenu('宿舍管理');
    }

    function downloadAddressTpl(){
        window.location.href = "<%=request.getContextPath()%>/admin/wefamily/downloadAddressTpl?dormitoryId=${dormitory.uuid}&type=${dormitory.type}";
    }

    function addAddress(){
        window.location.href = "<%=request.getContextPath()%>/admin/wefamily/addressInfo?dormitoryId=${dormitory.uuid}";
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
        //表单合法
        if ($('#searchForm').parsley().isValid()) {
            $('#searchBtn').attr('disabled', true);
            //ui block
            pleaseWait();
            var searchForm = document.getElementById("searchForm");
            searchForm.action = "${ctx}/admin/wefamily/addressManage?page=" + page;
            searchForm.submit();
        }
    }


    function checkFileTypes() {
        var pictureError = document.getElementById('picUrlErrors');
        pictureError.innerHTML = '';

        var fl = document.getElementById('fileIds').value;
        if (fl.length <= 0) {
            pictureError.innerHTML = "该项为必填项";
            return false;
        }
        var type = fl.substr(fl.lastIndexOf('.') + 1);
        //格式：xls，xlsx。
        if (type != '' && type != 'xls') {
            pictureError.innerHTML = "文件格式不合法。（格式只允许：xls）";
            return false;
        }

        //关闭模态框
        document.getElementById('modelCloseBtnForImport').click();
        return true;
    }


    function deleteAddress(addressId){
        qikoo.dialog.confirm('确认删除？',function(){
            //确定
            $.get("${ctx}/admin/wefamily/deleteAddress?addressId="+addressId+"&version="+Math.random(),function(data,status){
                if(undefined != data.deleteFlag){
                    var searchForm = document.getElementById("searchForm");
                    searchForm.action = "${ctx}/admin/wefamily/addressManage?deleteFlag=" + data.deleteFlag;
                    searchForm.submit();
                }
            });
        },function(){
            //取消
        });
    }


    function showDormitoryInfo(){
        window.location.href = "<%=request.getContextPath()%>/admin/wefamily/dormitoryInfo";
    }

</script>
</body>
</html>