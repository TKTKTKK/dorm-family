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
                公众号 》 门店管理 》 </span><span class="font-bold text-black">门店</span>
            </header>
            <div class="row">
                <div class="col-sm-2">
                </div>
                <div class="col-sm-8">
                    <div style="margin-bottom: 5px">
                        <span class="text-success">${successMessage}</span>
                        <span class="text-danger">${errorMessage}</span>
                    </div>
                    <form class="form-horizontal" data-validate="parsley" action="${ctx}/admin/account/storeInfo" method="POST" onsubmit="return submitStoreInfo()">
                        <section class="panel panel-default">
                            <header class="panel-heading">
                                <strong>门店信息：</strong>
                            </header>
                            <div class="panel-body">
                                <div class="form-group">
                                    <label class="col-sm-3 control-label"><span class="text-danger">*</span>门店名称：</label>
                                    <div class="col-sm-9">
                                        <input type="text" class="form-control" data-required="true" name="business_name" id="business_name" data-maxlength="60"
                                               onblur="validateChineseTextForTwo(60, this, 'business_nameError')" value="${wechatStore.business_name}">
                                        <span id="business_nameError" class="text-danger"></span>
                                    </div>
                                </div>
                                <div class="line line-dashed b-b line-lg pull-in"></div>
                                <div class="form-group">
                                    <label class="col-sm-3 control-label"><span class="text-danger">*</span>分店名：</label>
                                    <div class="col-sm-9">
                                        <input type="text" class="form-control" data-required="true" name="branch_name" id="branch_name" data-maxlength="60"
                                               onblur="validateChineseTextForTwo(60, this, 'branch_nameError')" value="${wechatStore.branch_name}">
                                        <span id="branch_nameError" class="text-danger"></span>
                                    </div>
                                </div>
                                <div class="line line-dashed b-b line-lg pull-in"></div>
                                <div class="form-group">
                                    <label class="col-sm-3 control-label">所在省：</label>
                                    <div class="col-sm-9">
                                        <select class="form-control" name="province" id="province" data-maxlength="60"
                                                onchange="javascript:selectchange(province,city);">

                                        </select>
                                        <span id="provinceError" class="text-danger"></span>
                                    </div>
                                </div>
                                <div class="line line-dashed b-b line-lg pull-in"></div>
                                <div class="form-group">
                                    <label class="col-sm-3 control-label">所在市：</label>
                                    <div class="col-sm-9">
                                        <select class="form-control" name="city" id="city" data-maxlength="60"  value="${wechatStore.city}">
                                        </select>
                                        <span id="cityError" class="text-danger"></span>
                                    </div>
                                </div>
                                <div class="line line-dashed b-b line-lg pull-in"></div>
                                <div class="form-group">
                                    <label class="col-sm-3 control-label">所在区：</label>
                                    <div class="col-sm-9">
                                        <input type="text" class="form-control" name="district" id="district" data-maxlength="30"  onblur="validateChineseTextForTwo(30, this, 'districtError')" value="${wechatStore.district}">
                                        <span id="districtError" class="text-danger"></span>
                                    </div>
                                </div>
                                <div class="line line-dashed b-b line-lg pull-in"></div>
                                <div class="form-group">
                                    <label class="col-sm-3 control-label"><span class="text-danger">*</span>联系电话：</label>
                                    <div class="col-sm-9">
                                        <input type="text" name="telephone" class="form-control" data-type="phone" placeholder="(XXX) XXXX XXX" data-required="true" data-maxlength="20"
                                               onblur="trimText(this)" value="${wechatStore.telephone}">
                                    </div>
                                </div>
                                <div class="line line-dashed b-b line-lg pull-in"></div>
                                <div class="form-group">
                                    <label class="col-sm-3 control-label"><span class="text-danger">*</span>详细地址：</label>
                                    <div class="col-sm-9">
                                        <textarea class="form-control" rows="6" name="address" data-required="true" id="address"  data-maxlength="256"
                                                  onblur="validateChineseTextForTwo(256, this, 'addressError')">${wechatStore.address}</textarea>
                                        <span id="addressError" class="text-danger"></span>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-sm-12">
                                        <input type="hidden" name="uuid" class="form-control" value="${wechatStore.uuid}">
                                        <input type="hidden" name="versionno" class="form-control" value="${wechatStore.versionno}">
                                    </div>
                                </div>
                            </div>
                            <footer class="panel-footer text-right bg-light lter">
                                <c:if test="${empty view}">
                                    <button type="submit" class="btn btn-success btn-s-xs">提 交</button>
                                </c:if>
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

    //province(省份类)
    function provinceList()
    {
        this.length=35;
        this[0] = new Option("安徽","0");
        this[1] = new Option("北京","1");
        this[2] = new Option("重庆","2");
        this[3] = new Option("福建","3");
        this[4] = new Option("甘肃","4");
        this[5] = new Option("广东","5");
        this[6] = new Option("广西","6");
        this[7] = new Option("贵州","7");
        this[8] = new Option("海南","8");
        this[9] = new Option("河北","9");
        this[10] = new Option("河南","10");
        this[11] = new Option("黑龙江","11");
        this[12] = new Option("湖北","12");
        this[13] = new Option("湖南","13");
        this[14] = new Option("江苏","14");
        this[15] = new Option("江西","15");
        this[16] = new Option("吉林","16");
        this[17] = new Option("辽宁","17");
        this[18] = new Option("内蒙古","18");
        this[19] = new Option("宁夏","19");
        this[20] = new Option("青海","20");
        this[21] = new Option("上海","21");
        this[22] = new Option("山东","22");
        this[23] = new Option("山西","23");
        this[24] = new Option("陕西","24");
        this[25] = new Option("四川","25");
        this[26] = new Option("天津","26");
        this[27] = new Option("新疆","27");
        this[28] = new Option("西藏","28");
        this[29] = new Option("云南","29");
        this[30] = new Option("浙江","30");
        this[31] = new Option("香港","31");
        this[32] = new Option("澳门","32");
        this[33] = new Option("台湾","33");
        this[34] = new Option("其它","34");
        return this;
    }

    //city(城市类)
    function citylist()
    {
        this.length=35;
        this[0] = new Array(17);
        this[0][0] = new Option("合肥市","0");
        this[0][1] = new Option("淮北市","1");
        this[0][2] = new Option("淮南市","2");
        this[0][3] = new Option("黄山市","3");
        this[0][4] = new Option("安庆市","4");
        this[0][5] = new Option("蚌埠市","5");
        this[0][6] = new Option("巢湖市","6");
        this[0][7] = new Option("池州市","7");
        this[0][8] = new Option("滁州市","8");
        this[0][9] = new Option("六安市","9");
        this[0][10] = new Option("马鞍山市","10");
        this[0][11] = new Option("宣城市","11");
        this[0][12] = new Option("宿州市","12");
        this[0][13] = new Option("铜陵市","13");
        this[0][14] = new Option("芜湖市","14");
        this[0][15] = new Option("阜阳市","15");
        this[0][16] = new Option("亳州市","16");

        this[1] = new Array(1);
        this[1][0] = new Option("北京市","100");
        this[2] = new Array(4);
        this[2][0] = new Option("重庆市","200");
        this[2][1] = new Option("涪陵市","201");
        this[2][2] = new Option("黔江市","202");
        this[2][3] = new Option("万县市","203");
        this[3] = new Array(9);
        this[3][0] = new Option("福州市","300");
        this[3][1] = new Option("龙岩市","301");
        this[3][2] = new Option("南平市","302");
        this[3][3] = new Option("宁德市","303");
        this[3][4] = new Option("莆田市","304");
        this[3][5] = new Option("泉州市","305");
        this[3][6] = new Option("三明市","306");
        this[3][7] = new Option("厦门市","307");
        this[3][8] = new Option("漳州市","308");
        this[4] = new Array(14);
        this[4][0] = new Option("兰州市","400");
        this[4][1] = new Option("甘南藏族自治州","401");
        this[4][2] = new Option("定西地区","402");
        this[4][3] = new Option("白银市","403");
        this[4][4] = new Option("嘉峪关市","404");
        this[4][5] = new Option("金昌市","405");
        this[4][6] = new Option("酒泉市","406");
        this[4][7] = new Option("临夏回族自治州","407");
        this[4][8] = new Option("陇南地区","408");
        this[4][9] = new Option("平凉市","409");
        this[4][10] = new Option("庆阳市","410");
        this[4][11] = new Option("天水市","411");
        this[4][12] = new Option("武威市","412");
        this[4][13] = new Option("张掖市","413");
        this[5] = new Array(21);
        this[5][0] = new Option("广州市","500");
        this[5][1] = new Option("佛山市","501");
        this[5][2] = new Option("惠州市","502");
        this[5][3] = new Option("东莞市","503");
        this[5][4] = new Option("江门市","504");
        this[5][5] = new Option("揭阳市","505");
        this[5][6] = new Option("潮州市","506");
        this[5][7] = new Option("茂名市","507");
        this[5][8] = new Option("梅州市","508");
        this[5][9] = new Option("清远市","509");
        this[5][10] = new Option("汕头市","510");
        this[5][11] = new Option("汕尾市","511");
        this[5][12] = new Option("深圳市","512");
        this[5][13] = new Option("韶关市","513");
        this[5][14] = new Option("阳江市","514");
        this[5][15] = new Option("河源市","515");
        this[5][16] = new Option("云浮市","516");
        this[5][17] = new Option("中山市","517");
        this[5][18] = new Option("珠海市","518");
        this[5][19] = new Option("湛江市","519");
        this[5][20] = new Option("肇庆市","520");
        this[6] = new Array(14);
        this[6][0] = new Option("南宁市","600");
        this[6][1] = new Option("防城港市","601");
        this[6][2] = new Option("北海市","602");
        this[6][3] = new Option("百色市","603");
        this[6][4] = new Option("贺州市","604");
        this[6][5] = new Option("桂林市","605");
        this[6][6] = new Option("来宾市","606");
        this[6][7] = new Option("柳州市","607");
        this[6][8] = new Option("崇左市","608");
        this[6][9] = new Option("钦州市","609");
        this[6][10] = new Option("贵港市","610");
        this[6][11] = new Option("梧州市","611");
        this[6][12] = new Option("河池市","612");
        this[6][13] = new Option("玉林市","613");
        this[7] = new Array(9);
        this[7][0] = new Option("贵阳市","700");
        this[7][1] = new Option("毕节地区","701");
        this[7][2] = new Option("遵义市","702");
        this[7][3] = new Option("安顺市","703");
        this[7][4] = new Option("六盘水市","704");
        this[7][5] = new Option("黔东南苗族侗族自治州","705");
        this[7][6] = new Option("黔南布依族苗族自治州","706");
        this[7][7] = new Option("黔西南布依族苗族自治","707");
        this[7][8] = new Option("铜仁地区","708");
        this[8] = new Array(3);
        this[8][0] = new Option("海口市","800");
        this[8][1] = new Option("三亚市","801");
        this[8][2] = new Option("省直辖行政单位","802");
        this[9] = new Array(11);
        this[9][0] = new Option("石家庄市","900");
        this[9][1] = new Option("邯郸市","901");
        this[9][2] = new Option("邢台市","902");
        this[9][3] = new Option("保定市","903");
        this[9][4] = new Option("张家口市","904");
        this[9][5] = new Option("沧州市","905");
        this[9][6] = new Option("承德市","906");
        this[9][7] = new Option("廊坊市","907");
        this[9][8] = new Option("秦皇岛市","908");
        this[9][9] = new Option("唐山市","909");
        this[9][10] = new Option("衡水市","910");
        this[10] = new Array(18);
        this[10][0] = new Option("郑州市","1000");
        this[10][1] = new Option("开封市","1001");
        this[10][2] = new Option("驻马店市","1002");
        this[10][3] = new Option("安阳市","1003");
        this[10][4] = new Option("焦作市","1004");
        this[10][5] = new Option("洛阳市","1005");
        this[10][6] = new Option("濮阳市","1006");
        this[10][7] = new Option("漯河市","1007");
        this[10][8] = new Option("南阳市","1008");
        this[10][9] = new Option("平顶山市","1009");
        this[10][10] = new Option("新乡市","1010");
        this[10][11] = new Option("信阳市","1011");
        this[10][12] = new Option("许昌市","1012");
        this[10][13] = new Option("商丘市","1013");
        this[10][14] = new Option("三门峡市","1014");
        this[10][15] = new Option("鹤壁市","1015");
        this[10][16] = new Option("周口市","1016");
        this[10][17] = new Option("济源市","1017");

        this[11] = new Array(13);
        this[11][0] = new Option("哈尔滨市","1100");
        this[11][1] = new Option("大庆市","1101");
        this[11][2] = new Option("大兴安岭地区","1102");
        this[11][3] = new Option("鸡西市","1103");
        this[11][4] = new Option("佳木斯市","1104");
        this[11][5] = new Option("牡丹江市","1105");
        this[11][6] = new Option("齐齐哈尔市","1106");
        this[11][7] = new Option("七台河市","1107");
        this[11][8] = new Option("双鸭山市","1108");
        this[11][9] = new Option("绥化市","1109");
        this[11][10] = new Option("伊春市","1110");
        this[11][11] = new Option("鹤岗市","1111");
        this[11][12] = new Option("黑河市","1112");

        this[12] = new Array(14);
        this[12][0] = new Option("武汉市","1200");
        this[12][1] = new Option("黄冈市","1201");
        this[12][2] = new Option("黄石市","1202");
        this[12][3] = new Option("恩施土家族苗族自治州","1203");
        this[12][4] = new Option("鄂州市","1204");
        this[12][5] = new Option("荆门市","1205");
        this[12][6] = new Option("荆州市","1206");
        this[12][7] = new Option("孝感市","1207");
        this[12][8] = new Option("省直辖县级行政单位","1208");
        this[12][9] = new Option("十堰市","1209");
        this[12][10] = new Option("襄樊市","1210");
        this[12][11] = new Option("咸宁市","1211");
        this[12][12] = new Option("宜昌市","1212");
        this[12][13] = new Option("随州市","1213");
        this[13] = new Array(14);
        this[13][0] = new Option("长沙市","1300");
        this[13][1] = new Option("怀化市","1301");
        this[13][2] = new Option("郴州市","1302");
        this[13][3] = new Option("常德市","1303");
        this[13][4] = new Option("娄底市","1304");
        this[13][5] = new Option("邵阳市","1305");
        this[13][6] = new Option("湘潭市","1306");
        this[13][7] = new Option("湘西土家族苗族自治州","1307");
        this[13][8] = new Option("衡阳市","1308");
        this[13][9] = new Option("永州市","1309");
        this[13][10] = new Option("益阳市","1310");
        this[13][11] = new Option("岳阳市","1311");
        this[13][12] = new Option("株洲市","1312");
        this[13][13] = new Option("张家界市","1313");
        this[14] = new Array(13);
        this[14][0] = new Option("南京市","1400");
        this[14][1] = new Option("淮安市","1401");
        this[14][2] = new Option("常州市","1402");
        this[14][3] = new Option("连云港市","1403");
        this[14][4] = new Option("南通市","1404");
        this[14][5] = new Option("徐州市","1405");
        this[14][6] = new Option("苏州市","1406");
        this[14][7] = new Option("无锡市","1407");
        this[14][8] = new Option("盐城市","1408");
        this[14][9] = new Option("扬州市","1409");
        this[14][10] = new Option("镇江市","1410");
        this[14][11] = new Option("泰州市","1411");
        this[14][12] = new Option("宿迁市","1412");
        this[15] = new Array(11);
        this[15][0] = new Option("南昌市","1500");
        this[15][1] = new Option("抚州市","1501");
        this[15][2] = new Option("赣州市","1502");
        this[15][3] = new Option("吉安市","1503");
        this[15][4] = new Option("景德镇市","1504");
        this[15][5] = new Option("九江市","1505");
        this[15][6] = new Option("萍乡市","1506");
        this[15][7] = new Option("新余市","1507");
        this[15][8] = new Option("上饶市","1508");
        this[15][9] = new Option("鹰潭市","1509");
        this[15][10] = new Option("宜春市","1510");
        this[16] = new Array(9);
        this[16][0] = new Option("长春市","1600");
        this[16][1] = new Option("白城市","1601");
        this[16][2] = new Option("白山市","1602");
        this[16][3] = new Option("吉林市","1603");
        this[16][4] = new Option("辽源市","1604");
        this[16][5] = new Option("四平市","1605");
        this[16][6] = new Option("松原市","1606");
        this[16][7] = new Option("通化市","1607");
        this[16][8] = new Option("延边朝鲜族自治州","1608");
        this[17] = new Array(14);
        this[17][0] = new Option("沈阳市","1700");
        this[17][1] = new Option("大连市","1701");
        this[17][2] = new Option("阜新市","1702");
        this[17][3] = new Option("抚顺市","1703");
        this[17][4] = new Option("本溪市","1704");
        this[17][5] = new Option("鞍山市","1705");
        this[17][6] = new Option("丹东市","1706");
        this[17][7] = new Option("锦州市","1707");
        this[17][8] = new Option("朝阳市","1708");
        this[17][9] = new Option("辽阳市","1709");
        this[17][10] = new Option("盘锦市","1710");
        this[17][11] = new Option("铁岭市","1711");
        this[17][12] = new Option("营口市","1712");
        this[17][13] = new Option("葫芦岛市","1713");
        this[18] = new Array(12);
        this[18][0] = new Option("呼和浩特市","1800");
        this[18][1] = new Option("阿拉善盟","1801");
        this[18][2] = new Option("巴彦淖尔盟","1802");
        this[18][3] = new Option("包头市","1803");
        this[18][4] = new Option("赤峰市","1804");
        this[18][5] = new Option("兴安盟","1805");
        this[18][6] = new Option("乌兰察布盟","1806");
        this[18][7] = new Option("乌海市","1807");
        this[18][8] = new Option("锡林郭勒盟","1808");
        this[18][9] = new Option("呼伦贝尔盟","1809");
        this[18][10] = new Option("伊克昭盟","1810");
        this[18][11] = new Option("通辽市","1811");
        this[19] = new Array(5);
        this[19][0] = new Option("银川市","1900");
        this[19][1] = new Option("固原市","1901");
        this[19][2] = new Option("石嘴山市","1902");
        this[19][3] = new Option("吴忠市","1903");
        this[19][4] = new Option("中卫市","1904");
        this[20] = new Array(8);
        this[20][0] = new Option("西宁市","2000");
        this[20][1] = new Option("海东地区","2001");
        this[20][2] = new Option("海南藏族自治州","2002");
        this[20][3] = new Option("海北藏族自治州","2003");
        this[20][4] = new Option("黄南藏族自治州","2004");
        this[20][5] = new Option("果洛藏族自治州","2005");
        this[20][6] = new Option("玉树藏族自治州","2006");
        this[20][7] = new Option("海西蒙古族藏族自治州","2007");
        this[21] = new Array(1);
        this[21][0] = new Option("上海市","2100");
        this[22] = new Array(17);
        this[22][0] = new Option("济南市","2200");
        this[22][1] = new Option("东营市","2201");
        this[22][2] = new Option("滨州市","2202");
        this[22][3] = new Option("淄博市","2203");
        this[22][4] = new Option("德州市","2204");
        this[22][5] = new Option("济宁市","2205");
        this[22][6] = new Option("聊城市","2206");
        this[22][7] = new Option("临沂市","2207");
        this[22][8] = new Option("莱芜市","2208");
        this[22][9] = new Option("青岛市","2209");
        this[22][10] = new Option("日照市","2210");
        this[22][11] = new Option("威海市","2211");
        this[22][12] = new Option("泰安市","2212");
        this[22][13] = new Option("潍坊市","2213");
        this[22][14] = new Option("烟台市","2214");
        this[22][15] = new Option("菏泽市","2215");
        this[22][16] = new Option("枣庄市","2216");
        this[23] = new Array(11);
        this[23][0] = new Option("太原市","2300");
        this[23][1] = new Option("大同市","2301");
        this[23][2] = new Option("晋城市","2302");
        this[23][3] = new Option("晋中市","2303");
        this[23][4] = new Option("长治市","2304");
        this[23][5] = new Option("临汾市","2305");
        this[23][6] = new Option("吕梁地区","2306");
        this[23][7] = new Option("忻州市","2307");
        this[23][8] = new Option("朔州市","2308");
        this[23][9] = new Option("阳泉市","2309");
        this[23][10] = new Option("运城市","2310");
        this[24] = new Array(10);
        this[24][0] = new Option("西安市","2400");
        this[24][1] = new Option("宝鸡市","2401");
        this[24][2] = new Option("安康市","2402");
        this[24][3] = new Option("商洛市","2403");
        this[24][4] = new Option("铜川市","2404");
        this[24][5] = new Option("渭南市","2405");
        this[24][6] = new Option("咸阳市","2406");
        this[24][7] = new Option("延安市","2407");
        this[24][8] = new Option("汉中市","2408");
        this[24][9] = new Option("榆林市","2409");
        this[25] = new Array(21);
        this[25][0] = new Option("成都市","2500");
        this[25][1] = new Option("达川市","2501");
        this[25][2] = new Option("甘孜藏族自治州","2502");
        this[25][3] = new Option("自贡市","2503");
        this[25][4] = new Option("阿坝藏族羌族自治州","2504");
        this[25][5] = new Option("巴中市","2505");
        this[25][6] = new Option("德阳市","2506");
        this[25][7] = new Option("广安市","2507");
        this[25][8] = new Option("广元市","2508");
        this[25][9] = new Option("凉山彝族自治州","2509");
        this[25][10] = new Option("乐山市","2510");
        this[25][11] = new Option("攀枝花市","2511");
        this[25][12] = new Option("南充市","2512");
        this[25][13] = new Option("内江市","2513");
        this[25][14] = new Option("泸州市","2514");
        this[25][15] = new Option("绵阳市","2515");
        this[25][16] = new Option("遂宁市","2516");
        this[25][17] = new Option("雅安市","2517");
        this[25][18] = new Option("宜宾市","2518");
        this[25][19] = new Option("眉山市","2519");
        this[25][20] = new Option("资阳市","2520");
        this[26] = new Array(1);
        this[26][0] = new Option("天津市","2600");
        this[27] = new Array(15);
        this[27][0] = new Option("乌鲁木齐市","2700");
        this[27][1] = new Option("喀什地区","2701");
        this[27][2] = new Option("克孜勒苏柯尔克孜自治","2702");
        this[27][3] = new Option("克拉玛依市","2703");
        this[27][4] = new Option("阿克苏地区","2704");
        this[27][5] = new Option("阿勒泰地区","2705");
        this[27][6] = new Option("巴音郭楞蒙古自治州","2706");
        this[27][7] = new Option("哈密地区","2707");
        this[27][8] = new Option("博尔塔拉蒙古自治州","2708");
        this[27][9] = new Option("昌吉回族自治州","2709");
        this[27][10] = new Option("塔城地区","2710");
        this[27][11] = new Option("吐鲁番地区","2711");
        this[27][12] = new Option("和田地区","2712");
        this[27][13] = new Option("石河子市","2713");
        this[27][14] = new Option("伊犁哈萨克自治州","2714");
        this[28] = new Array(7);
        this[28][0] = new Option("拉萨市","2800");
        this[28][1] = new Option("阿里地区","2801");
        this[28][2] = new Option("昌都市","2802");
        this[28][3] = new Option("林芝地区","2803");
        this[28][4] = new Option("那曲地区","2804");
        this[28][5] = new Option("山南地区","2805");
        this[28][6] = new Option("日喀则地区","2806");
        this[29] = new Array(16);
        this[29][0] = new Option("昆明市","2900");
        this[29][1] = new Option("大理白族自治州","2901");
        this[29][2] = new Option("昭通市","2902");
        this[29][3] = new Option("保山市","2903");
        this[29][4] = new Option("德宏傣族景颇族自治州","2904");
        this[29][5] = new Option("迪庆藏族自治州","2905");
        this[29][6] = new Option("楚雄彝族自治州","2906");
        this[29][7] = new Option("临沧地区","2907");
        this[29][8] = new Option("丽江市","2908");
        this[29][9] = new Option("怒江傈僳族自治州","2909");
        this[29][10] = new Option("曲靖市","2910");
        this[29][11] = new Option("思茅地区","2911");
        this[29][12] = new Option("西双版纳傣族自治州","2912");
        this[29][13] = new Option("文山壮族苗族自治州","2913");
        this[29][14] = new Option("红河哈尼族彝族自治州","2914");
        this[29][15] = new Option("玉溪市","2915");
        this[30] = new Array(11);
        this[30][0] = new Option("杭州市","3000");
        this[30][1] = new Option("嘉兴市","3001");
        this[30][2] = new Option("金华市","3002");
        this[30][3] = new Option("衢州市","3003");
        this[30][4] = new Option("丽水市","3004");
        this[30][5] = new Option("宁波市","3005");
        this[30][6] = new Option("绍兴市","3006");
        this[30][7] = new Option("台州市","3007");
        this[30][8] = new Option("温州市","3008");
        this[30][9] = new Option("湖州市","3009");
        this[30][10] = new Option("舟山市","3010");
        this[31] = new Array(1);
        this[31][0] = new Option("香港","3100");
        this[32] = new Array(1);
        this[32][0] = new Option("澳门","3200");
        this[33] = new Array(1);
        this[33][0] = new Option("台湾","3300");
        this[34] = new Array(7);
        this[34][0] = new Option("北美洲","3400");
        this[34][1] = new Option("南美洲","3401");
        this[34][2] = new Option("大洋洲","3402");
        this[34][3] = new Option("欧洲","3403");
        this[34][4] = new Option("亚洲","3404");
        this[34][5] = new Option("非洲","3405");
        this[34][6] = new Option("虚拟社团","3406");
        return this;
    }

    //创建provincelist、citylist类实例
    var provinceOb=new provinceList();
    var cityOb=new citylist();

    //定义province、city变量，用于select元素
    var province;
    var city;

    //子函数添加城市
    function addCitys(province,city)
    {
        var index=province.selectedIndex;
        for(var i=0;i<cityOb[index].length;i++)
        {
            try
            {
                city.add(cityOb[index][i]);
            }
            catch(e)
            {
                city.add(cityOb[index][i],null);
            }
        }
    }

    //子函数删除城市
    function delCitys(city)
    {
    //    for(var i=0;i<city.length;i++)
    //    {
    //        city.remove(i);
    //    }
        city.length=0;
    }


    //初始化地区下拉菜单
    function initialize(privinceId,cityId)
    {
        //获取select元素
        province=document.getElementById("province");
        city=document.getElementById("city");

        //循环添加省份到province
        for(var i=0;i<provinceOb.length;i++)
        {
            try
            {
                province.add(provinceOb[i]);
            }
            catch(e)
            {
                province.add(provinceOb[i],null);
            }
        }

        //初始化privinceId
        if(privinceId==undefined)
        {
            privinceId=0;
        }
        //设置province默认选项
        province.options[privinceId].selected=true;

        //添加城市到city
        addCitys(province,city);
        //设置city的默认选项
        if(cityId!=undefined)
        {
            //city.options[cityId].selected=true;
            for(var i = 0; i < city.options.length; i++){
                if(city.options[i].value == cityId){
                    city.options[i].selected = true;
                }
            }
        }
        else
        {
            city.options[0].selected=true;
        }
    }

    //下拉列表改变事件
    function selectchange(province,city)
    {
        delCitys(city);
        addCitys(province,city);
    }

    //提交门店信息
    function submitStoreInfo(){
        //检查门店名称合法性
        var business_nameValid = validateChineseTextForTwo(60, document.getElementById('business_name'), 'business_nameError');
        //检查分店名
        var branch_nameValid = validateChineseTextForTwo(60, document.getElementById('branch_name'), 'branch_nameError');
        //检查省
        var provinceValid = validateChineseTextForTwo(60, document.getElementById('province'), 'provinceError');
        //检查市
        var cityValid = validateChineseTextForTwo(60, document.getElementById('city'), 'cityError');
        //检查区
        var districtValid = validateChineseTextForTwo(30, document.getElementById('district'), 'districtError');
        //检查详细地址
        var addressValid = validateChineseTextForTwo(256, document.getElementById('address'), 'addressError');

        return business_nameValid && branch_nameValid && provinceValid && cityValid && districtValid && addressValid;
    }

    var store = '${wechatStore}';
    if(store.length == 0){
        //初始化省市下拉列表 for add
        initialize();
    }else{
        //省市下拉列表 for other
        initialize('${wechatStore.province}', '${wechatStore.city}');
    }

</script>

</body>
</html>