<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>actorMap</title>
	<link rel="stylesheet" href="./public/stylesheets/actorMap.css">
	<link rel="stylesheet" href="./public/stylesheets/header.css">
	<link rel="stylesheet" href="./public/stylesheets/footer.css">
    <link rel="stylesheet" href="./public/stylesheets/menu.css">
	<script src="./public/javascript/lib/jquery-2.1.1.min.js"></script>
    <script src="./public/javascript/lib/echarts.js"></script>
    <script src="./public/javascript/lib/echarts-2.2.7/build/dist/echarts.js"></script>

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
              <li class="active"><a href="#">actor graph</a><div class="on"></div></li>
              <li><a href="./movieGraph.action">creative contribution</a><div></div></li>
              <li><a href="./movieNew.action">news</a><div></div></li>
              </ul>
          </div>
    </div>

    <!--放知识图谱以及对应的卡片-->
	<div id="wrap">
         
		<div id="center">
			<div id="actorMapEchart" style="width: 680px; height: 570px"></div>            
		</div>
        
		<div id="right">        
		
             <c:forEach items="${actorCardInfo}" var="actorInfo" varStatus="statu"> 
             	<div class="card actor_card" id="actor${statu.index+1}" style=" display:none;">

		            <div class="content scrollbar">
	
	                    <ul class="actor_introduce">
	                         <li class="images">
	                              <img  src="${actorInfo.imgPath}" alt=""  style="width:120px;">
	                         </li>
	                         
	                         <li class="message">
	                               <p style="color:#ffb472; font-size:18px; ">${actorInfo.name}</p>
	                               <c:if test="${actorInfo.nickName != 'none' }">
	                               		<p>alias：${actorInfo.nickName}</p>
	                               </c:if>
	                               <p>role name : ${actorInfo.roleName}</p>
	                               <c:if test="${actorInfo.birthday != 'none' }">
	                               		<p>birthday：${actorInfo.birthday}</p>
	                               </c:if>
	                               <c:if test="${actorInfo.area != 'none' }">
	                              		 <p>area：${actorInfo.area}</p>
	                              	</c:if>
	                               <p>average box office(last 5 years)：${actorInfo.avgBox}万</p>
	                         </li>
	                        
	                    </ul>
	
		                <div class="film_type_pie" >
	                          <div class="name"><p>the proportion of film type>>></p></div>
	                          <div id="pieCharts${statu.index+1}" style="	
	margin-left:30px;width:350px;height:250px;position:relative;"></div>                   
	                    </div>
		            </div>
	            </div>
             </c:forEach>
            
		</div>
	</div>
	
	<footer>
		
	   <!----	<p>copyright©广东外语外贸大学 广外数据挖掘实验室</p> ------>
	       <p>CopyRight@Data Mining Lab of GuangDong University of Foreign Study</p>
	</footer>
    
	<%@ include file="../../public/javascript/meme/film_type_pie.jsp" %>
	<%@ include file="../../public/javascript/meme/relation_graph.jsp" %>
    
	 <script>
   $(document).ready(function ($){
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