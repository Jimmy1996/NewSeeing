<%@ page language="java" contentType="text/html"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<script>
// JavaScript Document

$(function(){
	var myChart = echarts.init(document.getElementById('baiduSearch'));
   /*var timeData = [ //横坐标数据
    '2009/6/12 2:00', '2009/6/12 3:00', '2009/6/12 4:00', '2009/6/12 5:00', 
	'2009/6/12 6:00', '2009/6/12 7:00', '2009/6/12 8:00', '2009/6/12 9:00', 
	'2009/6/12 10:00', '2009/6/12 11:00', '2009/6/12 12:00', '2009/6/12 13:00', 
	'2009/6/12 14:00', '2009/6/12 15:00', '2009/6/12 16:00', '2009/6/12 17:00', 
	'2009/6/12 18:00', '2009/6/12 19:00', '2009/6/12 20:00', '2009/6/12 21:00', 
	 '2009/6/12 22:00', '2009/6/12 23:00','2009/6/13 0:00', '2009/6/13 1:00', 
	 '2009/6/13 2:00', '2009/6/13 3:00', '2009/6/13 4:00', '2009/6/13 5:00', 
	 '2009/6/13 6:00', '2009/6/13 7:00', '2009/6/13 8:00', '2009/6/13 9:00', 
	 '2009/6/13 10:00', '2009/6/13 11:00', '2009/6/13 12:00', '2009/6/13 13:00', 
	 '2009/6/13 14:00', '2009/6/13 15:00', '2009/6/13 16:00', '2009/6/13 17:00', 
	 '2009/6/13 18:00', '2009/6/13 19:00', '2009/6/13 20:00', '2009/6/13 21:00', 
	 '2009/6/13 22:00', '2009/6/13 23:00','2009/6/14 0:00', '2009/6/14 1:00', 
	 '2009/6/14 2:00', '2009/6/14 3:00', '2009/6/14 4:00', '2009/6/14 5:00',
	 '2009/6/14 6:00', '2009/6/14 7:00', '2009/6/14 8:00', '2009/6/14 9:00', 
	 '2009/6/14 10:00', '2009/6/14 11:00', '2009/6/14 12:00', '2009/6/14 13:00', 
	 '2009/6/14 14:00', '2009/6/14 15:00', '2009/6/14 16:00', '2009/6/14 17:00', 
	 '2009/6/14 18:00', '2009/6/14 19:00', '2009/6/14 20:00', '2009/6/14 21:00',
   ];*/
   var timeData = [
	   <c:forEach items="${movieBaiduIndex}"  var="index">
	   		"<c:out value="${index.date}"/>",
	   </c:forEach>
   ];

timeData = timeData.map(function (str) {
    return str.replace('2009/', '');
});

option = {
    title: {
        show:false,
    },
    tooltip: {
        trigger: 'axis',
        axisPointer: {
            animation: false
        }
    },
    legend: {
       show:false,
    },
    
    axisPointer: {
        link: {xAxisIndex: 'all'}
    },

    grid:{
        left: 50,
        right: 50,
        height: '35%'
    },
    xAxis :
        {
            type : 'category',
            boundaryGap : false,
            axisLine: {onZero: true},
            data: timeData,
			axisLabel:{
                    show: true,
                    textStyle: {
                        color: '#fff',
						fontSize:13,
                    }},
	    	axisLine: {
	            	lineStyle: {
	            		color:'#3dffff'
	            	}
	            },		
        },
    yAxis :
        {
            name : 'baidu search index', // 纵坐标名字
            type : 'value',
            max : ${maxOrdinate},
			axisLabel:{
                    show: true,
                    textStyle: {
                        color: '#fff',
                    }},
			axisLine: {
	            	lineStyle: {
	            		color:'#3dffff'
	            	}
	            },
			splitLine: {
	            	show:true,
					lineStyle: {
	            		color:'#022833'
	                },					
				}
        },
    series :
        {
            name:'流量', //曲线名字
            type:'line',
            symbolSize: 8,
            itemStyle : {  
                normal : {  
                    lineStyle:{  
                        color:'yellow' 
                    }  
                }  
            },  
            hoverAnimation: false,
         /*  data:[ // 纵坐标数据
                100,200,300,400,
				200,300,400,500,
				450,460,430,350,
				200,150,130,160,
				100,200,300,400,
				200,300,400,500,
				450,460,430,350,
				200,150,130,160,
				100,200,300,400,
				200,300,400,500,
				450,460,430,350,
				200,150,130,160,
				100,200,300,400,
				200,300,400,500,	
				200,150,130,160,
				100,200,300,400,
				200,300,400,500,			
			]*/
			  data:[
				<c:forEach items="${movieBaiduIndex}"  var="index">
			   		<c:out value="${index.num}"/>,
			   </c:forEach>
			]
        }
    
};
 myChart.setOption(option);
})

</script>