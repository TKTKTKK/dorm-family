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
                    <%--<tr>--%>
                        <%--<td>--%>
                                <%--${web:queryTmIdShortByName('新业主认证提醒')}--%>
                        <%--</td>--%>
                        <%--<td>--%>
                            <%--新业主认证提醒--%>
                        <%--</td>--%>
                        <%--<c:if test="${web:getTMByTypeAndBindid(bindid,'NEW_VAL') ne null}">--%>
                            <%--<td>--%>
                                    <%--${web:getTMByTypeAndBindid(bindid,'NEW_VAL')}--%>
                            <%--</td>--%>
                            <%--<td>--%>
                                <%--&lt;%&ndash;<a href="${ctx}/admin/account/templateMessageDetail?tmtype=NEW_VAL&tmname=新业主认证提醒" type="button" class="btn btn-sm btn-dangernew  a-noline" style="color: #fff">修 &nbsp; 改</a>&ndash;%&gt;--%>
                                <%--<a href="javascript:deleteTM('NEW_VAL')" type="button" class="btn btn-sm btn-yellow a-noline" style="color: #fff" >删 &nbsp; 除</a>--%>
                            <%--</td>--%>
                        <%--</c:if>--%>
                        <%--<c:if test="${web:getTMByTypeAndBindid(bindid,'NEW_VAL') eq null}">--%>
                            <%--<td>--%>
                                <%--未配置--%>
                            <%--</td>--%>
                            <%--<td>--%>
                                <%--&lt;%&ndash;<a href="${ctx}/admin/account/templateMessageDetail?tmtype=NEW_VAL&tmname=新业主认证提醒" type="button" class="btn btn-sm btn-dangernew  a-noline" style="color: #fff" >修 &nbsp; 改</a>&ndash;%&gt;--%>
                                <%--<a href="javascript:addTemplateMessage('${web:queryTmIdShortByName('新业主认证提醒')}', 'NEW_VAL', '新业主认证提醒')" type="button" class="btn btn-sm btn-dangernew  a-noline" style="color: #fff" >添 &nbsp; 加</a>--%>
                            <%--</td>--%>
                        <%--</c:if>--%>
                    <%--</tr>--%>
                    <tr>
                        <td>
                                    ${web:queryTmIdShortByName('业主认证结果')}
                        </td>
                        <td>
                            业主认证结果
                        </td>
                        <c:if test="${web:getTMByTypeAndBindid(bindid,'VAL_RESULT') ne null}">
                            <td>
                                    ${web:getTMByTypeAndBindid(bindid,'VAL_RESULT')}
                            </td>
                            <td>
                                <%--<a href="${ctx}/admin/account/templateMessageDetail?tmtype=VAL_RESULT&tmname=业主认证结果" type="button" class="btn btn-sm btn-dangernew  a-noline" style="color: #fff" >修 &nbsp; 改</a>--%>
                                <a href="javascript:deleteTM('VAL_RESULT')" type="button" class="btn btn-sm btn-yellow a-noline" style="color: #fff" >删 &nbsp; 除</a>
                            </td>
                        </c:if>
                        <c:if test="${web:getTMByTypeAndBindid(bindid,'VAL_RESULT') eq null}">
                            <td>
                                未配置
                            </td>
                            <td>
                                <%--<a href="${ctx}/admin/account/templateMessageDetail?tmtype=VAL_RESULT&tmname=业主认证结果" type="button" class="btn btn-sm btn-dangernew  a-noline" style="color: #fff" >修 &nbsp; 改</a>--%>
                                    <a href="javascript:addTemplateMessage('${web:queryTmIdShortByName('业主认证结果')}', 'VAL_RESULT', '业主认证结果')" type="button" class="btn btn-sm btn-dangernew  a-noline" style="color: #fff" >添 &nbsp; 加</a>
                            </td>
                        </c:if>
                    </tr>
                    <tr>
                        <td>
                                ${web:queryTmIdShortByName('服务动态提醒')}
                        </td>
                        <td>
                            服务动态提醒
                        </td>
                        <c:if test="${web:getTMByTypeAndBindid(bindid,'SERVICE_RMD') ne null}">
                            <td>
                                    ${web:getTMByTypeAndBindid(bindid,'SERVICE_RMD')}
                            </td>
                            <td>
                                <a href="javascript:deleteTM('SERVICE_RMD')" type="button" class="btn btn-sm btn-yellow a-noline" style="color: #fff" >删 &nbsp; 除</a>
                            </td>
                        </c:if>
                        <c:if test="${web:getTMByTypeAndBindid(bindid,'SERVICE_RMD') eq null}">
                            <td>
                                未配置
                            </td>
                            <td>
                                <a href="javascript:addTemplateMessage('${web:queryTmIdShortByName('服务动态提醒')}', 'SERVICE_RMD', '服务动态提醒')" type="button" class="btn btn-sm btn-dangernew  a-noline" style="color: #fff" >添 &nbsp; 加</a>
                            </td>
                        </c:if>
                    </tr>
                    <tr>
                        <td>
                                ${web:queryTmIdShortByName('任务处理通知')}
                        </td>
                        <td>
                            任务处理通知
                        </td>
                        <c:if test="${web:getTMByTypeAndBindid(bindid,'NEW_TASK') ne null}">
                            <td>
                                    ${web:getTMByTypeAndBindid(bindid,'NEW_TASK ')}
                            </td>
                            <td>
                                <%--<a href="${ctx}/admin/account/templateMessageDetail?tmtype=NEW_TASK &tmname=任务处理通知" type="button" class="btn btn-sm btn-dangernew  a-noline" style="color: #fff" >修 &nbsp; 改</a>--%>
                                <a href="javascript:deleteTM('NEW_TASK ')" type="button" class="btn btn-sm btn-yellow a-noline" style="color: #fff" >删 &nbsp; 除</a>
                            </td>
                        </c:if>
                        <c:if test="${web:getTMByTypeAndBindid(bindid,'NEW_TASK ') eq null}">
                            <td>
                                未配置
                            </td>
                            <td>
                                <%--<a href="${ctx}/admin/account/templateMessageDetail?tmtype=NEW_TASK &tmname=任务处理通知" type="button" class="btn btn-sm btn-dangernew  a-noline" style="color: #fff" >修 &nbsp; 改</a>--%>
                                    <a href="javascript:addTemplateMessage('${web:queryTmIdShortByName('任务处理通知')}', 'NEW_TASK', '任务处理通知')" type="button" class="btn btn-sm btn-dangernew  a-noline" style="color: #fff" >添 &nbsp; 加</a>
                            </td>
                        </c:if>
                    </tr>
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
                                <%--<a href="${ctx}/admin/account/templateMessageDetail?tmtype=TASK_RESULT &tmname=任务处理结果提醒" type="button" class="btn btn-sm btn-dangernew  a-noline" style="color: #fff" >修 &nbsp; 改</a>--%>
                                <a href="javascript:deleteTM('TASK_RESULT ')" type="button" class="btn btn-sm btn-yellow a-noline" style="color: #fff" >删 &nbsp; 除</a>
                            </td>
                        </c:if>
                        <c:if test="${web:getTMByTypeAndBindid(bindid,'TASK_RESULT ') eq null}">
                            <td>
                                未配置
                            </td>
                            <td>
                                <%--<a href="${ctx}/admin/account/templateMessageDetail?tmtype=TASK_RESULT &tmname=任务处理结果提醒" type="button" class="btn btn-sm btn-dangernew  a-noline" style="color: #fff" >修 &nbsp; 改</a>--%>
                                    <a href="javascript:addTemplateMessage('${web:queryTmIdShortByName('任务处理结果提醒')}', 'TASK_RESULT', '任务处理结果提醒')" type="button" class="btn btn-sm btn-dangernew  a-noline" style="color: #fff" >添 &nbsp; 加</a>
                            </td>
                        </c:if>
                    </tr>

                    <tr>
                        <td>
                                ${web:queryTmIdShortByName('任务过期提醒')}
                        </td>
                        <td>
                            任务过期提醒
                        </td>
                        <c:if test="${web:getTMByTypeAndBindid(bindid,'TASK_OVERDUE') ne null}">
                            <td>
                                    ${web:getTMByTypeAndBindid(bindid,'TASK_OVERDUE')}
                            </td>
                            <td>
                                <%--<a href="${ctx}/admin/account/templateMessageDetail?tmtype=TASK_OVERDUE&tmname=任务过期提醒" type="button" class="btn btn-sm btn-dangernew  a-noline" style="color: #fff" >修 &nbsp; 改</a>--%>
                                <a href="javascript:deleteTM('TASK_OVERDUE')" type="button" class="btn btn-sm btn-yellow a-noline" style="color: #fff" >删 &nbsp; 除</a>
                            </td>
                        </c:if>
                        <c:if test="${web:getTMByTypeAndBindid(bindid,'TASK_OVERDUE') eq null}">
                            <td>
                                未配置
                            </td>
                            <td>
                                <%--<a href="${ctx}/admin/account/templateMessageDetail?tmtype=TASK_OVERDUE&tmname=任务过期提醒" type="button" class="btn btn-sm btn-dangernew  a-noline" style="color: #fff" >修 &nbsp; 改</a>--%>
                                    <a href="javascript:addTemplateMessage('${web:queryTmIdShortByName('任务过期提醒')}', 'TASK_OVERDUE', '任务过期提醒')" type="button" class="btn btn-sm btn-dangernew  a-noline" style="color: #fff" >添 &nbsp; 加</a></td>
                        </c:if>
                    </tr>

                    <%--<tr>--%>
                        <%--<td>--%>
                            <%--新投诉提醒--%>
                        <%--</td>--%>
                        <%--<c:if test="${web:getTMByTypeAndBindid(bindid,'NEW_COMP') ne null}">--%>
                            <%--<td>--%>
                                    <%--${web:getTMByTypeAndBindid(bindid,'NEW_COMP')}--%>
                            <%--</td>--%>
                            <%--<td>--%>
                                <%--<a href="${ctx}/admin/account/templateMessageDetail?tmtype=NEW_COMP&tmname=新投诉提醒" type="button" class="btn btn-info a-noline" >修 &nbsp; 改</a>--%>
                                <%--<a href="javascript:deleteTM('NEW_COMP')" type="button" class="btn btn-danger a-noline" >删 &nbsp; 除</a>--%>
                            <%--</td>--%>
                        <%--</c:if>--%>
                        <%--<c:if test="${web:getTMByTypeAndBindid(bindid,'NEW_COMP') eq null}">--%>
                            <%--<td>--%>
                                <%--未配置--%>
                            <%--</td>--%>
                            <%--<td>--%>
                                <%--<a href="${ctx}/admin/account/templateMessageDetail?tmtype=NEW_COMP&tmname=新投诉提醒" type="button" class="btn btn-info a-noline" >修 &nbsp; 改</a>--%>
                            <%--</td>--%>
                        <%--</c:if>--%>
                    <%--</tr>--%>
                    <%--<tr>--%>
                        <%--<td>--%>
                            <%--新报修提醒--%>
                        <%--</td>--%>
                        <%--<c:if test="${web:getTMByTypeAndBindid(bindid,'NEW_REPAIR') ne null}">--%>
                            <%--<td>--%>
                                    <%--${web:getTMByTypeAndBindid(bindid,'NEW_REPAIR')}--%>
                            <%--</td>--%>
                            <%--<td>--%>
                                <%--<a href="${ctx}/admin/account/templateMessageDetail?tmtype=NEW_REPAIR&tmname=新报修提醒" type="button" class="btn btn-info a-noline" >修 &nbsp; 改</a>--%>
                                <%--<a href="javascript:deleteTM('NEW_REPAIR')" type="button" class="btn btn-danger a-noline" >删 &nbsp; 除</a>--%>
                            <%--</td>--%>
                        <%--</c:if>--%>
                        <%--<c:if test="${web:getTMByTypeAndBindid(bindid,'NEW_REPAIR') eq null}">--%>
                            <%--<td>--%>
                                <%--未配置--%>
                            <%--</td>--%>
                            <%--<td>--%>
                                <%--<a href="${ctx}/admin/account/templateMessageDetail?tmtype=NEW_REPAIR&tmname=新报修提醒" type="button" class="btn btn-info a-noline" >修 &nbsp; 改</a>--%>
                            <%--</td>--%>
                        <%--</c:if>--%>
                    <%--</tr>--%>
                    <%--<tr>--%>
                        <%--<td>--%>
                            <%--用户咨询提醒--%>
                        <%--</td>--%>
                        <%--<c:if test="${web:getTMByTypeAndBindid(bindid,'CONSULT ') ne null}">--%>
                            <%--<td>--%>
                                    <%--${web:getTMByTypeAndBindid(bindid,'CONSULT ')}--%>
                            <%--</td>--%>
                            <%--<td>--%>
                                <%--<a href="${ctx}/admin/account/templateMessageDetail?tmtype=CONSULT &tmname=用户咨询提醒 " type="button" class="btn btn-info a-noline" >修 &nbsp; 改</a>--%>
                                <%--<a href="javascript:deleteTM('CONSULT ')" type="button" class="btn btn-danger a-noline" >删 &nbsp; 除</a>--%>
                            <%--</td>--%>
                        <%--</c:if>--%>
                        <%--<c:if test="${web:getTMByTypeAndBindid(bindid,'CONSULT ') eq null}">--%>
                            <%--<td>--%>
                                <%--未配置--%>
                            <%--</td>--%>
                            <%--<td>--%>
                                <%--<a href="${ctx}/admin/account/templateMessageDetail?tmtype=CONSULT &tmname=用户咨询提醒 " type="button" class="btn btn-info a-noline" >修 &nbsp; 改</a>--%>
                            <%--</td>--%>
                        <%--</c:if>--%>
                    <%--</tr>--%>
                    <tr>
                        <td>
                                ${web:queryTmIdShortByName('收到新快递通知')}
                        </td>
                        <td>
                            收到新快递通知
                        </td>
                        <c:if test="${web:getTMByTypeAndBindid(bindid,'NEW_EXPRESS') ne null}">
                            <td>
                                    ${web:getTMByTypeAndBindid(bindid,'NEW_EXPRESS')}
                            </td>
                            <td>
                                <%--<a href="${ctx}/admin/account/templateMessageDetail?tmtype=NEW_EXPRESS&tmname=收到新快递通知" type="button" class="btn btn-sm btn-dangernew  a-noline" style="color: #fff" >修 &nbsp; 改</a>--%>
                                <a href="javascript:deleteTM('NEW_EXPRESS')" type="button" class="btn btn-sm btn-yellow a-noline" style="color: #fff" >删 &nbsp; 除</a>
                            </td>
                        </c:if>
                        <c:if test="${web:getTMByTypeAndBindid(bindid,'NEW_EXPRESS') eq null}">
                            <td>
                                未配置
                            </td>
                            <td>
                                <%--<a href="${ctx}/admin/account/templateMessageDetail?tmtype=NEW_EXPRESS&tmname=收到新快递通知" type="button" class="btn btn-sm btn-dangernew  a-noline" style="color: #fff" >修 &nbsp; 改</a>--%>
                                    <a href="javascript:addTemplateMessage('${web:queryTmIdShortByName('收到新快递通知')}', 'NEW_EXPRESS', '收到新快递通知')" type="button" class="btn btn-sm btn-dangernew  a-noline" style="color: #fff" >添 &nbsp; 加</a></td>
                            </td>
                        </c:if>
                    </tr>

                    <%--<tr>--%>
                        <%--<td>--%>
                            <%--投诉处理进展通知--%>
                        <%--</td>--%>
                        <%--<c:if test="${web:getTMByTypeAndBindid(bindid,'COMP_PROG') ne null}">--%>
                            <%--<td>--%>
                                    <%--${web:getTMByTypeAndBindid(bindid,'COMP_PROG')}--%>
                            <%--</td>--%>
                            <%--<td>--%>
                                <%--<a href="${ctx}/admin/account/templateMessageDetail?tmtype=COMP_PROG&tmname=投诉处理进展通知" type="button" class="btn btn-info a-noline" >修 &nbsp; 改</a>--%>
                                <%--<a href="javascript:deleteTM('COMP_PROG')" type="button" class="btn btn-danger a-noline" >删 &nbsp; 除</a>--%>
                            <%--</td>--%>
                        <%--</c:if>--%>
                        <%--<c:if test="${web:getTMByTypeAndBindid(bindid,'COMP_PROG') eq null}">--%>
                            <%--<td>--%>
                                <%--未配置--%>
                            <%--</td>--%>
                            <%--<td>--%>
                                <%--<a href="${ctx}/admin/account/templateMessageDetail?tmtype=COMP_PROG&tmname=投诉处理进展通知" type="button" class="btn btn-info a-noline" >修 &nbsp; 改</a>--%>
                            <%--</td>--%>
                        <%--</c:if>--%>
                    <%--</tr>--%>

                    <%--<tr>--%>
                        <%--<td>--%>
                            <%--报修处理进展通知--%>
                        <%--</td>--%>
                        <%--<c:if test="${web:getTMByTypeAndBindid(bindid,'REPAIR_PROG') ne null}">--%>
                            <%--<td>--%>
                                    <%--${web:getTMByTypeAndBindid(bindid,'REPAIR_PROG')}--%>
                            <%--</td>--%>
                            <%--<td>--%>
                                <%--<a href="${ctx}/admin/account/templateMessageDetail?tmtype=REPAIR_PROG&tmname=报修处理进展通知" type="button" class="btn btn-info a-noline" >修 &nbsp; 改</a>--%>
                                <%--<a href="javascript:deleteTM('REPAIR_PROG')" type="button" class="btn btn-danger a-noline" >删 &nbsp; 除</a>--%>
                            <%--</td>--%>
                        <%--</c:if>--%>
                        <%--<c:if test="${web:getTMByTypeAndBindid(bindid,'REPAIR_PROG') eq null}">--%>
                            <%--<td>--%>
                                <%--未配置--%>
                            <%--</td>--%>
                            <%--<td>--%>
                                <%--<a href="${ctx}/admin/account/templateMessageDetail?tmtype=REPAIR_PROG&tmname=报修处理进展通知" type="button" class="btn btn-info a-noline" >修 &nbsp; 改</a>--%>
                            <%--</td>--%>
                        <%--</c:if>--%>
                    <%--</tr>--%>
                    <%--<tr>--%>
                        <%--<td>--%>
                            <%--咨询回复消息提醒--%>
                        <%--</td>--%>
                        <%--<c:if test="${web:getTMByTypeAndBindid(bindid,'RE_CONSULT') ne null}">--%>
                            <%--<td>--%>
                                    <%--${web:getTMByTypeAndBindid(bindid,'RE_CONSULT')}--%>
                            <%--</td>--%>
                            <%--<td>--%>
                                <%--<a href="${ctx}/admin/account/templateMessageDetail?tmtype=RE_CONSULT&tmname=咨询回复消息提醒" type="button" class="btn btn-info a-noline" >修 &nbsp; 改</a>--%>
                                <%--<a href="javascript:deleteTM('RE_CONSULT')" type="button" class="btn btn-danger a-noline" >删 &nbsp; 除</a>--%>
                            <%--</td>--%>
                        <%--</c:if>--%>
                        <%--<c:if test="${web:getTMByTypeAndBindid(bindid,'RE_CONSULT') eq null}">--%>
                            <%--<td>--%>
                                <%--未配置--%>
                            <%--</td>--%>
                            <%--<td>--%>
                                <%--<a href="${ctx}/admin/account/templateMessageDetail?tmtype=RE_CONSULT&tmname=咨询回复消息提醒" type="button" class="btn btn-info a-noline" >修 &nbsp; 改</a>--%>
                            <%--</td>--%>
                        <%--</c:if>--%>
                    <%--</tr>--%>
                    <tr>
                        <td>
                                ${web:queryTmIdShortByName('快递领取成功通知')}
                        </td>
                        <td>
                            快递领取成功通知
                        </td>
                        <c:if test="${web:getTMByTypeAndBindid(bindid,'EXPRESS_SIGNED') ne null}">
                            <td>
                                    ${web:getTMByTypeAndBindid(bindid,'EXPRESS_SIGNED')}
                            </td>
                            <td>
                                <%--<a href="${ctx}/admin/account/templateMessageDetail?tmtype=EXPRESS_SIGNED&tmname=快递领取成功通知" type="button" class="btn btn-sm btn-dangernew  a-noline" style="color: #fff" >修 &nbsp; 改</a>--%>
                                <a href="javascript:deleteTM('EXPRESS_SIGNED')" type="button" class="btn btn-sm btn-yellow a-noline" style="color: #fff" >删 &nbsp; 除</a>
                            </td>
                        </c:if>
                        <c:if test="${web:getTMByTypeAndBindid(bindid,'EXPRESS_SIGNED') eq null}">
                            <td>
                                未配置
                            </td>
                            <td>
                                <%--<a href="${ctx}/admin/account/templateMessageDetail?tmtype=EXPRESS_SIGNED&tmname=快递领取成功通知" type="button" class="btn btn-sm btn-dangernew  a-noline" style="color: #fff" >修 &nbsp; 改</a>--%>
                                    <a href="javascript:addTemplateMessage('${web:queryTmIdShortByName('快递领取成功通知')}', 'EXPRESS_SIGNED', '快递领取成功通知')" type="button" class="btn btn-sm btn-dangernew  a-noline" style="color: #fff" >添 &nbsp; 加</a></td>
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
                                <%--<a href="${ctx}/admin/account/templateMessageDetail?tmtype=SERVICE_COMP&tmname=服务信息完成提示 " type="button" class="btn btn-sm btn-dangernew  a-noline" style="color: #fff" >修 &nbsp; 改</a>--%>
                                <a href="javascript:deleteTM('SERVICE_COMP')" type="button" class="btn btn-sm btn-yellow a-noline" style="color: #fff" >删 &nbsp; 除</a>
                            </td>
                        </c:if>
                        <c:if test="${web:getTMByTypeAndBindid(bindid,'SERVICE_COMP') eq null}">
                            <td>
                                未配置
                            </td>
                            <td>
                                <%--<a href="${ctx}/admin/account/templateMessageDetail?tmtype=SERVICE_COMP&tmname=服务信息完成提示 " type="button" class="btn btn-sm btn-dangernew  a-noline" style="color: #fff" >修 &nbsp; 改</a>--%>
                                    <a href="javascript:addTemplateMessage('${web:queryTmIdShortByName('服务信息完成提示')}', 'SERVICE_COMP', '服务信息完成提示')" type="button" class="btn btn-sm btn-dangernew  a-noline" style="color: #fff" >添 &nbsp; 加</a></td>
                            </td>
                        </c:if>
                    </tr>
                    <tr>
                        <td>
                                ${web:queryTmIdShortByName('业主委托房源提醒')}
                        </td>
                        <td>
                            业主委托房源提醒
                        </td>
                        <c:if test="${web:getTMByTypeAndBindid(bindid,'HOUSE_AGENT') ne null}">
                            <td>
                                    ${web:getTMByTypeAndBindid(bindid,'HOUSE_AGENT')}
                            </td>
                            <td>
                                <%--<a href="${ctx}/admin/account/templateMessageDetail?tmtype=HOUSE_AGENT&tmname=业主委托房源提醒 " type="button" class="btn btn-sm btn-dangernew  a-noline" style="color: #fff" >修 &nbsp; 改</a>--%>
                                <a href="javascript:deleteTM('HOUSE_AGENT')" type="button" class="btn btn-sm btn-yellow a-noline" style="color: #fff" >删 &nbsp; 除</a>
                            </td>
                        </c:if>
                        <c:if test="${web:getTMByTypeAndBindid(bindid,'HOUSE_AGENT') eq null}">
                            <td>
                                未配置
                            </td>
                            <td>
                                <%--<a href="${ctx}/admin/account/templateMessageDetail?tmtype=HOUSE_AGENT&tmname=业主委托房源提醒 " type="button" class="btn btn-sm btn-dangernew  a-noline" style="color: #fff" >修 &nbsp; 改</a>--%>
                                    <a href="javascript:addTemplateMessage('${web:queryTmIdShortByName('业主委托房源提醒')}', 'HOUSE_AGENT', '业主委托房源提醒')" type="button" class="btn btn-sm btn-dangernew  a-noline" style="color: #fff" >添 &nbsp; 加</a></td>
                            </td>
                        </c:if>
                    </tr>
                    <tr>
                        <td>
                                ${web:queryTmIdShortByName('物业费缴费提醒')}
                        </td>
                        <td>
                            物业费缴费提醒
                        </td>
                        <c:if test="${web:getTMByTypeAndBindid(bindid,'PROPERTY_PAYMENT') ne null}">
                            <td>
                                    ${web:getTMByTypeAndBindid(bindid,'PROPERTY_PAYMENT')}
                            </td>
                            <td>
                                <%--<a href="${ctx}/admin/account/templateMessageDetail?tmtype=PROPERTY_PAYMENT&tmname=物业费缴费提醒" type="button" class="btn btn-sm btn-dangernew  a-noline" style="color: #fff" >修 &nbsp; 改</a>--%>
                                <a href="javascript:deleteTM('PROPERTY_PAYMENT')" type="button" class="btn btn-sm btn-yellow a-noline" style="color: #fff" >删 &nbsp; 除</a>
                            </td>
                        </c:if>
                        <c:if test="${web:getTMByTypeAndBindid(bindid,'PROPERTY_PAYMENT') eq null}">
                            <td>
                                未配置
                            </td>
                            <td>
                                <%--<a href="${ctx}/admin/account/templateMessageDetail?tmtype=PROPERTY_PAYMENT&tmname=物业费缴费提醒" type="button" class="btn btn-sm btn-dangernew  a-noline" style="color: #fff" >修 &nbsp; 改</a>--%>
                                    <a href="javascript:addTemplateMessage('${web:queryTmIdShortByName('物业费缴费提醒')}', 'PROPERTY_PAYMENT', '物业费缴费提醒')" type="button" class="btn btn-sm btn-dangernew  a-noline" style="color: #fff" >添 &nbsp; 加</a></td>
                            </td>
                        </c:if>
                    </tr>
                    <tr>
                        <td>
                                ${web:queryTmIdShortByName('停电通知')}
                        </td>
                        <td>
                            停电通知
                        </td>
                        <c:if test="${web:getTMByTypeAndBindid(bindid,'cutOffPower') ne null}">
                            <td>
                                    ${web:getTMByTypeAndBindid(bindid,'cutOffPower')}
                            </td>
                            <td>
                                <%--<a href="${ctx}/admin/account/templateMessageDetail?tmtype=cutOffPower&tmname=停电通知" type="button" class="btn btn-sm btn-dangernew  a-noline" style="color: #fff" >修 &nbsp; 改</a>--%>
                                <a href="javascript:deleteTM('cutOffPower')" type="button" class="btn btn-sm btn-yellow a-noline" style="color: #fff" >删 &nbsp; 除</a>
                            </td>
                        </c:if>
                        <c:if test="${web:getTMByTypeAndBindid(bindid,'cutOffPower') eq null}">
                            <td>
                                未配置
                            </td>
                            <td>
                                <%--<a href="${ctx}/admin/account/templateMessageDetail?tmtype=cutOffPower&tmname=停电通知" type="button" class="btn btn-sm btn-dangernew  a-noline" style="color: #fff" >修 &nbsp; 改</a>--%>
                                    <a href="javascript:addTemplateMessage('${web:queryTmIdShortByName('停电通知')}', 'cutOffPower', '停电通知')" type="button" class="btn btn-sm btn-dangernew  a-noline" style="color: #fff" >添 &nbsp; 加</a></td>
                            </td>
                        </c:if>
                    </tr>
                    <tr>
                        <td>
                                ${web:queryTmIdShortByName('停水通知')}
                        </td>
                        <td>
                            停水通知
                        </td>
                        <c:if test="${web:getTMByTypeAndBindid(bindid,'cutOffWater') ne null}">
                            <td>
                                    ${web:getTMByTypeAndBindid(bindid,'cutOffWater')}
                            </td>
                            <td>
                                <%--<a href="${ctx}/admin/account/templateMessageDetail?tmtype=cutOffWater&tmname=停水通知" type="button" class="btn btn-sm btn-dangernew  a-noline" style="color: #fff" >修 &nbsp; 改</a>--%>
                                <a href="javascript:deleteTM('cutOffWater')" type="button" class="btn btn-sm btn-yellow a-noline" style="color: #fff" >删 &nbsp; 除</a>
                            </td>
                        </c:if>
                        <c:if test="${web:getTMByTypeAndBindid(bindid,'cutOffWater') eq null}">
                            <td>
                                未配置
                            </td>
                            <td>
                                <%--<a href="${ctx}/admin/account/templateMessageDetail?tmtype=cutOffWater&tmname=停水通知" type="button" class="btn btn-sm btn-dangernew  a-noline" style="color: #fff" >修 &nbsp; 改</a>--%>
                                    <a href="javascript:addTemplateMessage('${web:queryTmIdShortByName('停水通知')}', 'cutOffWater', '停水通知')" type="button" class="btn btn-sm btn-dangernew  a-noline" style="color: #fff" >添 &nbsp; 加</a></td>
                            </td>
                        </c:if>
                    </tr>
                    <tr>
                        <td>
                                ${web:queryTmIdShortByName('停燃气通知')}
                        </td>
                        <td>
                            停燃气通知
                        </td>
                        <c:if test="${web:getTMByTypeAndBindid(bindid,'cutOffGas') ne null}">
                            <td>
                                    ${web:getTMByTypeAndBindid(bindid,'cutOffGas')}
                            </td>
                            <td>
                                <%--<a href="${ctx}/admin/account/templateMessageDetail?tmtype=cutOffGas&tmname=停燃气通知" type="button" class="btn btn-sm btn-dangernew  a-noline" style="color: #fff" >修 &nbsp; 改</a>--%>
                                <a href="javascript:deleteTM('cutOffGas')" type="button" class="btn btn-sm btn-yellow a-noline" style="color: #fff" >删 &nbsp; 除</a>
                            </td>
                        </c:if>
                        <c:if test="${web:getTMByTypeAndBindid(bindid,'cutOffGas') eq null}">
                            <td>
                                未配置
                            </td>
                            <td>
                                <%--<a href="${ctx}/admin/account/templateMessageDetail?tmtype=cutOffGas&tmname=停燃气通知" type="button" class="btn btn-sm btn-dangernew  a-noline" style="color: #fff" >修 &nbsp; 改</a>--%>
                                    <a href="javascript:addTemplateMessage('${web:queryTmIdShortByName('停燃气通知')}', 'cutOffGas', '停燃气通知')" type="button" class="btn btn-sm btn-dangernew  a-noline" style="color: #fff" >添 &nbsp; 加</a></td>
                            </td>
                        </c:if>
                    </tr>
                    <tr>
                        <td>
                                ${web:queryTmIdShortByName('业务处理通知')}
                        </td>
                        <td>
                            业务处理通知
                        </td>
                        <c:if test="${web:getTMByTypeAndBindid(bindid,'BUSINESS_PRO') ne null}">
                            <td>
                                    ${web:getTMByTypeAndBindid(bindid,'BUSINESS_PRO')}
                            </td>
                            <td>
                                <%--<a href="${ctx}/admin/account/templateMessageDetail?tmtype=BUSINESS_PRO&tmname=业务处理通知" type="button" class="btn btn-sm btn-dangernew  a-noline" style="color: #fff" >修 &nbsp; 改</a>--%>
                                <a href="javascript:deleteTM('BUSINESS_PRO')" type="button" class="btn btn-sm btn-yellow a-noline" style="color: #fff" >删 &nbsp; 除</a>
                            </td>
                        </c:if>
                        <c:if test="${web:getTMByTypeAndBindid(bindid,'BUSINESS_PRO') eq null}">
                            <td>
                                未配置
                            </td>
                            <td>
                                <%--<a href="${ctx}/admin/account/templateMessageDetail?tmtype=BUSINESS_PRO&tmname=业务处理通知" type="button" class="btn btn-sm btn-dangernew  a-noline" style="color: #fff" >修 &nbsp; 改</a>--%>
                                    <a href="javascript:addTemplateMessage('${web:queryTmIdShortByName('业务处理通知')}', 'BUSINESS_PRO', '业务处理通知')" type="button" class="btn btn-sm btn-dangernew  a-noline" style="color: #fff" >添 &nbsp; 加</a></td>
                            </td>
                        </c:if>
                    </tr>
                    <tr>
                        <td>
                                ${web:queryTmIdShortByName('消防报警信息')}
                        </td>
                        <td>
                            消防报警信息
                        </td>
                        <c:if test="${web:getTMByTypeAndBindid(bindid,'ALARM_INFO') ne null}">
                            <td>
                                    ${web:getTMByTypeAndBindid(bindid,'ALARM_INFO')}
                            </td>
                            <td>
                                <%--<a href="${ctx}/admin/account/templateMessageDetail?tmtype=ALARM_INFO&tmname=消防报警信息" type="button" class="btn btn-sm btn-dangernew  a-noline" style="color: #fff" >修 &nbsp; 改</a>--%>
                                <a href="javascript:deleteTM('ALARM_INFO')" type="button" class="btn btn-sm btn-yellow a-noline" style="color: #fff" >删 &nbsp; 除</a>
                            </td>
                        </c:if>
                        <c:if test="${web:getTMByTypeAndBindid(bindid,'ALARM_INFO') eq null}">
                            <td>
                                未配置
                            </td>
                            <td>
                                <%--<a href="${ctx}/admin/account/templateMessageDetail?tmtype=ALARM_INFO&tmname=消防报警信息" type="button" class="btn btn-sm btn-dangernew  a-noline" style="color: #fff" >修 &nbsp; 改</a>--%>
                                    <a href="javascript:addTemplateMessage('${web:queryTmIdShortByName('消防报警信息')}', 'ALARM_INFO', '消防报警信息')" type="button" class="btn btn-sm btn-dangernew  a-noline" style="color: #fff" >添 &nbsp; 加</a></td>
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
                    <tr>
                        <td>
                                ${web:queryTmIdShortByName('订单待付款提醒')}
                        </td>
                        <td>
                            订单待付款提醒
                        </td>
                        <c:if test="${web:getTMByTypeAndBindid(bindid,'UNPAID') ne null}">
                            <td>
                                    ${web:getTMByTypeAndBindid(bindid,'UNPAID')}
                            </td>
                            <td>
                                <a href="javascript:deleteTM('UNPAID')" type="button" class="btn btn-sm btn-yellow a-noline" style="color: #fff" >删 &nbsp; 除</a>
                            </td>
                        </c:if>
                        <c:if test="${web:getTMByTypeAndBindid(bindid,'UNPAID') eq null}">
                            <td>
                                未配置
                            </td>
                            <td>
                                <a href="javascript:addTemplateMessage('${web:queryTmIdShortByName('订单待付款提醒')}', 'UNPAID', '订单待付款提醒')" type="button" class="btn btn-sm btn-dangernew  a-noline" style="color: #fff" >添 &nbsp; 加</a></td>
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