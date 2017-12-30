/**
 * Created by shanny on 12/16/2014.
 */
    //含有中文的最大长度验证
function validateChineseText(maxLength, value, errorSpanId){
    var errorSpan = document.getElementById(errorSpanId);
    //清空错误信息
    errorSpan.innerText = "";

    var sum = 0;
    for(var i=0; i<value.length; i++){
        if(value.charCodeAt(i)>127){
            sum += 3;
        }else{
            sum ++;
        }
    }

    if(sum <= maxLength){
        return true;
    }

    errorSpan.innerText = "该项的最大长度不能超过"+maxLength+"个字符，中文算作三个";

    return false;
}

//含有中文的最大长度验证(中文算作两个)
function validateChineseTextForTwo(maxLength, obj, errorSpanId){
    var errorSpan = document.getElementById(errorSpanId);
    //清空错误信息
    errorSpan.innerText = "";

    //去空格
//    obj.value = obj.value.trim();
    trimText(obj);

    var value = obj.value;

    var sum = 0;
    for(var i=0; i<value.length; i++){
        if(value.charCodeAt(i)>127){
            sum += 2;
        }else{
            sum ++;
        }
    }

    if(sum <= maxLength){
        return true;
    }

    errorSpan.innerText = "该项的最大长度不能超过"+maxLength+"个字符，中文算作两个";

    return false;
}

//去空格
function trimText(obj){
//    obj.value = obj.value.trim();
    if(obj.value.length > 0){
        obj.value = obj.value.replace(/(^\s*)|(\s*$)/g, "");
    }
}

//去0
function trimZero(number){
    number = number.replace(/(^0*)/g, "");
    return number;
}

//格式化楼栋号
function formatBuildingno(number){
    //去0
    number = trimZero(number);
    var numberRule = /^\d+$/;
    //是数字才加幢
    if(numberRule.test(number)){
        number += '幢';
    }
    return number;
}

//检查上传文件的大小
function checkFileSize(){
    $('#picUrlError').text('');
    $('input[type=file]').each(function()
    {
        //文件要求的指定大小
        var max_size = parseInt($(this).attr('data-max_size'));
        var isIE = /msie/i.test(navigator.userAgent) && !window.opera;
        $(this).change(function(evt)
        {
           // var files = evt.target.files; // 获得文件对象

            var fileSize = 0;
            if (isIE && !evt.target.files) {
                var filePath = evt.target.value;
                var fileSystem = new ActiveXObject("Scripting.FileSystemObject");
                var file = fileSystem.getFile(filePath);
                fileSize = file.size;

            } else {
                      fileSize = evt.target.files[0].size;
               }

            //检查文件大小
            if(fileSize > max_size){
                $('#picUrlError').text('文件最大不能超过' + (max_size/1000000) + 'M');
                return;
            }else{
                var frm = document.getElementById("frm");
                frm.submit();
            }
        });
    });
}

//显示父菜单
function showParentMenu(menuName){
    $.get(encodeURI("/admin/usermanage/queryPermitIdByMenuName?menuName="+menuName+ "&version=" + Math.random()),function(data,status){
        if(data.parentPermitId != null && data.parentPermitId.length > 0){
            document.getElementById(data.parentPermitId).click();
        }
    });
}

//格式化金额
function formatMoney(obj){
    if(obj.value.length > 0){
        obj.value = (obj.value*1).toFixed(2);
    }
}

//检查是否为PC端
function checkIfPC() {
    var userAgentInfo = navigator.userAgent;
    var Agents = ["Android", "iPhone",
        "SymbianOS", "Windows Phone",
        "iPad", "iPod"];
    var flag = true;
    for (var v = 0; v < Agents.length; v++) {
        if (userAgentInfo.indexOf(Agents[v]) > 0) {
            flag = false;
            break;
        }
    }
    return flag;
}

//ui block
function pleaseWait(){
    $.blockUI({
        // $.blockUI.defaults.message = "请稍候";(不写在$.blockUI({})里，写在外面)
        message: '<span style="font-size:13px;font-weight:bolder">请稍候</span>',

        // 指的是提示框的css
        css: {
            width: "90px",   // 宽度小一点
            top: "50%",
            left: "50%"
        },

        // 遮光罩的css
        // 等价$.blockUI.defaults.overlayCSS.backgroundColor = "#E4E7EC";
        overlayCSS: {
            backgroundColor: "#E4E7EC",
            opacity:"0.8"
        }
    });
}

//检查金额合法性
function validateMoney(obj, errorId){
    var errorObj = document.getElementById(errorId);
    errorObj.innerHTML = "";

    trimText(obj);
    if(obj.value.length > 0){
        var moneyRule = /^\d+(\.\d+)?$/;
        console.log(obj.value.length > 0 && (!(moneyRule.test(obj.value)) || obj.value*1 < 0));
        if(obj.value.length > 0 && (!(moneyRule.test(obj.value)) || obj.value*1 < 0)){
            errorObj.innerText = "输入金额非法";
            return false;
        }
        formatMoney(obj);
    }
    return true;
}


//本地压缩上传
function compressUploadPicture(that,path){
    var filepath=$(that).val();
    if(filepath=="")
    {
        return;
    }
    var extStart=filepath.lastIndexOf(".");
    var ext=filepath.substring(extStart,filepath.length).toUpperCase();
    if(".jpg|.png|.bmp|.jpeg".toUpperCase().indexOf(ext.toUpperCase())==-1){
        alert("只允许上传jpg、png、bmp、jpeg格式的图片");
        return false;
    }
    //以图片宽度为800进行压缩
    lrz(that.files[0], {
        width: 800
    })
        .then(function (rst) {
            //压缩后异步上传
            $.ajax({
                url : "/common/compressUploadPicture",
                type: "POST",
                data : {
                    imgdata:rst.base64,//压缩后的base值
                    ext : ext,
                    path : path
                },
                dataType:"json",
                cache:false,
                async:false,
                success : function(data) {
                    if(data.success)
                    {
                        if(1 === $(that).attr('data-max-count')*1){
                            $('#' + $(that).attr('id') + 'Container').html(
                                '<img src="' + data.message + '" style="margin-top: 3px;margin-left: 10px"' +
                                'onclick="viewBigImageForUpload(this)" data-toggle="modal" data-target=".bs-example-modal-lg-image"' +
                                '>' +
                                '<input type="checkbox" name="' + $(that).attr('id') + '" value="' + data.message + '" checked class="hidden">'
                            );
                        }else {
                            //alert(data.message);///data.message为上传成功后的文件路径
                            $('#' + $(that).attr('id') + 'Container').append(
                                '<img src="' + data.message + '" style="margin-top: 3px;margin-left: 10px"' +
                                'onclick="viewBigImageForUpload(this)" data-toggle="modal" data-target=".bs-example-modal-lg-image"' +
                                '>' +
                                '<input type="checkbox" name="' + $(that).attr('id') + '" value="' + data.message + '" checked class="hidden">'
                            );
                            if(undefined != $(that).attr('data-max-count') &&  $('#' + $(that).attr('id') + 'Container').children().length/2 >= $(that).attr('data-max-count')*1){
                                $('#' + $(that).attr('id') + 'UrlContainer').addClass('hidden');
                            }
                        }
                    }else{
                        alert(data.message);///data.message为上传失败原因
                    }

                },
                error : function(){
                    alert("上传失败");
                }
            });
        });
}

//查看大图
function viewBigImage(obj){
    //获取同级所有元素
    var imgs = $(obj).prevAll('img').andSelf();
    var nextImgs = $(obj).nextAll('img');
    Array.prototype.push.apply(imgs, nextImgs);

    $('#carousel-example-generic').empty();
    //加点
    $('#carousel-example-generic').append('<ol class="carousel-indicators"></ol>');
    for(var i=0; i<imgs.length; i++){
        //当前图片对应的点高亮
        if(i == $(obj).prevAll('img').length){
            $('.carousel-indicators').append(
                '<li data-target="#carousel-example-generic" data-slide-to="' + i + '" class="active"' +
                'id="carousel-example-generic-li' + i + '"></li>'
            );
        }else{
            $('.carousel-indicators').append(
                '<li data-target="#carousel-example-generic" data-slide-to="' + i + '"' +
                'id="carousel-example-generic-li' + i + '"></li>'
            );
        }
    }

    //加图片
    $('#carousel-example-generic').append('<div class="carousel-inner " role="listbox"></div>');
    for(var i=0; i<imgs.length; i++){
        //定位到当前图片
        if(i == $(obj).prevAll('img').length){
            $('.carousel-inner').append(
                '<div class="item active" id="carousel-example-generic-item' + i + '" name="' + $(imgs[i]).attr('name') + '">' +
                '<img src="' + $(imgs[i]).attr('src') + '"' +
                'style="margin: 0px auto;width: 100%">' +
                '</div>'
            );
        }else{
            $('.carousel-inner').append(
                '<div class="item" id="carousel-example-generic-item' + i + '">' +
                '<img src="' + $(imgs[i]).attr('src') + '"' +
                'style="margin: 0px auto;width: 100%">' +
                '</div>'
            );
        }

    }

    //添加上一页
    $('#carousel-example-generic').append(
        '<a class="left carousel-control" href="#carousel-example-generic" role="button" data-slide="prev">' +
        '<span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>' +
        '<span class="sr-only">Previous</span>' +
        '</a>'
    );
    //添加下一页
    $('#carousel-example-generic').append(
        '<a class="right carousel-control" href="#carousel-example-generic" role="button" data-slide="next">' +
        '<span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>' +
        '<span class="sr-only">Next</span>' +
        '</a>'
    );

}

//查看大图(上传图片)
function viewBigImageForUpload(obj){
    //获取同级所有元素
    var imgs = $(obj).prevAll('img').andSelf();
    var nextImgs = $(obj).nextAll('img');
    Array.prototype.push.apply(imgs, nextImgs);

    $('#carousel-example-generic').empty();

    //加图片
    $('#carousel-example-generic').append('<div class="carousel-inner " role="listbox"></div>');
    for(var i=0; i<imgs.length; i++){
        //定位到当前图片
        if(i == $(obj).prevAll('img').length){
            $('.carousel-inner').append(
                '<div class="item active" id="carousel-example-generic-item' + i + '">' +
                '<img src="' + $(imgs[i]).attr('src') + '"' +
                'style="margin: 0px auto;width: 100%">' +
                '</div>'
            );
        }else{
            $('.carousel-inner').append(
                '<div class="item" id="carousel-example-generic-item' + i + '">' +
                '<img src="' + $(imgs[i]).attr('src') + '"' +
                'style="margin: 0px auto;width: 100%">' +
                '</div>'
            );
        }

    }
}

//排序
function searchByOrder(tblname, orderStr){
    //升降序都没有，默认升序
    if($('#' + orderStr + 'Up').hasClass('hidden') && $('#' + orderStr + 'Down').hasClass('hidden')){
        $('#orderbyStr').val(tblname + orderStr + ' asc');
        $('.myOrderTbl .fa-arrow-up').addClass('hidden');
        $('.myOrderTbl .fa-arrow-down').addClass('hidden');
        $('#' + orderStr + 'Up').removeClass('hidden');
    }else if($('#' + orderStr + 'Up').hasClass('hidden') && !$('#' + orderStr + 'Down').hasClass('hidden')){
        //之前为降序，则现在为升序
        $('#orderbyStr').val(tblname + orderStr + ' asc');
        $('.myOrderTbl .fa-arrow-up').addClass('hidden');
        $('.myOrderTbl .fa-arrow-down').addClass('hidden');
        $('#' + orderStr + 'Up').removeClass('hidden');
    }else if(!$('#' + orderStr + 'Up').hasClass('hidden') && $('#' + orderStr + 'Down').hasClass('hidden')){
        //之前为升序，则现在为降序
        $('#orderbyStr').val(tblname + orderStr + ' desc');
        $('.myOrderTbl .fa-arrow-up').addClass('hidden');
        $('.myOrderTbl .fa-arrow-down').addClass('hidden');
        $('#' + orderStr + 'Down').removeClass('hidden');
    }
    //查询数据（排序）
    searchDataForOrder();
}

//自动查询缴费类型
function autoQueryFeeTypeList(obj, inputFlag, callback){
    trimText(obj);
    if($(obj).val().length >= 2){
        queryFeeTypeList(inputFlag, callback);
    }
}

//查询缴费类型列表
function queryFeeTypeList(inputFlag, callback){
    trimText(document.getElementById('feetype'));
    var url = "/admin/family/queryFeeTypeList?feetype=" + $('#feetype').val() +"&version=" + Math.random();
    if(undefined != inputFlag){
        url = "/admin/family/queryInputFeeTypeList?feetype=" + $('#feetype').val() +"&version=" + Math.random();
    }
    $.get(url
        ,function(data,status){
            $('#feetypeUl').html('');
            if(data.feeTypeList.length > 0){
                $('#feetypeUl').removeClass('hidden');
                $('#feetypeUlClose').removeClass('hidden');
            }else{
                $('#feetypeUl').addClass('hidden');
                $('#feetypeUlClose').addClass('hidden')
            }

            for(var i=0; i<data.feeTypeList.length; i++){
                $('#feetypeUl').append('<li class="pading">' + data.feeTypeList[i] + '</li>');
            }

            $('.pading').on('click', function(){
                $('#feetype').val($(this).text());
                if(undefined != callback){
                    callback();
                }
                $('#feetypeUl').addClass('hidden');
                $('#feetypeUlClose').addClass('hidden');
            });
            $('#feetypeUlClose').on('click', function(){
                $('#feetypeUl').addClass('hidden');
                $('#feetypeUlClose').addClass('hidden');
            });
        });
}

//自动查询发票列表
function autoQueryInvoiceList(obj){
    trimText(obj);
    if($(obj).val().length >= 2){
        queryInvoiceList();
    }
    $('#invoiceid').val('')
}

//查询发票列表
function queryInvoiceList(){
    trimText(document.getElementById('invoiceno'));
    $.get("/admin/family/queryInvoiceListByInvoiceNo?invoiceNo=" + $('#invoiceno').val() + "&version=" + Math.random()
        ,function(data,status){
            $('#invoiceUl').html('');
            if(undefined != data.wpInvoiceList && data.wpInvoiceList.length > 0){
                $('#invoiceUl').removeClass('hidden');
                $('#invoiceUlClose').removeClass('hidden');
                //发票号码存在，则隐藏发票状态
                $('#invoiceStatusDiv').addClass('hidden');

                for(var i=0; i<data.wpInvoiceList.length; i++){
                    $('#invoiceUl').append('<li class="pading" id="' + data.wpInvoiceList[i].uuid + '">' + data.wpInvoiceList[i].invoiceno + '</li>');
                }

                $('.pading').on('click', function(){
                    $('#invoiceid').val($(this).attr('id'));
                    $('#invoiceno').val($(this).text());
                    $('#invoiceUl').addClass('hidden');
                    $('#invoiceUlClose').addClass('hidden');
                });
                $('#invoiceUlClose').on('click', function(){
                    $('#invoiceUl').addClass('hidden');
                    $('#invoiceUlClose').addClass('hidden');
                });
            }else if($('#invoiceno').val().length > 0){
                //发票号码不存在，则显示发票状态
                $('#invoiceStatusDiv').removeClass('hidden');
                //隐藏发票列表
                $('#invoiceUl').addClass('hidden');
                $('#invoiceUlClose').addClass('hidden');
            }
        });
}

//选中或取消选中点选框
function setSelectRadio(radioObj){
    var radioCheck= $(radioObj).attr("my-value");
    if("1" == radioCheck){
        $(radioObj).attr("checked",false);
        $(radioObj).attr("my-value", "0");

    }else{
        $('#' + $($(radioObj).parents('form')[0]).attr('id') + ' input[name='+ $(radioObj).attr('name') +']').attr("my-value", "0");
        $(radioObj).attr("checked", true);
        $(radioObj).attr("my-value", "1");
    }
}

//身份证号码验证
function IdentityCodeValid(code, errorSpanId){

    var errorSpan = document.getElementById(errorSpanId);
    //清空错误信息
    errorSpan.innerText = "";
    var city={11:"北京",12:"天津",13:"河北",14:"山西",15:"内蒙古",21:"辽宁",22:"吉林",23:"黑龙江 ",31:"上海",32:"江苏",33:"浙江",34:"安徽",35:"福建",36:"江西",37:"山东",41:"河南",42:"湖北 ",43:"湖南",44:"广东",45:"广西",46:"海南",50:"重庆",51:"四川",52:"贵州",53:"云南",54:"西藏 ",61:"陕西",62:"甘肃",63:"青海",64:"宁夏",65:"新疆",71:"台湾",81:"香港",82:"澳门",91:"国外 "};
    var tip = "";
    var pass= true;

    if(!code || !/^[1-9]\d{5}((1[89]|20)\d{2})(0[1-9]|1[0-2])(0[1-9]|[12]\d|3[01])\d{3}[\dx]$/i.test(code)){
        tip = "身份证号格式错误";
        pass = false;
    }

    else if(!city[code.substr(0,2)]){
        tip = "地址编码错误";
        pass = false;
    }
    else{
        //18位身份证需要验证最后一位校验位
        if(code.length == 18){
            code = code.split('');
            //∑(ai×Wi)(mod 11)
            //加权因子
            var factor = [ 7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2 ];
            //校验位
            var parity = [ 1, 0, 'X', 9, 8, 7, 6, 5, 4, 3, 2 ];
            var sum = 0;
            var ai = 0;
            var wi = 0;
            for (var i = 0; i < 17; i++)
            {
                ai = code[i];
                wi = factor[i];
                sum += ai * wi;
            }
            var last = parity[sum % 11];
            if(parity[sum % 11] != code[17].toUpperCase()){
                tip = "校验位错误";
                pass =false;
            }
        }
    }
    if(!pass) errorSpan.innerText = tip;
    return pass;
}

//处理ie9及以下版本把placeholder当做value传值的问题
function dealIePlaceholderProblem(){
    if(navigator.appName == "Microsoft Internet Explorer"
        && parseInt(navigator.appVersion.split(";")[1].replace(/[ ]/g, "").replace("MSIE",""))<=9){
        $('input[placeholder]').each(function(){
            trimText(this);
            if($(this).attr('placeholder') == this.value){
                //置空
                this.value = '';
            }
        });
    }
}

//计算两个日期相差几个月
function monthDiff(d1, d2) {
    var months;
    months = (d2.getFullYear() - d1.getFullYear()) * 12;
    months = months - d1.getMonth() + 1;
    months = months + d2.getMonth();
    return months <= 0 ? 0 : months;
}

//格式化房间号
function formatRoomno(number){
    //去0
    number = trimZero(number);
    var numberRule = /^\d+$/;
    //是数字才加室
    if(numberRule.test(number)){
        number += '室';
    }
    return number;
}