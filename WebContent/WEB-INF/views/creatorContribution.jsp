<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>creatorContribution</title>
	<link rel="stylesheet" href="./public/stylesheets/lib/perfect-scrollbar.min.css">
    <link rel="stylesheet" href="./public/stylesheets/creatorContribution.css">
	<link rel="stylesheet" href="./public/stylesheets/header.css">
	<link rel="stylesheet" href="./public/stylesheets/footer.css">
    <link rel="stylesheet" href="./public/stylesheets/menu.css">
    
    <script src="https://img.hcharts.cn/jquery/jquery-1.8.3.min.js"></script>
    <script src="https://img.hcharts.cn/highcharts/highcharts.js"></script>
	<script src="https://img.hcharts.cn/highcharts/modules/data.js"></script>
	<script src="https://img.hcharts.cn/highcharts/modules/drilldown.js"></script>
	<script src="https://img.hcharts.cn/highcharts-plugins/highcharts-zh_CN.js"></script>
    
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
                            <li><a href="./movieInfo.action">General</a><div></div></li>
                            <li><a href="./movieActor.action">actor graph</a><div></div></li>
                            <li class="active"><a href="#">creative contribution</a><div  class="on"></div></li>
                            <li><a href="./movieNew.action">news</a><div></div></li>
                            </ul>
                        </div>
        </div>
        <div id="wrap"> 
             　
               <!--放置 评论涉及率，历史票房，百度搜索指数，以及其他影响指标  和 微博号召力-->           
               <div id="left">
                    <div id="up">
                    
                        <div class="leftleft">
                           <!--评论涉及率-->
                             <div class="reviewRate">
                                  <p>word of mouth>>></p>
                                  <div id="reviewRate_charts" style="margin-left:20px;width:280px;height:220px;"></div>
                             </div>
                             
                           <!--百度搜索指数-->    
                             <div class="baiduSearch">
                                   <p>baidu searches>>></p>
                                   <div id="baiduSearch_charts"  style="padding-top:10px;margin-left:10px;width:270px;height:180px"></div>
                             </div>
                         
                        </div>  
                        
                        <div class="leftright">  
                            <!-- 历史票房-->
                             <div class="historicalBoxOffice " >
                                  <p>historical box office>>></p>
                                  <div class="historyCharts_area scrollbar" >
                                        <div id="historicalBoxOffice_charts"  style="width:280px;height:300px"></div>
                                  </div>
                                  
                             </div>
                             
                            <!--其他影响指标-->    
                             <div class="otherImpactTarget">
                                  <p>others>>></p>
                                  <div id="otherImpactTarget_charts"  style="padding-left:20px;top:-15px;width:280px;height:140px;"></div>
                             </div>
                         </div>
                    </div>
                    
                    <div id="below">
                    <!--微博号召力-->
                        <p>weibo influence>>></p>
                        <div class="microBlogAppeal scrollbar">
                            <table>
                            	<thead>
                                    <tr>
                                        <td>name</td>
                                        <td>number of fans</td>
                                        <td>number of concerns</td>
                                        <td>number of microblog</td>
                                        <td>degree of influence</td>
                                        <td>degree of activity</td>
                                    </tr>
                                </thead>
                                <tbody>
	                                <c:forEach items="${actorWeibo}" var="weibo">
	                                	<tr>
	                                        <td>${weibo.name}</td>
	                                        <td>${weibo.fanNum}</td>
	                                        <td>${weibo.followNum}</td>
	                                        <td>${weibo.weiboNum}</td>
	                                        <td>${weibo.influence}</td>
	                                        <td>${weibo.active}</td>
	                                    </tr>
	                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
               </div>
           
               <!--演员提名及获奖情况，主创贡献榜，票房与豆瓣评分 以及 总体排行榜-->
               <div id="right">
               
                    <div class="rightleft">
                    
                        <!--演员提名及获奖情况-->
                        <div class="actorAward">
                             <p>nominations&awards>>></p>
                                  <div id="actorAward_charts"  style="top:-20px;width:275px;height:230px"></div>
                        
                        </div>
                        
                        <!--票房与豆瓣评分-->
                        <div class="boxOffice_douBanScore">
                             <p>score of douban>>></p>
                             <div id="boxOffice_douBanScore_charts"  style="padding-left:10px;padding-top:15px;width:295px;height:230px"></div>
                        </div>
                     </div>
                     
                     <div class="rightright">  
                      
                        <!--主创贡献榜-->
                        <div class="creatContributeList">
                             <p>list of contributors>>></p>
                             <div id="creatContributeList_charts"  style="top:-20px;width:285px;height:210px"></div>
                        </div>
                        
                        <!--总体排行榜-->
                        <div class="overallRanking">
                             <p>overall ranking>>></p>
                             <div id="overallRanking_charts"  style="top:-20px;width:285px;height:220px"></div>
                        </div>
                     </div>
                     
               </div>
               
               <div id="menuright">
                    <div id="small_menu">
                        <ul>
                            <li id="creatContributeList"><a href="./movieGraph/creatContributeList.action">contributors</a></li>
                            <li id="overallRanking"><a href="./movieGraph/overallRanking.action">overall ranking</a></li>                            
                            <li id="reviewRate" ><a href="./movieGraph/reviewRate.action">word of mouth</a></li>
                            <li id="baiduSearch" ><a href="./movieGraph/baiduSearch.action">baidu searches</a></li>
                            <li id="historicalBoxOffice"><a href="./movieGraph/historicalBoxOffice.action">box office</a></li>
                            <li id="microBlog"><a href="./movieGraph/microBlogAppeal.action">weibo influence</a></li>
                            <li id="actorAward"><a href="./movieGraph/actorAward.action">nominations&awards</a></li>
                            <li id="boxOffice_douBanScore"><a href="./movieGraph/boxOffice_douBanScore.action">score of douban</a></li>                        
                            <li id="otherImpactTarget" ><a href="./movieGraph/otherImpactTarget.action">others</a></li>
                           
                        </ul>                  
                    </div>        
                    <div id="on"><p>+</p></div> 
               </div>
       </div>
	<footer>
	
	   <!----	<p>copyright©广东外语外贸大学 广外数据挖掘实验室</p> ------>
	       <p>CopyRight@Data Mining Lab of GuangDong University of Foreign Study</p>
	</footer>
    <%@ include file="../../public/javascript/meme/eight-Contribution/reviewRate_charts.jsp" %>
    <%@ include file="../../public/javascript/meme/eight-Contribution/baiduSearchCharts.jsp" %>
    <%@ include file="../../public/javascript/meme/eight-Contribution/historicalBoxOffice_charts.jsp" %>
    <%@ include file="../../public/javascript/meme/eight-Contribution/otherImpactTarget_charts.jsp" %>
    <%@ include file="../../public/javascript/meme/eight-Contribution/overallRanking_charts.jsp" %>
    <%@ include file="../../public/javascript/meme/eight-Contribution/actorAward_charts.jsp" %>
    <%@ include file="../../public/javascript/meme/eight-Contribution/creatContributeList_charts.jsp" %>
    <%@ include file="../../public/javascript/meme/eight-Contribution/boxOffice_douBanScore_charts.jsp" %>
    <%@ include file="../../public/javascript/meme/small_menu_change.jsp" %>
    
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