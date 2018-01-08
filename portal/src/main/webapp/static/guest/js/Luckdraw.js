
var nametxt = $('.slot');
var phonetxt = $('.name');
var runing = true;//运行标记
var trigger = true;//打印中奖者标记  判断当前是否在显示中奖人的过程中
var num = 0;//当今中奖者标记
var currentLuckyCount=0;
//设置单次抽奖人数
var Lotterynumber = 0;

//设置获奖总人数
var Totalnumber = 0;

var luckyParticipantList;

var list=[];


$(function () {
	nametxt.css('background-image','url('+participartors[0].image+')');
	phonetxt.html(participartors[0].phone);
});//初始化

// 开始/停止
function start() {
	$.post("/admin/wefamily/getTotalLuckyParticipant?uuid="+uuid,function(data){
		if(data){
			Lotterynumber = data.everyLuckyCount;
			Totalnumber = data.totalLuckyCount;
			currentLuckyCount=data.currentLuckyCount;
			luckyParticipantList=data.luckyParticipantList;
			for(var i=0;i<luckyParticipantList.length;i++){
				list[i]={id: luckyParticipantList[i].userid,image:luckyParticipantList[i].headimg,phone:luckyParticipantList[i].nickname}
			}
			winners = list;
			wcount = winners.length-1;
			if(Totalnumber==currentLuckyCount){
				window.clearInterval(stopTime);
				$('#start').text("抽奖完毕");
				$('#btntxt').removeClass('stop').removeClass('start').addClass('over');
				$('#start').css('background-color','#999');
			}else{
				//抽奖完毕则无需开始
				if($('#start').text()=="抽奖完毕"){
					return;
				}
				//在抽奖过程中
				if (runing) {
					if(wcount < 0){
						alert("奖品不足！");
					}
					else{
						runing = false;
						$('#start').text('停止');
						startNum()
					}
				}
				//不在抽奖过程中
				else {
					//人数判断，看剩余可抽奖人数是否满足设定的单次抽奖人数
					if(Totalnumber-currentLuckyCount>Lotterynumber){
						$('#start').text('自动抽取中('+ Lotterynumber+')');
					}else{
						$('#start').text('自动抽取中('+ (Totalnumber-currentLuckyCount) +')');
					}
					//开始抽奖
					zd();
				}
			}
		}
	});


}

// 循环参加名单
function startNum() {
	num = Math.floor(Math.random() * wcount);
	nametxt.css('background-image','url('+participartors[num].image+')');
	phonetxt.html(participartors[num].phone);
	t = setTimeout(startNum, 0);
}

// 停止跳动
function stop() {
	wcount = winners.length-1;
	clearInterval(t);
	t = 0;
}

// 打印中奖人
function zd() {
	var a=document.getElementById("lucky");
	var lis = a.getElementsByTagName("li");
	if (trigger) {
		trigger = false;
		var i = 0;
		if ( wcount >= 0 ) {
		    //中奖人循环显示，通过定时器实现
			stopTime = window.setInterval(function () {
				if (runing) {
				    //闪烁
					runing = false;
					$('#btntxt').removeClass('start').addClass('stop');
					startNum();
				} else {
				    //打印单个中奖者
					runing = true;
					$('#btntxt').removeClass('stop').addClass('start');
					stop();

					i++;

					$('#start').text('自动抽取中('+ Lotterynumber+')');

                    //判断是否已抽取单次中奖者完毕，是则退出当前定时器循环
                    if (i==Lotterynumber) {
						window.clearInterval(stopTime);
						$('#start').text("开始");
						trigger = true;
					};
					
					//判断是否已抽取所有中奖者，是则显示抽奖完毕
					if(i+currentLuckyCount == Totalnumber){
					    window.clearInterval(stopTime);
						$('#start').text("抽奖完毕");
						$('#btntxt').removeClass('stop').removeClass('start').addClass('over');
						$('#start').css('background-color','#999');
					}

                    //提交中奖者
                    submitWinner(winners[num].id);
					//打印中奖者名单
					$('.luck-user-list').prepend("<li><div class='portrait' style='background-image:url("+winners[num].image+")'></div><div class='luckuserName'>"+winners[num].phone+"</div></li>");
					$('.modality-list ul').append("<li><div class='luck-img' style='background-image:url("+winners[num].image+")'></div><p>"+winners[num].phone+"</p></li>");
					//将已中奖者从参与者名单和白名单中"删除",防止二次中奖
					//participartors.splice($.inArray(winners[num], participartors), 1);
					winners.splice($.inArray(winners[num], winners), 1);
					
				}
			},1000);
		};

	}
}

