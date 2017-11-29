<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="/WEB-INF/layout/taglib.jsp" %>
<!DOCTYPE html>
<html lang="en" class="app">
<head>
    <%--<link href="${ctx}/static/admin/css/sweetalert.css" rel="stylesheet">--%>
        <link href="${ctx}/static/admin/css/qikoo/qikoo.css" rel="stylesheet">
</head>
<body class="">

<section id="content">
    <section class="vbox">
        <section class="scrollable padder">
            <header class="panel-heading">
                自动回复 》 <a href="${ctx}/admin/account/articleMessage">图文消息</a> 》
                <span class="font-bold  text-black"> 发送图文消息 </span>
            </header>
            <div class="row">
                <div class="col-sm-2">
                </div>
                <div class="col-sm-8">
                    <div style="margin-bottom: 5px">
                        <span class="text-success">${successMessage}</span>
                        <span class="text-danger">${errorMessage}</span>
                    </div>
                    <form class="form-horizontal" data-validate="parsley" action="${ctx}/admin/account/sendArticleMessage" method="POST"
                          id="frm" onsubmit="compareBeginEndDate()">
                        <section class="panel panel-default">
                            <header class="panel-heading">
                            <strong>发送业主：</strong>
                            </header>
                            <div class="panel-body">
                                <%--<div class="form-group">--%>
                                    <%--<label class="col-sm-3 control-label"><span class="text-danger">*</span>图文消息标题：</label>--%>
                                    <%--<div class="col-sm-9">--%>
                                        <%--<input type="text" class="form-control" id="tmname" name="tmname"--%>
                                               <%--value="${title}" readonly/>--%>
                                    <%--</div>--%>
                                <%--</div>--%>
                                <div class="line line-dashed b-b line-lg pull-in"></div>
                                <div class="form-group">
                                    <label class="col-sm-3 control-label">小区：</label>
                                    <div class="col-sm-8">
                                        <select class="form-control" name="communityid" id="communityid">
                                             <option value="">--全部--</option>
                                            <c:forEach items="${wpCommunityList}" var="wpCommunity">
                                                <c:if test="${communityid eq wpCommunity.uuid}">
                                                    <option value="${wpCommunity.uuid}" selected>${wpCommunity.name}</option>
                                                </c:if>
                                                <c:if test="${!(communityid eq wpCommunity.uuid)}">
                                                    <option value="${wpCommunity.uuid}">${wpCommunity.name}</option>
                                                </c:if>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>
                                <div class="line line-dashed b-b line-lg pull-in"></div>
                                <div class="form-group">
                                    <label class="col-sm-3 control-label">认证开始时间：</label>
                                    <div class="col-sm-8">
                                        <input class="datepicker-input form-control" size="16" type="text" data-type="dateIso" name="startDateStr"  value="${startDateStr}"
                                               data-date-format="yyyy-mm-dd" id="startDateStr" >
                                        <div class="text-danger" id="dateError">
                                        </div>
                                    </div>
                                </div>
                                <div class="line line-dashed b-b line-lg pull-in"></div>
                                <div class="form-group">
                                    <label class="col-sm-3 control-label">认证截止时间：</label>
                                    <div class="col-sm-8">
                                        <input class="datepicker-input form-control" size="16" type="text" data-type="dateIso" name="endDateStr"  value="${endDateStr}"
                                               data-date-format="yyyy-mm-dd" id="endDateStr" >
                                    </div>
                                </div>
                                <div class="line line-dashed b-b line-lg pull-in"></div>
                                <div class="form-group">
                                    <div class="col-sm-12">
                                        <input type="hidden" id="mediaid" name="mediaid" value="${mediaid}">
                                    </div>
                                </div>
                            </div>

                        </section>
                    </form>
                    <footer class="panel-footer text-right bg-light lter">
                        <button onclick="confirmSend()" class="btn btn-success btn-s-xs">提 交</button>
                    </footer>

                </div>

            </div>
        </section>
    </section>
    <a href="#" class="hide nav-off-screen-block" data-toggle="class:nav-off-screen,open" data-target="#nav,html"></a>
</section>
<%--<script src="${ctx}/static/admin/js/sweetalert.min.js"></script>--%>
<script src="${ctx}/static/admin/js/qikoo/qikoo.js"></script>
<script type="text/javascript">
    window.onload = function(){
        //显示父菜单
        showParentMenu('公众号');
    }

    //比较起始日期和截止日期
    function compareBeginEndDate(){
        var startDateStr = document.getElementById('startDateStr');
        var endDateStr = document.getElementById('endDateStr');
        var dateError = document.getElementById('dateError');
        dateError.innerHTML = '';
        if(startDateStr.value.length > 0 && endDateStr.value.length > 0 ){
            //比较起始和截止日期的大小
            var arr=startDateStr.value.split("-");
            var bgDate=new Date(arr[0],arr[1],arr[2]);
            var starttimes=bgDate.getTime();

            var arrs=endDateStr.value.split("-");
            var edDate=new Date(arrs[0],arrs[1],arrs[2]);
            var edtimes=edDate.getTime();
            //比较起始和截止日期的大小
            if(starttimes > edtimes){
                dateError.innerHTML = '起始日期不能大于截止日期';
                return false;
            }
        }
        return true;
    }


    function confirmSend(){
        if(compareBeginEndDate()){
            <%--swal({--%>
                <%--title: "确定发送该图文消息?",--%>
                <%--text: "你将发送此图文消息至业主!",--%>
                <%--type: "warning",--%>
                <%--showCancelButton: true,--%>
                <%--confirmButtonColor: "#DD6B55",--%>
                <%--confirmButtonText: "确定",--%>
                <%--closeOnConfirm: false--%>
            <%--}, function () {--%>
                    <%--var searchForm = $('#frm');--%>
                    <%--searchForm.action = "${ctx}/admin/account/sendArticleMessage";--%>
                    <%--searchForm.submit();--%>
                <%--})--%>
            qikoo.dialog.confirm('确定发送该图文消息？',function(){
                //确定
                var searchForm = $('#frm');
                searchForm.action = "${ctx}/admin/account/sendArticleMessage";
                searchForm.submit();
            },function(){
                //取消
            });
         }
        return;
     }
</script>
</body>
</html>