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
            <header class="panel-heading bg-white text-md b-b">
                用户 /
                <a href="${ctx}/admin/usermanage/rolePermitManage">权限管理</a> /
                <span class="font-bold text-shallowred">角色</span>
            </header>
                <div class="col-sm-12 pos">
                    <div style="margin-bottom: 5px">
                        <span class="text-success">${successMessage}</span>
                        <span class="text-danger">${errorMessage}</span>
                    </div>
                    <form class="form-horizontal  form-bordered" data-validate="parsley" action="${ctx}/admin/usermanage/roleInfo" method="POST"
                          id="frm">
                        <section class="panel panel-default m-n">
                            <header class="panel-heading mintgreen">
                                <i class="fa fa-gift"></i>
                                <span class="text-lg">角色信息：</span>
                            </header>
                            <div class="panel-body p-0-15">
                                <div class="form-group">
                                    <label class="col-sm-3 control-label"><span class="text-danger">*</span>角色CODE：</label>
                                    <div class="col-sm-9 b-l bg-white">
                                        <input type="text" class="form-control" data-required="true" name="rolekey" id="rolekey" data-maxlength="30"
                                               onblur="validateChineseText(30, this, 'rolekeyError')" value="${platformRole.rolekey}"/>
                                        <c:if test="${'true' eq rolekeyExist}">
                                            <span class="text-danger">角色CODE ${platformRole.rolekey} 已存在，请重新输入</span>
                                        </c:if>
                                        <span id="rolekeyError" class="text-danger"></span>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-3 control-label"><span class="text-danger">*</span>角色名称：</label>
                                    <div class="col-sm-9 b-l bg-white">
                                        <input type="text" class="form-control" data-required="true" name="rolename" id="rolename" data-maxlength="90"
                                               onblur="validateChineseText(90, this, 'rolenameError')" value="${platformRole.rolename}"/>
                                        <c:if test="${'true' eq rolenameExist}">
                                            <span class="text-danger">角色名称 ${platformRole.rolename} 已存在，请重新输入</span>
                                        </c:if>
                                        <span id="rolenameError" class="text-danger"></span>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-sm-12">
                                        <input type="hidden" name="uuid" class="form-control" value="${platformRole.uuid}">
                                        <input type="hidden" name="versionno" class="form-control" value="${platformRole.versionno}">
                                    </div>
                                </div>
                            </div>
                            <div class="panel-footer text-left bg-light lter">
                                  <button type="submit" class="btn btn-submit btn-s-xs"><i class="fa fa-check"></i>&nbsp;提&nbsp;交</button>
                            </div>
                        </section>
                    </form>
            </div>
        </section>
    </section>
    <a href="#" class="hide nav-off-screen-block" data-toggle="class:nav-off-screen,open" data-target="#nav,html"></a>
</section>

<script type="text/javascript">
//    //提交用户信息
//    function submitRoleInfo(){
//        //检查角色Code
//        var rolekeyValid = validateChineseText(32, document.getElementById('rolekey'), 'rolekeyError');
//        //检查角色名称
//        var rolenameValid = validateChineseText(45, document.getElementById('rolename'), 'rolenameError');
//
//        return rolekeyValid && rolenameValid;
//    }

</script>

</body>
</html>