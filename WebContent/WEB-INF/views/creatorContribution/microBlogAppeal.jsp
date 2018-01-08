<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>microBlog</title>
	<link rel="stylesheet" href="../public/stylesheets/lib/perfect-scrollbar.min.css">
    <link rel="stylesheet" href="../public/stylesheets/creatContribution_All_Need.css">
	<link rel="stylesheet" href="../public/stylesheets/header.css">
	<link rel="stylesheet" href="../public/stylesheets/footer.css">
    <link rel="stylesheet" href="../public/stylesheets/menu.css">
	<script src="../public/javascript/lib/jquery-2.1.1.min.js"></script>
    <script src="../public/javascript/lib/perfect-scrollbar.jquery.min.js"></script>
    <script src="../public/javascript/lib/echarts.js"></script>

</head>
<body>
	<header>
		<a href="index.html"><img src="../public/images/header_logo.png" alt="seeing logo" class="logo"></a>
	</header>
        <!--菜单栏-->
        <div id="menu">       
                        <div id = "film_menu">
                            <ul>
                            <li><a href="#">${sessionScope.movieName}</a></li>
                            <li><a href="../movieInfo.action">General</a><div></div></li>
                            <li><a href="../movieActor.action">actor graph</a><div></div></li>
                            <li class="active"><a href="#">creative contribution</a><div  class="on"></div></li>
                            <li><a href="../movieNew.action">news</a><div></div></li>
                            </ul>
                        </div>
        </div>
        <div id="wrap">      
               <div id="left">
                    <!--微博号召力-->                  
                    <div id="microBlog_Area">                 
                        <p>weibo influence>>></p>
                        <div class="microBlogAppeal scrollbar">
                            <!-- 
                            <table>
                                <thead>
                                    <tr>
                                        <td>名字</td>
                                        <td>粉丝数</td>
                                        <td>关注数</td>
                                        <td>微博数</td>
                                        <td>影响度</td>
                                        <td>活跃度</td>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>吴京</td>
                                        <td>500,000</td>
                                        <td>1,000,000</td>
                                        <td>1,000,000</td>
                                        <td>100</td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                    </tr>
                                     <tr>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                    </tr>
                                     <tr>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                    </tr>
                                     <tr>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                    </tr>
                                     <tr>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                    </tr>
                                     <tr>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                    </tr>
                                     <tr>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                    </tr>
                                         
                                </tbody>
                            </table>               -->           
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
               <div id="menuright">
                    <div id="small_menu">
                        <ul>
                          <li id="creatContributeList"><a href="../movieGraph/creatContributeList.action">contributors</a></li>
                            <li id="overallRanking"><a href="../movieGraph/overallRanking.action">overall ranking</a></li>                            
                            <li id="reviewRate" ><a href="../movieGraph/reviewRate.action">word of mouth</a></li>
                            <li id="baiduSearch" ><a href="../movieGraph/baiduSearch.action">baidu searches</a></li>
                            <li id="historicalBoxOffice"><a href="../movieGraph/historicalBoxOffice.action">box office</a></li>
                            <li id="microBlog"><a href="../movieGraph/microBlogAppeal.action">weibo influence</a></li>
                            <li id="actorAward"><a href="../movieGraph/actorAward.action">nominations&awards</a></li>
                            <li id="boxOffice_douBanScore"><a href="../movieGraph/boxOffice_douBanScore.action">score of douban</a></li>                        
                            <li id="otherImpactTarget" ><a href="../movieGraph/otherImpactTarget.action">others</a></li>
                               </ul>                  
                    </div>        
                    <div id="on"><p class="pp">+</p></div> 
                    <div id="back"><a href="../movieGraph.action">back</a></div>
               </div>
       </div>
	<footer>
		<!----	<p>copyright©广东外语外贸大学 广外数据挖掘实验室</p> ------>
	       <p>CopyRight@Data Mining Lab of GuangDong University of Foreign Study</p>
	</footer>
    <%@ include file="../../../public/javascript/meme/small_menu_change.jsp" %>

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