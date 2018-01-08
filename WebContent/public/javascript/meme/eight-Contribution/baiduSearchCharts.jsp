<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<script>
// JavaScript Document

$(function(){
	var myChart = echarts.init(document.getElementById('baiduSearch_charts'));
option = {
    title: {
		show:false,
    },
	color:['#019358','#1F9097'],
	
    tooltip: {
        trigger: 'axis'
    },
	
    legend: {
        data:['search index'],
		textStyle:{color:'#fff',fontSize:12,},
		show:true,
		top:25,
		right:10,
    },
    grid: {
        left: '3%',
        right: '4%',
        bottom: '3%',
        containLabel: true
    },
	
    xAxis: {
        type: 'category',
        boundaryGap: false,
        //data: ['1','2','3','4','5','6','7'],
        data: [
        	<c:forEach items="${actorName}" var="name">
        		'${name}',
        	</c:forEach>
        ],
		axisTick: {show: false},
		
		axisLabel:{
                    show: true,
                    textStyle: {
                        color: '#fff',
					    fontSize:12,	
                    }
                },
		axisLine: {
	            	lineStyle: {
	            		color:'#3dffff'
	            	}
	            },
    },
    yAxis: {
        type: 'value',
		splitLine: {
	            	show:true,
					lineStyle: {
	            		color:'#022833'
	            	}
	            },
		axisTick: {show: false},
		axisLine: {
	            	lineStyle: {
	            		color:'#3dffff'
	            	}
	            },
		axisLabel:{
                    show: true,
                    textStyle: {
                        color: '#fff',
					    fontSize:12,	
                    }
                },
    },
    series: [
        {
            name:'search index',
            type:'line',
            stack: '总量',
           // data:[120, 132, 101, 134, 90, 230, 210],
           data: [
        	<c:forEach items="${actorIndex}" var="index">
        		${index},
        	</c:forEach>
        ],
			itemStyle : {normal : {color:'#019358'}},
        },
    /*    {
            name:'人2',
            type:'line',
            stack: '总量',
            data:[220, 182, 191, 234, 290, 330, 310],
			itemStyle : {normal : {color:'#1F9097'},}
        }*/
    ]
};
 myChart.setOption(option);
})
</script>