var jsSdkUrl="";
var jsSdkAppid="";
var wechatUtil = (function ($) {

    if (typeof isWechatBrowser == "undefined") {
        var isWechatBrowser = function () {
            var ua = window.navigator.userAgent.toLowerCase();
            return ua.match(/MicroMessenger/i) == 'micromessenger';
        };
    }

    if (typeof requestJssdkSign == "undefined") {
        var requestJssdkSign = function (url, success, error) {
            $.ajax({
                url: "/api/requestJssdkSign",
                type: "POST",
                dataType: "json",
                data: {
                    url: url
                },
                success: success,
                error: error
            });
        };
    }

    if (typeof initWechat == "undefined") {
        var initWechat = function (url, apiList, ready, error) {
            if(jsSdkUrl == url){
                ready();
            }else{
                requestJssdkSign(url, function (data) {
                    wx.config({
                        debug: false, // 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
                        appId: data.appid, // 必填，公众号的唯一标识
                        timestamp: data.timestamp, // 必填，生成签名的时间戳
                        nonceStr: data.nonceStr, // 必填，生成签名的随机串
                        signature: data.signature,// 必填，签名，见附录1
                        jsApiList: apiList // 必填，需要使用的JS接口列表，所有JS接口列表见附录2
                    });
                    wx.error(function (err) {
                        error(err)
                    });
                    wx.ready(function () {
                        jsSdkAppid = data.appid;
                        ready(data)
                    })
                });
                if(jsSdkAppid != ""){
                    jsSdkUrl = url;
                }
            }

        };
    }

    if (typeof checkJsApi == "undefined") {
        var checkJsApi = function (api, success, fail) {
            wx.checkJsApi({
                jsApiList: [api],
                success: function (res) {
                    if (res.checkResult[api]) {
                        success();
                    } else {
                        fail();
                    }
                }
            });
        }
    }

    if (typeof previewImage == "undefined") {
        var previewImage = function(currentUrl, imageUrls) {
            initWechat(location.href, ["previewImage"], function() {
                wx.previewImage({
                    current: currentUrl, // 当前显示图片的http链接
                    urls: imageUrls // 需要预览的图片http链接列表
                });
            })
        }
    }

    if (typeof getLocation == "undefined") {
        var getLocation = function (options) {
            var opts = $.extend(getLocation.defaults, options);
            initWechat(location.href, ["getLocation"], function () {
                wx.getLocation({
                    type: 'wgs84', // 默认为wgs84的gps坐标，如果要返回直接给openLocation用的火星坐标，可传入'gcj02'
                    success: opts.success,
                    fail: opts.fail,
                    cancel: opts.cancel
                });
            }, opts.error)
        };

        getLocation.defaults = {
            success: function (resp) {
                console.info(JSON.stringify(resp))
            },
            fail: function (resp) {
                console.info(JSON.stringify(resp))
            },
            cancel: function (resp) {
                console.info(JSON.stringify(resp))
            },
            error: function (resp) {
                console.info(JSON.stringify(resp))
            }
        };
    }

    if (typeof openLocation == "undefined") {
        var openLocation = function (options) {
            var opts = $.extend(getLocation.defaults, options);
            initWechat(location.href, ["openLocation"], function () {

                wx.openLocation({
                    latitude: opts.latitude, // 纬度，浮点数，范围为90 ~ -90
                    longitude: opts.longitude, // 经度，浮点数，范围为180 ~ -180。
                    name: opts.name, // 位置名
                    address: opts.address, // 地址详情说明
                    scale: 15, // 地图缩放级别,整形值,范围从1~28。默认为最大
                    infoUrl: '' // 在查看位置界面底部显示的超链接,可点击跳转
                });
            }, opts.error)
        };

        openLocation.defaults = {
            success: function (resp) {
                console.info(JSON.stringify(resp))
            },
            fail: function (resp) {
                console.info(JSON.stringify(resp))
            },
            cancel: function (resp) {
                console.info(JSON.stringify(resp))
            },
            error: function (resp) {
                console.info(JSON.stringify(resp))
            }
        };
    }

    if (typeof hideNonBaseMenu == "undefined") {
        var hideNonBaseMenu = function (options) {
            var opts = $.extend(hideNonBaseMenu.defaults, options);
            initWechat(location.href, ["hideAllNonBaseMenuItem"], function () {
                wx.hideAllNonBaseMenuItem();
            }, opts.error)
        };

        hideNonBaseMenu.defaults = {
            success: function (resp) {
                console.info(JSON.stringify(resp))
            },
            fail: function (resp) {
                console.info(JSON.stringify(resp))
            },
            cancel: function (resp) {
                console.info(JSON.stringify(resp))
            },
            error: function (resp) {
                console.info(JSON.stringify(resp))
            }
        };
    }

    if (typeof hideMenuItems == "undefined") {
        var hideMenuItems = function (options) {
            var opts = $.extend(hideMenuItems.defaults, options);
            initWechat(location.href, ["hideMenuItems"], function () {
                wx.hideMenuItems({
                    menuList: options.menuList // 要显示的菜单项，所有menu项见附录3
                });
            }, opts.error)
        };

        hideMenuItems.defaults = {
            success: function (resp) {
                console.info(JSON.stringify(resp))
            },
            fail: function (resp) {
                console.info(JSON.stringify(resp))
            },
            cancel: function (resp) {
                console.info(JSON.stringify(resp))
            },
            error: function (resp) {
                console.info(JSON.stringify(resp))
            }
        };
    }
    if (typeof showNonBaseMenu == "undefined") {
        var showNonBaseMenu = function (options) {
            var opts = $.extend(showNonBaseMenu.defaults, options);
            initWechat(location.href, ["showAllNonBaseMenuItem"], function () {
                wx.showAllNonBaseMenuItem();
            }, opts.error)
        };

        showNonBaseMenu.defaults = {
            success: function (resp) {
                console.info(JSON.stringify(resp))
            },
            fail: function (resp) {
                console.info(JSON.stringify(resp))
            },
            cancel: function (resp) {
                console.info(JSON.stringify(resp))
            },
            error: function (resp) {
                console.info(JSON.stringify(resp))
            }
        };
    }
    if (typeof showMenuItems == "undefined") {
        var showMenuItems = function (options) {
            var opts = $.extend(showMenuItems.defaults, options);
            initWechat(location.href, ["showMenuItems"], function () {
                wx.showMenuItems({
                    menuList: options.menuList, // 要显示的菜单项，所有menu项见附录3
                });
            }, opts.error)
        };

        showMenuItems.defaults = {
            success: function (resp) {
                console.info(JSON.stringify(resp))
            },
            fail: function (resp) {
                console.info(JSON.stringify(resp))
            },
            cancel: function (resp) {
                console.info(JSON.stringify(resp))
            },
            error: function (resp) {
                console.info(JSON.stringify(resp))
            }
        };
    }

    if (typeof chooseImage == "undefined") {
        var chooseImage = function (options) {
            var opts = $.extend(chooseImage.defaults, options);
            initWechat(location.href, ["chooseImage","uploadImage"], function () {
                wx.chooseImage({
                    count: opts.count, // 默认9
                    sizeType: opts.sizeType, // 可以指定是原图还是压缩图，默认二者都有
                    sourceType: opts.sourceType, // 可以指定来源是相册还是相机，默认二者都有,
                    success:opts.success,
                    fail:opts.fail
                });
            }, opts.error)
        };

        chooseImage.defaults = {
            success: function (resp) {
                console.info(JSON.stringify(resp)); // 返回选定照片的本地ID列表，localId可以作为img标签的src属性显示图片
            },
            fail: function (resp) {
                console.info(JSON.stringify(resp))
            },
            cancel: function (resp) {
                console.info(JSON.stringify(resp))
            },
            error: function (resp) {
                console.info(JSON.stringify(resp))
            }
        };
    }

    if (typeof uploadImage == "undefined") {
        var uploadImage = function (options) {
            var opts = $.extend(uploadImage.defaults, options);
            initWechat(location.href, ["chooseImage","uploadImage"], function () {
                wx.uploadImage({
                    localId: opts.localId, // 需要上传的图片的本地ID，由chooseImage接口获得
                    isShowProgressTips: opts.isShowProgressTips,// 默认为1，显示进度提示
                    success:opts.success,
                    fail:opts.fail
                });
            }, opts.error)
        };

        uploadImage.defaults = {
            success: function (resp) {
                console.info(JSON.stringify(resp)); // 返回图片的服务器端ID
            },
            fail: function (resp) {
                console.info(JSON.stringify(resp))
            },
            cancel: function (resp) {
                console.info(JSON.stringify(resp))
            },
            error: function (resp) {
                console.info(JSON.stringify(resp))
            }
        };
    }

   if (typeof getLocalImgData == "undefined") {
        var getLocalImgData = function (options) {
            var opts = $.extend(getLocalImgData.defaults, options);
            initWechat(location.href, ["getLocalImgData"], function () {
                wx.getLocalImgData({
                    localId: opts.localId, // 图片的localID
                    success: opts.success
                });
            }, opts.error)
        };

       getLocalImgData.defaults = {
            success: function (resp) {
                console.info(JSON.stringify(resp)); // 返回图片的服务器端ID
            },
            fail: function (resp) {
                console.info(JSON.stringify(resp))
            },
            cancel: function (resp) {
                console.info(JSON.stringify(resp))
            },
            error: function (resp) {
                console.info(JSON.stringify(resp))
            }
        };
    }

    if (typeof downloadImage == "undefined") {
        var downloadImage = function (options) {
            var opts = $.extend(downloadImage.defaults, options);
            initWechat(location.href, ["downloadImage"], function () {
                wx.downloadImage({
                    serverId: opts.serverId, // 需要下载的图片的服务器端ID，由uploadImage接口获得
                    isShowProgressTips: opts.isShowProgressTips, // 默认为1，显示进度提示
                    success:opts.success,
                    fail:opts.fail
                });
            }, opts.error)
        };

        downloadImage.defaults = {
            success: function (resp) {
                console.info(JSON.stringify(resp.localId)); // 返回图片下载后的本地ID
            },
            fail: function (resp) {
                console.info(JSON.stringify(resp))
            },
            cancel: function (resp) {
                console.info(JSON.stringify(resp))
            },
            error: function (resp) {
                console.info(JSON.stringify(resp))
            }
        };
    }
    if (typeof onMenuShareAppMessage == "undefined") {
        var onMenuShareAppMessage = function (options) {
            var opts = $.extend(onMenuShareAppMessage.defaults, options);
            initWechat(location.href, ["onMenuShareAppMessage"], function () {
                //code&state不参与分享
                console.log("onMenuShareAppMessage");
                var url = opts.url.replace(/code=/, "").replace(/state=/, "");

                var link = wechatOauth2Url(jsSdkAppid, url, opts.userInfoScope ? "userinfo" : "base", "123");

                //var imgUrl = encodeURI(opts.imgUrl);
                var imgUrl = opts.imgUrl;
                if (imgUrl != null && imgUrl.indexOf("cmsstatic") > 0) {
                    imgUrl = encodeURI(imgUrl);
                }
                wx.onMenuShareAppMessage({
                    title: opts.title, // 分享标题
                    desc: opts.desc, // 分享描述
                    link: link, // 分享链接
                    imgUrl: imgUrl, // 分享图标
                    type: "link", // 分享类型,music、video或link，不填默认为link
                    dataUrl: "", // 如果type是music或video，则要提供数据链接，默认为空
                    success: opts.success,
                    cancel: opts.cancel
                });
            }, opts.error)
        };

        downloadImage.defaults = {
            success: function (resp) {
                console.info(JSON.stringify(resp.localId)); // 返回图片下载后的本地ID
            },
            fail: function (resp) {
                console.info(JSON.stringify(resp))
            },
            cancel: function (resp) {
                console.info(JSON.stringify(resp))
            },
            error: function (resp) {
                console.info(JSON.stringify(resp))
            }
        };
    }

    if (typeof share == "undefined") {
        var share = function (options) {
            var opts = $.extend(share.defaults, options);
            initWechat(location.href, ["onMenuShareAppMessage", "onMenuShareTimeline", "onMenuShareQQ"], function (data) {

                //code&state不参与分享
                var url = opts.url.replace(/code=/, "").replace(/state=/, "");

                var link = wechatOauth2Url(jsSdkAppid, url, opts.userInfoScope ? "userinfo" : "base", "123");

                //var imgUrl = encodeURI(opts.imgUrl);
                var imgUrl = opts.imgUrl;
                if (imgUrl != null && imgUrl.indexOf("cmsstatic") > 0) {
                    imgUrl = encodeURI(imgUrl);
                }
                //分享给朋友
                wx.onMenuShareAppMessage({
                    title: opts.title, // 分享标题
                    desc: opts.desc, // 分享描述
                    link: link, // 分享链接
                    imgUrl: imgUrl, // 分享图标
                    type: "link", // 分享类型,music、video或link，不填默认为link
                    dataUrl: "", // 如果type是music或video，则要提供数据链接，默认为空
                    success: opts.success,
                    cancel: opts.cancel
                });

                //分享到朋友圈
                wx.onMenuShareTimeline({
                    title: opts.timelineDesc == "" ? opts.desc : opts.timelineDesc,
                    link: link,
                    imgUrl: imgUrl,
                    success: opts.success,
                    cancel: opts.cancel
                });

                //分享到QQ
                wx.onMenuShareQQ({
                    title: opts.title,
                    desc: opts.desc,
                    link: "http://" + location.host + "/wechat/route?url=" + encodeURIComponent(opts.url),
                    imgUrl: imgUrl,
                    success: opts.success,
                    cancel: opts.cancel
                });
            }, opts.error)
        };

        share.defaults = {
            title: "",
            desc: "",
            timelineDesc: "",
            imgUrl: "http://" + location.host + "/static/img/logo.jpg",
            url: location.pathname,
            userInfoScope: false,

            success: function () {
                console.info("success")
            },
            cancel: function () {
                console.info("cancel")
            },
            error: function (resp) {
                console.info(JSON.stringify(resp))
            }
        };
    }

    if (typeof scanQRCode == "undefined") {
        var scanQRCode = function (options) {
            var opts = $.extend(scanQRCode.defaults, options);
            initWechat(location.href, ["scanQRCode"], function () {
                wx.scanQRCode({
                    needResult: 1, // 默认为0，扫描结果由微信处理，1则直接返回扫描结果，
                    scanType: ["qrCode","barCode"],
                    success:opts.success,
                    fail:opts.fail// 可以指定扫二维码还是一维码，默认二者都有
                });
            }, opts.error)
        };

        scanQRCode.defaults = {
            success: function (resp) {
                console.info(JSON.stringify(resp));
            },
            fail: function (resp) {
                console.info(JSON.stringify(resp))
            },
            cancel: function (resp) {
                console.info(JSON.stringify(resp))
            },
            error: function (resp) {
                console.info(JSON.stringify(resp))
            }
        };
    }

    return {
        isWechatBrowser: isWechatBrowser,
        initWechat: initWechat,
        checkJsApi: checkJsApi,
        requestJssdkSign: requestJssdkSign,
        previewImage: previewImage,
        getLocation: getLocation,
        share: share,
        hideNonBaseMenu: hideNonBaseMenu,
        hideMenuItems: hideMenuItems,
        showMenuItems: showMenuItems,
        openLocation: openLocation,
        chooseImage:chooseImage,
        uploadImage:uploadImage,
        getLocalImgData:getLocalImgData,
        downloadImage:downloadImage,
        onMenuShareAppMessage:onMenuShareAppMessage,
        showNonBaseMenu:showNonBaseMenu,
        scanQRCode:scanQRCode
    }
})($);
