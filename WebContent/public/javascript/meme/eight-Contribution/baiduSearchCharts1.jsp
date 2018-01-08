<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<script>
// JavaScript Document
// JavaScript Document

$(function(){
	var myChart = echarts.init(document.getElementById('baiduSearch_charts'));
option = {
    title: {
		show:false,
    },
	color:['#019358','#1F9097'],
	
    tooltip: {
        trigger: 'axis',

    },
	
    legend: {
        data:['search index'],
		textStyle:{color:'#fff',fontSize:14,},
		show:true,
		top:15,
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
					    fontSize:15,	
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
					    fontSize:15,	
                    }
                },
    },
    series: [
        {
            name:'search index',
            type:'line',
			symbol:'emptyCircle', //折线图拐点图形
			symbolSize : 10,    //折线图拐点图形大小
            stack: '总量',
         // data:[120, 132, 101, 134, 90, 230, 210],
            data: [
         	<c:forEach items="${actorIndex}" var="index">
         		${index},
         	</c:forEach>
         ],
			itemStyle : {
				normal : {
					color:'#019358',
					lineStyle:{
						width:2.5,
						}
					},
				
				emphasis:{},
				},
        },
       /* {
            name:'人2',
            type:'line',
			symbol:'emptyCircle',
			symbolSize : 10,
            stack: '总量',
            data:[220, 182, 191, 234, 290, 330, 310],
			itemStyle : {
				normal : {
					color:'#1F9097',
					lineStyle:{
						width:2.5,
						}
					},}
        }*/
    ]
};
 myChart.setOption(option);
})
</script>