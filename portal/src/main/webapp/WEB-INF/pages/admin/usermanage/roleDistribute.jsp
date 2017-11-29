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
        .specialTable .table tbody>tr>td{
            border-right: 1px solid #ddd;
        }
    </style>
</head>
<body class="">

<section id="content">
    <section class="vbox">
        <section class="scrollable">
            <header class="panel-heading bg-white text-lg">
                用户 / <span class="font-bold  text-shallowred"> 用户管理</span>
            </header>
            <div class="bg-white closel">
                <div class="col-sm-12 no-padder">
                    <div style="margin-bottom: 5px">
                        <span class="text-success">${successMessage}</span>
                        <span class="text-danger">${errorMessage}</span>
                    </div>
                    <c:if test="${not empty wechatBinding}">
                    <form method="post" action="" class="form-horizontal" data-validate="parsley" id="searchForm" style="margin: 10px 0">
                        <div>
                            <c:choose>
                                <c:when test="${allCommunities}">
                                    <div class="col-sm-2">
                                        <select class="form-control" name="topAccount"  id="topAccount" onchange="showCommunityid()">
                                                <option value="Y" <c:if test="${'Y' eq topAccount}">selected="selected"</c:if>>顶级用户</option>
                                                <option value="N" <c:if test="${'N' eq topAccount}">selected="selected"</c:if>>非顶级用户</option>
                                        </select>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                        <input type="hidden" name="topAccount" id="topAccount" value="N">
                                </c:otherwise>
                            </c:choose>
                            <div class="col-sm-2" id="communityidDiv">
                                <select class="form-control" name="communityid"  id="communityid">
                                    <c:if test="${allCommunities}">
                                        <option value="">机构</option>
                                    </c:if>

                                    <c:forEach items="${wpCommunityList}" var="community">
                                        <option value="${community.uuid}" <c:if test="${communityid == community.uuid}">selected = "selected"</c:if>  communityType="${community.type}" >${community.name}</option>
                                    </c:forEach>

                                </select>
                            </div>
                            <div class="col-sm-2 col-xs-12 m-b-sm" style="padding-right: 0px">

                                <input type="text" class="form-control" id="username" name="username"
                                       data-maxlength="11"
                                       value="${username}"
                                       placeholder="用户名"
                                >
                            </div>

                            <div class="col-sm-2 col-xs-12 m-b-sm" style="padding-right: 0px">

                                <input type="text" class="form-control" id="name" name="name"
                                       data-maxlength="11"
                                       value="${name}"
                                       placeholder="姓名"
                                >
                            </div>

                            <div style="clear: both"></div>
                            <div class="row col-sm-12 text-muted text-center" style="padding-right: 5px;">
                                <button type="button" class="btn btn-submit btn-s-xs"
                                        id="submitBtn"
                                        onclick="submitInfo()">查 询
                                </button>
                                <a href="javascript:showUserInfo()" class="btn btn-primary btn-s-xs"  style="color: #fff">创建用户</a>
                                <div class="col-sm-1 text-right" style="float: right">
                                    <c:if test="${not empty staffqrcode}">
                                        <img src="${web:getFileViewUrl(staffqrcode)}" style="width: 100px;height: 100px;margin-top: -56px;"
                                             data-toggle="modal" data-target=".bs-example-modal-lg">
                                    </c:if>
                                </div>
                                <a href="${ctx}/admin/usermanage/wechatUserManage" class="btn btn-primary btn-s-xs"  style="color: #fff;float: right;">用户微信</a>
                            </div>
                        </div>
                       </form>
                        <%--<p>&nbsp;</p>--%>
                        <div class="table-responsive specialTable"
                             style="width: 100%;overflow-x: scroll;overflow-y: hidden;">
                            <table class="table table-striped b-t b-light b-b b-l b-r text-center">
                                <thead>
                                <tr>
                                    <th class="text-center">用户名</th>
                                    <th class="text-center">姓名</th>
                                    <th class="text-center">职位</th>
                                    <th class="text-center">微信昵称</th>
                                    <th class="text-center">微信头像</th>
                                    <th class="text-center">是否关注</th>
                                    <th class="text-center">绑定微信</th>
                                    <c:if test="${topAccount == 'N'}">
                                        <th class="text-center">机构</th>
                                        <th class="text-center">片区</th>
                                    </c:if>
                                    <th class="text-center">操作</th>
                                </tr>
                                </thead>
                                <tbody>

                                <c:forEach items="${platformUserList}" var="platformUser" varStatus="status">
                                    <tr>
                                        <c:choose>
                                            <c:when test="${status.index > 0
                                                                && platformUserList[status.index].uuid eq platformUserList[status.index-1].uuid}">
                                                <td style="border-top: 0px">
                                                    &nbsp;
                                                </td>
                                            </c:when>
                                            <c:otherwise>
                                                <td>
                                                        ${platformUser.username}
                                                </td>
                                            </c:otherwise>
                                        </c:choose>
                                        <c:choose>
                                            <c:when test="${status.index > 0
                                                                && platformUserList[status.index].uuid eq platformUserList[status.index-1].uuid}">
                                                <td style="border-top: 0px">
                                                    &nbsp;
                                                </td>
                                            </c:when>
                                            <c:otherwise>
                                                <td>
                                                        ${platformUser.name}
                                                </td>
                                            </c:otherwise>
                                        </c:choose>
                                        <c:choose>
                                            <c:when test="${status.index > 0
                                                                && platformUserList[status.index].uuid eq platformUserList[status.index-1].uuid}">
                                                <td style="border-top: 0px">
                                                    &nbsp;
                                                </td>
                                            </c:when>
                                            <c:otherwise>
                                                <td>
                                                        ${platformUser.title}
                                                </td>
                                            </c:otherwise>
                                        </c:choose>
                                        <c:choose>
                                            <c:when test="${status.index > 0
                                                                && platformUserList[status.index].uuid eq platformUserList[status.index-1].uuid}">
                                                <td style="border-top: 0px">
                                                    &nbsp;
                                                </td>
                                            </c:when>
                                            <c:otherwise>
                                                <td>
                                                        ${web:getWechatUser(platformUser.openid).nickname}
                                                </td>
                                            </c:otherwise>
                                        </c:choose>
                                        <c:choose>
                                            <c:when test="${status.index > 0
                                                                && platformUserList[status.index].uuid eq platformUserList[status.index-1].uuid}">
                                                <td style="border-top: 0px">
                                                    &nbsp;
                                                </td>
                                            </c:when>
                                            <c:otherwise>
                                                <td>
                                                    <c:if test="${not empty web:getWechatUser(platformUser.openid).headimgurl}">
                                                        <img src="${web:getFileViewUrl(web:getWechatUser(platformUser.openid).headimgurl)}" style="width: 50px;height: 50px;">
                                                    </c:if>
                                                </td>
                                            </c:otherwise>
                                        </c:choose>
                                        <c:choose>
                                            <c:when test="${status.index > 0
                                                                && platformUserList[status.index].uuid eq platformUserList[status.index-1].uuid}">
                                                <td style="border-top: 0px">
                                                    &nbsp;
                                                </td>
                                            </c:when>
                                            <c:otherwise>
                                                <td>
                                                    <c:if test="${web:getWechatUser(platformUser.openid).subscribe == 1}">
                                                        是
                                                    </c:if>
                                                    <c:if test="${web:getWechatUser(platformUser.openid).subscribe == 0}">
                                                        否
                                                    </c:if>

                                                </td>
                                            </c:otherwise>
                                        </c:choose>
                                        <c:choose>
                                            <c:when test="${status.index > 0
                                                                && platformUserList[status.index].uuid eq platformUserList[status.index-1].uuid}">
                                                <td style="border-top: 0px">
                                                    &nbsp;
                                                </td>
                                            </c:when>
                                            <c:otherwise>
                                                <td>
                                                    <c:if test="${ empty platformUser.openid}">
                                                        否
                                                    </c:if>
                                                    <c:if test="${not empty platformUser.openid}">
                                                        是
                                                    </c:if>

                                                </td>
                                            </c:otherwise>
                                        </c:choose>
                                        <c:if test="${topAccount == 'N'}">
                                            <td>
                                                    ${platformUser.communityname}
                                            </td>
                                            <td>
                                            <span class="hsspan">
                                                    ${platformUser.blknos}
                                            </span>
                                            </td>
                                        </c:if>
                                        <c:choose>
                                            <c:when test="${status.index > 0
                                                                && platformUserList[status.index].uuid eq platformUserList[status.index-1].uuid}">
                                                <td style="border-top: 0px">
                                                    &nbsp;
                                                </td>
                                            </c:when>
                                            <c:otherwise>
                                                <td>
                                                    <a href="javascript:goModifyuserInfo('${platformUser.uuid}','${communityid}')"  type="button"
                                                       class="btn btn-sm btn-dangernew  a-noline" style="color:white">
                                                        修改</a>
                                                        <%--<a href="javascript:gouserInfo('${platformUser.uuid}','${communityid}')"  type="button"
                                                           class="btn btn-sm btn-infonew a-noline" style="color: white">
                                                            详情</a>--%>
                                                    <c:if test="${currentUserId != platformUser.uuid}">
                                                        <a href="javascript:deleteUserInfo('${platformUser.uuid}')" type="button"
                                                           class="btn btn-sm btn-yellow a-noline" style="color:white">
                                                            删除</a>
                                                    </c:if>

                                                </td>
                                            </c:otherwise>
                                        </c:choose>

                                    </tr>
                                </c:forEach>
                                </tbody>

                            </table>
                            <c:if test="${not empty platformUserList}">
                                <web:pagination pageList="${platformUserList}" postParam="true"/>
                            </c:if>
                        </div>

                        <div style="clear: both"></div>
                        <p class="warningword"> <i class="fa fa-warning">：</i>1. 点击二维码，可查看大图。</p>
                        <p  class="warningword" style="text-indent: 2em">2. 扫码二维码，提交用户信息。</p>
                    </c:if>
                    <c:if test="${empty wechatBinding}">
                        <span>您还没有添加公众号，请先去</span>
                        <a href="${ctx}/admin/account/search" class="text-info">添加公众号</a>
                    </c:if>
                </div>
            </div>
            <!-- /.modal -->
            <div class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-lg">
                    <div class="modal-content">

                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" id="modelCloseBtn"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                            <h4 class="modal-title" id="myLargeModalLabel">扫码提交</h4>
                        </div>
                        <c:if test="${!empty staffqrcode}">
                            <div class="modal-body">
                                <div class="row">
                                    <div class="col-sm-12">
                                        <img src="${web:getFileViewUrl(staffqrcode)}" width="100%" height="100%"/>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-sm-12">
                                        <span>*&nbsp;请用微信扫码或长按识别二维码，提交用户及微信信息</span>
                                    </div>
                                </div>
                            </div>
                        </c:if>
                    </div><!-- /.modal-content -->
                </div><!-- /.modal-dialog -->
            </div>
            <!-- /.modal -->
        </section>
    </section>
    <a href="#" class="hide nav-off-screen-block" data-toggle="class:nav-off-screen,open" data-target="#nav,html"></a>
</section>

<%--<script type="text/javascript" src="${ctx}/static/admin/geo.js"></script>--%>
<%--<script src="${ctx}/static/admin/js/sweetalert.min.js"></script>--%>
<script src="${ctx}/static/admin/js/qikoo/qikoo.js"></script>
<script type="text/javascript">

    window.onload = function () {
        //显示父菜单
        showParentMenu('用户');

        var topAccount = $("#topAccount").find("option:selected").val();
        if(topAccount == 'Y'){
            $("#communityidDiv").addClass("hidden");
        }
        if(topAccount == 'N'){
            $("#communityidDiv").removeClass("hidden");
        }
    }

    function resubmitSearch(page){
        window.location.href = "<%=request.getContextPath()%>/admin/usermanage/roleDistribute?topAccount="+$('#topAccount').val()+"&page="+page+"&communityid="+$('#communityid').val()+"&username="+$('#username').val()+"&name="+$('#name').val();
    }
    function submitInfo(){
        window.location.href = "<%=request.getContextPath()%>/admin/usermanage/roleDistribute?topAccount="+$('#topAccount').val()+"&communityid="+$('#communityid').val()+"&username="+$('#username').val()+"&name="+$('#name').val();
    }
    function goModifyuserInfo(userId,communityid){
        window.location.href="${ctx}/admin/usermanage/userInfo?userId="+userId+"&communityid="+communityid+"&username="+$('#username').val()+"&name="+$('#name').val()+"&topAccount="+$('#topAccount').val();
    }
    function gouserInfo(userId,communityid){
        window.location.href="${ctx}/admin/usermanage/userInfo?userId="+userId+"&view=1&communityid="+communityid+"&username="+$('#username').val()+"&name="+$('#name').val()+"&topAccount="+$('#topAccount').val();
    }
    function showCommunityid(){
        var topAccount = document.getElementById('topAccount').value;
        if(topAccount == 'Y'){
            $("#communityidDiv").addClass("hidden");
        }
        if(topAccount == 'N'){
            $("#communityidDiv").removeClass("hidden");
        }
    }

    //检查图片格式
    function checkPicType(){
        var pictureError = document.getElementById('pictureError');
        pictureError.innerHTML = '';

        var pic = document.getElementById('pictureId').value;
        var imgname = document.getElementById('logonameId').value;
        var type = '';
        //提交时
        if(pic.length == 0){
            type = imgname.substr(imgname.lastIndexOf('.')+1);
        }else{
            //预览时
            type = pic.substr(pic.lastIndexOf('.')+1);
        }
        //格式：bmp，png，jpeg，jpg，gif。
        if(type != 'bmp' && type != 'png' && type != 'jpeg' && type != 'jpg'){
            pictureError.innerHTML = "图片格式不合法。（格式只允许：bmp，png，jpeg，jpg）";
            return false;
        }

        return true;
    }

    //上传文件
    function uploadFile(){
        //检查图片格式
        if(checkPicType()){
            var frm = document.getElementById("frm");
            frm.submit();
        }
    }


    //添加商家信息
    function addBrandInfo(){
        var brand_name = document.getElementById('brand_name');
        //检查商家名称
        var brandNameValid = validateChineseTextForTwo(24, brand_name, 'brand_nameError');

        //检查图片格式
        var picTypeValid = checkPicType();

        if(!brandNameValid || !picTypeValid){
            return false;
        }

        return true;
    }

    //用户信息界面
    function showUserInfo(){
        window.location.href = "<%=request.getContextPath()%>/admin/usermanage/userInfo";
    }

    //删除用户
    function deleteUserInfo(userId){
        <%--swal({--%>
            <%--title: "确定删除?",--%>
            <%--text: "你将删除该用户!",--%>
            <%--type: "warning",--%>
            <%--showCancelButton: true,--%>
            <%--confirmButtonColor: "#DD6B55",--%>
            <%--confirmButtonText: "确定",--%>
            <%--closeOnConfirm: false--%>
        <%--}, function () {--%>
            <%--window.location.href = "<%=request.getContextPath()%>/admin/usermanage/deleteUser?userId="+userId;--%>
        <%--});--%>
        qikoo.dialog.confirm('确定删除？',function(){
            //确定
            window.location.href = "<%=request.getContextPath()%>/admin/usermanage/deleteUser?userId="+userId+"&communityid=${communityid}";
        },function(){
            //取消
        });
    }

    //重载当前页面
    function reloadPage(){
        resubmitSearch(1);
        <%--window.location.href = "<%=request.getContextPath()%>/admin/usermanage/roleDistribute?communityid="+communityid;--%>
    }
</script>
</body>
</html>