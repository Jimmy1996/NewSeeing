<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<script>
// JavaScript Document
// JavaScript Document
$(function(){
	var myChart = echarts.init(document.getElementById('actorAward_charts'));
option = {
	title:{
		show:false,
		},
	color: ['#01E290','#F19147'],
    tooltip: {
        trigger: 'axis',
        axisPointer: {
            type: 'shadow'
        }
    },
    legend: {
        data:['nomination','award'],
		textStyle: {
                        color: '#fff',
					    fontSize:12,	
                    },
		itemWidth:15,
		itemHeight:8,			
		top:30,
		right:5,
		    },
    grid: {
        left: '3%',
        right: '4%',
        bottom: '3%',
        containLabel: true
    },
    xAxis: {
        type: 'value',
        boundaryGap: [0, 0.01],
		 splitLine:{show: false},//去除网格线
		 axisLabel:{
                    show: true,
                    textStyle: {
                        color: '#fff',
                    }
                },
	     axisTick: {show: false},
	     axisLine: {
	            	lineStyle: {
	            		color:'#3dffff'
	            	}
	            },
    },
    yAxis: {
        type: 'category',
        //data: ['人名1','人名2','人名3'],//演员名
        data:[
        	<c:forEach items="${actorAward}" var="award">
        	 '${award.name}',
        	</c:forEach>
        ],
		axisTick: {show: false},
		
		axisLabel:{
                    show: true,
                    textStyle: {
                        color: '#fff',
					    fontSize:13,	
                    }
                },
		axisLine: {
	            	lineStyle: {
	            		color:'#3dffff'
	            	}
	            },
    },
    series: [
	
        {
            name: 'nomination',
            type: 'bar',
            //data: [182, 204,300],
            data:[
        	<c:forEach items="${actorAward}" var="award">
	        	 ${award.nomination},
	        </c:forEach>
	        ],
			barGap:'60%',
			barWidth:'5px',
        },
		{
            name: 'award',
            type: 'bar',
            //data: [123, 234,200],
            data:[
        	<c:forEach items="${actorAward}" var="award">
	        	 ${award.price},
	        	</c:forEach>
	        ],
			barGap:'60%',
			barWidth:'5px',
        },

    ]
};
 myChart.setOption(option);
})
</script>