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
                <span class="font-bold text-shallowred">修改密码</span>
            </header>
                <div class="col-sm-12 pos">
                    <div>
                        <span class="text-success">${successMessage}</span>
                        <span class="text-danger">${errorMessage}</span>
                    </div>
                    <form class="form-horizontal  form-bordered" data-validate="parsley" action="${ctx}/admin/changePassword" method="POST" onsubmit="return changePassword()" style="margin-top: 20px">
                        <section class="panel panel-default  m-n">
                            <header class="panel-heading mintgreen">
                                <i class="fa fa-gift"></i>
                                <span class="text-lg">请填写如下信息：</span>
                            </header>
                            <div class="panel-body p-0-15">
                                <div class="form-group">
                                    <label class="col-sm-3 control-label"><span class="text-danger">*</span>原始密码：</label>
                                    <div class="col-sm-9 b-l bg-white">
                                        <input type="password" class="form-control" data-required="true" name="oldPassword" id="oldPwd" onblur="checkPassword(this.value, 'oldPasswordError')">
                                        <span id="oldPasswordError" class="text-danger"></span>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-3 control-label"><span class="text-danger">*</span>新密码：</label>
                                    <div class="col-sm-9 b-l bg-white">
                                        <input type="password" class="form-control" data-required="true" name="newPassword" id="pwd" onblur="checkPassword(this.value, 'passwordError')">
                                        <span id="passwordError" class="text-danger"></span>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-3 control-label"><span class="text-danger">*</span>确认密码：</label>
                                    <div class="col-sm-9 b-l bg-white">
                                        <input type="password" class="form-control" data-required="true" name="newPassword2" id="pwd2" data-equalto="#pwd">
                                    </div>
                                </div>
                            </div>
                            <div class="panel-footer text-left bg-light lter">
                                <button type="submit" class="btn btn-success btn-s-xs"><i class="fa fa-check"></i>&nbsp;提&nbsp;交</button>
                            </div>
                        </section>
                    </form>
            </div>
        </section>
    </section>
    <a href="#" class="hide nav-off-screen-block" data-toggle="class:nav-off-screen,open" data-target="#nav,html"></a>
</section>

<script type="text/javascript">

    //验证密码合法性
    function checkPassword(userPassword, errorId){
        var passwordError = document.getElementById(errorId);
        passwordError.innerText = "";
        var pwdRes = /^[A-Za-z0-9_#@]{6,16}$/;
        //var pwdRes = /((?!^\\d+$)(?!^[a-zA-Z]+$)(?!^[_#@]+$)){8,}/;
        if(!pwdRes.test(userPassword)){
            passwordError.innerText = "该项只能输入字母、数字及特殊符号（_#@），且只能输入6-16位";
            return false;
        }

        return true;
    }

    //修改密码
    function changePassword(){
        //验证原始密码
        var oldPwdValid = checkPassword(document.getElementById("oldPwd").value, "oldPasswordError");
        //验证新密码
        var pwdValid = checkPassword(document.getElementById("pwd").value, "passwordError");
        if(!oldPwdValid || !pwdValid){
            return false;
        }
        return true;
    }
</script>
</body>
</html>