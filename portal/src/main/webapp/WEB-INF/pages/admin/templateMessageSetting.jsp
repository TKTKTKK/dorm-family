<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
        <section class="scrollable">
            <header class="panel-heading bg-white text-lg">
                公众号 / <span class="font-bold text-shallowred">模板消息</span>
            </header>
            <div class="bg-white closel">
                <div class="col-sm-12 clearfix no-padder">
                    <div style="margin-bottom: 5px">
                        <span class="text-success">${successMessage}</span>
                        <span class="text-danger">${errorMessage}</span>
                    </div>
                    <c:if test="${not empty wechatBinding}">
                    <div class="table-responsive">
                    <table class="table table-striped b-t b-light b-b b-l b-r">
                    <thead>
                    <tr>
                        <th width="20%">模板SHORT ID</th>
                        <th width="30%">模板名</th>
                        <th width="30%">模板ID</th>
                        <th width="20%">操作</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td>
                                ${web:queryTmIdShortByName('服务请求处理提醒')}
                        </td>
                        <td>
                            <%--代替任务处理通知--%>
                            服务请求处理提醒
                        </td>
                        <c:if test="${web:getTMByTypeAndBindid(bindid,'SERVICE_REQ') ne null}">
                            <td>
                                    ${web:getTMByTypeAndBindid(bindid,'SERVICE_REQ ')}
                            </td>
                            <td>
                                <a href="javascript:deleteTM('SERVICE_REQ ')" type="button" class="btn btn-sm btn-yellow a-noline" style="color: #fff" >删 &nbsp; 除</a>
                            </td>
                        </c:if>
                        <c:if test="${web:getTMByTypeAndBindid(bindid,'SERVICE_REQ ') eq null}">
                            <td>
                                未配置
                            </td>
                            <td>
                                <a href="javascript:addTemplateMessage('${web:queryTmIdShortByName('服务请求处理提醒')}', 'SERVICE_REQ', '服务请求处理提醒')" type="button" class="btn btn-sm btn-dangernew  a-noline" style="color: #fff" >添 &nbsp; 加</a>
                            </td>
                        </c:if>
                    </tr>
                    <tr>
                        <td>
                                ${web:queryTmIdShortByName('任务处理结果提醒')}
                        </td>
                        <td>
                            任务处理结果提醒
                        </td>
                        <c:if test="${web:getTMByTypeAndBindid(bindid,'TASK_RESULT') ne null}">
                            <td>
                                    ${web:getTMByTypeAndBindid(bindid,'TASK_RESULT ')}
                            </td>
                            <td>
                                <a href="javascript:deleteTM('TASK_RESULT ')" type="button" class="btn btn-sm btn-yellow a-noline" style="color: #fff" >删 &nbsp; 除</a>
                            </td>
                        </c:if>
                        <c:if test="${web:getTMByTypeAndBindid(bindid,'TASK_RESULT ') eq null}">
                            <td>
                                未配置
                            </td>
                            <td>
                                    <a href="javascript:addTemplateMessage('${web:queryTmIdShortByName('任务处理结果提醒')}', 'TASK_RESULT', '任务处理结果提醒')" type="button" class="btn btn-sm btn-dangernew  a-noline" style="color: #fff" >添 &nbsp; 加</a>
                            </td>
                        </c:if>
                    </tr>

                    <tr>
                        <td>
                                ${web:queryTmIdShortByName('服务信息完成提示')}
                        </td>
                        <td>
                            服务信息完成提示
                        </td>
                        <c:if test="${web:getTMByTypeAndBindid(bindid,'SERVICE_COMP') ne null}">
                            <td>
                                    ${web:getTMByTypeAndBindid(bindid,'SERVICE_COMP')}
                            </td>
                            <td>
                                <a href="javascript:deleteTM('SERVICE_COMP')" type="button" class="btn btn-sm btn-yellow a-noline" style="color: #fff" >删 &nbsp; 除</a>
                            </td>
                        </c:if>
                        <c:if test="${web:getTMByTypeAndBindid(bindid,'SERVICE_COMP') eq null}">
                            <td>
                                未配置
                            </td>
                            <td>
                                    <a href="javascript:addTemplateMessage('${web:queryTmIdShortByName('服务信息完成提示')}', 'SERVICE_COMP', '服务信息完成提示')" type="button" class="btn btn-sm btn-dangernew  a-noline" style="color: #fff" >添 &nbsp; 加</a></td>
                            </td>
                        </c:if>
                    </tr>


                    <tr>
                        <td>
                                ${web:queryTmIdShortByName('积分提醒')}
                        </td>
                        <td>
                            积分提醒
                        </td>
                        <c:if test="${web:getTMByTypeAndBindid(bindid,'INTEGRATION') ne null}">
                            <td>
                                    ${web:getTMByTypeAndBindid(bindid,'INTEGRATION')}
                            </td>
                            <td>
                                <a href="javascript:deleteTM('INTEGRATION')" type="button" class="btn btn-sm btn-yellow a-noline" style="color: #fff" >删 &nbsp; 除</a>
                            </td>
                        </c:if>
                        <c:if test="${web:getTMByTypeAndBindid(bindid,'INTEGRATION') eq null}">
                            <td>
                                未配置
                            </td>
                            <td>
                                <a href="javascript:addTemplateMessage('${web:queryTmIdShortByName('积分提醒')}', 'INTEGRATION', '积分提醒')" type="button" class="btn btn-sm btn-dangernew  a-noline" style="color: #fff" >添 &nbsp; 加</a></td>
                            </td>
                        </c:if>
                    </tr>

                    </tbody>
                    </table>
                        <a class="btn btn-submit btn-s-xs" data-toggle="modal"
                           data-target=".bs-example-modal-lg-plan-start-time">
                            发送模板消息
                        </a>
                    </div>
                    </c:if>
                    <c:if test="${empty wechatBinding}">
                        <span>您还没有添加公众号，请先去</span>
                        <a href="${ctx}/admin/account/search" class="text-info">添加公众号</a>
                    </c:if>
                    <div class="modal fade bs-example-modal-lg-plan-start-time " tabindex="-1" role="dialog"
                         aria-labelledby="myPlanStartLargeModalLabel" aria-hidden="false">
                        <div class="modal-dialog modal-lg" style="margin-top: 15%">
                            <div class="modal-content">
                                <form id="planStartFrm" method="post" action=""
                                      class="form-horizontal" data-validate="parsley"
                                >
                                    <div class="modal-header mintgreen">
                                        <button type="button" class="close" data-dismiss="modal" id="planStartModelCloseBtn"><span
                                                aria-hidden="true">×</span><span class="sr-only">Close</span></button>
                                        <h4 class="modal-title" id="myPlanStartLargeModalLabel">模板消息</h4>
                                    </div>
                                    <div class="panel-body p-0-15">
                                        <div class="form-group">
                                            <label class="col-sm-2 control-label "><span class="text-danger">*</span>openid：</label>
                                            <div class="col-sm-9 b-l bg-white">
                                                <input type="text"  class="form-control" name="openid" data-required="true" id="openid" placeholder="多个请用;隔开!">
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-sm-2 control-label "><span class="text-danger">*</span>tmid：</label>
                                            <div class="col-sm-9 b-l bg-white">
                                                <input type="text"  class="form-control" name="tmid" data-required="true" id="tmid">
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-sm-2 control-label "><span class="text-danger">*</span>url：</label>
                                            <div class="col-sm-9 b-l bg-white">
                                                <input type="text"  class="form-control" name="url" data-required="true" id="url">
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-sm-2 control-label "><span class="text-danger">*</span>data：</label>
                                            <div class="col-sm-9 b-l bg-white">
                                                <textarea name="messageContent" id="messageContent" data-required="true" style="width:100%; height: 200px;"></textarea>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-sm-2 control-label "><span class="text-danger"></span></label>
                                            <div class="col-sm-9 b-l bg-white">
                                                <a  class="btn btn-submit btn-s-xs"
                                                    onclick="sendMessage()"
                                                >
                                                    <i class="fa fa-check"></i>&nbsp;发&nbsp;送
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </section>
    <a href="#" class="hide nav-off-screen-block" data-toggle="class:nav-off-screen,open" data-target="#nav,html"></a>
</section>
<%--<script src="${ctx}/static/admin/js/sweetalert.min.js"></script>--%>
<script src="${ctx}/static/admin/js/qikoo/qikoo.js"></script>
<script type="text/javascript">
    //显示父菜单
    showParentMenu('公众号');
    $("#messageContent").val("");
    //删除配置
    function deleteTM(tmtype){
        qikoo.dialog.confirm('确定删除？',function(){
            //确定
            window.location.href = "<%=request.getContextPath()%>/admin/account/deleteTemplateMessage?tmtype="+tmtype;
        },function(){
            //取消
        });
    }
    //发送按钮
    function sendMessage(){
        var messageContent=document.getElementById("messageContent").value;
        $("#planStartFrm").parsley("validate");
        if ($('#planStartFrm').parsley().isValid()){
            $("#planStartModelCloseBtn").click();
            document.getElementById('planStartFrm').action = "${ctx}/admin/account/sendMessage";
            document.getElementById('planStartFrm').submit();
        }
    }
    //添加模板消息
    function addTemplateMessage(tmidshort, tmtype, tmname){
        $.post("${ctx}/admin/account/addTemplateMessage",
                {
                    tmidshort:tmidshort,
                    tmtype:tmtype,
                    tmname:tmname
                },
                function(data,status){
                    var addFlag = data.addFlag;
                    window.location.href = "<%=request.getContextPath()%>/admin/account/templateMessageSetting?addFlag="+addFlag;
        });
    }
</script>
</body>
</html>