<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<script>
//JavaScript Document
//small_menu切换

$(function(){
	
	//小菜单切换
	var buttons = $("#small_menu li");
	buttons.on('click',function(){
		if(!$(this).hasClass('active')){
			console.log(this.id);
			$(this).siblings().removeClass('active');
			$(this).addClass('active');
			var cur_content = $('#'+ this.id + '_Area');
			cur_content.siblings().hide();
			cur_content.show();
		}
	});
	
	//小菜单悬浮
	
	var menubox = document.getElementById("menuright");
 var cli_on = document.getElementById("on");
 var flag = false, timer = null, initime = null, r_len = 0;
	if(menubox.style.right=== 0){
		flag = true;
		}
	else{
		flag = false;
	    }
 cli_on.onclick = function () {
 /*如果不需要动态效果，这两句足矣
 combox.style.right = flag?'-270px':0;
 flag = !flag;
 */
 clearTimeout(initime);
 //根据状态flag执开展开收缩
 if (flag) {
 r_len = 0;
 timer = setInterval(slideright, 10);
 } else {
 r_len = -160;
 timer = setInterval(slideleft, 10);
 }
 }
 //展开
 function slideright() {
 if (r_len <= -160) {
 clearInterval(timer);
 flag = !flag;
 return false;
 } else {
 r_len -= 5;
 menubox.style.right = r_len + 'px';
 }
 }
 //收缩
 function slideleft() {
 if (r_len >= 0) {
 clearInterval(timer);
 flag = !flag;
 return false;
 } else {
 r_len += 5;
 menubox.style.right = r_len + 'px';
 }
 }
})
</script>
