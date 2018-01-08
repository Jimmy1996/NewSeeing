<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>news_Message</title>
	<link rel="stylesheet" href="./public/stylesheets/lib/perfect-scrollbar.min.css">
    <link rel="stylesheet" href="./public/stylesheets/newsMessage.css">
	<link rel="stylesheet" href="./public/stylesheets/header.css">
	<link rel="stylesheet" href="./public/stylesheets/footer.css">
    <link rel="stylesheet" href="./public/stylesheets/menu.css">
	<script src="./public/javascript/lib/jquery-2.1.1.min.js"></script>
    <script src="./public/javascript/lib/perfect-scrollbar.jquery.min.js"></script>
</head>
<body>
	<header>
		<a href="./index.action"><img src="./public/images/header_logo.png" alt="seeing logo" class="logo"></a>
	</header>
        <!--菜单栏-->
        <div id="menu">       
                        <div id = "film_menu">
                            <ul>
                            <li><a href="#">${sessionScope.movieName}</a></li>
                            <li><a href="./movieInfo.action">General</a><div></div></li>
                            <li><a href="./movieActor.action">actor graph</a><div></div></li>
                            <li><a href="./movieGraph.action">creative contribution</a><div></div></li>
                            <li class="active"><a href="#">news</a><div class="on"></div></li>
                            </ul>
                        </div>
        </div>
            
       <div id="search_result">

				<!-- 搜索框 -->
	           <div class="search">
	                <form method="post" action="./ movieNewDetail.action">
	                    <input type="text" name="searchKey"></input>
	                    <button type="submit">
	                        <img src="./public/images/index_search.png" alt="search">
	                    </button>
	                </form>
	            </div>
        </div>
          <!--搜索结果，包括相关新闻、好评及差评列表-->
       <div id="wrap"> 
                 <div id="left_container">
                         <p class="biaoti">related news>>></p>
                         <div class="item_list scrollbar">

                                 <c:if test="${not empty movieNew}">
                                 	<c:forEach items="${movieNew}" var="newObject">
                                 			<div class="item">
			                                   <h5>${newObject.title} >>></h5>
			                                   <h6>${newObject.writer} ${newObject.time}</h6>
			                                   <p>${newObject.content}</p>
			                                    <a href="${newObject.link}">More...</a> 
			                                </div>
                                 	</c:forEach>
                                 </c:if>
						 </div>
                    </div>
                   
                  <div id="right_container">                  
                       <!--好评列表-->
                      <div id="positive" >
                            <p class="biaoti">positive>>></p>
                            <div  class="positive_negativeArea">
		                            <ul class="scrollbar">
									<!-- <li><img src="./public/images/positive_comment_icon.png" alt=""><p>很可爱的片子，动物很可爱。但是故意的剧情和解说有点画蛇添足，也许小朋友会喜欢这种设定吧，看他们好开心。</p></li>
									<li><img src="./public/images/positive_comment_icon.png" alt=""><p>把自然现象动物相处加之过于成人的视角，其实不觉得多奇妙可爱，像一种过度诠释。而静静观赏，配以合适音乐，比像逗小丑一样去配音揣度更加真实自然。给人想象空间。</p></li>
									<li><img src="./public/images/positive_comment_icon.png" alt=""><p>把自然现象动物相处加之过于成人的视角，其实不觉得多奇妙可爱，像一种过度诠释。而静静观赏，配以合适音乐，比像逗小丑一样去配音揣度更加真实自然。给人想象空间。</p></li>
								 	<li><img src="./public/images/positive_comment_icon.png" alt=""><p>把自然现象动物相处加之过于成人的视角，其实不觉得多奇妙可爱，像一种过度诠释。而静静观赏，配以合适音乐，比像逗小丑一样去配音揣度更加真实自然。给人想象空间。</p></li>
								     -->
								     <c:if test="${not empty goodNews}">
		                                 	<c:forEach items="${goodNews}" var="good">
		                                 			<li><img src="./public/images/positive_comment_icon.png" alt=""><p><c:out value="${good}"/></p></li>
		                                 	</c:forEach>
		                                 </c:if>
								    </ul>
						    </div>
                       </div>
                       
                       <!--差评列表-->
                   <div id="negative"style="margin-top:10px;">
                            <p class="biaoti">negative>>></p>
                             <div  class="positive_negativeArea">
		                            <ul  class="scrollbar" >
									<!-- <li><img src="./public/images/negative_comment_icon.png" alt=""><p>很可爱的片子，动物很可爱。但是故意的剧情和解说有点画蛇添足，也许小朋友会喜欢这种设定吧，看他们好开心。</p></li>
									<li><img src="./public/images/negative_comment_icon.png" alt=""><p>把自然现象动物相处加之过于成人的视角，其实不觉得多奇妙可爱，像一种过度诠释。而静静观赏，配以合适音乐，比像逗小丑一样去配音揣度更加真实自然。给人想象空间。</p></li>
								    <li><img src="./public/images/negative_comment_icon.png" alt=""><p>把自然现象动物相处加之过于成人的视角，其实不觉得多奇妙可爱，像一种过度诠释。而静静观赏，配以合适音乐，比像逗小丑一样去配音揣度更加真实自然。给人想象空间。</p></li>
								   -->
								   <c:if test="${not empty badNews}">
		                                 	<c:forEach items="${badNews}" var="bad">
		                                 			<li><img src="./public/images/negative_comment_icon.png" alt=""><p><c:out value="${bad}"/></p></li>
		                                 	</c:forEach>
		                                 </c:if>
		                            </ul>
                            </div>
                       </div>             
                  </div>

                  
          </div>
	<footer>
		
	   <!----	<p>copyright©广东外语外贸大学 广外数据挖掘实验室</p> ------>
	       <p>CopyRight@Data Mining Lab of GuangDong University of Foreign Study</p>
	</footer>

     <script>
    	$(document).ready(function ($){
	        $('.scrollbar').perfectScrollbar({wheelSpeed: 0.5});
			//菜单栏覆盖事件
		    $('li').hover(function(){
			       $(this).children('div').addClass("hover");
			    },function(){
				   $(this).children('div').removeClass("hover");
				 });
	     });
    </script>
</body>
</html>