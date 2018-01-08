<%@ page language="java" contentType="text/html"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>essential_Information</title>
	<link rel="stylesheet" href="./public/stylesheets/lib/perfect-scrollbar.min.css">
	<link rel="stylesheet" href="./public/stylesheets/essential_Information.css">
	<link rel="stylesheet" href="./public/stylesheets/header.css">
	<link rel="stylesheet" href="./public/stylesheets/footer.css">
    <link rel="stylesheet" href="./public/stylesheets/menu.css">
	<script src="./public/javascript/lib/jquery-2.1.1.min.js"></script>
    <script src="./public/javascript/lib/perfect-scrollbar.jquery.min.js"></script>
    <script src="./public/javascript/lib/echarts.js"></script>
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
                            <li class="active"><a href="#">General</a><div class="on"></div></li>
                            <li><a href="./movieActor.action">actor graph</a><div></div></li>
                            <li><a href="./movieGraph.action">creative contribution</a><div></div></li>
                            <li><a href="./movieNew.action">news</a><div></div></li>
                            </ul>
                        </div>
            </div>
            
        <div id="wrap"> 
              <!--剧情简要以及百度搜索指数--> 
             <div id="left_container">
                   <!--剧情简要-->
                   
                  <div class="plot">
                       <h5>story>>></h5>
                       <div class="film">
                       <div class="film_pic"><img src="${movieInfo.moviePicPath}" alt=""  style="height:150px;width:100px;size:contain;"></div>
                       <!--      <div class="film_pic"><img src="./public/images/MovieImg/测试/588160.jpg" alt=""  style="height:100px;width:100px;size:contain;"></div>-->
                       <div class="film_intro scrollbar">
                            <p>${movieInfo.movieBaseInfo}</p>
                       </div>
                       <a  class="film_more"  href="#" onClick="window.open('${movieInfo.movieMoreLink}','','height=500,width=800,top=100,left=100,scrollbars=yes,status =yes')">
                            <span>More</span>
                            <button>></button>
                       </a>
                    </div>
                  </div>
                  
                   <!--百度搜索走势-->
                  <div class="baidu_Search">
                      <h5>searches numbers>>></h5>
                      <div id="baiduSearch" style="margin-left:25px;width: 520px; height: 450px;"></div>  
                  </div>
             </div>
             
             <div id = "right_container">
             
                   <!--电影评分情况-->
                  <div class="filmScore">
                  　　
                       <div class="info">
                            <ul>
                                <li class="film_type">
                                    <h6>type：</h6>
                                    <p>${movieInfo.movieType}</p>
                                </li>
                                <li class="showing_time">
                                    <h6>length:</h6>
                                    <p>${movieInfo.movieLength}</p>
                                </li>
                                <li class="release_time">
                                    <h6>date of release:</h6>
                                    <p>${movieInfo.movieTime}</p>
                                </li>
                                <li class="overall_boxoffice">
                                    <h6>box office:</h6>
                                    <p>${movieInfo.movieBoxOffice}</p>
                                </li>
                            </ul>
                       </div>
                           
                       <h5>scores>>></h5>
                       
                       <div class="filmScoreArea">
                              <div id="film_score" style="top:-35px;margin-left:10px;width:530px; height:160px"></div>
                       </div>
                  </div>
                  
                   <!-- 票房走势-->
                  <div class="boxOffice_Trend">
                       <h5>box office growth>>></h5>
                       <div id="boxOfficeTrend" style="margin-top:-20px;margin-left:30px;width:500px;height:270px;"></div>
                  </div>
             </div>
               
        </div>
	<footer>
		
	   <!----	<p>copyright©广东外语外贸大学 广外数据挖掘实验室</p> ------>
	       <p>CopyRight@Data Mining Lab of GuangDong University of Foreign Study</p>
	</footer>
     <script src="./public/javascript/lib/echarts.js"></script>
     <%@ include file="../../public/javascript/meme/baidu_Search.jsp" %>
      <%@ include file="../../public/javascript/meme/boxOfficeTrend.jsp" %>
      <%@ include file="../../public/javascript/meme/film_score.jsp" %>

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