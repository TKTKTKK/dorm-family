<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/layout/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
</head>
<body>
<section id="content">
    <section class="vbox">
        <section class="scrollable padder">
            <header class="panel-heading">
                卡券 》 <span class="font-bold text-black"> 添加卡券</span>
            </header>
            <c:if test="${not empty wechatBinding && not empty wechatBinding.appid && not empty wechatBinding.appsecret && not empty wechatBinding.brand_name && not empty wechatBinding.logo_url}">

            <div class="row">
                <div class="col-sm-12">
                    <span class="text-success">${successMessage}</span>
                    <span class="text-danger">${errorMessage}</span>
                </div>
                <div class="col-sm-12">
                    <div class="form-group row">
                        <label class="col-sm-1">卡券类型:</label>
                        <div class="col-sm-3">
                            <select data-required="true" class="form-control" id="sltcard_type" onchange="selectCartType(this)">
                                <c:if test="${card_type == 'MEMBER_CARD'}">
                                    <option value="GENERAL_COUPON">优惠券</option>
                                    <option value="MEMBER_CARD" selected>会员卡</option>
                                </c:if>
                                <c:if test="${card_type != 'MEMBER_CARD'}">
                                    <option value="GENERAL_COUPON" selected>优惠券</option>
                                    <option value="MEMBER_CARD">会员卡</option>
                                </c:if>
                            </select>
                        </div>
                        <div class="col-sm-8"></div>
                    </div>
                </div>
                <div class="col-sm-12">
                <div class="row">
                <div class="col-sm-4 item-border">
                    <div class="row item-border-bottom" style="padding-right: 16px; padding-left: 15px">
                        <div class="col-sm-12 text-center text-white bg-black">
                            <c:if test="${card_type == 'MEMBER_CARD'}">
                                <H3>会员卡</H3>
                            </c:if>
                            <c:if test="${card_type != 'MEMBER_CARD'}">
                                <H3>优惠券</H3>
                            </c:if>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-12 btn-group btn-group-justified" style="width: 100%">
                            <div class="btn-group" style="width: 100%">
                                <button type="button" class="btn btn-default" onclick="showOrHidInfoDiv('baseInfo','consumSet','detailInfo','fitBusiness')" id="cardBtn"
                                        style="width: 100%">
                                    <div class="row" style="height: 200px">
                                        <div class="col-sm-2">
                                            <img src="${web:getFileViewUrl(wechatBinding.logo_url)}" width="50" height="50">
                                        </div>
                                        <div class="col-sm-5">
                                            <H4><b>${wechatBinding.brand_name}</b></H4>
                                        </div>
                                        <div class="col-sm-5">
                                        </div>
                                        <div class="col-sm-12 font-bold top-margin-twenty" id="titleForCard"></div>
                                        <div class="col-sm-12 font-normal top-margin-twenty" id="sub_titleForCard"></div>
                                        <div class="col-sm-12 font-normal top-margin-twenty" id="noticeForCard"></div>
                                    </div>
                                </button>
                            </div>
                        </div>
                    </div>
                    <div class="row item-border-bottom item-height">
                        <div class="col-sm-12 btn-group btn-group-justified" style="width: 100%">
                            <div class="btn-group" style="width: 100%">
                                <button type="button" class="btn btn-default" onclick="showOrHidInfoDiv('consumSet','baseInfo','detailInfo','fitBusiness')" id="consumSetBtn"
                                        style="width: 100%">
                                    <div class="col-sm-11">
                                        <div class="col-sm-12" id="consumSetInfo">销券设置</div>
                                        <div class="col-sm-12 hide-element" id="consumSetQrcode">
                                            <img src="${ctx}/static/admin/img/qrcode.png">
                                        </div>
                                        <div class="col-sm-12 font-bold hide-element" id="consumSetText">1230-4560-7890</div>
                                    </div>
                                    <div class="col-sm-1">＞</div>
                                </button>
                            </div>
                        </div>
                    </div>
                    <div class="row item-border-top item-height" style="margin-top: 10px">
                        <div class="col-sm-12 btn-group btn-group-justified" style="width: 100%">
                            <div class="btn-group" style="width: 100%">
                                <button type="button" class="btn btn-default" onclick="showOrHidInfoDiv('detailInfo','consumSet','baseInfo','fitBusiness')"
                                        style="width: 100%">
                                    <span class="col-sm-11">
                                        <c:if test="${card_type == 'MEMBER_CARD'}">
                                            会员卡详情
                                        </c:if>
                                        <c:if test="${card_type != 'MEMBER_CARD'}">
                                            优惠券详情
                                        </c:if>
                                    </span>
                                    <span class="col-sm-1">＞</span>
                                </button>
                            </div>
                        </div>
                    </div>
                    <div class="row item-border-top item-height">
                        <div class="col-sm-12 btn-group btn-group-justified" style="width: 100%">
                            <div class="btn-group" style="width: 100%">
                                <button type="button" class="btn btn-default" onclick="showOrHidInfoDiv('fitBusiness','consumSet','detailInfo','baseInfo')"
                                        style="width: 100%">
                                    <span class="col-sm-11">适用门店</span>
                                    <span class="col-sm-1">＞</span>
                                </button>
                            </div>
                        </div>
                    </div>


                </div>
                <div class="col-sm-8">
                <form class="form-horizontal" data-validate="parsley" action="${ctx}/admin/card/${actionStr}" method="post" onsubmit="return showAllInfoDiv()" id="cardForm">
                <div class="row" id="baseInfo">
                    <div class="col-sm-12">
                        <section class="panel panel-default">
                            <header class="panel-heading">
                                <strong>券面信息：</strong>
                            </header>
                            <div class="panel-body">
                                <div class="form-group">
                                    <label class="col-sm-3 control-label"><span class="text-danger">*</span>商家名称:</label>
                                    <div class="col-sm-9">
                                        <label class="control-label" style="padding-top: 4px">${wechatBinding.brand_name}</label>
                                        <input type="hidden" name="${preObj}.base_info.brand_name" value="${wechatBinding.brand_name}">
                                    </div>
                                </div>
                                <div class="line line-dashed b-b line-lg pull-in"></div>
                                <div class="form-group">
                                    <label class="col-sm-3 control-label">商家LOGO:</label>
                                    <div class="col-sm-9">
                                        <div class="col-sm-12 navbar-left" style="padding-left: 0px">
                                            <img src="${web:getFileViewUrl(wechatBinding.logo_url)}" width="50" height="50">
                                            <input type="hidden" name="${preObj}.base_info.logo_url" value="${wechatBinding.logo_url}">
                                        </div>
                                        <div class="col-sm-12 zero-padding-left">
                                            如商家信息有变更，请在 <a href="${ctx}/admin/card/brandInfo">商家信息</a> 开通页更新。
                                        </div>
                                    </div>
                                </div>

                                <div class="line line-dashed b-b line-lg pull-in"></div>
                                <div class="form-group">
                                    <label class="col-sm-3 control-label"><span class="text-danger">*</span>卡券颜色:</label>
                                    <div class="col-sm-9">
                                        <select data-required="true" class="form-control" id="color" name="${preObj}.base_info.color" onchange="selectColor()">
                                            <option value="" style="background-color: #ffffff" selected>请选择颜色</option>
                                            <c:forEach items="${commonCodeList}" var="commonCode">
                                                <option value="${commonCode.code}-${commonCode.codevalue}" style="background-color: ${commonCode.codevalue}"></option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>
                                <div class="line line-dashed b-b line-lg pull-in"></div>
                                <div class="form-group">
                                    <label class="col-sm-3 control-label"><span class="text-danger">*</span>
                                        <c:if test="${card_type == 'MEMBER_CARD'}">
                                            会员卡标题:
                                        </c:if>
                                        <c:if test="${card_type != 'MEMBER_CARD'}">
                                            优惠券标题:
                                        </c:if>
                                    </label>
                                    <div class="col-sm-9">
                                        <input type="text" name="${preObj}.base_info.title" class="form-control" id="title" data-required="true" data-maxlength="18" onblur="setTitleAndSubTitle(this, 'titleForCard', 18, 'titleError')"
                                               value="${article.title}">
                                        <span id="titleError" class="text-danger"></span>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-3 control-label">副标题:</label>
                                    <div class="col-sm-9">
                                        <input type="text" name="${preObj}.base_info.sub_title" class="form-control" data-maxlength="36" id="sub_title" value="${article.title}"
                                               onblur="setTitleAndSubTitle(this, 'sub_titleForCard', 36, 'sub_titleError')">
                                        <span id="sub_titleError" class="text-danger"></span>
                                    </div>
                                </div>
                                <div class="line line-dashed b-b line-lg pull-in"></div>
                                <div class="form-group">
                                    <label class="col-sm-3 control-label" style="padding-top: 24px"><span class="text-danger">*</span>有效期:</label>
                                    <div class="col-sm-9">
                                        <div class="radio row">
                                            <label class="col-sm-2 control-label"  style="text-align: left;padding-top: 4px">
                                                <input type="radio" name="${preObj}.base_info.date_info.type" id="type1" value="1"  onclick="compareBeginEndDate()" checked>
                                                <span>固定日期，</span>
                                            </label>
                                            <label class="col-sm-1 control-label" style="padding-top: 4px">从</label>
                                            <input class="input-sm input-s datepicker-input form-control col-sm-4" size="16" type="text" data-type="dateIso" name="begin_timestampstr"  value="${scheduleDate}"
                                                   placeholder="请选择起始日期" data-date-format="yyyy-mm-dd" id="begin_timestamp" readonly onchange="compareBeginEndDate()">
                                            <label class="col-sm-1  control-label"  style="padding-top: 4px">到</label>
                                            <input class="input-sm input-s datepicker-input form-control col-sm-4" size="16" type="text" data-type="dateIso" name="end_timestampstr"  value="${scheduleDate}"
                                                   placeholder="请选择截止日期" data-date-format="yyyy-mm-dd" id="end_timestamp" readonly onchange="compareBeginEndDate()">
                                        </div>
                                        <div class="radio row" style="margin-top: 20px">
                                            <label class="col-sm-2 control-label" style="text-align: left;padding-top: 4px">
                                                <input type="radio" name="${preObj}.base_info.date_info.type" id="type2" value="2" onclick="compareBeginEndDate()">
                                                领取后,
                                            </label>
                                            <select data-required="true" class="input-sm input-s-sm form-control col-sm-2" name="${preObj}.base_info.date_info.fixed_begin_term">
                                                <c:forEach items="${beginTermList}" var="beginTerm">
                                                    <option value="${beginTerm}">
                                                        <c:if test="${beginTerm == 0}">
                                                            当天
                                                        </c:if>
                                                        <c:if test="${beginTerm != 0}">
                                                            ${beginTerm}天
                                                        </c:if>
                                                    </option>
                                                </c:forEach>
                                            </select>
                                            <label class="col-sm-3 control-label" style="padding-top: 4px">
                                                <span>生效，</span>
                                                <span style="margin-left: 20px">有效天数</span>
                                            </label>
                                            <select data-required="true" class="input-sm input-s-sm form-control col-sm-2" name="${preObj}.base_info.date_info.fixed_term">
                                                <c:forEach items="${fixedTermList}" var="fixedTerm">
                                                    <c:if test="${fixedTerm == 30}">
                                                        <option value="${fixedTerm}" selected>${fixedTerm}天</option>
                                                    </c:if>
                                                    <c:if test="${fixedTerm != 30}">
                                                        <option value="${fixedTerm}">${fixedTerm}天</option>
                                                    </c:if>
                                                </c:forEach>
                                            </select>
                                            <label class="col-sm-1 control-label"></label>
                                        </div>
                                        <div class="col-sm-12 text-danger"  id="typeError">
                                        </div>

                                    </div>
                                </div>
                                <div class="form-group">
                                    <input type="hidden" name="newsid" value="${newsid}">
                                    <input type="hidden" name="uuid" value="${article.uuid}">
                                    <input type="hidden" name="versionno" value="${article.versionno}">
                                </div>
                            </div>

                        </section>
                    </div>
                </div>

                <div class="row hide-element" id="consumSet">
                    <div class="col-sm-12">
                        <section class="panel panel-default">
                            <header class="panel-heading">
                                <strong>领券设置：</strong>
                            </header>
                            <div class="panel-body">
                                <div class="form-group">
                                    <label class="col-sm-3 control-label"><span class="text-danger">*</span>库存:</label>
                                    <div class="col-sm-9">
                                        <div>
                                            <input type="text" name="${preObj}.base_info.sku.quantity" class="form-control input-s-lg col-sm-8" data-required="true" data-maxlength="64"
                                                   onblur="trimText(this),validQuantity(),compareGetLimitAndQuantity()" id="quantity" value="${article.title}">
                                            <label class="col-sm-1 control-label" style="padding-top: 4px;">份</label>
                                            <label class="col-sm-3"></label>
                                        </div>
                                        <div class="col-sm-12">
                                            <span id="quantityError" class="text-danger"></span>
                                        </div>
                                    </div>
                                </div>
                                <div class="line line-dashed b-b line-lg pull-in"></div>
                                <div class="form-group">
                                    <label class="col-sm-3 control-label">领券限制:</label>
                                    <div class="col-sm-9">
                                        <div>
                                            <input type="text" name="${preObj}.base_info.get_limit" class="form-control input-s-lg col-sm-8" data-maxlength="64"
                                                   onblur="trimText(this),compareGetLimitAndQuantity()"
                                                   id="get_limit" value="${article.title}">
                                            <label class="col-sm-1 control-label" style="padding-top: 4px;">张</label>
                                            <label class="col-sm-3"></label>
                                        </div>
                                        <div class="col-sm-12 zero-padding-left" style="padding-top: 4px;">
                                            每个用户领券上限，如不填，则默认为1
                                        </div>
                                        <div class="col-sm-12">
                                            <span id="get_limitError" class="text-danger"></span>
                                        </div>
                                    </div>
                                </div>
                                <div>
                                    <div class="col-sm-3"></div>
                                    <div class="col-sm-9 text-danger" id="compareGetLimitQuantityError"></div>
                                </div>
                                <div class="line line-dashed b-b line-lg pull-in"></div>
                                <div class="checkbox i-checks">
                                    <label class="col-sm-2"></label>
                                    <label class="col-sm-10">
                                        <input type="checkbox" name="${preObj}.base_info.can_share" checked><i></i> 用户可以分享领券链接
                                    </label>
                                </div>
                                <c:if test="${card_type != 'MEMBER_CARD'}">
                                    <div class="checkbox i-checks">
                                        <label class="col-sm-2"></label>
                                        <label class="col-sm-10">
                                            <input type="checkbox" name="${preObj}.base_info.can_give_friend" checked><i></i> 用户领券后可转赠其他好友
                                        </label>
                                    </div>
                                </c:if>
                            </div>

                        </section>
                        <section class="panel panel-default">
                            <header class="panel-heading">
                                <strong>销券设置：</strong>
                            </header>
                            <div class="panel-body">
                                <div class="form-group">
                                    <label class="col-sm-3 control-label"><span class="text-danger">*</span>销券方式:</label>
                                    <div class="col-sm-9">
                                        <div class="radio">
                                            <label class="col-sm-12">
                                                <input type="radio" name="${preObj}.base_info.code_type" id="code_type1" value="CODE_TYPE_TEXT" onclick="showConsumTypeForCard('CODE_TYPE_TEXT')">
                                                <b>仅卡券号</b>
                                            </label>
                                            <label class="col-sm-12">
                                                仅显示卡券号，验证后可进行销券
                                            </label>
                                        </div>
                                        <div class="radio" style="margin-top: 20px">
                                            <label class="col-sm-12">
                                                <input type="radio" name="${preObj}.base_info.code_type" id="code_type2" value="CODE_TYPE_QRCODE" onclick="showConsumTypeForCard('CODE_TYPE_QRCODE')">
                                                <b>二维码</b>
                                            </label>
                                            <label class="col-sm-12">
                                                包含卡券信息的二维码，扫描后可进行销券
                                            </label>
                                        </div>
                                        <div class="col-sm-12 text-danger" id="code_typeError"></div>
                                    </div>
                                </div>
                                <div class="line line-dashed b-b line-lg pull-in"></div>
                                <div class="form-group">
                                    <label class="col-sm-3 control-label"><span class="text-danger">*</span>操作提示:</label>
                                    <div class="col-sm-9">
                                        <input type="text" name="${preObj}.base_info.notice" class="form-control" data-maxlength="32" data-required="true"
                                               onblur="setNoticeForCard(this, 'noticeForCard', 32, 'noticeError')"
                                               id="notice" value="${article.title}">
                                        <span>建议引导用户到店出示卡券，由店员完成核销操作</span>
                                        <span id="noticeError" class="text-danger col-sm-12"></span>
                                    </div>
                                </div>
                            </div>
                        </section>
                    </div>
                </div>

                <div class="row hide-element" id="detailInfo">
                    <div class="col-sm-12">
                        <section class="panel panel-default">
                            <header class="panel-heading">
                                <strong>
                                    <c:if test="${card_type == 'MEMBER_CARD'}">
                                        会员卡详情：
                                    </c:if>
                                    <c:if test="${card_type != 'MEMBER_CARD'}">
                                        优惠券标题:
                                    </c:if>
                                </strong>
                            </header>
                            <div class="panel-body">
                                <c:if test="${card_type == 'MEMBER_CARD'}">
                                    <div class="checkbox i-checks">
                                        <label class="col-sm-2"></label>
                                        <label class="col-sm-10">
                                            <input type="checkbox" name="${preObj}.supply_bonus" id="member_card.supply_bonus" onclick="validBonus()"><i></i> 支持积分
                                        </label>
                                    </div>
                                    <div class="checkbox i-checks hidden">
                                        <label class="col-sm-2"></label>
                                        <label class="col-sm-10">
                                            <input type="checkbox" name="${preObj}.supply_balance" id="member_card.supply_balance" onclick="validBalanceRule()"><i></i> 支持储值
                                        </label>
                                    </div>
                                    <div class="line line-dashed b-b line-lg pull-in"></div>
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">积分清零规则:</label>
                                        <div class="col-sm-9">
                                            <textarea class="form-control" rows="6" name="${preObj}.bonus_cleared" id="bonus_cleared"  data-maxlength="2000"
                                                      onblur="validBonus(), validateChineseTextForTwo(2000, this, 'bonus_clearedError')">${branch.address}</textarea>
                                            <span id="bonus_clearedError" class="text-danger"></span>
                                        </div>
                                    </div>
                                    <div class="line line-dashed b-b line-lg pull-in"></div>
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">积分规则:</label>
                                        <div class="col-sm-9">
                                            <textarea class="form-control" rows="6" name="${preObj}.bonus_rules" id="bonus_rules"  data-maxlength="2000"
                                                      onblur="validBonus(), validateChineseTextForTwo(2000, this, 'bonus_rulesError')">${branch.address}</textarea>
                                            <span id="bonus_rulesError" class="text-danger"></span>
                                        </div>
                                    </div>
                                    <div>
                                        <div class="col-sm-3"></div>
                                        <div class="col-sm-9 text-danger" id="bonusError"></div>
                                    </div>
                                    <div class="line line-dashed b-b line-lg pull-in"></div>
                                    <div class="form-group hidden">
                                        <label class="col-sm-3 control-label">储值说明:</label>
                                        <div class="col-sm-9">
                                            <textarea class="form-control" rows="6" name="${preObj}.balance_rules" id="balance_rules"  data-maxlength="2000"
                                                      onblur="validBalanceRule(), validateChineseTextForTwo(2000, this, 'balance_rulesError')">${branch.address}</textarea>
                                            <span id="balance_rulesError" class="text-danger"></span>
                                        </div>
                                    </div>
                                    <div class="line line-dashed b-b line-lg pull-in"></div>
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label"><span class="text-danger">*</span>特权说明:</label>
                                        <div class="col-sm-9">
                                            <textarea class="form-control" rows="6" name="${preObj}.prerogative" id="prerogative" data-required="2000" data-maxlength="2000"
                                                      onblur="validateChineseTextForTwo(2000, this, 'prerogativeError')">${branch.address}</textarea>
                                            <span id="prerogativeError" class="text-danger"></span>
                                        </div>
                                    </div>
                                    <div class="line line-dashed b-b line-lg pull-in"></div>
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">绑定旧卡url:</label>
                                        <div class="col-sm-9">
                                            <input type="text" name="${preObj}.bind_old_card_url" data-type="url" class="form-control" data-maxlength="255" id="bind_old_card_url" value="${article.url}"
                                                   onblur="trimText(this),validateBindActiveUrl()">
                                        </div>
                                    </div>
                                    <div class="line line-dashed b-b line-lg pull-in"></div>
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">激活会员卡url:</label>
                                        <div class="col-sm-9">
                                            <input type="text" name="${preObj}.activate_url" data-type="url" class="form-control" data-maxlength="255" id="activate_url" value="${article.url}"
                                                   onblur="trimText(this),validateBindActiveUrl()">
                                        </div>
                                    </div>
                                    <div>
                                        <div class="col-sm-3"></div>
                                        <div class="col-sm-9 text-danger" id="bindOrActiveUrlError"></div>
                                    </div>
                                </c:if>
                                <c:if test="${card_type != 'MEMBER_CARD'}">
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label"><span class="text-danger">*</span>优惠券详情:</label>
                                        <div class="col-sm-9">
                                            <textarea class="form-control" rows="6" name="general_coupon.default_detail" id="default_detail" data-required="2000" data-maxlength="2000"
                                                      onblur="validateChineseTextForTwo(2000, this, 'default_detailError')">${branch.address}</textarea>
                                            <span id="default_detailError" class="text-danger"></span>
                                        </div>
                                    </div>
                                </c:if>
                                <div class="line line-dashed b-b line-lg pull-in"></div>
                                <div class="form-group">
                                    <label class="col-sm-3 control-label"><span class="text-danger">*</span>使用须知:</label>
                                    <div class="col-sm-9">
                                        <textarea class="form-control" rows="6" name="${preObj}.base_info.description" id="description" data-required="true" data-maxlength="2000"
                                                  onblur="validateChineseTextForTwo(2000, this, 'descriptionError')">${branch.address}</textarea>
                                        <span id="descriptionError" class="text-danger"></span>
                                    </div>
                                </div>
                                <div class="line line-dashed b-b line-lg pull-in"></div>
                                <div class="form-group">
                                    <label class="col-sm-3 control-label">客服电话：</label>
                                    <div class="col-sm-9">
                                        <input type="text" name="${preObj}.base_info.service_phone" class="form-control" data-type="phone" placeholder="(XXX) XXXX XXX" onblur="trimText(this)" value="${wpCommunity.contactno}">
                                    </div>
                                </div>
                                <p class="font-bold">说明：</p>
                                <p style="text-indent: 2em">1. 客服电话可填写手机或固话。</p>
                                <c:if test="${card_type == 'MEMBER_CARD'}">
                                    <p style="text-indent: 2em">2. 若支持积分，则积分相关字段为必填;否则不必填。</p>
                                    <p style="text-indent: 2em">3. 绑定旧卡url 与 激活会员卡url 二选一必填。</p>
                                </c:if>
                            </div>
                        </section>
                    </div>
                </div>

                <div class="row hide-element" id="fitBusiness">
                    <div class="col-sm-12">
                        <section class="panel panel-default">
                            <header class="panel-heading">
                                <strong>服务信息：</strong>
                            </header>
                            <div class="panel-body">
                                <div class="form-group">
                                    <label class="col-sm-3 control-label">适用门店:</label>
                                    <div class="col-sm-9">
                                        <div class="radio">
                                            <label class="col-sm-12">
                                                <input type="radio" name="location_id_list" id="fitbranch1" value="">
                                                指定门店适用
                                            </label>
                                            <label class="col-sm-12">
                                                <a href="#">添加适用门店</a>
                                            </label>
                                        </div>
                                        <div class="radio" style="margin-top: 20px">
                                            <label class="col-sm-12">
                                                <input type="radio" name="location_id_list" id="fitbranch2" value="" checked>
                                                无指定门店
                                            </label>
                                        </div>
                                        <div class="radio" style="margin-top: 20px">
                                            <label class="col-sm-12">
                                                <input type="radio" name="location_id_list" id="fitbranch3" value="">
                                                全部门店适用
                                            </label>
                                        </div>

                                    </div>
                                </div>

                            </div>


                        </section>
                    </div>
                </div>

                <div>
                    <input type="hidden" name="card_type" value="${card_type}" id="hidcard_type">
                </div>

                <footer class="panel-footer text-right bg-light lter">
                    <button type="submit" class="btn btn-success btn-s-xs">提 交</button>
                </footer>
                </form>
                </div>
                </div>
                </div>

            </div>
            </c:if>
            <c:if test="${empty wechatBinding}">
                <span>您还没有添加公众号，请先去</span>
                <a href="${ctx}/admin/account/search" class="text-info">添加公众号</a>
            </c:if>
            <c:if test="${not empty wechatBinding && (empty wechatBinding.appid || empty wechatBinding.appsecret)}">
                <span>您尚未被授权，请先进行 <a href="${ctx}/admin/account/authorizationSetting"  class="text-info">授权设置</a> 。</span>
            </c:if>
            <c:if test="${not empty wechatBinding && not empty wechatBinding.appid && not empty wechatBinding.appsecret && (empty wechatBinding.brand_name || empty wechatBinding.logo_url)}">
                <span>商家信息不完整，请完善 <a href="${ctx}/admin/card/brandInfo"  class="text-info">商家信息</a> 。</span>
            </c:if>
        </section>
    </section>
    <a href="#" class="hide nav-off-screen-block" data-toggle="class:nav-off-screen,open" data-target="#nav,html"></a>
</section>


<script type="text/javascript">
    //选择卡券类型
    function selectCartType(obj){
        window.location.href = "<%=request.getContextPath()%>/admin/card/createCard?card_type="+obj.value;
    }

    //信息div的隐藏和显示
    function showOrHidInfoDiv(showDivId, hideDiv1Id, hideDiv2Id, hideDiv3Id){
        document.getElementById(showDivId).style.display = "block";
        document.getElementById(hideDiv1Id).style.display = "none";
        document.getElementById(hideDiv2Id).style.display = "none";
        document.getElementById(hideDiv3Id).style.display = "none";

    }

    //显示所有信息div
    function showAllInfoDiv(){
        document.getElementById('baseInfo').style.display = "block";
        document.getElementById('consumSet').style.display = "block";
        document.getElementById('detailInfo').style.display = "block";
        document.getElementById('fitBusiness').style.display = "block";
        return submitCard();

    }

    //选择颜色
    function selectColor(){
        var color = document.getElementById('color');
        var cardBtn = document.getElementById('cardBtn');
        var selectedColor = '';
        //选择颜色时
        if(color.value.length > 0){
            selectedColor = color.value.split('-')[1];
        }

        //设置下拉框背景色
        color.style.backgroundColor = selectedColor;
        //设置卡券背景色
        cardBtn.style.backgroundColor = selectedColor;

    }

    //设置卡券标题和副标题内容
    function setTitleAndSubTitle(obj, titleId, maxlength, errorDivId){
        //验证合法性
        var titleValid = validateChineseTextForTwo(maxlength, obj, errorDivId);
        if(titleValid){
            var title = document.getElementById(titleId);
            title.innerHTML = obj.value;
        }
    }

    //设置卡券操作提示
    function setNoticeForCard(obj, noticeId, maxlength, errorDivId){
        //验证合法性
        var noticeValid = validateChineseTextForTwo(maxlength, obj, errorDivId);
        if(noticeValid){
            var notice = document.getElementById(noticeId);
            notice.innerHTML = '操作提示：' + obj.value;
        }
    }

    //根据销券方式设置card相应部分的显示
    function showConsumTypeForCard(selectType){
        var consumSetInfo = document.getElementById('consumSetInfo');
        var consumSetQrcode = document.getElementById('consumSetQrcode');
        var consumSetText = document.getElementById('consumSetText');

        //仅卡券号
        if(selectType == 'CODE_TYPE_TEXT'){
            consumSetInfo.style.display = "none";
            consumSetQrcode.style.display = "none";
            consumSetText.style.display = "block";
        }else if(selectType == 'CODE_TYPE_QRCODE'){
            //二维码
            consumSetInfo.style.display = "none";
            consumSetQrcode.style.display = "block";
            consumSetText.style.display = "block";
        }

        var code_typeError = document.getElementById('code_typeError');
        code_typeError.innerHTML = '';
    }


    //合法性验证
    //券面信息 比较起始日期与截止日期
    function compareBeginEndDate(){
        var types = document.getElementsByName('${preObj}.base_info.date_info.type');
        var typeError = document.getElementById('typeError');
        typeError.innerHTML = '';

        var selectedType = 0;
        for(var i=0; i<types.length; i++){
            if(types[i].checked){
                selectedType = types[i].value;
                break;
            }
        }


        //当有效期选择 固定日期 时
        if(selectedType == 1){
            var beginDate = document.getElementById('begin_timestamp');
            var endDate = document.getElementById('end_timestamp');
            //起始和截止日期均必填
            if(beginDate.value.length == 0){
                typeError.innerHTML = '起始日期必填';
                return false;
            }

            var bgDate = Date.parse(beginDate.value);
            var nowDate = new Date();
            //起始日期合法性
            if(bgDate <= nowDate){
                typeError.innerHTML = '起始日期必须大于当前时间';
                return false;
            }

            if(endDate.value.length == 0){
                typeError.innerHTML = '截止日期必填';
                return false;
            }

            //比较起始和截止日期的大小
            var edDate = Date.parse(endDate.value);
            if(bgDate > edDate){
                typeError.innerHTML = '起始日期不能大于截止日期';
                return false;
            }
        }
        return true;
    }

    //库存合法性
    function validQuantity(){
        //库存
        var quantity = document.getElementById('quantity');
        var quantityError = document.getElementById('quantityError');
        quantityError.innerHTML = '';

        var countRule = /^[1-9]\d*$/;
        if(quantity.value.length > 0 && !countRule.test(quantity.value)){
            quantityError.innerHTML = '库存应该为正整数';
            return false;
        }
        return true;
    }

    //领券限制 和 库存 的比较
    function compareGetLimitAndQuantity(){
        //领券限制
        var get_limit = document.getElementById('get_limit');
        //库存
        var quantity = document.getElementById('quantity');

        var compareGetLimitQuantityError = document.getElementById('compareGetLimitQuantityError');
        compareGetLimitQuantityError.innerHTML = '';

        var countRule = /^[1-9]\d*$/;
        if(get_limit.value.length > 0 && !countRule.test(get_limit.value)){
            compareGetLimitQuantityError.innerHTML = '领券限制应该为正整数';
            return false;
        }

        if(get_limit.value.length > 0 && quantity.value.length > 0 && get_limit.value > quantity.value){
            compareGetLimitQuantityError.innerHTML = '领券限制不能大于库存';
            return false;
        }
        return true;
    }

    //绑定旧卡url和激活会员卡url，二选一必填
    function validateBindActiveUrl(){
        var bind_old_card_url = document.getElementById('bind_old_card_url');
        var activate_url = document.getElementById('activate_url');
        var bindOrActiveUrlError = document.getElementById('bindOrActiveUrlError');
        bindOrActiveUrlError.innerHTML = '';
        //绑定旧卡url和激活会员卡url，二选一必填
        if((bind_old_card_url.value.length == 0 && activate_url.value.length == 0) || (bind_old_card_url.value.length > 0 && activate_url.value.length > 0) ){
            bindOrActiveUrlError.innerHTML = '绑定旧卡url和激活会员卡url，二选一必填';
            return false;
        }
        return true;
    }

    //若选择了支持积分，则积分清零规则和积分规则必填
    function validBonus(){
        var supply_bonus = document.getElementById('member_card.supply_bonus');
        var bonusError = document.getElementById("bonusError");
        bonusError.innerHTML = '';

        //若选择了支持积分，则积分清零规则和积分规则必填
        if(supply_bonus.checked) {
            var bonus_cleared = document.getElementById("bonus_cleared");
            var bonus_rules = document.getElementById("bonus_rules");
            if (bonus_cleared.value.length == 0 || bonus_rules.value.length == 0) {
                bonusError.innerHTML = '因为选择了支持积分，所以积分清零规则和积分规则必填';
                return false;
            }
        }
        return true;
    }

    //若选择了支持储值，则储值说明必填
    function validBalanceRule(){
        var supply_balance = document.getElementById('member_card.supply_balance');
        var balance_rules = document.getElementById('balance_rules');
        var balance_rulesError = document.getElementById('balance_rulesError');
        balance_rulesError.innerHTML = '';
        //若选择了支持储值，则储值说明必填
        if(supply_balance.checked){
            if(balance_rules.value.length == 0){
                balance_rulesError.innerHTML = '因为选择了支持储值，所以储值说明必填';
                return false;
            }
        }

        return true;
    }

    //提交卡券
    function submitCard(){
        var title = document.getElementById('title');
        //验证标题合法性
        var titleValid = validateChineseTextForTwo(18, title, 'titleError');

        var sub_title = document.getElementById('sub_title');
        //验证副标题合法性
        var sub_titleValid = validateChineseTextForTwo(36, sub_title, 'sub_titleError');

        //券面信息 比较起始日期与截止日期
        var beginEndDateValid = compareBeginEndDate();

        var code_typeValid = true;
        var code_typeError = document.getElementById('code_typeError');
        code_typeError.innerHTML = '';
        //判断销券方式是否已选
        var code_types = document.getElementsByName('${preObj}.base_info.code_type');
        var selectedType = '';
        for(var i=0; i<code_types.length; i++){
            if(code_types[i].checked){
                selectedType = code_types[i].value;
                break;
            }
        }
        //没选择
        if(selectedType.length == 0){
            code_typeError.innerHTML = '请选择销券方式';
            code_typeValid = false;
        }

        var notice = document.getElementById('notice');
        //验证操作提示合法性
        var noticeValid = validateChineseTextForTwo(32, notice, 'noticeError');

        var description = document.getElementById('description');
        //验证使用须知合法性
        var descriptionValid = validateChineseTextForTwo(2000, description, 'descriptionError');

        //库存合法性
        var quantityValid = validQuantity();

        //领券限制 和 库存 的比较
        var compareGetLimitQuantity = compareGetLimitAndQuantity();

        var validFlag = titleValid && titleValid && sub_titleValid && beginEndDateValid && code_typeValid && noticeValid  && descriptionValid && quantityValid
                && compareGetLimitQuantity;
        var hidcard_type = document.getElementById('hidcard_type').value;
        if(hidcard_type == 'MEMBER_CARD'){

            //若选择了支持积分，则积分清零规则和积分规则必填
            var bonusValid = validBonus();

            //若选择了支持储值，则储值说明必填
            var balanceValid = validBalanceRule();

            var bonus_cleared = document.getElementById('bonus_cleared');
            //积分清零规则合法性
            var bonusClearRuleValid = validateChineseTextForTwo(2000, bonus_cleared, 'bonus_clearedError');

            var bonus_rules = document.getElementById('bonus_rules');
            //积分规则合法性
            var bonusRuleValid = validateChineseTextForTwo(2000, bonus_rules, 'bonus_rulesError');

            var balance_rules = document.getElementById('balance_rules');
            //储值说明合法性
            var balanceRuleVlaid = validateChineseTextForTwo(2000, balance_rules, 'balance_rulesError');

            var prerogative = document.getElementById('prerogative');
            //特权说明合法性
            var prerogativeValid = validateChineseTextForTwo(2000, prerogative, 'prerogativeError');

            //绑定旧卡url和激活会员卡url，二选一必填
            var bindOrActiveUrlValid = validateBindActiveUrl();

            validFlag = validFlag && bonusValid && balanceValid && bonusClearRuleValid && bonusRuleValid && balanceRuleVlaid && prerogativeValid && bindOrActiveUrlValid;
        }else{
            var default_detail = document.getElementById('default_detail');
            //优惠券详情合法性
            var defaultDetailValid = validateChineseTextForTwo(2000, default_detail, 'default_detailError');

            validFlag = validFlag && defaultDetailValid;
        }

        return validFlag;
    }
</script>
</body>
</html>
