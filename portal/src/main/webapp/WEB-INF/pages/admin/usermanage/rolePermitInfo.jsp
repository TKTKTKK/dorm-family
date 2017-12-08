<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/layout/taglib.jsp" %>
<!DOCTYPE html>
<html lang="en" class="app">
<head>

</head>
<body class="">

<section id="content">
    <section class="vbox">
        <section class="scrollable padder">
            <header class="panel-heading">
                用户 》
                <a href="${ctx}/admin/usermanage/rolePermitManage">权限管理</a> 》
                <span class="font-bold text-black">权限</span>
            </header>
            <div class="row">
                <div class="col-sm-2">
                </div>
                <div class="col-sm-8">
                    <div style="margin-bottom: 5px">
                        <span class="text-success">${successMessage}</span>
                        <span class="text-danger">${errorMessage}</span>
                    </div>
                    <form class="form-horizontal" data-validate="parsley" action="${ctx}/admin/usermanage/rolePermitInfo" method="POST"
                          id="frm">
                        <section class="panel panel-default">
                            <header class="panel-heading">
                                <strong>资源分配：</strong>
                            </header>
                            <div class="panel-body">
                                <div class="form-group">
                                    <label class="col-sm-3 control-label"><span class="text-danger">*</span>角色名称：</label>
                                    <div class="col-sm-9">
                                        <input type="text" class="form-control" data-required="true" name="rolename" id="rolename" data-maxlength="90"
                                               onblur="validateChineseText(90, this, 'rolenameError')" value="${platformRolePermit.rolename}" readonly/>
                                    </div>
                                </div>
                                <div class="line line-dashed b-b line-lg pull-in"></div>
                                <div class="form-group">
                                    <label class="col-sm-3 control-label">权限资源：</label>
                                    <div class="col-sm-9">
                                        <c:if test="${fn:length(permitList) > 0}">
                                            <div class="row checkbox i-checks" id="permitids" >
                                                <c:if test="${fn:length(permitList) > 1}">
                                                    <div class="row col-sm-12">
                                                        <label class="checkbox m-n col-sm-3">
                                                            <input type="checkbox" name="sltAll" value="" id="sltAll"
                                                                   onclick="selectAllOrNone('permitid','sltAll')"><i></i>全选
                                                        </label>
                                                    </div>
                                                </c:if>
                                                <c:forEach items="${permitList}" var="permit">
                                                    <div class="row col-sm-12" style="margin-top: 10px;">
                                                        <label class="checkbox m-n col-sm-3">
                                                            <c:if test="${fn:contains(platformRolePermit.permitnames, permit.permitname)}">
                                                                <input type="checkbox" name="permitid" value="${permit.uuid}" checked
                                                                       onclick="modifySelectAllOrNone('permitid','sltAll')"><i></i>${permit.permitname}
                                                            </c:if>
                                                            <c:if test="${!fn:contains(platformRolePermit.permitnames, permit.permitname)}">
                                                                <input type="checkbox" name="permitid" value="${permit.uuid}"
                                                                       onclick="modifySelectAllOrNone('permitid','sltAll')"><i></i>${permit.permitname}
                                                            </c:if>
                                                        </label>
                                                    </div>
                                                    <div class="row col-sm-12">
                                                        <c:forEach items="${permit.childPermits}" var="childpermit">
                                                            <label class="checkbox m-n col-sm-3">
                                                                <c:if test="${fn:contains(platformRolePermit.permitnames, childpermit.permitname)}">
                                                                    <input type="checkbox" name="permitid" value="${childpermit.uuid}" checked
                                                                           onclick="modifySelectAllOrNone('permitid','sltAll')"><i></i>${childpermit.permitname}
                                                                </c:if>
                                                                <c:if test="${!fn:contains(platformRolePermit.permitnames, childpermit.permitname)}">
                                                                    <input type="checkbox" name="permitid" value="${childpermit.uuid}"
                                                                           onclick="modifySelectAllOrNone('permitid','sltAll')"><i></i>${childpermit.permitname}
                                                                </c:if>
                                                            </label>
                                                        </c:forEach>
                                                    </div>
                                                </c:forEach>
                                                <div class="row col-sm-12">
                                                    <span id="permitidsError" class="text-danger"></span>
                                                </div>
                                            </div>
                                        </c:if>
                                        <c:if test="${fn:length(permitList) == 0}">
                                            <div style="margin-top: 8px">
                                                您暂无权限资源
                                            </div>
                                        </c:if>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-sm-12">
                                        <input type="hidden" name="roleid" class="form-control" value="${platformRolePermit.roleid}">
                                    </div>
                                </div>
                            </div>
                            <footer class="panel-footer text-right bg-light lter">
                                <button type="submit" class="btn btn-success btn-s-xs">提 交</button>
                            </footer>
                        </section>
                    </form>

                </div>
                <div class="col-sm-2">
                </div>
            </div>
        </section>
    </section>
    <a href="#" class="hide nav-off-screen-block" data-toggle="class:nav-off-screen,open" data-target="#nav,html"></a>
</section>

<script type="text/javascript">
    //全选 或 全不选
    function selectAllOrNone(permitid, sltAll){
        var permitids = document.getElementsByName(permitid);
        for(var i=0; i<permitids.length; i++){
            //全选
            if(document.getElementById(sltAll).checked){
                if(!permitids[i].checked){
                    permitids[i].checked = true;
                }
            }else{
                //全不选
                if(permitids[i].checked){
                    permitids[i].checked = false;
                }
            }

        }
    }

    //小区选择的个数
    function querySltCount(permitid){
        var permitids = document.getElementsByName(permitid);
        var sltCount = 0;
        for(var i=0; i<permitids.length; i++){
            if(permitids[i].checked){
                sltCount ++;
            }
        }
        return sltCount;
    }

    //修改全选、全不选
    function modifySelectAllOrNone(permitid,sltAll){
        var permitids = document.getElementsByName(permitid);
        //小区选择的个数
        var sltCount = querySltCount(permitid);
        if(sltCount == permitids.length){
            var sltAllChk = document.getElementById(sltAll);
            if(undefined != sltAllChk && null != sltAllChk){
                sltAllChk.checked = true;
            }
        }else{
            var sltAllChk = document.getElementById(sltAll);
            if(undefined != sltAllChk && null != sltAllChk){
                sltAllChk.checked = false;
            }
        }
    }


</script>

</body>
</html>